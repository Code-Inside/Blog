---
layout: post
title: "Fix: „There is a duplicate ‚uri‘ section defined“ on DotNetOpenAuth"
date: 2011-12-10 11:01
author: CI Team
comments: true
categories: [Fix]
tags: [duplicate; DotNetOpenAuth]
language: en
---
{% include JB/setup %}

  
  <p>A little hint about what to do if you receive this error.</p>  <p><b>Following setup for me:</b></p>  <p>- Asp.NET MVC project including .NET Framework 4.0</p>  <p>- <a href="http://www.dotnetopenauth.net/">DotNetOpenAuth</a> via <a href="http://nuget.org/">NuGet</a> installed</p>  <p>- The Webprojects also used “Cassini”</p>  
  <p><b>During the deployment to an ordinary IIS I received this error message:</b></p>  
  <p><i>“There is a duplicate ‘uri’ section defined”</i></p>  <p><i></i></p>  <p>This line was marked in red:</p>  <p>&lt;section name=”uri” type=”System.Configuration.UriSection, System, Version=2.0.0.0,Culture = neutral, PublicKeyToken=b77a5c561934e089” /&gt;</p>  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb601.png" width="593" height="306" /></p>  
  <p><b>Solution</b></p>  
  <p>(Very easy <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile30.png" />) Delete the following line from your own Web.config:</p>  <p><em>&lt;section name=”uri” type=”System.Configuration.UriSection, System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089″ /&gt;</em></p>  
  <p><b>Reason: </b>This entry is already included into the machine.config of .NET 4.0 applications so it would be double. </p>  <p>The Problem is only in connection with IIS and IIS Express. “Cassini” doesn’t recognize it at all (unfortunately). This Hint is, like almost every time from <a href="http://stackoverflow.com/questions/2475329/steps-to-investigate-cause-of-web-config-duplicate-section">Stackoverflow</a> (but in my opinion the best answer is a little bit too complicated so I decided to write this blogpost <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile30.png" />) </p>
