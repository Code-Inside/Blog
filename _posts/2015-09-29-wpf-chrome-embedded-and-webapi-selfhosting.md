---
layout: post
title: "WPF, Chrome Embedded and WebApi Self-hosted"
description: "... or how to ditch XAML and use Web-Technologies for desktop apps."
date: 2015-09-29 23:30
author: Robert Muehsig
tags: [WPF, CEF, WebAPI]
language: en
---
{% include JB/setup %}

Building "rich desktop clients" is not a very easy task. WPF can be a good choice for "fat" Windows Apps, but if you have zero knowledge in XAML you might end up in hell, because... XAML, right? If you are more a "web guy" (like myself) or just want to reuse existing code from your Web-App and want to stick to your .NET know-how this blogpost might come handy.

## Cross Platfrom?

If you want to go __real cross platform__ and don't have any issues with Javascript there are other options available: __[nw.js](http://nwjs.io/)__ or for more advanced use cases __[Electron](http://electron.atom.io/)__. Both frameworks seems like a good starting point, but in a "Windows Only"-environment (well... this might be a bet on the future...) or with an existing large .NET code base not the ideal solution.
 
## The idea

So, back to .NET land and the idea is clever and kinda stupid together: We want to build a small app that embeds a browser __and__ a server (this is more or less the same trick from Electron & co.).
The host should be a WPF application, because with this we could combine interesting frameworks in one application - e.g. legacy code stuff, WPF controls, web stuff... yeah!

## Building blocks: The Browser

If you just want to display "Web-Content" you can just use the __[built-in WebBrowser-Control](https://msdn.microsoft.com/en-us/library/system.windows.controls.webbrowser(v=vs.110).aspx)__. The most common and annoying problem is that the default rendering engine is stuck in the stone age: Internet Explorer 7. Even on Windows 10 the default rendering engine will be set to IE7.
To fix this you can use some [Registry-Magic](https://weblog.west-wind.com/posts/2011/May/21/Web-Browser-Control-Specifying-the-IE-Version), but this is not very elegant.

A better solution would be to take a deeper look at the [Chromium Embedded Framework for .NET](https://github.com/cefsharp/CefSharp). It is the rendering engine of Chrome - which gives you a super powerful platform - and is super easy to use.
The only downside: You need to [compile your app for x86 or x64 - AnyCPU won't work](https://github.com/cefsharp/CefSharp/issues/576#issuecomment-61926661).

So... let's take a look how we can achieve our goal.

## Building blocks: The Server

A good option is using the HttpListener with the ASP.NET WebApi - of course you could also use NancyFx or any other OWIN/"self-host" web framework. The hosting application will use the HttpListener from your System and will listen to a specific port. As long as you use a high port number you don't need admin privileges.

For the demo I embedded the HTML inside the application, but this could be read from a resource file or any other storage in real life.

As far as I know maybe you could also do some other hosting tricks, so that the application doesn't really needs to listen to a specific port, e.g. hosting the stuff in-memory.


## Code: Server Part

__The (important) Server Parts:__

    public partial class App : Application
    {
        public App()
        {
            string baseAddress = "http://localhost:9000/";

            webApp = WebApp.Start<Startup>(url: baseAddress);
           
        }

        public IDisposable webApp { get; set; }

        ~App()
        {
            webApp.Dispose();
        }
    }
	
	public class Startup
    {
        // This code configures Web API. The Startup class is specified as a type
        // parameter in the WebApp.Start method.
        public void Configuration(IAppBuilder appBuilder)
        {
            // Configure Web API for self-host. 
            HttpConfiguration config = new HttpConfiguration();

            DefaultConnectWebApiConfig.Register(config);

            appBuilder.UseWebApi(config);
        }
    }
	

__The controller code: Simple ApiController which reads a embedded HTML file.__


	public class DemoController : ApiController
    {
        private const string ResourcePath = "SelfHostAndCef.HtmlSamples.{0}";
        public static string GetTestFileContent(string folderAndFileInProjectPath)
        {
            var asm = Assembly.GetExecutingAssembly();
            var resource = string.Format(ResourcePath, folderAndFileInProjectPath);

            using (var stream = asm.GetManifestResourceStream(resource))
            {
                if (stream != null)
                {
                    var reader = new StreamReader(stream);
                    return reader.ReadToEnd();
                }
            }
            return String.Empty;
        }

        public HttpResponseMessage Get()
        {
            var response = new HttpResponseMessage();
            response.Content = new StringContent(GetTestFileContent("demo.html"));
            response.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");
            return response;
        }

    }

## Code: The Browser

This is more or less the __["minimal cef" sample](https://github.com/cefsharp/CefSharp.MinimalExample/)__, but for the sample it is good enough:

    <Window x:Class="SelfHostAndCef.DialogWindow"
            xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
            xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
            xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
            xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
            xmlns:local="clr-namespace:SelfHostAndCef"
            xmlns:wpf="clr-namespace:CefSharp.Wpf;assembly=CefSharp.Wpf"
            mc:Ignorable="d"
            Title="DialogWindow" Height="300" Width="300">
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition />
                <RowDefinition Height="Auto" />
            </Grid.RowDefinitions>
            <wpf:ChromiumWebBrowser x:Name="Browser" Grid.Row="0"
                              WebBrowser="{Binding WebBrowser, Mode=OneWayToSource}"
                              Title="{Binding Title, Mode=TwoWay}" />
            <StatusBar Grid.Row="1">
                <ProgressBar HorizontalAlignment="Right"
                             IsIndeterminate="{Binding WebBrowser.IsLoading}"
                             Width="100"
                             Height="16"
                             Margin="3" />
                <Separator />
                <!-- TODO: Could show hover link URL here -->
                <TextBlock />
            </StatusBar>
        </Grid>
    </Window>

	public partial class DialogWindow : Window
    {
        public DialogWindow()
        {
            InitializeComponent();
            this.Browser.Address = "http://localhost:9000/api/v1/Demo";

            var hostElement = new SampleWebViewHost();
            this.Browser.RegisterJsObject("sampleWebViewHost", hostElement);

            hostElement.SampleWebViewHostInvoked += HostElementSampleWebViewHostInvoked;
        }

        private void HostElementSampleWebViewHostInvoked(object sender, SampleWebViewHostEventArgs e)
        {
            Dispatcher.Invoke(() =>
            {
                this.DialogResult = true;
                this.Close();
            });
        }   
    }
	
## Code: The HTML

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Example Form</title>
        <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
    </head>
    <body>
    <h1>SampleForm</h1>
    <form>
        <label>HelloWorld:</label>
        <input name="test"/>
        <button type="submit">OK</button>
    </form>
    <script>
        $(document).ready(function() {
            $("form").submit(function() {
    
                var result = JSON.stringify($("form").serializeArray());
    
                if (sampleWebViewHost != null) {
                    sampleWebViewHost.done(result);
                }
    
                return false;
            });
    
        });
    </script>
    </body>
    </html>
	
## Building blocks: Browser-to-App communication

There are several ways how to interact between the hosting app and the web-app. One way is via URLs or using standard web methods. If you host the server component, then you can invoke anything inside your app.
Another solution would be to register a "scriptable" Javascript object inside the Browser-Control. I already blogged about the ["window.external" api](http://blog.codeinside.eu/2013/09/04/interaktionen-zwischen-web-und-windows-desktopwindows-phonewinrt-mit-objectforscripting-window-external-notify/) (in German). With this "scriptable" object in place you can call .NET functions from Javascript or the other way around.

## The full lifecycle

* Application starts and "self-hosts" the WebApi and listens on Port 9000 
* WPF Window is displayed with a large button
* The Button will invoke the actual WebBrowser Control and set up a "scriptable" Javascript object
* User fills in the desired data, press OK inside the WebBrowser and sends the data (in this case) to the WebBrowser-Host via the "scriptable" Javascript object
* Our technology mix is complete: We can host our own WebApp inside our WinApp 

![x]({{BASE_PATH}}/assets/md-images/2015-09-29/demo.gif "Demo")

## TL;DR

Ok... as I told you this blogpost shows you a really stupid or really clever trick (it depends on your habbits... WebGuy vs. WindowsGuy).
In this example we used a self-hosting WebApi to display an embedded HTML page via CEF Sharp inside a Windows App. 

It's magic, right? 

The full code can be found on __[GitHub](https://github.com/Code-Inside/Samples/tree/master/2015/SelfHostAndCef)__.