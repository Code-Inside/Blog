---
layout: post
title: "Signing with SignTool.exe - don't forget the timestamp!"
description: "If you need to sign your assemblies or installers be aware of time-stamping... "
date: 2017-11-31 23:15
author: Robert Muehsig
tags: [installer, msi, signtool]
language: en
---
{% include JB/setup %}

If you currently not touching signtool.exe at all or have nothing to do with "signing" you can just pass this blogpost, because this is more or less a stupid "Today I learned I did a mistake"-blogpost.

# Signing?

We use authenticode code signing for our software just to prove that the installer is from us and "safe to use", otherwise you might see a big warning from Windows that the application is from an "unknown publisher":

![x]({{BASE_PATH}}/assets/md-images/2017-11-30/uac.png "UAC")

To avoid this, you need a code signing certificate and need to sign your program (e.g. the installer and the .exe)

# The problem...

We are doing this code signing since the first version of our application. Last year we needed to buy a new certificate because the first code signing certificate was getting stale. Sadly, after the first certificate was expired we got a call from a customer who recently tried to install our software and the installer was signed with the "old" certificate. The result was the big "Warning"-screen from above.

I checked the file and compared it to other installers (with expired certificates) and noticed that our signature didn't had a timestamp:

![x]({{BASE_PATH}}/assets/md-images/2017-11-30/properties.png "Properties")

# The solution

I stumbled upon [this great blogpost about authenticode code signing](https://blogs.msdn.microsoft.com/ieinternals/2011/03/22/everything-you-need-to-know-about-authenticode-code-signing/) and the timestamp was indeed important:

*When signing your code, you have the opportunity to timestamp your code; you should definitely do this. Time-stamping adds a cryptographically-verifiable timestamp to your signature, proving when the code was signed. If you do not timestamp your code, the signature will be treated as invalid upon the expiration of your digital certificate. Since it would probably be cumbersome to re-sign every package you’ve shipped when your certificate expires, you should take advantage of time-stamping. A signed, time-stamped package remains valid indefinitely, so long as the timestamp marks the package as having been signed during the validity period of the certificate.*


Time-stamping itself is pretty easy and only one parameter was missing all the time... now we invoke [Signtool.exe](https://docs.microsoft.com/en-us/dotnet/framework/tools/signtool-exe) like this and we have a digitial signature __with__ a timestamp:

    signtool.exe sign /tr http://timestamp.digicert.com /sm /n "Subject..." /d "Description..." file.msi

Remarks: 

* Our code signing cert is from Digicert and they provide the timestamp URL.
* SignTool.exe is part of the Windows SDK and currently is in the ClickOnce folder (e.g. C:\Program Files (x86)\Microsoft SDKs\ClickOnce\SignTool\)

Hope this helps.



