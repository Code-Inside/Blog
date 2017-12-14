---
layout: post
title: "How to convert .crt & .key files to a .pfx"
description: "If you are dealing with SSL certificates and want to use them with IIS you will need a .pfx file. Some cert companys will just issue a .crt and .key file, but don't worry: Converting them to a PFX is easy."
date: 2017-07-31 23:15
author: Robert Muehsig
tags: [IIS, SSL, OpenSSL, crt, pfx, key]
language: en
---
{% include JB/setup %}

The requirements are simple: You will need the .cer with the corresponding .key file and need to download [OpenSSL](https://wiki.openssl.org/index.php/Binaries).

If you are using Windows __without the awesome Linux Subsystem__, take the latest pre-compiled version __for Windows__ [from this site](https://indy.fulgan.com/SSL/).

Otherwise with __Bash on Windows__ you can just use OpenSSL via its "native" environment. *Thanks for the hint @kapsiR*

After the download run this command:

       openssl pkcs12 -export -out domain.name.pfx -inkey domain.name.key -in domain.name.crt

This will create a __domain.name.pfx__. As far as I remember you will be asked to set a password for the generated private .pfx part.

If you are confused with .pfx, .cer, .crt take a look at this [nice description blogpost](http://www.gtopia.org/blog/2010/02/der-vs-crt-vs-cer-vs-pem-certificates/).

Hope this helps!
