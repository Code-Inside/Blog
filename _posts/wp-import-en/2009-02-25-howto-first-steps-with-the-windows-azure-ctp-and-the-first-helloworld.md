---
layout: post
title: "HowTo: First steps with the Windows Azure CTP and the first &quot;HelloWorld&quot;"
date: 2009-02-25 03:16
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET, Azure, Cloud, Cloud Computing, HowTo, Web Role, Windows Azure]
language: en
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image56.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; border-right-width: 0px" height="161" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb64.png" width="240" align="left" border="0" /></a>In my <a href="{{BASE_PATH}}/2009/02/24/howto-hello-cloud-computing/">last blogpost</a> I talked about different cloud computing providers, like Google, Amazon and Microsoft. </p>
<p>Today I want to describe Windows Azure more and show you how to use the Windows Azure CTP and how to publish a &quot;Hello World&quot; app in the &quot;cloud&quot;.</p> 
<!--more-->
  <p><strong>Azure Service Platform&#160; <br /></strong>The <a href="http://www.microsoft.com/azure/services.mspx">Azure Service Platform</a> use &quot;<a href="http://www.microsoft.com/azure/windowsazure.mspx">Windows Azure</a>&quot; as it&#180;s core: </p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image57.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="225" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb65.png" width="486" border="0" /></a> </p>
<p>Azure offers <strong>basic functionality</strong>, like resource sharing, monitoring and so on. You can <strong>host Web- or- Worker-Processes</strong> on it or use it as <strong>blob or table storage</strong>.     <br />Everything on Azure can be accessed via <a href="http://de.wikipedia.org/wiki/Representational_State_Transfer">REST interfaces</a>. </p>
<p><strong>Services on Azure      <br /></strong>Microsoft itself build some services on top of Azure:</p>  <ul>   <li><a href="http://dev.live.com/">Live Services</a> - Live Framework &amp; Live Mesh </li>    <li><a href="http://www.microsoft.com/azure/netservices.mspx">.NET Services</a> - Workflows, Authentication &amp; Services </li>    <li><a href="http://www.microsoft.com/azure/sql.mspx">SQL Services</a> - SQL Server in the cloud </li>    <li>SharePoint &amp; CRM </li> </ul>  <p><strong>Information about Windows Azure      <br /></strong>To learn more about Azure I recommend you to have a look at these <a href="http://www.microsoft.com/azure/videos.mspx">videos</a>:</p>
<p><iframe marginwidth="0" marginheight="0" src="http://www.microsoft.com/azure/slMediaPlayer/videosSLMP.htm" frameborder="0" width="666" scrolling="no" height="297"></iframe></p>
<p>(Even if this video player destroy the blog design - it&#180;s worth ;))</p>
<p><strong>Let&#180;s start!&#160; <br /></strong>Now have a look at the real Azure system. The whole Azure thing is <strong>currently</strong> <strong>only a CTP</strong>, but <strong>should be released at the end of the year</strong>.     <br />My first application will be a &quot;Hello-World&quot; app (yeah, I know, this example sucks ;) )</p>
<p><strong>Step 1: SDKs + Access Key      <br /></strong>You can find the SDKs on the Windows Azure website (<a href="http://www.azure.com">www.azure.com</a>) and <a href="http://www.microsoft.com/azure/sdk.mspx">download it</a> without having an access key.&#160; </p>  <ul>   <li>Windows Azure SDK (help files, concepts) </li>    <li>Windows Azure Tools for Microsoft Visual Studio (dev environment) </li> </ul>  <p>You need the access key to upload projects to Azure. <strong>Register</strong> on <a href="http://www.microsoft.com/azure/register.mspx">MS Connect</a> to get an access key.     <br />All services (SQL Data, .NET Services...) needs a specific code.</p>
<p><strong>Step 2: Create Web Cloud Service Project      <br /></strong>After the installation of the &quot;Windows Azure Tools for MS VS&quot; you will see a new category &quot;Cloud Services&quot; - we want to create a &quot;Web Cloud Service&quot; project:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image58.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="349" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb66.png" width="491" border="0" /></a></p>
<p>Visual Studio creates two projects in your solution:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image59.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="204" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb67.png" width="244" border="0" /></a></p>  
  <ul>
  <li>&quot;WindowsAzureHello&quot;:      
    <ul>
      <li>Contains configs for the &quot;Cloud&quot; </li>    
    </ul>
  </li>
  <li>&quot;WindowsAzureHello_WebRole&quot;:
    <ul>
    <li>A standard ASP.NET project </li> 
  </ul> 
  </li>
  </ul> 
<strong>Step 3: First steps with the cloud-debugging environment / &quot;Development Fabric&quot;    <br /></strong>
If you hit F5, several processes will start. The development storage creates a SQL server database on your local SQL server (download <a href="http://www.microsoft.com/germany/Express/">SQL Express</a>). The development storage simulate the Azure database:   <br />  

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image60.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="125" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb68.png" width="392" border="0" /></a>&#160;</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image61.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="324" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb69.png" width="424" border="0" /></a> </p> 

<p>A look inside the DevelopmentStorageDb:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image62.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="219" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb70.png" width="244" border="0" /></a></p>
<p>You should see a new icon in your Windows Tray: <a href="{{BASE_PATH}}/assets/wp-images-en/image63.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="24" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb73.png" width="30" border="0" /></a></p> 

<p>This is the &quot;<strong>Development Fabric</strong>&quot;, which simulate the hosting environment of Azure: </p> 

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image64.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="384" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb74.png" width="511" border="0" /></a> </p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image65.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="383" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb75.png" width="509" border="0" /></a></p> 

<p><strong>Step 4: Add &quot;Hello World&quot; to your ASP.NET page      <br /></strong>I add these lines to my default.aspx page:     <br /></p> 

<pre name="code" class="c#">
&lt;form id="form1" runat="server"&gt;
    &lt;div&gt;
        Hello World @ Code Inside Blog &lt;br /&gt;
        http://code-inside.de
    &lt;/div&gt;
    &lt;/form&gt;
</pre>

<p><strong>Step 5: Publish cloud service 
    <br /></strong>
    In this step we publish your &quot;WindowsAzureHello&quot;-project. Just &quot;publish&quot; it via the context menu and you should get these two files:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image66.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="53" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb76.png" width="197" border="0" /></a> </p>

<p>Now *right click* on your &quot;WindowsAzureHello&quot; project and get the context menu with two additional buttons and go to the portal:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image67.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="76" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb77.png" width="244" border="0" /></a>&#160;</p>

<p><strong>Step 6: Create a Hosted Service on Windows Azure</strong> 

  <br />Now create a &quot;Hosted Service&quot; project on the Azure Service page:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image68.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="183" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb78.png" width="483" border="0" /></a> </p>

<p>Type the name of your project and type a (sub)-domain:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image69.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="215" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb79.png" width="445" border="0" /></a> </p>

<p>After your project is created, you see this website:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image70.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="332" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb80.png" width="421" border="0" /></a></p>

<p>&quot;Production&quot; is your live app and &quot;Staging&quot; is just to test your app. At first you have to deploy your app on the &quot;Staging&quot; environment. </p>

<p><strong>Step 8: Staging deployment 
    <br /></strong>
    Select the two files, which we created in step 5 and upload it. After the upload processs is finished, the package will be deployed to the staging environment.</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image71.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="170" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb82.png" width="244" border="0" /></a> </p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image72.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="200" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb83.png" width="244" border="0" /></a> </p>

<p>If this process finished you should see this:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image73.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="227" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb84.png" width="406" border="0" /></a> </p>

<p>Now you can click on the URL and test your app - here is my demo-app:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image74.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="66" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb85.png" width="227" border="0" /></a> </p>

<p><strong>Step 8: Move it to &quot;Production&quot;</strong> 

  <br />
  If you want to move your app to the &quot;Product&quot;-environment, just click on that button:
  </p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image75.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="86" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb86.png" width="93" border="0" /></a> </p>

<p>... and now the app is live under your own subdomain (remember: this is just a CTP) :</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image76.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="227" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb87.png" width="244" border="0" /></a> </p>

<p>You can see my demo web page live at: <a href="http://codeinside.cloudapp.net/Default.aspx">Azure Link</a></p>

<p><strong>Fast track:</strong> 

  <br />This maybe sounds difficult, but it just <a href="http://www.microsoft.com/azure/webdev.mspx">takes 3 minutes</a>:</p>

<p><iframe marginwidth="0" marginheight="0" src="http://www.microsoft.com/azure/slMediaPlayer/webDeveloperSLMP0.htm" frameborder="0" width="666" scrolling="no" height="297"></iframe></p>

<p><strong>Result: 
    <br /></strong>
    The Visual Studio tools are great and I&#180;m really interested in the future of Azure (and the pricing ;) ). You can now play with Windows Azure and don&#180;t need to relearn everything from the ground. 

  <br />But, of course, you have to be careful with session handling, because your application can run on many different maschines and each request goes to another maschine. </p>
