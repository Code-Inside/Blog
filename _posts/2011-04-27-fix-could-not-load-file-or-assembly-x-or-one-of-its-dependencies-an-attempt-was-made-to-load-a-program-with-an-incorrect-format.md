---
layout: post
title: "Fix: “Could not load file or assembly 'x' or one of its dependencies. An attempt was made to load a program with an incorrect format.”"
date: 2011-04-27 10:51
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Windows Server 2008 R2; x64]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1258.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb438.png" width="146" height="80" /></a> </p>  <p>Diese etwas nicht sagende Fehlermeldung hatte mich heute etwas herausgefordert. Vermutlich gibt es dutzende Fehlerquellen - meine war: Windows 2008 R2 auf X64 und eine fehlende IIS Einstellung.</p> <!--more-->  <p><strong>Lösung:</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1259.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb439.png" width="201" height="244" /></a> </p>  <p>In den Advanced Settings des Applicationspools muss "<strong>Enable 32-Bit Applications</strong>” auf "<strong>True</strong>” stehen (per Default ist es auf false!).</p>  <p><a href="http://social.msdn.microsoft.com/Forums/en-US/wfprerelease/thread/db9616e8-07b4-4c6d-91f7-04edfc494988/">Hier</a> gibts bestimmt noch mehr Tipps zu dem Problem.</p>
