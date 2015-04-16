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

Well, this was my first thought when I was thinking about a simple approach to protect Web APIs, but then I found this nicely written blogpost: [Why I love Basic Auth](http://www.rdegges.com/why-i-love-basic-auth/)

The topic is still very controversial, but if it done right and you are using SSL: Why not give it a try. There are other well known examples, suchs as the [GitHub API](https://developer.github.com/v3/auth/) which can be used with Basic Auth.

## Short introduction to Basic Authentication

We can all agree that Basic Authentication is dead simple for HTTP Servers and Clients. The Client just needs to send the given Username and Password Base64 encoded in the "Authorization" HTTP header like this:

    Authorization: Basic dXNlcm5hbWU6cGFzc3dvcmQ=

The "dXN" is just "username:password" encoded in Base64.

Now the Server just needs to decode the Username and Password and get the actual user lookup started. The Server can also inform Clients that the authentication is need via this HTTP Response Header:

    WWW-Authenticate: Basic realm="RealmName"
	
All typical Clients and Servers can handle this "basic" stuff very well.
