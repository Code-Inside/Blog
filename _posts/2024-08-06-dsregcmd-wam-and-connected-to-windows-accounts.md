---
layout: post
title: "dsregcmd, WAM and 'Connected to Windows Account'"
description: "A (small) look at these tools..."
date: 2024-08-06 23:59
author: Robert Muehsig
tags: [WAM, Microsoft Account, Azure AD, EntraId, Windows, TIL]
language: en
---

{% include JB/setup %}

*This is more of a "Today-I-Learned" post and not a "full-blown How-To article." If something is completely wrong, please let me know - thanks!* 

I was researching if it is possible to have a "real" single-sign-on experience with Azure AD/Entra ID and third-party desktop applications and I stumbled across a few things during my trip.

# "Real" SSO?

There are a bunch of definitions out there about SSO.
Most of the time, SSO just means: You can use the same account in different applications.

But some argue that a "real" SSO experience should mean: You log in to your Windows Desktop environment, and that's it - each application should just use the existing Windows account.

# Problems

With "Integrated Windows Auth," this was quite easy, but with Entra ID, it seems really hard. Even Microsoft seems to struggle with this task, because even Microsoft Teams and Office need at least a hint like an email address to sign in the actual user.

# Solution?

I _didn't__ found a solution for this (complex) problem, but I found a few interesting tools/links that might help achieve it.

*Please let me know if you find a solution 😉*

# "dsregcmd"

There is a tool called [dsregcmd](https://learn.microsoft.com/en-us/entra/identity/devices/troubleshoot-device-dsregcmd), which stands for "Directory Service Registration" and shows how your device is connected to Azure AD.

```
PS C:\Users\muehsig> dsregcmd /?
DSREGCMD switches
                        /? : Displays the help message for DSREGCMD
                   /status : Displays the device join status
               /status_old : Displays the device join status in old format
                     /join : Schedules and monitors the Autojoin task to Hybrid Join the device
                    /leave : Performs Hybrid Unjoin
                    /debug : Displays debug messages
               /refreshprt : Refreshes PRT in the CloudAP cache
          /refreshp2pcerts : Refreshes P2P certificates
          /cleanupaccounts : Deletes all WAM accounts
             /listaccounts : Lists all WAM accounts
             /UpdateDevice : Update device attributes to Azure AD
```

In Windows 11 - as far as I know - a new command was implemented: `/listaccounts`

# dsregcmd /listaccounts

This command lists all "WAM" accounts from my current profile:

*The `...xxxx...` is used to hide information*

```
PS C:\Users\muehsig> dsregcmd /listaccounts
Call ListAccounts to list WAM accounts from the current user profile.
User accounts:
Account: u:a17axxxx-xxxx-xxxx-xxxx-1caa2b93xxxx.85c7xxxx-xxxx-xxxx-xxxx-34dc6b33xxxx, user: xxxx.xxxx@xxxx.com, authority: https://login.microsoftonline.com/85c7xxxx-xxxx-xxxx-xxxx-34dc6b33xxxx.
Accounts found: 1.
Application accounts:
Accounts found: 0.
Default account: u:a17axxxx-xxxx-xxxx-xxxx-1caa2b93xxxx.85c7xxxx-xxxx-xxxx-xxxx-34dc6b33xxxx, user: xxxx.xxxx@xxxx.com.
```

# What is WAM?

It's __not__ the cool x-mas band with the fancy song (that we all love!). 

WAM stands for __Web Account Manager__ and it integrates with the Windows __Email & accounts__ setting:

![x]({{BASE_PATH}}/assets/md-images/2024-08-06/wam.png "WAM")

WAM can also be used to [obtain a Token](https://learn.microsoft.com/en-us/entra/identity-platform/scenario-desktop-acquire-token-wam) - which might be the right direction for my SSO question, but I couldn't find the time to test this out.

# "Connected to Windows"

This is now pure speculation, because I couldn't find any information about it, but I think the "Connected to Windows" hint here:

![x]({{BASE_PATH}}/assets/md-images/2024-08-06/login.png "Login")

... is based on the __Email & accounts__ setting (= WAM), and with `dsregcmd /listaccounts` I can see diagnostic information about it.

# TIL

I (and you!) have learned about a tool called `dsregcmd`. 

Try out the `dsregcmd /status`, it's like `ipconfig /all`, but for information about AD connectivity.

`WAM` plays an important part with the "Email & accounts" setting and maybe this is the right direction for the actual SSO topic.

# Open questions...

Some open questions:

- Why does `dsregcmd /listAccounts` only list one account when I have two accounts attached under the "WAM" (see screenshot - a Azure AD account AND an Microsoft account)?
- Where does "Connected to Windows" come from? How does the browser know this?

Hope this helps!