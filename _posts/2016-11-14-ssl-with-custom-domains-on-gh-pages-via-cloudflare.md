---
layout: post
title: "Enable SSL with custom domains on GitHub Pages via Cloudflare"
description: "Encryption is important these days, but is not out of the box possible with a custom domain on GitHub Pages. I will show you how to enable SSL with Cloudflare - it is super easy and free."
date: 2016-11-31 23:15
author: Robert Muehsig
tags: [SSL, HTTPS, GitHub, Cloudflare]
language: en
---
{% include JB/setup %}

Two weeks ago I decided (finally!) that I should enable SSL on this blog. 

## Problem: GitHub Pages with a custom domain

This blog is hosted on GitHub Pages with a custom domain, which currently doesn't support SSL out of the box. If you stick with a github.io domain SSL is not a problem.

## Cloudflare to the rescure

I decided to take a deeper look at __[Cloudflare](https://www.cloudflare.com)__, which provides DNS, CDN and other "network"-related services. For the "main" service Cloudflare serves as the DNS for your domain and is like a proxy. 

With this setup you have some nice benefits: 

* A free SSL certificate (AFAIK you can also use your own cert if you need)
* A CDN cache
* DDOS protection
* "Analytics"

Be aware: This is just the __free plan__. 

And everything is pretty easy to manage via the web interface. 

### Setup

The first step is to register at Cloudflare & setup your domain. After the first step you need to change the name server for your domain to Cloudflares server.

All your domain belonging can now be managed inside Cloudflare:

![x]({{BASE_PATH}}/assets/md-images/2016-11-14/dns.png "DNS")

### Setting up some rules

When your DNS changes are done (which can take a couple of hours) you might want to introduce some basic rules. I use these settings, which enforces HTTPS and Cloudflare cache:

![x]({{BASE_PATH}}/assets/md-images/2016-11-14/rules.png "Rules")

### Done... or nearly done.

Now we have done the "Cloudflare-part". The next step is to make sure that everything on your page uses HTTPS instead of HTTP to avoid "mixed content"-errors.

Some notes from my own "migration":

* If you have Google Analytics - make sure you change the property-settings to the HTTPS URL
* If you use Disqus you __need__ to migrate your comments from the HTTP url to the HTTPS URL. There is a migrate tool available, which uses a CSV file. 

## Other solutions...

As far as I know there are other, similar, providers out there and of course you can host the page yourself.

Cloudflare is an easy solution if you are willing to hand of the DNS settings of your domain.

Hope this helps!