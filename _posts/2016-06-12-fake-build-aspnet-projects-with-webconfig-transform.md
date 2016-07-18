---
layout: post
title: "FAKE: Build ASP.NET projects with web.config transformation (and without knowing a tiny bit of F#)"
description: "Using FAKE to build console or desktop applications is quite easy, but for ASP.NET projects a web.config transformation might be needed. This post will show you an easy solution with FAKE."
date: 2016-06-12 14:00
author: Robert Muehsig
tags: [FAKE, ASP.NET]
language: en
---
{% include JB/setup %}

_This is a follow-up to my other FAKE posts:_

* ["FAKE: Building C# projects without knowing a tiny bit of F#"](http://blog.codeinside.eu/2015/02/23/fake-building-with-fake/) 
* ["FAKE: Running xUnit Tests with FAKE without knowing a tiny bit of F#"](http://blog.codeinside.eu/2015/02/24/fake-running-xunit-tests-with-fake/)
* ["FAKE: Create NuGet Packages without knowing a tiny bit of F#"](http://blog.codeinside.eu/2015/06/21/fake-create-nuget-packages/)
* ["FAKE: Running MSTest Tests with FAKE without knowing a tiny bit of F#"](http://blog.codeinside.eu/2015/08/30/fake-running-mstest-tests-with-fake/)

## What's the difference between a ASP.NET and other projects?

The most obvious difference is that the output is a bunch of dlls and content files. Additionally you might have a __web.debug.config or web.release.config__ in your source folder. 

Both files are important, because they are used during a Visual-Studio build as a [__Web.Config Transformation__](https://msdn.microsoft.com/en-us/library/dd465326(v=vs.110).aspx).

With a normal build the transformation will not kick in, so we need a way to trigger the transformation "manually".

## Project Overview

The sample project consists of one ASP.NET project and the .fsx file. 

![x]({{BASE_PATH}}/assets/md-images/2016-06-12/project.png "Project Overview")

The "released" web.config should cover this 3 main transformation parts:

* DefaultConnectionString to 'ReleaseSQLServer'
* No "debug"-attribute on system.web
* developmentMode-AppSetting set to 'true'

__Web.Release.config__

    <?xml version="1.0"?>
    <configuration xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
      <connectionStrings>
        <add name="DefaultConnection"
          connectionString="ReleaseSQLServer"
          xdt:Transform="SetAttributes" xdt:Locator="Match(name)"/>
      </connectionStrings>
    
      <appSettings>
        <add key="developmentMode" value="true" xdt:Transform="SetAttributes"
             xdt:Locator="Match(key)"/>
      </appSettings>
      
      <system.web>
        <compilation xdt:Transform="RemoveAttributes(debug)" />
      </system.web>
    </configuration>


## The FAKE script

We reuse the MSBuild-Helper from FAKE and inject a couple of "Publish"-related stuff, which will trigger the transformation.

__A few remarks:__ In the "normal" WebDeploy-World you would have a PublishProfile and it would end up with a .zip-file and a couple of other files that fill in parameters like the ConnectionString. With this MSBuild command I mimik a part of this behavior and use the temporary output as our main artifact. In my most apps I use web.config transformations only for "easy" stuff (e.g. remove the debug attribute) - if you are doing fancy stuff and the output is not what you want, please let me know.

__This MSBuild command *should* apply all your web.config transformations.__

__Publish a ASP.NET project__

    ...
    Target "BuildWebApp" (fun _ ->
    trace "Building WebHosted Connect..."
    !! "**/*.csproj"
     |> MSBuild artifactsBuildDir "Package"
        ["Configuration", "Release"
         "Platform", "AnyCPU"
         "AutoParameterizationWebConfigConnectionStrings", "False"
         "_PackageTempDir", (@"..\" + artifactsDir + @"Release-Ready-WebApp")
         ]
     |> Log "AppBuild-Output: "
    )
    ...

### "AutoParameterizationWebConfigConnectionStrings" or how to get rid of $(ReplacableToken_...

*Blogpost updated on 2016-07-18*

A friend told me that his transformed web.config contained "$(ReplaceableToken_...)" strings. It seems that "connectionStrings" are treated specially. If you have a connectionString in your web.config and don't set ["AutoParameterizationWebConfigConnectionStrings=False"](http://stackoverflow.com/questions/7207689/how-to-get-rid-of-replacabletoken-in-web-config-completely) you will get something like that:

    <connectionStrings>
      <!-- Not the result we are looking for :-/ -->
      <add name="DefaultConnection" connectionString="$(ReplacableToken_DefaultConnection-Web.config Connection String_0)" providerName="System.Data.SqlClient" />
    </connectionStrings>

I would say this is not the result you are expecting. With the "AutoParameterizationWebConfigConnectionStrings=False" parameter it should either do a transformation or leave the default-connectionString value in the result.

*Thanks to Timur Zanagar! I completely missed this issue.*

## Result

![x]({{BASE_PATH}}/assets/md-images/2016-06-12/output.png "Output")

This build will produce two artifacts - the build-folder just contains the normal build output, but __without__ a web.config transformation. 

The other folder contains a ready to deploy web application, __with the web.release.config applied__.

    <connectionStrings>
      <add name="DefaultConnection" connectionString="ReleaseSQLServer" providerName="System.Data.SqlClient" />
    </connectionStrings>
    <appSettings>
      ...
      <add key="developmentMode" value="true" />
    </appSettings>
    <system.web>
      ...
    </system.web>

You can find the complete [sample & build script on GitHub](https://github.com/Code-Inside/Samples/tree/master/2016/LetsUseFake-AspNet).
