---
layout: post
title: "OpenGraph for Twitter Cards"
description: "Instead of using Twitters proprietary meta tags just use OpenGraph"
date: 2014-09-17 23:00
author: robert.muehsig
tags: [OpenGraph, Twitter]
language: en
---
{% include JB/setup %}

On of the first things I did on this blog was to enable the "Twitter Card" integration. 

## What is Twitter Card?
Twitter Cards are a way to preview you content / post / site when shared via Twitter. When someone tweets your blog post Twitter (and Facebook and others...) will reach out to your site and try to find meta information. With the correct meta tags Twitter & co. will display more information.

## Minimal Twitter Card Integration
Twitter understands Twitters "own" proprietary meta tags and (some) [OpenGraph](http://ogp.me/) meta tags.
If you try to get the minimal "Twitter Card" integration for your site you will need the following meta tags:

    <meta name="twitter:card" content="summary">
    <meta name="twitter:site" content="@TWITTERHANDLE"> 

    <meta property="og:title"       content="SOME TITLE" />
    <meta property="og:type"        content="blog" /> 
    <meta property="og:url"         content="HTTP://AWESOMENESS.IO" /> 
    <meta property="og:description" content="SOME DESCRIPTION" >

This markup works well on [nuget.org](https://github.com/NuGet/NuGetGallery/pull/2173)

## Twitter Card Markup
I only applied the minimal Twitter Card Integration on this blog currently and it works for me. If you need a more sophisticated Twitter Card read the docs at the [Twitter Dev Center](https://dev.twitter.com/cards/types). 

## Register for Twitter Card
To get things running you need to verify your site via the [Twitter Dev Center](https://dev.twitter.com/cards/overview). This process takes one or two days and doesn't cost anything.

## Test your site
You can test your site [here](https://cards-dev.twitter.com/validator).

## Social Meta Tags for Twitter, Google, Facebook and more
This [Blogpost](http://moz.com/blog/meta-data-templates-123) is an awesome resource to learn more about the different Meta-Tags for Facebook, Goolge & co.
