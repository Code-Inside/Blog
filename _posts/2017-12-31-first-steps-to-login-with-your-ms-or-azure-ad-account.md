---
layout: post
title: "First steps to enable login with Microsoft or Azure AD account for your application"
description: "In the last couple of months I had the opportunity to work again with Microsoft & Azure AD Login related tasks and because Microsoft has quite a few different implementations I will just point you to the most recent version of their identity platform."
date: 2017-12-31 14:15
author: Robert Muehsig
tags: [microsoft account, azure ad, office365]
language: en
---
{% include JB/setup %}

It is quite common these days to "Login with Facebook/Google/Twitter". Of course Microsoft has something similar.
If I remember it correctly the first version was called "Live SDK" with the possibility to login with your personal Microsoft Account.

With Office 365 and the introduction of Azure AD we were able to build an application to sign-in with a personal account via the "Live SDK" and organizational account via "Azure AD".

However: The developer and end user UX was far way from perfect, because the implementation for each account type was different and for the user it was not clear which one to choose.

# Microsoft Graph & Azure AD 2.0

Fast forward to the right way: Use the __[Azure AD 2.0 endpoint](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-v2-app-registration)__. 

## Step 1: Register your own application

You just need to register your own application in the __[Application Registration Portal](https://apps.dev.microsoft.com)__. The registration itself is a typical OAuth-application registration and you get a ClientId and Secret for your application.

Warning: If you have "older" LiveSDK application registered under your account you need to choose __Converged Applications__. LiveSDK applications are more or less legacy and I wouldn't use them anymore.

## Step 2: Choose a platform

Now you need to choose your application platform. If you want to enable the sign-in stuff for your web application you need to choose "Web" and insert the redirect URL. After the sign-in process the token will be send to this URL. 

![x]({{BASE_PATH}}/assets/md-images/2017-12-31/platforms.png "Platforms")

## Step 3: Choose Microsoft Graph Permissions (Scopes)

In the last step you need to select what permissions your applications need. A first-time user needs to accept your permission requests. The "Microsoft Graph" is a collection of APIs that works for personal Microsoft accounts __and__ Office 365/Azure AD account. 

![x]({{BASE_PATH}}/assets/md-images/2017-12-31/platforms.png "Platforms")

The "User.Read" permission is the most basic permission that would allow to sign-in, but if you want to access other APIs as well you just need to add those permissions to your application:

![x]({{BASE_PATH}}/assets/md-images/2017-12-31/scopes.png "Scopes")

## Finish

After the application registration and the selection of the needed permissions you are ready to go. You can even generate a sample application on the portal. For a __quick start__ check this [page](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-v2-app-registration#build-a-quick-start-app)

# Microsoft Graph Explorer

![x]({{BASE_PATH}}/assets/md-images/2017-12-31/graphexplorer.png "Microsoft Graph Explorer")

As I already said: The Graph is the center of Microsofts Cloud Data and the easiest way to play around with the different scopes and possibilities is with the __[Microsoft Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer)__.


Hope this helps.



