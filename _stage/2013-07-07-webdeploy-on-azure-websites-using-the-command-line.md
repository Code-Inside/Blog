---
layout: post
title: "WebDeploy on Azure Websites using the command line"
date: 2013-07-07 14:11
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
&nbsp;

<img style="background-image: none; padding-top: 0px; padding-left: 0px; padding-right: 0px; border: 0px;" title="image.png" src="{{BASE_PATH}}/assets/wp-images-de/image1867-570x194.png" border="0" alt="image.png" width="570" height="194" />

The deployment of ASP.NET applications on Azure websites in Visual Studio is pretty easy. With the new Azure SDK it is possible to import your Azure subscription and directly choose the already created Azure Website as deployment-destination:

<img style="background-image: none; padding-top: 0px; padding-left: 0px; padding-right: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1008.png" border="0" alt="image" width="544" height="431" />

<img style="background-image: none; padding-top: 0px; padding-left: 0px; padding-right: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1009.png" border="0" alt="image" width="553" height="440" />

&nbsp;

The deployment information’s are saved in a .pubxml file in the project. It includes all information’s – <strong>besides the password.</strong>

Visual Studio saves the password somewhere else. Besides it is not a very clean process to deploy out of Visual Studio it would be a better way to have a build system build the WebDeploy package and publish the project later on a random Azure website or a local IIS.

<strong> </strong>

<strong>How to publish a WebDeploy Package with an CMD?</strong>

If you use <a href="http://code-inside.de/blog-in/2010/11/21/howto-msdeploy-msbuild/">MSBuild for example to build a WebDeploy Package</a> you will receive a Batch-file beside the main package where you can start the process.

<img style="background-image: none; padding-top: 0px; padding-left: 0px; padding-right: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1010.png" border="0" alt="image" width="521" height="127" />

If you run the file like this you will see a ReadMe file. Important for Azure Websites: you need a password to deploy!

<strong> </strong>

<strong>How can I find the WebDeploy password for Azure Websites?</strong>

The only way I know is to download the Publishing-Profile using the Web-Management-Tool. The WebDeploy password isn’t connected to the FTP/GIT-password which can be set in addition!

<img style="background-image: none; padding-top: 0px; padding-left: 0px; padding-right: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1011.png" border="0" alt="image" width="501" height="341" />

This file shows the uncoded but still cryptical password:

<img style="background-image: none; padding-top: 0px; padding-left: 0px; padding-right: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1012.png" border="0" alt="image" width="530" height="83" /><strong></strong>

<strong></strong>

<strong>TL;DR – the CMD order:</strong>

That’s how it looks like in my example:
<div id="scid:9D7513F9-C04C-4721-824A-2B34F0212519:d0cd7f23-9689-4869-afa1-72568a0717dd" class="wlWriterEditableSmartContent" style="float: none; margin: 0px; display: inline; padding: 0px;">
<pre style="width: 836px; height: 43px; background-color: white; overflow: auto;">
<div><!--

Code highlighting produced by Actipro CodeHighlighter (freeware)
http://www.CodeHighlighter.com/

--><span style="color: #000000;">WebDeployPackage.deploy.cmd </span><span style="color: #000000;">/</span><span style="color: #000000;">y </span><span style="color: #800000;">"</span><span style="color: #800000;">/m:https://waws-prod-am2-001.publish.azurewebsites.windows.net/MsDeploy.axd?Site=blogpostsample</span><span style="color: #800000;">"</span><span style="color: #000000;"> </span><span style="color: #000000;">-</span><span style="color: #000000;">allowUntrusted </span><span style="color: #000000;">/</span><span style="color: #000000;">u:</span><span style="color: #800000;">"</span><span style="color: #800000;">$blogpostsample</span><span style="color: #800000;">"</span><span style="color: #000000;"> </span><span style="color: #000000;">/</span><span style="color: #000000;">p:</span><span style="color: #800000;">"</span><span style="color: #800000;">AssmJvtBrcWqfjaoHiANseLfyLuyJ1zyMn44L8YGQNKLCA9Rd9CZesxe9ilJ</span><span style="color: #800000;">"</span><span style="color: #000000;"> </span><span style="color: #000000;">/</span><span style="color: #000000;">a:Basic</span></div></pre>
<!-- Code inserted with Steve Dunn's Windows Live Writer Code Formatter Plugin.  http://dunnhq.com -->

</div>
You have to adapt the URL (/m:) (changes depending on the region), the site, the password (/p:) and the user (/u:). The information’s are available in the publishing-profile.

Additional you have to adapt the IIS App Name in the SetParameters.xmls file:
<div id="scid:9D7513F9-C04C-4721-824A-2B34F0212519:d78bb1db-c885-49dd-b8bd-6b00e174e947" class="wlWriterEditableSmartContent" style="float: none; margin: 0px; display: inline; padding: 0px;">
<pre style="width: 848px; height: 54px; background-color: white; overflow: auto;">
<div><!--

Code highlighting produced by Actipro CodeHighlighter (freeware)
http://www.CodeHighlighter.com/

--><span style="color: #000000;">&lt;?</span><span style="color: #000000;">xml version</span><span style="color: #000000;">=</span><span style="color: #800000;">"</span><span style="color: #800000;">1.0</span><span style="color: #800000;">"</span><span style="color: #000000;"> encoding</span><span style="color: #000000;">=</span><span style="color: #800000;">"</span><span style="color: #800000;">utf-8</span><span style="color: #800000;">"</span><span style="color: #000000;">?&gt;&lt;</span><span style="color: #000000;">parameters</span><span style="color: #000000;">&gt;</span><span style="color: #000000;">  </span><span style="color: #000000;">&lt;</span><span style="color: #000000;">setParameter name</span><span style="color: #000000;">=</span><span style="color: #800000;">"</span><span style="color: #800000;">IIS Web Application Name</span><span style="color: #800000;">"</span><span style="color: #000000;"> value</span><span style="color: #000000;">=</span><span style="color: #800000;">"</span><span style="color: #800000;">blogpostsample</span><span style="color: #800000;">"</span><span style="color: #000000;"> </span><span style="color: #000000;">/&gt;&lt;/</span><span style="color: #000000;">parameters</span><span style="color: #000000;">&gt;</span></div></pre>
<!-- Code inserted with Steve Dunn's Windows Live Writer Code Formatter Plugin.  http://dunnhq.com -->

</div>
Now you should be able to deploy directly on the Azure Website with the command line without any other tools.

Source:

I’ve got the solution after reading this <a href="http://blog.greatrexpectations.com/2013/02/02/publish-an-azure-web-site-from-the-command-line/">blogpost</a> – I’ve already asked the question on <a href="http://stackoverflow.com/questions/16433911/deploy-azure-website-via-msbuild-webdeploy-but-with-which-credentials">Stackoverflow</a> myself.
