---
layout: post
title: "WebApps easy deploying with the Windows Azure Accelerator for Web Roles"
date: 2011-10-05 15:07
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: [Windows Azure Accelerator]
language: en
---
{% include JB/setup %}
&nbsp;

<strong> </strong>

The definitely catchy name <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile27.png" alt="Zwinkerndes Smiley" /> stands for a relative clever Deploymentmodell for Windows Azure. Base is the fact, that the <a href="http://blogs.msdn.com/b/windowsazure/archive/2010/12/02/new-full-iis-capabilities-differences-from-hosted-web-core.aspx">Web Roll of Azure is able since a few versions are able to use the full IIS.</a>

That means, in one Web-Roll many websites are able to run. The configuration was a little bit <a href="http://blogs.msdn.com/b/avkashchauhan/archive/2011/01/01/windows-azure-how-to-define-virtual-directories-in-service-definition-csdef-for-your-site.aspx">bulky so far</a>.

The best fact: You can use WebDeploy on Azure and it will be saved so all things are persistent on the Blob Storage!

The initialization takes about 10 minutes (+ 15 minutes for singular deploying on the usual way)

<strong>What’s the “Windows Azure Accelerator for Web Roles”? </strong>

<a href="{{BASE_PATH}}/assets/wp-images-en/image1341.png"><img style="background-image: none; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; padding-top: 0px; border-width: 0px;" title="image1341" src="{{BASE_PATH}}/assets/wp-images-en/image1341_thumb.png" border="0" alt="image1341" width="180" height="332" align="left" /></a>In fact it’s a new <a href="http://waawebroles.codeplex.com/">projecttemplate</a> including a kind of “Container-App” (the “Website Manager”). You don’t have to change anything on the project – you will be guided through a Wizard and set the used Credentials for the WebDeploy.

On the left side you can see the two projects we are going to use:

- A normal Cloud Project with the “Container” application

- The Container App “Website Manager”

You don’t have to change anything on the last project. This application will receive the “WebDeploy” packages later on and put them on the Blob-Storage afterwards. Beside this application takes care of endowing every instance with a configuration package. That’s why it’s named “Container”.

<strong>After the Deployment… </strong>

<strong> </strong>

The “Web Site Manager” offers only a few configuration options. At the web surface you are able to add new IIS bindings and manage the synchronization process (spread packages from the Blob Storages on the instance) – a screenshot:

<a href="{{BASE_PATH}}/assets/wp-images-en/image1342.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border-width: 0px;" title="image1342" src="{{BASE_PATH}}/assets/wp-images-en/image1342_thumb.png" border="0" alt="image1342" width="539" height="225" /></a>

<strong>5-Minute access…</strong>

<strong> </strong>

Videos says more than 1000 words – here a <a href="http://channel9.msdn.com/posts/Getting-Started-with-the-Windows-Azure-Accelerator-for-Web-Roles">5 minutes access from Channel 9</a>

&nbsp;

&nbsp;

<strong>The main application </strong>

<strong> </strong>

The actually application which you want to run on Azure don’t need to know about Azure. The WebDeploy could also run on a normal Windows Server. ( as far as you don’t want to use all Azure Features (Blob Storage, Tables…))

<strong>Wher did I get the “Windows Azure Accelerator for Web Roles”?</strong>

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb525.png" border="0" alt="image" width="94" height="102" align="left" />

&nbsp;

<a href="{{BASE_PATH}}/assets/wp-images-de/image1344.png">Windows Azure Accelerator for Web Roles</a> on <a href="http://waawebroles.codeplex.com/">Codepex</a>!

&nbsp;

&nbsp;

<strong>Are there any disadvantages?</strong>

<strong> </strong>

The only disadvantage that gets into my mind is that in some Azure Instances the Web Site Manager runs as well and (like the name says) it is produced for Web Rolls only. But the name also betrays that the Deployment will be <a href="{{BASE_PATH}}/2011/02/22/automatisiertes-deployment-auf-windows-azure-ber-einen-buildserver-via-powershell/">much easier on Azure.</a>

<strong>Maybe it will be also much more beneficial to use it…</strong>

<strong> </strong>

I can imagine that it’s better to run several small websites on Azure. Two instances hosting Mini-websites are more beneficial than one instance for each which will be bored in the end. I need to test it …
