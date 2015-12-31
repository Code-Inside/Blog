---
layout: post
title: "Serving embedded resources with ASP.NET WebApi"
description: "Let's build a PageController, which can return any embedded file inside your WebApi code."
date: 2015-12-31 13:45
author: Robert Muehsig
tags: [WebAPI, ASP.NET]
language: en
---
{% include JB/setup %}

## Embedded files? Why?

In a normal Web-Application all files are somehow stored as files in the app directory, but sometimes it could be handy to embed those files. 

One scenario could be that you have a "library", which can be integrated in a larger application. If you don't want to pull over all files and you __just want to expose a single assembly__ (for example as NuGet package) embedded resources might come handy.

## Demo-Application

My demo application is a simple ConsoleApp, which a selfhosting WebAPI and two Controllers (Demo and Pages):

![x]({{BASE_PATH}}/assets/md-images/2015-12-31/embeddedresources-structure.png "VS Structure")

Important is, that my "target" html and css file are marked as __Embedded Resource__.

## Routing

In my sample I have created on "PageController", which accepts all requests that seems to target the embedded files.

Registration:

    public class Startup
    {
        public void Configuration(IAppBuilder appBuilder)
        {
            HttpConfiguration config = new HttpConfiguration();

            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "ApiV1",
                routeTemplate: "api/v1/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
                );

            config.Routes.MapHttpRoute(
               name: "PageController",
               routeTemplate: "{*anything}",
               defaults: new { controller = "Page", uri = RouteParameter.Optional });

            appBuilder.UseWebApi(config);
        }

    }

## The "PageController"

This controller will try to read the HTTP GET QueryString and will look inside the resources. 

    public class PageController : ApiController
    {
        private const string ResourcePath = "SelfHostWithBetterRouting.Pages{0}";

        public static Stream GetStream(string folderAndFileInProjectPath)
        {
            var asm = Assembly.GetExecutingAssembly();
            var resource = string.Format(ResourcePath, folderAndFileInProjectPath);
            return asm.GetManifestResourceStream(resource);
        }


        public HttpResponseMessage Get()
        {
            string filename = this.Request.RequestUri.PathAndQuery;

            // input as /page-assets/js/scripts.js
            if (filename == "/")
            {
                filename = ".index.html";
            }

            // folders will be seen as "namespaces" - so replace / with the .
            filename = filename.Replace("/", ".");
            // resources can't be named with -, so it will be replaced with a _
            filename = filename.Replace("-", "_");

            var mimeType = System.Web.MimeMapping.GetMimeMapping(filename);

            var fileStream = GetStream(filename);

            if (fileStream != null)
            {
                var response = new HttpResponseMessage();
                response.Content = new StreamContent(fileStream);
                response.Content.Headers.ContentType = new MediaTypeHeaderValue(mimeType);
                return response;
            }

            return new HttpResponseMessage(System.Net.HttpStatusCode.NotFound);
        }

    }	

## Mix the "PageController" and normal WebAPI Controllers

In my sample the "PageController" will catch all requests that are not handled by other controllers, so you could even serve a general 404 page.

## Hosting in IIS

If you host this inside an IIS it will not work out of the box, because the IIS itself tries to serve static content. One easy option would be to include this inside your web.config:

  <!-- prevent IIS from serving embeddded stuff -->
  <location path="pages">
    <system.webServer>
      <handlers>
        <add name="nostaticfile" path="*" verb="GET" type="System.Web.Handlers.TransferRequestHandler" preCondition="integratedMode,runtimeVersionv4.0" />
      </handlers>
    </system.webServer>
  </location>

With this web.config setting in place the request should route through your code.  
  
## Result

The self hosting WebAPI returns the "index.html" and the linked "site.css" - all embedded inside the assembly:

![x]({{BASE_PATH}}/assets/md-images/2015-12-31/embeddedresources-result.png "Result of Democode")

In an [older blogpost](http://blog.codeinside.eu/2015/09/29/wpf-chrome-embedded-and-webapi-selfhosting/) I used a similar approach, but the routing part is now "better" solved.

Hope this helps!

The code is also available on __[GitHub](https://github.com/Code-Inside/Samples/tree/master/2015/SelfHostWithBetterRoutingForEmbeddedResources)__.
