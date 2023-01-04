---
layout: post
title: "Your URL is flagged as malware/phishing, now what?"
description: "Checkpoint & Windows Defender - fun with false positives."
date: 2023-01-04 22:15
author: Robert Muehsig
tags: [Malware]
language: en
---

{% include JB/setup %}

# Problem

On my last day in 2022 - Friday, 23. December, I received a support ticket from one customer, that our software seems to be offline and it looks like that our servers are not responding. I checked our monitoring and the server side of the customer and everything was fine. 
My first thought: Maybe a missconfiguration on the customer side, but after a remote support session with the customer, it "should" work, but something in the customer network block the requests to our services.
Next thought: Firewall or proxy stuff. Always nasty, but we are just using port 443, so nothing to special.

After a while I received a phone call from the customers firewall team and they discovered the problem: They are using a firewall solution from "Check Point" and __our domain was flagged as "phishing"/"malware"__. What the... 
They even created a exception so that Check Point doesn't block our requests, but the next problem occured: The customers "Windows Defender for Office 365" has the same "flag" for our domain, so they revert everything, because they didn't want to change their settings too much.

![x]({{BASE_PATH}}/assets/md-images/2023-01-04/defender-warning.png "Defender Warning")

Be aware, that from our end everything was working "fine" and I could access the customer services and our Windows Defender didn't had any problems with this domain.

# Solution

Somehow our domain was flagged as malware/phishing and we needed to change this false positive listening. I guess there are tons of services, that "tracks" "bad" websites and maybe all are connected somehow. From this indicent I can only suggest:

__If you have trouble with Check Point:__

Go to ["URLCAT"](https://urlcat.checkpoint.com/urlcat/main.htm), register an account and try to change the category of your domain. After you submit the "change request" you will get an email like this:

```
Thank you for submitting your category change request.
We will process your request and notify you by email (to: xxx.xxx@xxx.com ).
You can follow the status of your request on this page.
Your request details
Reference ID: [GUID]
URL: https://[domain].com
Suggested Categories: Computers / Internet,Business / Economy
Comment: [Given comment]
```

After ~1-2 days the change was done. Not sure if this is automated or not, but it was during Christmas.

__If you have trouble with Windows Defender:__

Go to ["Report submission"](https://security.microsoft.com/reportsubmission) in your Microsoft 365 Defender setting (you will need an account with special permissions, e.g. global admin) and add the URL as "Not junk".

![x]({{BASE_PATH}}/assets/md-images/2023-01-04/defender-report.png "Defender Report")

I'm not really sure if this helped or not, because we didn't had any issues with the domain itself and I'm not sure if those "false positive" tickets bubbles up into a "global defender catalog" or if this only affects our own tenant. 

# Result

Anyway - after those tickets were "resolved" by Check Point / Microsoft the problem on the customer side disappeared and everyone was happy. This was my first experience with such an "false positive malware report". I'm not sure how we ended up on such a list and why only one customer was affected.   

Hope this helps! 