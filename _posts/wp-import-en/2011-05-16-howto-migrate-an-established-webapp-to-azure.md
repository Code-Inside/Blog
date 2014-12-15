---
layout: post
title: "HowTo: migrate an established WebApp to Azure"
date: 2011-05-16 11:34
author: CI Team
comments: true
categories: [HowTo]
tags: [Azure]
language: en
---
{% include JB/setup %}

  
  <p><a href="{{BASE_PATH}}/assets/wp-images-en/image1109.png"><img style="background-image: none; border-right-width: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image1109" border="0" alt="image1109" align="left" src="{{BASE_PATH}}/assets/wp-images-en/image1109_thumb.png" width="191" height="168" /></a>The Windows Azure platform exists for a long time till now but I never had the chance to migrate an established Web application to Azure. I try to document this step by step. The first step is really easy: build a WebApp package and enter SQLAzure (the easiest way).</p>  
  


  
  <p><b>&quot;deferral&quot; - my scenario </b></p>  
  <p>The base of this blogpost is an ASP.NET MVC 2 application which is using an SQL server as data bank. Any kind of windows services, Services Bus Stuff or other constructs are not part of this. I just want my WebApp to run under Azure with an instance in the simplest case. That´s not a big thing but a first step <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile20.png" /></p>
<p><b>What do I need?</b></p>  
  <p>Of course you need the latest version of Windows Azure SDK (I´m use the <a href="http://www.microsoft.com/downloads/en/details.aspx?FamilyID=21910585-8693-4185-826e-e658535940aa">June 2010 Version</a> - is this the latest? <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile20.png" /> ) Also you need an SQL Management Studio Express and if you installed a bigger SQL Server on your computer than you might read this.</p>
<p><b>Demo Solution </b></p>  
  <p><a href="{{BASE_PATH}}/assets/wp-images-en/image158.png"><img style="background-image: none; border-right-width: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb66.png" width="227" height="225" /></a>We have a standard MVC App without any references to azure assemblies. Therefore we have our file bank on the SQL Server. But I´m going to talk about the SQL Server later.</p>  
  
  
  
  <p><b>Add a Cloud Project </b></p>  
  <p>After the installation of the windows azure SDKs you will find a new project type:</p>
<p><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb295.png" width="432" height="382" /></p>
<p>In the following window it´s possible to create a new project but in our case we already have a WebApp.</p>
<p><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb296.png" width="450" height="283" /></p>
<p>So just click on &quot;ok&quot;.</p>
<p><b>Now add the existing project </b></p>  
  <p>With the context menu you are able to add an existing web application as web role</p>
<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb297.png" width="447" height="168" /></p>
<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb298.png" width="447" height="357" /></p>  
  <p><b>Debugging</b></p>  
  <p>Now you can start the MVC Project but also the cloud project. At the cloud project the application will be hosted on the local Cloud-Dev-Plattform:</p>
<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb299.png" width="475" height="259" /></p>
<p><b>Adapt the config - DiagnosticsConnectionString</b></p>  
  <p>For the logs in the local environment a config entry will be created in the cloud config. This one have to be <a href="http://www.davidaiken.com/2010/05/28/remember-to-update-your-diagnosticsconnectionstring-before-deploying/">deleted before the Deployment</a>.</p>
<p><u>My ServiceConfiguration.cscfg</u></p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:244a14b9-da72-4117-9502-54759fb35a3e" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;?xml version="1.0"?&gt;
&lt;ServiceConfiguration serviceName="MoveToAzure.WebHost" xmlns="http://schemas.microsoft.com/ServiceHosting/2008/10/ServiceConfiguration"&gt;
  &lt;Role name="MoveToAzure.WebApp"&gt;
    &lt;Instances count="1" /&gt;
    &lt;ConfigurationSettings /&gt;
  &lt;/Role&gt;
&lt;/ServiceConfiguration&gt;</pre></div>

<p>My ServiceDefinition.csdef</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9faf2687-462a-489c-9f52-f5282e007f12" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;ServiceDefinition name="MoveToAzure.WebHost" xmlns="http://schemas.microsoft.com/ServiceHosting/2008/10/ServiceDefinition"&gt;
  &lt;WebRole name="MoveToAzure.WebApp"&gt;
    &lt;InputEndpoints&gt;
      &lt;InputEndpoint name="HttpIn" protocol="http" port="80" /&gt;
    &lt;/InputEndpoints&gt;
    &lt;ConfigurationSettings /&gt;
  &lt;/WebRole&gt;
&lt;/ServiceDefinition&gt;</pre></div>

<p>Both &quot;ConfigurationSettings&quot; are empty. Otherwise our project won´t run in the Cloud.</p>

<p><b>MVC adaption</b></p>




<p>At the moment the cloud doesn´t know the MVC2 DLL and because of this we need to define &quot;Copy Local&quot;:</p>

<p><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb300.png" width="361" height="280" /></p>

<p><b>Cloud - publish...</b></p>

<p>Those of you who are using an SQL file base and want to change to SQL Azure should read the second part first because after deployment you won´t be able to access the web.config. Here you need to apply the WebApp a little to reach thinks like this a little bit easier.</p>

<p>But we are going on with the easier case &quot;without DB&quot;:</p>

<p>With the context menu of the cloud-project we are able to build a package:</p>

<p><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb301.png" width="390" height="356" /></p>

<p><b>IMPORTANT: </b>the configuration of the build act should be on release.</p>

<p><b>Go one to the right code</b></p>




<p><img style="background-image: none; border-right-width: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb302.png" width="244" height="73" />Create a new server on <a href="http://windows.azure.com">http://windows.azure.com</a>.</p>

<p>Now chose a &quot;Hosted Service.&quot; The <img style="margin: 0px 10px 0px 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb303.png" width="313" height="162" />other alternative is just disk space for tables, queues and blobs. At this point this is not interesting for us.</p>

<p>In this screen you choose a name and eventually a description for the <img style="margin: 0px 10px 0px 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb304.png" width="244" height="133" />service.</p>

<p>At this point you need to be careful. If you start slowly than you need to beware that, for example, the SQLAzure Instance is situated in the same region like the WebApp. At least you choose a domain for the service.</p>




<p><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb305.png" width="460" height="291" /></p>

<p>After this you enter a site with the actual state of the staging environment:<img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb306.png" width="456" height="198" /></p>

<p>Click on Deploy and after this choose the already builded package file and upload it:</p>

<p><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb307.png" width="407" height="305" /></p>

<p>After the upload you need to click on &quot;run&quot;. Now it will take a few minutes until Microsoft saved the WebApp.</p>

<p><b>After the click on &quot;Run&quot;:</b></p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image159.png"><img style="background-image: none; border-right-width: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb67.png" width="179" height="240" /></a>Now the instance will start. This procedure will take 5 or 10 minutes. First there will be the init phase after this a short busy phase will start and then the icon will change into green for &quot;Ready&quot;. Now it works. If you did not make the changes like I told you before the WebApp won´t start and will be &quot;Busy&quot; for a long time before it stops. No pretty error message <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-sadsmile" alt="Trauriges Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-sadsmile.png" /></p>










<p><b>Because of this I wrote this HowTo <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile20.png" /></b></p>




<p><b>SQL Azure</b></p>




<p>If you use a MS SQL data base you will be able to have a SQL Azure data base. Here the connectionString is shown and you can use it for example in the SQL Management Studio and connect to the data base. For safety reasons you need to enter you IP address.</p>

<p>Probably there are many ways to transfer files from A to B. I´ve generated a SQL Script and these two parameter are very useful with that:</p>

<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb309.png" width="370" height="332" /></p>

<p>You will find this dialog if you enter a SQL DB, click right on &quot;Tasks&quot; &quot;Generate Scripts.&quot;</p>

<p>Afterwards you pass the SQL to the SQL Azure via Management Studio and that´s it. <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-openmouthedsmile" alt="Smiley mit geÃ¶ffnetem Mund" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-openmouthedsmile.png" /></p>

<p>Now the apply the ConnectionString in the WebApp and see if it works <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile20.png" /></p>

<p><b>Result</b></p>

<p>For now the WebApp with DB should run on Azure. But there are several problems to solve like for example how to use the Session ore the Cache with Azure and build a scalable Application. But for now this will work <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile20.png" /></p>
