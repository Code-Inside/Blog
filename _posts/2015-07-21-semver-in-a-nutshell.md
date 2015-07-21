---
layout: post
title: "Semantic Versioning in a nutshell"
description: "TL;DR: Instead of Major.Minor.Patch say Breaking.Feature.Bugfix"
date: 2015-07-21 23:30
author: robert.muehsig
tags: [SemVer]
language: en
---
{% include JB/setup %}

I made a short tweet today and it seems I hit a nerve:

<blockquote class="twitter-tweet" lang="de"><p lang="en" dir="ltr">Instead of Major.Minor.Patch say Breaking.Feature.Bugfix - that&#39;s <a href="https://twitter.com/hashtag/SemVer?src=hash">#SemVer</a> in a nutshell.</p>&mdash; Robert Muehsig (@robert0muehsig) <a href="https://twitter.com/robert0muehsig/status/623397900274561024">21. Juli 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Because I like blogging I decided to write a small blogpost about SemVer.

## Why Semantic Versioning (SemVer)

In our industry we use version numbers a lot. The typical naming is *MAJOR.MINOR.PATCH*, sometimes also *MAJOR.MINOR.PATCH.BUILD* or instead of *PATCH* you could say *REVISION* - it is more or less the same.  

But the problem is: This is not very self describing. What is *MAJOR* or a *REVISION*? When should I change the *MAJOR* version and when should I increase the *MINOR* version etc.
You see: It sounds simple, but it is really complicated.

## SemVer

__[SemVer](http://semver.org/)__ is a pretty simple concept to give each part a better description.

> Given a version number MAJOR.MINOR.PATCH, increment the:
> 
> MAJOR version when you make incompatible API changes,
> MINOR version when you add functionality in a backwards-compatible manner, and
> PATCH version when you make backwards-compatible bug fixes.
> Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

If you change your API with breaking changes: Increase the MAJOR version. A new feature? Increase the *MINOR* version. Bugfix? Simple... 

So in short: __Breaking.Feature.Bugfix__

## It's a technical solution - don't try to get nice Marketing-Version-Numbers.

SemVer is a technical solution - if you want to get great Marketing-Version-Numbers this will probably fail, so maybe you should split the "commercial" and "technical" version number.

<blockquote class="twitter-tweet" lang="de"><p lang="en" dir="ltr">There should also be a separate &#39;commercial&#39; number so as not to interfere so V3 - 12.166.2 <a href="https://t.co/Gp61dYltkf">https://t.co/Gp61dYltkf</a></p>&mdash; Dean McDonnell (@McDonnellDean) <a href="https://twitter.com/McDonnellDean/status/623422780739072000">21. Juli 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

## Learn more

I had read the "Breaking.Feature.Bugfix" summary somewhere else, but I can't remember the original author (Kudos!), but I received this Tweet with a full talk about exactly this topic, so if you want to learn more:

<blockquote class="twitter-tweet" lang="de"><p lang="en" dir="ltr"><a href="https://twitter.com/robert0muehsig">@robert0muehsig</a> <a href="https://twitter.com/PascalPrecht">@PascalPrecht</a> Glad you like it :) The original tweet: <a href="https://t.co/QGlydUsPYg">https://t.co/QGlydUsPYg</a> + an entire talk: <a href="https://t.co/iydJudpqYW">https://t.co/iydJudpqYW</a></p>&mdash; Stephan Bönnemann (@boennemann) <a href="https://twitter.com/boennemann/status/623451396386476032">21. Juli 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

## Well...

Just for fun:

<blockquote class="twitter-tweet" lang="de"><p lang="en" dir="ltr"><a href="https://twitter.com/robert0muehsig">@robert0muehsig</a> <a href="https://twitter.com/chrisoldwood">@chrisoldwood</a> I use node, so versioning is Unused.Breaking.Breaking ;)</p>&mdash; I, Dom Davis (@idomdavis) <a href="https://twitter.com/idomdavis/status/623492934734872576">21. Juli 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

;)

Hope this helps!
