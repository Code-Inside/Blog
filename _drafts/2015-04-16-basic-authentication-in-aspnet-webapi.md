---
layout: post
title: "Using Basic Authentication in ASP.NET WebAPI"
description: "Back to the roots: How to use Basic Authentication to protect your ASP.NET WebAPI"
date: 2015-04-15 23:30
author: robert.muehsig
tags: [Basic Auth, WebAPI, ASP.NET]
language: en
---
{% include JB/setup %}


## Basic Authentication? Are you kidding?

Well, this was my first thought when I was thinking about a simple approach to protect my Web APIs. But then I found this nicely written blogpost http://www.rdegges.com/why-i-love-basic-auth/ 

The topic is still very controversial, but if it done right and you are using SSL: Why not give it a try.

## Short introduction to Basic Authentication

We can all agree that Basic Authentication is dead simple for HTTP Servers and Clients. 