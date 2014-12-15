---
layout: post
title: "HowTo: MSDeploy & MSBuild"
date: 2010-11-21 17:03
author: CI Team
comments: true
categories: [HowTo]
tags: []
language: en
---
{% include JB/setup %}


<p><img title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb275.png" width="139" height="120" />In my last blogpost I showed you some ways how to work with MSBuild. With the help of MSBuild it´s also possible to build a nice Deployment Package. Microsoft released a new tool with VS2010 called MSDeploy. In this Blogpost I´m going to talk about what´s MSDeploy and how does it work in comparison with MSBuild.</p>  
  
  

<p><b>Big Picture from MSDeploy</b></p>
<p>We start with the big picture of MSDeploy. The aim is to build a Deployment Package to make the delivery of software easier. Therefore we have several providers which are used to, for example, pack the data bank or the main ASP.NET Files into one package. Now you are able to publish this package quit easy with MSDeploy. MSDeploy should be installed on the Server too.</p>
<p>At this point I recommend you the blogs of <a href="http://weblogs.asp.net/scottgu/archive/2010/09/13/automating-deployment-with-microsoft-web-deploy.aspx">ScottGu</a> and <a href="http://vishaljoshi.blogspot.com/2009/03/how-does-web-deployment-with-vs-10.html">Vishal Joshi</a> (feels like he is THE developer behind MSDeploy).</p>
<p>One of the main advantages of MSDeploy: it´s very easy to bring in new updates. For example you can use the developer-machine of Visual Studio or a Buildserver with a Buildscript.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image96.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb5.png" width="495" height="293" /></a></p>
<p><b>MSDeploy on the Server</b></p>  

<p>Install MSDeploy with the web platform installer. (look at ScottGus Post). Be careful: the Port of MSDeploy needs to be activated in the Firewall. Every other detail you will find either on ScottGus Post or on IIS.NET <a href="http://www.iis.net/download/webdeploy">here</a>, <a href="http://learn.iis.net/page.aspx/421/installing-web-deploy/">here</a> or <a href="http://learn.iis.net/page.aspx/516/configure-the-web-deployment-handler/">here</a>.</p>
<p><b>My deploy-try´s till now</b></p>  

<p>So far I build a solution with MSBuild and I used the "_PublishedWebsites" directory. Soon I´m going to write a&#160; post&#160; about the web.conig transformation. But there is a more classy way to do so.</p>
<p>At the moment MSDeploy is created for Web applications. Because of this you do have to think about the Deployment and Packaging from windows services etc. <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile2.png" /></p>
<p><b>Easy example </b></p>  

<p><img title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb277.png" width="219" height="244" />In my example I want to pack a MVC WebApp into a Deployment Package.</p>
<p>Alternative A) Just use Visual Studio. Click right on the project and afterwards "build deployment package". It´s possible if you work just for your own. In my opinion it should be possible to call a build script controlled. At least if you integrate a buildserver you will have no other choice.</p>
<p>Because of this: Alternative B) we write a little MSBuild Script. The output will be the same like in alternative A at the end - just in a script.</p>
<p>In the deployment settings it´s also possible to define the IIS Settings:</p>
<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb278.png" width="485" height="325" /></p>
<p>But it´s also possible to do so later with parameter. For now, we define the settings before. The site I define should be already created in IIS at the target host. I´m not sure what will happen if this is not given. <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile2.png" /></p>
<p>Now we are going to talk about the script.</p>
<p><b>Build.targets</b></p>  
  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6799cdbd-28ac-44f6-a520-dafb6607ea0e" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" DefaultTargets="Run"&gt;
&lt;Import Project="$(MSBuildExtensionsPath)\Microsoft\VisualStudio\v10.0\WebApplications\Microsoft.WebApplication.targets" /&gt;
   &lt;PropertyGroup&gt;
	&lt;OutDir&gt;$(MSBuildStartupDirectory)\OutDir\&lt;/OutDir&gt;
   &lt;/PropertyGroup&gt;
	&lt;Target Name="Run"&gt;
	&lt;Message Text="Run called." /&gt;
			&lt;MSBuild Projects="MSDeployMSBuild.Web\MSDeployMSBuild.Web.csproj"
            Targets="Package"
			Properties="PackageLocation=$(OutDir)\MSDeploy\Package.zip;
						_PackageTempDir=C:\Temp\Web"/&gt;
	&lt;/Target&gt;

&lt;/Project&gt;
 </pre></div>

<p>The most important thing is line 8. Here I call the package target. MSDeploy starts and automatically a Web.config transformation will be done. For property I give the PackageLocation and a help variable named "_PackageTempDir."</p>

<p>As result we have a "Build Deployment Package" or you will have this result with MSBuild:</p>

<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb279.png" width="223" height="151" /></p>

<p>If you do not define the _PackageTempDir the whole building path will be written down in the Package.SourceManifest.xml. I don´t want this and because of this I apply any other. This path has no influence on the later deployment but I think it looks a little strange <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile2.png" /></p>

<p><b>If you don´t want to build the project directly but the solution:</b></p>




<p><b></b>In the last blogposts I always build the whole solution. That´s possible if you use this parameter:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:53d4a692-a267-4abb-b20d-4176d17df4d2" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;Solution Include="$(BuildDirFullName)Source\BusinessBingo\BusinessBingo.sln"&gt;
	&lt;Properties&gt;
		OutDir=$(OutDir);
      	Platform=Any CPU;
     	Configuration=Release;
      	DeployOnBuild=True;
      	DeployTarget=Package;
      	PackageLocation=$(OutDir)\MSDeploy\Package.zip;
      	_PackageTempDir=C:\Temp\Web
	&lt;/Properties&gt;
&lt;/Solution&gt;</pre></div>

<p><b>Accomplish the Deployment</b></p>

<p>If you just call the "MSDeployMSBuild.Web.deploy.cmd" the ReadMe will be opened because there are some information´s absent. Where should be something deploy?</p>

<p>An example for a call:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e43f9cea-7cbf-400a-adfc-09f05374f2d7" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Package.deploy.cmd /Y /M:http://SERVER_NAME/MSDeployAgentService /U:USERDATEN /P:PASSWORT</pre></div>

<p>Now they try to deploy the package on the defined IIS site on the Server "SERVER_NAME". With the switch /Y the deployment will be started. If you choose /T instead of /Y you are able to make a test - the files won´t be carried.</p>

<p><b>Result </b></p>




<p>It doesn´t take a lot to bring the Visual Studio Functionality into a Buildscript. MSDeploy is a big issue. Because of this It´s possible, that not everything is exact on this post but for me it works. <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile2.png" /></p>
