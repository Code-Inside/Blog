---
layout: post
title: "Automated Security Analyser for ASP.NET websites"
date: 2012-05-09 18:18
author: CI Team
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image.png" src="{{BASE_PATH}}/assets/wp-images-de/image1510-570x194.png" border="0" alt="image.png" width="570" height="194" />

Evil Hackers are lurking everywhere and many Web-applications are delicately and share “too much” with the attacker.

A quick (first!) overview offers the Tool “<a href="https://asafaweb.com/">ASafaWeb</a>”. All the website does is making a few requests and writing an Analyses including problem solving’s. There are no permanent disadvantages (bad requests/ DoS attacks and so on).

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb681.png" border="0" alt="image" width="539" height="305" />

Example: <a href="http://www.knowyourstack.com/">KnowYourStack.com</a>

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image1511.png" border="0" alt="image" width="547" height="223" />

There is a short description including a problem solving:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb682.png" border="0" alt="image" width="434" height="233" />

The last test recommends hiding the information’s about the ASP.NET version / IIS.

<strong>That’s not enough!</strong>

The service only provides very simple tests – For example there is no test for the entering validation. Here <a href="{{BASE_PATH}}/2012/04/03/xss-in-asp-net-mvcrequestvalidation-html-displayfor-mvchtmlstring/">you need to be very carefully!</a>

If someone wants to share more tips with us you are welcome J

<strong>Prevent the Top 10 Security holes!</strong>

<strong> </strong>

Some time ago <a href="http://philipproplesch.de/post/gaengige-angriffe-auf-webseiten-vermeiden">Philip Proplesch</a> referred about the excellent Blog row from Troy Hunt: <a href="http://www.troyhunt.com/2010/05/owasp-top-10-for-net-developers-part-1.html">OWASP Top 10 for .NET developer’s part 1: Injection. Read!</a>
