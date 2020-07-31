---
layout: post
title: "EWS, Exchange Online and OAuth with a Service Account"
description: "Is is possible without full access to all mailboxes? YES!"
date: 2020-07-31 23:45
author: Robert Muehsig
tags: [Exchange Online, EWS]
language: en
---

{% include JB/setup %}

This week we had a fun experiment: We wanted to talk to Exchange Online via the "old school" EWS API, but in a "sane" way. 

But here is the full story:

# Our goal

We wanted to access contact information via a web service from the organization, just like the traditional "Global Address List" in Exchange/Outlook. We knew that EWS was on option for the OnPrem Exchange, but what about Exchange Online? 

The big problem: Authentication is tricky. We wanted to use a "traditional" Service Account approach (think of username/password). Unfortunately the "basic auth" way will be blocked [in the near future](https://techcommunity.microsoft.com/t5/exchange-team-blog/basic-authentication-and-exchange-online-april-2020-update/ba-p/1275508) because of security concerns (makes sense TBH). There is an alternative approach available, but at first it seems not to work as we would like.

So... what now?

# EWS is... old. Why?

The [Exchange Web Services](https://docs.microsoft.com/en-us/exchange/client-developer/exchange-web-services/start-using-web-services-in-exchange) are old, but still quite powerful and still supported for Exchange Online and OnPrem Exchanges. On the other hand we could use the Microsoft Graph, but - at least currently - there is not a single "contact" API available. 

To mimic the GAL we would need to query [List Users](https://docs.microsoft.com/en-us/graph/api/user-list) and [List orgContacts](https://docs.microsoft.com/en-us/graph/api/orgcontact-list?view=graph-rest-1.0&tabs=http), which would be ok, but the "orgContacts" has a "flaw". 
"Hidden" contacts ("msexchhidefromaddresslists") are returned from this API and we thought that this might be a NoGo for our customers.

Another argument for using EWS was, that we could support OnPrem and Online with one code base. 

# Docs from Microsoft

The good news is, that EWS and the Auth problem is more or less good [documented here](https://docs.microsoft.com/en-us/exchange/client-developer/exchange-web-services/how-to-authenticate-an-ews-application-by-using-oauth). 

There are two ways to authenticate against the Microsoft Graph or any Microsoft 365 API: Via "delegation" or via "application". 

__Delegation:__

Delegation means, that we can write a desktop app and all actions are executed in the name of the signed in user. 

__Application:__ 

Application means, that the app itself can do some actions without any user involved. 

# EWS and the application way

At first we thought that we might need to use the "application" way. 

The good news is, that this was easy and worked. 
The bad news is, that the application needs the EWS permission "full_access_as_app", which means that our application can access __all__ mailboxes from this tenant. This might be ok for certain apps, but this scared us. 

Back to the delegation way:

# EWS and the delegation way

The documentation from Microsoft is good, but our "Service Account" usecase was not mentioned. In the example from Microsoft a user needs to manually login.

# Solution / TL;DR

After some research I found the solution to use a "username/password" OAuth flow to access a single mailbox via EWS:

1. Follow the normal ["delegate" steps from the Microsoft Docs](https://docs.microsoft.com/en-us/exchange/client-developer/exchange-web-services/how-to-authenticate-an-ews-application-by-using-oauth)

2. Instead of this code, which will trigger the login UI:

```
...
// The permission scope required for EWS access
var ewsScopes = new string[] { "https://outlook.office.com/EWS.AccessAsUser.All" };

// Make the interactive token request
var authResult = await pca.AcquireTokenInteractive(ewsScopes).ExecuteAsync();
...
```

Use the "AcquireTokenByUsernamePassword" method:

```
...
var cred = new NetworkCredential("UserName", "Password");
var authResult = await pca.AcquireTokenByUsernamePassword(new string[] { "https://outlook.office.com/EWS.AccessAsUser.All" }, cred.UserName, cred.SecurePassword).ExecuteAsync();
...
```

To make this work you need to enable the "Treat application as public client" under "Authentication" > "Advanced settings" in our AAD Application because this uses the ["Resource owner password credential flow"](https://docs.microsoft.com/en-us/azure/active-directory/develop/v2-oauth-ropc). 

Now you should be able to get the AccessToken and do some EWS magic. 

*I posted a shorter version on [Stackoverflow.com](https://stackoverflow.com/questions/57009837/how-to-get-oauth2-access-token-for-ews-managed-api-in-service-daemon-application/63175301#63175301)*

Hope this helps!