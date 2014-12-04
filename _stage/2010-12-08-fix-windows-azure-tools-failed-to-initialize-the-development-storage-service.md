---
layout: post
title: "Fix: Windows Azure Tools: Failed to initialize the Development Storage Service"
date: 2010-12-08 13:58
author: antje.kilian
comments: true
categories: [Fix]
tags: [Azure, Development Storage Service, Error]
language: en
---
{% include JB/setup %}
<p>&#160;</p>  <p><img title="image" border="0" alt="image" align="left" src="http://code-inside.de/blog/wp-content/uploads/image_thumb291.png" width="151" height="133" />I´ve installed the Azure SDK 1.2 on my computer and tried to debug the application. But as a result I received the following error message. Reason: Instead of the SQLExpress Installation I installed a SQL Server 2008R2.</p>  <p>But, like always, there is a little trick. ;)</p>  <p>&#160;</p>  <!--more-->  <p><b>Error message</b></p>  <p><b></b></p>  <p>That´s my error message:</p>  <p><em>Windows Azure Tools: Failed to initialize the Development Storage service. Unable to start Development Storage. Failed to start Development Storage: the SQL Server instance "˜localhost\SQLExpress´ could not be found.&#160;&#160; Please configure the SQL Server instance for Development Storage using the "˜DSInit´ utility in the Windows Azure SDK.</em></p>  <p><em>Keep in mind: I´ve installed a SQL Server 2008R2.</em></p>  <p><em></em></p>  <p><em>Usually you will find the DSInit Tool here:</em></p>  <p><em></em></p>  <p>C:\Program Files\Windows Azure SDK\v1.2\bin\devstore</p>  <p>But while I was opening it I received this error: </p>  <p><img title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb292.png" width="382" height="302" /></p>    <p>Reason: He tries to find the SQLExpress Server but this Server doesn´t exist. </p>  <p><b>Solution</b></p>  <p>It´s possible to define the SQL instance-name as a parameter at the tool. But in the standart-installation the SQL Server doesn´t have an instance-name. All you have to do is enter this into the CMD:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:de07bfb5-e670-44c5-9987-cdcbb34c66a9" class="wlWriterEditableSmartContent"><pre name="code" class="c#">C:\Program Files\Windows Azure SDK\v1.2\bin\devstore&gt;DSInit.exe /sqlinstance:</pre></div>

<p>NOW it should be working! <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="http://code-inside.de/blog-in/wp-content/uploads/wlEmoticon-winkingsmile4.png" /></p>

<p>I found the solution <a href="http://suntsu.ch/serendipity/index.php?/archives/190-Visual-Studio-2010-Problem-Windows-Azure-Tools-Failed-to-initialize-the-Development-Storage-service..html">here</a></p>
