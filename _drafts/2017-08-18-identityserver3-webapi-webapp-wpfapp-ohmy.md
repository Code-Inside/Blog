---
layout: post
title: "IdentityServer3 with WindowsAuthentication with ASP.NET WebApi & ASP.NET & WPF App"
description: "In the recent month I was working on our identity system. The main problem was that we have larger range of application types. This blogpost demonstrate how to use a WindowsAuth IdentityProvider in ASP.NET MVC and WebApi and inside a WPF App in combination with IdentityServer3."
date: 2017-08-18 23:15
author: Robert Muehsig
tags: [OpenId Connect, JWT, IdentityServer3, OAuth]
language: en
---
{% include JB/setup %}

__Please note__: In my sample and in this blogpost I cover IdentityServer 3, because last year when I created working on the sample and our real implementation IdentityServer4, a rewrite and with .NET Core in mind was in beta. My guess is, that most stuff should still apply even if you are using IdentityServer4, but I didn't test it.

Also: I'm not a security expert - this might be all wrong, but currently this more or less works for me. If you find something strange, please let me know!

## Overview

The sample consists of the following projects:

__IdentityTest.IdServerHost:__ That's the central IdentityServer in our solution. It contains all "client" & "identityprovider" settings.
__IdentityTest.WinAuth:__ This is our Windows-Authentication provider. Because of the nature of WindowsAuth it needs to be an extra project. This needs to be hosted via IIS (or IIS Express) with Windows authentication enabled. The ASP.NET app acts as a bride and will convert the Windows-Auth ticket into a saml token. It is more or less like a mini-ADFS
__IdentityTest.WebApp:__ The WebApp itself can be used via browser and also hosts a WebApi. The WebApi is secured by the IdServerHost and one page will trigger the authentication against our IdServerHost.
__IdentityTest.WpfClient:__ With the WPFApp we want to get a AccessToken via a WebBrowser-Control from the IdServerHost and call the WebApi that is hosted and secured by the very same IdServerHost.

The IdentityServer team did a great job and have a large __[sample repository on GitHub](https://github.com/IdentityServer/IdentityServer3.Samples)__. 

I will talk about each part. Now lets beginn with...

### The 'IdServerHost' Project

The IdentityServerHost is a plain ASP.NET application. To include the IdentityServer3 you need to add this [NuGet-Package](https://www.nuget.org/packages/IdentityServer3/).

The code is more or less identical with the [Minimal-Sample](https://github.com/IdentityServer/IdentityServer3.Samples/tree/master/source/WebHost%20(minimal)/WebHost), but I __disabled the SSL__ requirements for my demo.

Be aware: The IdentityServer use a certificate to sign the tokens, but this has nothing to do with the SSL certificate. This was a hard learning curve for me and IISExpress or something messed things up. In the end I disabled the SSL requirements for __for my development enviroment__ and could start to understand how each part is communicating with each other. 
The signing certificate in the sample is the sample .pfx file from the offical samples.

Remember: __DO USE SSL IN PRODUCTION.__ Oh - and use the Cert-Store for the signing certificate as well! 

Besides the SSL stuff the most important stuff might be the [client-registration](https://github.com/Code-Inside/Samples/blob/master/2016/IdentityTest/IdentityTest.IdServerHost/Configuration/Clients.cs) and the [identity-provider-registration](https://github.com/Code-Inside/Samples/blob/79fda88113a4736a465ab275fe0745dfc6aefa9a/2016/IdentityTest/IdentityTest.IdServerHost/Startup.cs#L45-L65).

The IdentityServer - as the auth-central - knows each 'client' and each 'identity-provider'. Make sure all URLs are correct otherwise you will end up with errors. Even a slightly difference like 'http://test.com/' and 'http://test.com' (without the trailing slash at the end) will result in strange errors. 

### The 'WinAuth' Project

As already written this is our Windows-Authentication provider. Of course, it is only needed if you need WinAuth. If you want to use any other provider, like a Google/Microsoft/Facebook/Twitter-Login, then this is not needed.
It is a bridge to the enterprise world and works quite well. 

In the project I just reference the [IdentityServer.WindowsAuthentication](https://www.nuget.org/packages/IdentityServer.WindowsAuthentication/) NuGet-Package and I'm nearly done. 
In the config I need to insert the URL of my IdentityServer host - those two parts needs to know each other and they will exchange public keys so they can trust each other.

For this trust-relationship the WinAuth provider has its own certificate. Actually you can reuse the same cert from the IdentityServerHost but I'm not sure if this is super secure, but it works.

The code and sample can also be found on the offical [GitHub repo](https://github.com/IdentityServer/WindowsAuthentication)

### The 'WebApp' Project

This project is a regular ASP.NET MVC project with WebApi 2 included. Nothing ASP.NET Core related, but the actual doing would be pretty similar.

On this page there are two ways to interact: 

* Via Browser
* Via the WebApi

__Browser Auth via OpenIdConnect Auth:__

The NuGet Package [Microsoft.Owin.Security.OpenIdConnect](https://www.nuget.org/packages/Microsoft.Owin.Security.OpenIdConnect) does the heavy lifting for us. In combination with the [Microsoft.Owin.Security.Cookies](https://www.nuget.org/packages/Microsoft.Owin.Security.Cookies/) NuGet package the authentication will kick in when someone access a [Authorize] marked Controller. The Cookie-Auth will preserve the identity information.

__WebApi Auth:__

To use the protected WebApi with any HTTP client the request must have a JWT bearer token. The implementation is super simple with this NuGet package [IdentityServer3.AccessTokenValidation](https://www.nuget.org/packages/IdentityServer3.AccessTokenValidation/). 

__Setup of both auth options:__

The setup is quite easy with the NuGet packages:

    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            app.UseIdentityServerBearerTokenAuthentication(new IdentityServerBearerTokenAuthenticationOptions
            {
                Authority = ConfigurationManager.AppSettings["Security.Authority"],
                RequiredScopes = new[] { "openid" }
            });

            app.UseCookieAuthentication(new CookieAuthenticationOptions()
            {
                AuthenticationType = "cookies",
            });

            app.UseOpenIdConnectAuthentication(new OpenIdConnectAuthenticationOptions()
            {
                AuthenticationType = "oidc",
                SignInAsAuthenticationType = "cookies",
                Authority = ConfigurationManager.AppSettings["Security.Authority"],
                ClientId = "webapp",
                RedirectUri = ConfigurationManager.AppSettings["Security.RedirectUri"],
                ResponseType = "id_token",
                Scope = "openid all_claims"
            });
        }
    }

It is important to use the correct "clientIds" and URLs as configured in the IdentityServer, otherwise you will receive errors from the IdentityServer.

### The 'WpfClient' Project

This project is a small version of the original [WpfOidcClientPop](https://github.com/IdentityServer/IdentityServer3.Samples/tree/master/source/Clients/WpfOidcClientPop) sample. The idea behind this sample is that a user can sign in with his regular account. 

__Auth via browser:__

Instead of a Loginname/Password form rendered from the WPF app itself the authentication is delegated to a embedded browser control. Another option is to delegate it to the "real" installed browser, but this is another topic. 
The Microsoft Account login in Visual Studio is made that way or think of any popular "Facebook-Login" mobile app on your phone: The auth-process is basically a typical Web signin.

This scenario is also convered as a offical [OpenID Connect specification](https://tools.ietf.org/wg/oauth/draft-ietf-oauth-native-apps/). In WPF your best and easiest choice would be the [IdentityModel.OidcClient2](https://github.com/IdentityModel/IdentityModel.OidcClient2) package.



 