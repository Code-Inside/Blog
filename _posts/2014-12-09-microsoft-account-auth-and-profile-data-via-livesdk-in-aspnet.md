---
layout: post
title: "Microsoft Account Auth and Profile Data via LiveSDK in ASP.NET"
description: "Getting started with the LiveSDK basics: Authentication & Load Profile Data from the given Microsoft Account."
date: 2014-12-09 00:01
author: robert.muehsig
tags: [Microsoft Account, Auth, LiveSDK]
language: en
---
{% include JB/setup %}

In this blogpost I will take a deeper look at the LiveSDK to authenticate users by their Microsoft Accounts and display some profile information of the given user.

## Didn't ASP.NET Identity try to solve this problem?
If you only need the "Authentication"-Part, this might be true (here is one quick [walkthrough](http://www.benday.com/2014/02/25/walkthrough-asp-net-mvc-identity-with-microsoft-account-authentication/). In theory you are only one checkbox away from the solution with the new Identity system.

__But__ if you need deeper integration and want to retrieve data from OneDrive, OneNote or Outlook.com then you need to take a look at the LiveSDK. Maybe you can use the auth token from the ASP.NET Identity part and use this for the LiveSDK - but I'm not sure on this.
Another point is that the ASP.NET Identity stuff feels so bloated and the database part is scary. 

Our Mission: Pure LiveSDK, no magic. 

## Before you start: Setup the Domain and get the API Key & Secret

The setup flow is the same as for Twitter/Facebook/Google Auth, but with one (stupid) limitation.

__First step__: Create an App in the [Microsoft Developer Center](https://account.live.com/developers/applications/index).

__Second step__: Enter the Root & Redirect Domain for the App. You will need a __"real"__ URL - localhost is not accepted (d'oh). 

Because real URLs are always kinda painful while developing you have two options:

* __a)__ Manipulate your hosts file (%SystemRoot%\system32\drivers\etc\hosts)
* __b)__ Use a service like [localtest.me](http://readme.localtest.me/)

I will stick to __b)__ with the blogpostsample.localtest.me URL. To setup the binding I will also commit a Powershell file called "Enable-LocalTestMe.ps1" - this should ramp up everything on your development machine and make VS & IIS Express happy. After that you can F5 to your WebApp and it will open at "blogpostsample.localtest.me". Yay!

So, my registration inside the DevCenter looks like this:

![x]({{BASE_PATH}}/assets/md-images/2014-12-09/registration.png "Microsoft DevCenter Registration")

## ASP.NET & LiveSDK

Next step: Create a new ASP.NET MVC app without any authentication provider and get the __[Live SDK for ASP.NET](https://www.nuget.org/packages/LiveSDKServer/)__ NuGet package.

The LiveSDK has two main parts:

* LiveAuthClient: For the authentication part.
* LiveConnectClient: After successful authentication interact with the service.

To learn more about the LiveSDK follow this __[MSDN link](http://msdn.microsoft.com/en-us/library/hh243641.aspx)__.

My sample code doesn't store any token on the client or does any other clever mechanics and it even has hardcoded URLs in it, but this should work for the demo ;). 


### Trigger Authentication Flow

You need to list all "needed" scopes for the authentication flow. The scopes are documented [here](http://msdn.microsoft.com/en-us/library/hh243646.aspx). The API uses [OAuth2 for the authorization flow](http://msdn.microsoft.com/en-us/library/hh243647.aspx).

    private static readonly string[] scopes =
        new string[] { 
            "wl.signin", 
            "wl.basic", 
            "wl.calendars" };

    private readonly LiveAuthClient authClient;

    public AuthController()
    {
        authClient = new LiveAuthClient("0000000044121F5D", "b6lolb9jiF-zaMtp8KXcRNJ7ACz37SuK", "http://blogpostsample.localtest.me/Auth/Redirect");
    }

    public async Task<ActionResult> Index()
    {
        LiveLoginResult loginStatus = await this.authClient.InitializeWebSessionAsync(HttpContext);
        switch (loginStatus.Status)
        {
            case LiveConnectSessionStatus.Expired:
            case LiveConnectSessionStatus.Unknown:
                string reAuthUrl = authClient.GetLoginUrl(scopes);
                return new RedirectResult(reAuthUrl);
        }

        return RedirectToAction("Index", "Home");
    }

This code will initialize the authentication flow and create the "LiveAuthClient" and (hopefully) redirect the browser to the Microsoft Account Login. 

![x]({{BASE_PATH}}/assets/md-images/2014-12-09/login.png "Microsoft Account Login")

On the first login the user needs to consent the desired "scopes". 

![x]({{BASE_PATH}}/assets/md-images/2014-12-09/consent.png "Microsoft Account Login - Consent Screen")

After this step the user will be redirected to the redirect url (in my case .../Auth/Redirect).

### Get Microsoft Account Data

So, now this part is a bit magic, but I guess the "ExchangeAuthCodeAsync" will load the token from the Request and validate it. If everything is correct the status should be "Connected". 


    public async Task<ActionResult> Redirect()
    {
        var result = await authClient.ExchangeAuthCodeAsync(HttpContext);
        if (result.Status == LiveConnectSessionStatus.Connected)
        {
            var client = new LiveConnectClient(this.authClient.Session);
            LiveOperationResult meResult = await client.GetAsync("me");
            LiveOperationResult mePicResult = await client.GetAsync("me/picture");
            LiveOperationResult calendarResult = await client.GetAsync("me/calendars");

            ViewBag.Name = meResult.Result["name"].ToString();
            ViewBag.PhotoLocation = mePicResult.Result["location"].ToString();
            ViewBag.CalendarJson = calendarResult.RawResult;
        }

        return View();
    }

The LiveConnectClient is a relatively thin layer on top of the [REST API](http://msdn.microsoft.com/en-us/library/hh243648.aspx).
	
Result:

![x]({{BASE_PATH}}/assets/md-images/2014-12-09/result.png "Microsoft Account Data")

## Mission accomplished! 

The code so far was trivial, but will run (but maybe not in the most robust way). 

If you want to learn more, the LiveSDK is on __[GitHub](https://github.com/liveservices/LiveSDK)__ and the __[Interactive Live SDK](http://isdk.dev.live.com/dev/isdk/Default.aspx)__ might be useful for you.

The source code is available on our [GitHub-Samples-Repo](https://github.com/Code-Inside/Samples/tree/master/2014/LiveSample).

I also posted a short blogpost in German about [Microsoft Account Authentication ASP.NET Identity](http://blog.codeinside.eu/2014/07/06/microsoft-account-login-via-asp-net-identity/) some month ago.

Hope this helps!
