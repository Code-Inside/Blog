---
layout: post
title: ".NET CultureInfo in Windows 10"
description: "See how the .NET CultureInfo behavior has changed with Windows 10"
date: 2017-04-23 23:45
author: Robert Muehsig
tags: [Windows 10, .NET]
language: en
---
{% include JB/setup %}

Did you know that the CultureInfo behavior with __"unkown"__ cultures has changed with Windows 10? 

I stumbled two times about this "problem" - so this is enough to write a short blogpost about it.

## Demo Code

Lets use this democode:

        try
        {


            // ok on Win10, but not on pre Win10 if culture is not registred
            CultureInfo culture1 = new CultureInfo("foo");
            CultureInfo culture2 = new CultureInfo("xyz");
            CultureInfo culture3 = new CultureInfo("en-xy");

            // not ok even on Win 10 - exception
            CultureInfo culture4 = new CultureInfo("foox");

        }
        catch (Exception exc)
        {

        }

## Windows 10 Case

If you run this code under Windows 10 it should fail for the "foox" culture, because it doesn't seem to be a valid culture anyway.

"culture1", "culture2", "culture3" are all __valid__ cultures in the Windows 10 world, but are resolved with __Unkown Locale__ and __LCID 4096__.

*I guess Windows will look for a 2 or 3 letter ISO style language, and "foox" doesn't match this pattern.*

## Pre Windows 10 - e.g. running on Win Server 2012R2

If you would run the code unter Windows Server 2012 R2 it would fail on the first culture, because there is no "foo" culture registred.

## "Problem" 

The main "problem" is that this behavior could lead to some production issues if you develop with Windows 10 and the software is running on a Win 2012 server.

__If__ you are managing "language" content in your application, be aware of this "limitation" on older Windows versions. 

I discovered this problem while debugging our backend admin application. With this ASP.NET frontend it is possible to add or manage "localized" content and the dropdown for the possible language listed a whole bunch of very special, but "Unkown locale" cultures. So we needed to filter out all LCID 4096 cultures to ensure it would run under all Windows versions.

## MSDN

This behavior is also documented on __[MSDN](https://msdn.microsoft.com/en-us/library/system.globalization.cultureinfo.lcid%28v=vs.110%29.aspx?f=255&MSPPError=-2147217396)__ 

The __["Unkown culture" LCID 4096](https://msdn.microsoft.com/en-us/library/windows/desktop/dd373745(v=vs.85).aspx)__ was introduced with Windows Vista, but only with Windows 10 it will be "easy" usable within the .NET Framework.

## (update!) LCID 8192?

Today I was preparing a new machine and I found a pretty interesting case and our application had some problems. I checked the CultureInfo stuff and this is what I got on a Windows 10 machine, that should be a EN-US machine, but somehow ended up with a "Swiss" configuration:

    CurrentCulture.LCID: 8192 - English (Switzerland)
    CurrentUICulture.LCID: 1033 - English (United States)

I have no idea why this machine had this configuration, but the CurrentCulture was set to 8192. After a bit of googling I found the confusing answer from this [MSDN "Locale Names without LCIDs"-Site](https://msdn.microsoft.com/en-us/library/dn363603.aspx?f=255&MSPPError=-2147217396):

*"If the user has configured any of these locales without LCIDs in their Language Profile, then the system MAY assign them additional values to provide applications with temporary unique identifiers. Those temporary LCIDs can differ between processes, machines, users, and application instances. If a temporary LCID is assigned it will be dynamically assigned at runtime to be 0x2000, 0x2400, 0x2800, 0x2C00, 0x3000, 0x3400, 0x3800, 0x3C00, 0x4000, 0x4400, 0x4800, or 0x4C00, for the valid language-script-region tags not otherwise listed in this table."*

It seems you not only can end up with LCID 4096, but with a wild language combination you can get 8192 or any of those codes above. Be aware of the problems when you are working with LCIDs, because they are more or less ["deprecated"](https://blogs.msdn.microsoft.com/shawnste/2013/10/23/lcids-vs-locale-names-and-the-deprecation-of-lcids/).
