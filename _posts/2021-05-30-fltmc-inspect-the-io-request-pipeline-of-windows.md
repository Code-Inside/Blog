---
layout: post
title: "Today I learned (sort of) 'fltmc' to inspect the IO request pipeline of Windows"
description: "TLDR; You will learn something about 'filter drivers' in Windows"
date: 2021-05-30 22:00
author: Robert Muehsig
tags: [Windows]
language: en
---

{% include JB/setup %}

The headline is obviously a big lie, because I followed [this twitter conversation](https://twitter.com/richturn_ms/status/1245836872598704128) last year, but it's still interesting to me and I wanted to write it somewhere down.

Starting point was that [Bruce Dawson (Google programmer)](https://twitter.com/BruceDawson0xB) noticed, that building Chrome on Windows is slow for various reasons:

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Based on some twitter discussion about source-file length and build times two months ago I wrote a blog post. It&#39;s got real data based on Chromium&#39;s build, and includes animations of build-time improvements:<a href="https://t.co/lsLH8BNe48">https://t.co/lsLH8BNe48</a></p>&mdash; Bruce Dawson (Antifa) (@BruceDawson0xB) <a href="https://twitter.com/BruceDawson0xB/status/1244850501457285122?ref_src=twsrc%5Etfw">March 31, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

[Trentent Tye](https://twitter.com/TrententTye) told him to disable the "filter driver":

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">disabling the filter driver makes it dead dead dead. Might be worth testing with the number and sizes of files you are dealing with. Even half a millisecond of processing time adds up when it runs against millions and millions of files.</p>&mdash; Trentent Tye (@TrententTye) <a href="https://twitter.com/TrententTye/status/1245395826907602945?ref_src=twsrc%5Etfw">April 1, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

If you have never heard of a "filter driver" (like me :)), you might want to take a look [here](https://docs.microsoft.com/en-us/windows-hardware/test/assessments/minifilter-diagnostics).

To see the loaded filter driver on your machine try out this: Run `fltmc` ([fltmc.exe](https://docs.microsoft.com/en-us/windows-hardware/drivers/ifs/development-and-testing-tools)) as admin. 

![x]({{BASE_PATH}}/assets/md-images/2021-05-30/fltmc.png "fltmc result")

Description:

<blockquote class="twitter-tweet" data-conversation="none"><p lang="en" dir="ltr">Each filter in the list sit in a pipe through which all IO requests bubble down and up. They see all IO requests, but ignore most. Ever wondered how Windows offers encrypted files, OneDrive/GDrive/DB file sync, storage quotas, system file protection, and, yes, anti-malware? ;)</p>&mdash; Rich Turner (@richturn_ms) <a href="https://twitter.com/richturn_ms/status/1245836872598704128?ref_src=twsrc%5Etfw">April 2, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

This makes more or less sense to me. I'm not really sure what to do with that information, but it's cool (nerd cool, but anyway :)).  