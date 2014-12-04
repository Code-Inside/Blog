---
layout: post
title: "Simple WebApp Deployment with WebDeploy and MSBuild in TFS & co."
description: "Continuous  Deployment is a pretty simple, but very helpful tool in your toolbox and the first steps can be achieved very easily with pure MSBuild. This works great with TFS or any other Build System."
date: 2014-12-04 00:01
author: robert.muehsig
tags: [MSBuild, WebDeploy, TFS]
language: en
---
{% include JB/setup %}

With this blogpost I will show you how you can trigger WebDeploy to deploy your WebApp - without complicated scripts or scary build workflow systems.

## WebDeploy, MSBuild - what?
This is not a introduction blogpost about MSBuild or WebDeploy, but I will try to give you a very short description.

__[MSBuild](http://msdn.microsoft.com/en-us/library/0k6kkbsd.aspx)__: Every time you open a .csproj file you work with MSBuild. MSBuild is XML-based and the primary build "language" for .NET projects.

__[WebDeploy](http://www.iis.net/learn/publish/using-web-deploy/introduction-to-web-deploy)__: WebDeploy is a modern alternative to FTP - the WebDeploy Packages contains the WebApp (in most cases a ASP.NET WebApp) and configuration details for IIS, connections to database etc.

The hardest challenge might be to get WebDeploy running. In theory it is not hard, but there are some tricky problems in certain situations. I already have a [couple of posts about WebDeploy-Setup on this Blog](http://blog.codeinside.eu/2014/10/25/Using-WebDeploy-As-Non-Admin/).

## MSBuild Parameter to trigger WebDeploy

The typical MSBuild call is:

    msbuild app.csproj /p:configuration=Release
	
To trigger MSBuild there are a couple of MSBuild arguments:

    /p:DeployOnBuild=True
    /p:DeployTarget=MsDeployPublish
    /p:MSDeployServiceURL=https://<server name>:8172/msdeploy.axd
    /p:DeployIISAppPath=”TestSiteForDeploy”
    /p:CreatePackageOnPublish=True
    /p:MsDeployPublishMethod=WMSVC
    /p:AllowUntrustedCertificate=True
    /p:UserName=*****
    /p:Password=*****

Most of these properties are listed [here](http://msdn.microsoft.com/en-us/library/microsoft.teamfoundation.build.workflow.activities.msbuild_properties.aspx).

So you just need to apply all parameters to your MSBuild call and it should build the package (you also may need the OutputPath and Configuration property) and publish it via WebDeploy.

## TFS and other Build Systems

If you just have simple requirements you could just add the deployment arguments to your CI-Build and everything should work. In the TFS World you can specify additional MSBuild args. You can do similar things in TeamCity and other Build Systems.

![x]({{BASE_PATH}}/assets/md-images/2014-12-04/tfsbuild.png "TFS Build")
 
As I said in the beginning - it is simple and I found this solution on this [Blog](http://www.codepool.biz/version-control/how-to-auto-deploy-web-application-with-tfs-build-server.html), but just to remind me better next time I reblogged it here with my own words.
 
Hope this helps!