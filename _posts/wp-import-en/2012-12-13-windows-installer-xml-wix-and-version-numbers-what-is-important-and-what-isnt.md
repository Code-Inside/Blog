---
layout: post
title: "Windows Installer XML (Wix) and version numbers: What is important and what isn’t"
date: 2012-12-13 16:21
author: CI Team
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image1677.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image1677" border="0" alt="image1677" src="{{BASE_PATH}}/assets/wp-images-en/image1677_thumb.png" width="152" height="88" /></a></p>  
  <p>If you are building setups/installer (Do you know the difference?) in the world of windows you might have heard about the <a href="http://wix.sourceforge.net/">Windows Installer XML (Wix) toolset.</a></p>
<p><b>Version number in Wix</b></p>  
  <p>While building an installer it is possible to define a version number after the usual system Major.Minor.Build.Revision which will be visible at the programs in the system administration:</p>
<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb836.png" width="534" height="135" /></p>
<p><b>What’s important in the case of an update</b></p>  
  <p>If the software is installed in version 1.0.0.0 and you wish to install the new version 2.0.0.0 Wix is going to recognize the difference and delete the older version automatically. </p>
<p>The problem appears if you change the last number of the version because Wix won’t recognize this. </p>
<p><b>Example: </b></p>
<p>Version 1.0.0.0 is currently installed and now version 1.0.0.1 is delivered. In this case the installer won’t delete the older version but reinstall it. Not until you reach version 1.0.1.0 he will recognize the difference and the usual upgrade-process works properly. </p>
<p>More information’s on the <a href="http://wix.sourceforge.net/manual-wix3/major_upgrade.htm">official website</a>. </p>
<p><b>How did I recognize the problem?</b></p>  
  <p>I’ve found this problem because that’s how our Nightly Build System generated version numbers after this system till now: 1.0.YYMM.DDBuildNumber – that means a lot of useless dead weight for my system at the end of the month <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile48.png" /></p>
<p>Thanks a lot also to <a href="https://twitter.com/Cayas_Software">Sebastian Seidel</a> – who provides me with several good hints about Installers on Twitter. </p>
<p><b>Conclusion</b></p>  
  <p>Wix-Version system: Number.Number.Number.doesn’t matter </p>
