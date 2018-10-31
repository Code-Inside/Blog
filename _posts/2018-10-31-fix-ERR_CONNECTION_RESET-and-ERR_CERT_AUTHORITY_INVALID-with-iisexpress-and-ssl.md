---
layout: post
title: "How to fix ERR_CONNECTION_RESET & ERR_CERT_AUTHORITY_INVALID with IISExpress and SSL"
description: "Selfsigned certificats for localhost development gone wrong... and fixed!"
date: 2018-10-31 23:45
author: Robert Muehsig
tags: [SSL, IISExpress, TLS, Chrome]
language: en
---
{% include JB/setup %}

This post is a result of some pretty strange SSL errors [that I encountered last weekend](https://github.com/NuGet/NuGetGallery/issues/3892#issuecomment-427608552).

__The scenario:__

I tried to setup a development environment for a website that uses a self signed SSL cert. The problem occured right after the start - especially Chrome displayed those wonderful error messages:

* ERR_CONNECTION_RESET
* ERR_CERT_AUTHORITY_INVALID

__The "maybe" solution:__

When you google the problem you will see a couple of possible solutions. I guess the first problem on my machine was, that a previous cert was stale and thus created this issue.
I later then began to delete all localhost SSL & IIS Express related certs in the LocalMachine-Cert store. Maybe this was a dumb idea, because it caused more harm then it helped.

But: Maybe this could solve your problem. Try to check your LocalMachine or LocalUser-Cert store and check for stale certs.

__How to fix the IIS Express?__

Well - after I deleted the IIS Express certs I couldn't get anything to work, so I tried to repair the IIS Express installation and boy... this is a long process. 

The repair process via the Visual Studio Installer will take some minutes and in the end I had the same problem again, but my IIS Express was working again.

__How to fix the real problem?__

After some more time (and I did repair the IIS Express at least 2 or 3 times) I tried the second answer from this [Stackoverflow.com question](https://stackoverflow.com/questions/20036984/how-do-i-restore-a-missing-iis-express-ssl-certificate):

    cd C:\Program Files (x86)\IIS Express\IisExpressAdminCmd.exe setupsslUrl -url:https://localhost:44387/ -UseSelfSigned

And yeah - this worked. Puh... 

__Conclusion:__

* Don't delete random IIS Express certs in your LocalMachine-Cert store.
* If you do: Repair the IIS Express via the Visual Studio Installer (the option to repair IIS Express via the Programs & Feature management tool seems to be gone with VS 2017).
* Try to setup the SSL cert with the "IisExpressAdminCmd.exe" - this helped me a lot.


I'm not sure if this really fixed my problem, but maybe it may help: 

You can "manage" some part of the SSL stuff via "netsh" from a normal cmd prompt (powershell acts weird with netsh), e.g.:

    netsh http delete sslcert ipport=0.0.0.0:44300
    netsh http add sslcert ipport=0.0.0.0:44300 certhash=your_cert_hash_with_no_spaces appid={123a1111-2222-3333-4444-bbbbcccdddee}
	
Be aware: I remember that I deleted a sslcert via the netsh tool, but was unable to add a sslcert. After the IisExpressAdminCmd.exe stuff I worked for me.

Hope this helps!