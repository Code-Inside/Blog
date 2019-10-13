---
layout: post
title: "IdentityServer & Azure AD Login: Unkown Response Type text/html"
description: "... and how to fix it."
date: 2019-10-13 19:00
author: Robert Muehsig
tags: [IdentityServer, Microsoft Graph, Azure AD]
language: en
---

{% include JB/setup %}

# The problem

Last week we had some problems with our [Microsoft Graph / Azure AD login](https://developer.microsoft.com/en-us/graph) based system. From a user perspective it was all good until the redirect from the Microsoft Account to our IdentityServer.

As STS and for all auth related stuff we use the excellent [IdentityServer4](https://identityserver.io/).

We used the following configuration:

    services.AddAuthentication()
                .AddOpenIdConnect(office365Config.Id, office365Config.Caption, options =>
                {
                    options.SignInScheme = IdentityServerConstants.ExternalCookieAuthenticationScheme;
                    options.SignOutScheme = IdentityServerConstants.SignoutScheme;
                    options.ClientId = office365Config.MicrosoftAppClientId;            // Client-Id from the AppRegistration 
                    options.ClientSecret = office365Config.MicrosoftAppClientSecret;    // Client-Secret from the AppRegistration 
                    options.Authority = office365Config.AuthorizationEndpoint;          // Common Auth Login https://login.microsoftonline.com/common/v2.0/ URL is preferred
                    options.TokenValidationParameters = new TokenValidationParameters { ValidateIssuer = false }; // Needs to be set in case of the Common Auth Login URL
                    options.ResponseType = "code id_token";
                    options.GetClaimsFromUserInfoEndpoint = true;
                    options.SaveTokens = true;
                    options.CallbackPath = "/oidc-signin"; 
                    
                    foreach (var scope in office365Scopes)
                    {
                        options.Scope.Add(scope);
                    }
                });

The "office365config" contains the basic OpenId Connect configuration entries like ClientId and ClientSecret and the needed scopes.

Unfortunatly with this configuration we couldn't login to our system, because after we successfully signed in to the Microsoft Account this error occured:

    System.Exception: An error was encountered while handling the remote login. ---> System.Exception: Unknown response type: text/html
       --- End of inner exception stack trace ---
       at Microsoft.AspNetCore.Authentication.RemoteAuthenticationHandler`1.HandleRequestAsync()
       at IdentityServer4.Hosting.FederatedSignOut.AuthenticationRequestHandlerWrapper.HandleRequestAsync() in C:\local\identity\server4\IdentityServer4\src\IdentityServer4\src\Hosting\FederatedSignOut\AuthenticationRequestHandlerWrapper.cs:line 38
       at Microsoft.AspNetCore.Authentication.AuthenticationMiddleware.Invoke(HttpContext context)
       at Microsoft.AspNetCore.Cors.Infrastructure.CorsMiddleware.InvokeCore(HttpContext context)
       at IdentityServer4.Hosting.BaseUrlMiddleware.Invoke(HttpContext context) in C:\local\identity\server4\IdentityServer4\src\IdentityServer4\src\Hosting\BaseUrlMiddleware.cs:line 36
       at Microsoft.AspNetCore.Server.IIS.Core.IISHttpContextOfT`1.ProcessRequestAsync()

# Fix

After some code research I found the problematic code:

We just needed to disable "__GetClaimsFromUserInfoEndpoint__" and everything worked. I'm not sure why we the error occured, because this code was more or less untouched a couple of month and worked as intended. I'm not even sure what "GetClaimsFromUserInfoEndpoint" really does in the combination with a Microsoft Account.

I wasted one or two hours with this behavior and maybe this will help someone in the future. If someone knows why this happend: Use the comment section or write me an email :)

Full code:

       services.AddAuthentication()
                    .AddOpenIdConnect(office365Config.Id, office365Config.Caption, options =>
                    {
                        options.SignInScheme = IdentityServerConstants.ExternalCookieAuthenticationScheme;
                        options.SignOutScheme = IdentityServerConstants.SignoutScheme;
                        options.ClientId = office365Config.MicrosoftAppClientId;            // Client-Id from the AppRegistration 
                        options.ClientSecret = office365Config.MicrosoftAppClientSecret;  // Client-Secret from the AppRegistration 
                        options.Authority = office365Config.AuthorizationEndpoint;        // Common Auth Login https://login.microsoftonline.com/common/v2.0/ URL is preferred
                        options.TokenValidationParameters = new TokenValidationParameters { ValidateIssuer = false }; // Needs to be set in case of the Common Auth Login URL
                        options.ResponseType = "code id_token";
                        // Don't enable the UserInfoEndpoint, otherwise this may happen
                        // An error was encountered while handling the remote login. ---> System.Exception: Unknown response type: text/html
                        // at Microsoft.AspNetCore.Authentication.RemoteAuthenticationHandler`1.HandleRequestAsync()
                        options.GetClaimsFromUserInfoEndpoint = false; 
                        options.SaveTokens = true;
                        options.CallbackPath = "/oidc-signin"; 
                        
                        foreach (var scope in office365Scopes)
                        {
                            options.Scope.Add(scope);
                        }
                    });


Hope this helps!
