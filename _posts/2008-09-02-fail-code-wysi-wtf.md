---
layout: post
title: "Fail Code - WYSI... WTF!"
date: 2008-09-02 12:36
author: robert.muehsig
comments: true
categories: [FailCode]
tags: [Fail, WTF]
---
<p>Je mehr Prüfungen man macht, desto sicherer wird der Code:</p> <p></p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:72aa9e2f-a073-4d73-9560-650e818bb439" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            if (windowHandelsLocked &amp;&amp; !windowHandelsLocked)
                return;</pre></div>
<p>Fail.</p>
