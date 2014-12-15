---
layout: post
title: "HowTo: First Steps with MEF (Hello MEF!)"
date: 2008-11-19 15:58
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [AddIns, HowTo, MEF, Plugins, System.AddIn]
language: en
---
{% include JB/setup %}
<p>In nearly every application you can install and use plugins (Firefox, Outlook, IE...). With .NET 4.0 you get a new feature to create extensible applications called &quot;Managed Extensibility Framework&quot; in short &quot;MEF&quot;. You can today play with a preview of this upcoming framework.    <br />Microsoft itself will use it in Visual Studio 2010 (<a href="http://channel9.msdn.com/pdc2008/KYN02/">take a look at the PDC Keynote from Scott Guthrie</a>). A very nice demo of MEF was in the PDC session of <a href="http://channel9.msdn.com/pdc2008/TL49/">Scott Hanselman and his &quot;BabySmash&quot;</a>. But there are a lot of other great MEF PDC Sessions.</p>  <p><strong>Addins? .NET? System.Addin?&#160; <br /></strong>The &quot;System.AddIn&quot; Namespace was introduced in .NET 3.5, but it was very hard to create addins. <a href="http://blogs.msdn.com/kcwalina/archive/2008/06/13/MAFMEF.aspx">But MEF and System.AddIn should play well together.</a></p>  <p><strong>What&#180;s needed to play with MEF?      <br /></strong>Everything you needed to start you can download at the <a href="http://www.codeplex.com/MEF">Codeplex Site</a>. Just download the newest release and copy the 2 DLLs in your project directory <em>(Disclaimer- it&#180;s still in development, everything might be changed until the release)</em>.</p>  <p><strong>Hello World! Hallo Welt! Hello MEF! - Preparation</strong></p>  <p>Projectstructure:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-en/image34.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb36.png" width="175" border="0" /></a> </p>  <p>We have a simple service interface called &quot;<strong>IHelloService</strong>&quot;:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c35ef68e-5110-43bd-89a1-248e08f1f4bf" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public interface IHelloService
    {
        string GetHelloMessage();
    }</pre></div>

<p>In the <strong>HelloMEF.English / German</strong> Project we have the following code:</p>




<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8d26e9f4-6f61-43b9-bc28-ebfeb8900caf" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using HelloMEF.App;
using System.ComponentModel.Composition;

namespace HelloMEF.English
{
    [Export(typeof(IHelloService))]
    public class EnglishHelloService : IHelloService
    {
        public string GetHelloMessage()
        {
            return "Hello World!";
        }
    }
}
</pre></div>

<br />Important for MEF is the &quot;Export&quot; attribut from the &quot;System.ComponentModel.Composite&quot; (MEF) Namespace. 

<br /><u>Export means:</u> This is a &quot;IHelloService&quot; plugin. 




<p>Both projects need only the reference to the HelloMEF.App because of the IHelloService interface. 
  <br />The HelloMEF.App doesn&#180;t know anything about these projects!</p>

<p><strong>Plugin dictionary 
    <br /></strong>Your application needs to know where plugins are placed, that&#180;s why we create a &quot;PlugIns&quot; dictionary:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image35.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="48" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb37.png" width="244" border="0" /></a> </p>

<p><strong>HelloMEF.App - HelloProgram:</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:553daee2-d550-4c33-8330-dba2470b15ec" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class HelloProgram
    {
        [Import(typeof(IHelloService))]
        public List&lt;IHelloService&gt; Services { get; set; }

        public HelloProgram()
        {
	... 
        }

        public void WriteHelloGreetings()
        {
            Console.WriteLine();
            Console.WriteLine("Writing Greetings...");

            foreach (IHelloService srv in Services)
            {
                Console.WriteLine(srv.GetHelloMessage());
            }

            Console.WriteLine("... powered by MEF");
        }
    }</pre></div>

<p>Inside the &quot;HelloProgram&quot; class is a &quot;IHelloServices&quot; list, which is decorated with the &quot;Import&quot; attribute from the MEF namespace. 
  <br /><u>Import means:</u> I took everything of type IHelloService.</p>

<p>The &quot;WriteHelloGreeting&quot; just iterate over the services list and write the message to the console. </p>

<p><strong>HelloMEF.App - search &amp; found plugins:</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2fad45d6-c0cb-4209-b955-b41b38fa18a8" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        public HelloProgram()
        {
            this.Services = new List&lt;IHelloService&gt;();

            if (!Directory.Exists("PlugIns"))
            {
                Directory.CreateDirectory("PlugIns");
            }

            AggregatingComposablePartCatalog catalog = new AggregatingComposablePartCatalog();
            catalog.Catalogs.Add(new AttributedAssemblyPartCatalog(Assembly.GetExecutingAssembly()));
            catalog.Catalogs.Add(new DirectoryPartCatalog("PlugIns"));
            
            CompositionContainer container = new CompositionContainer(catalog.CreateResolver());
            container.AddPart(this);
            container.Compose();
        }</pre></div>

<p>At first we search for the &quot;PluginIns&quot; directory and create it if it it&#180;s necessary. Now - pure MEF action: 
  <br />Plugins are manged with parts and catalogs. We tell our catalog to search for plugins in this assembly: 

  <br /></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:54e02d6b-2ba6-4e75-b867-5dec99356fb7" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            catalog.Catalogs.Add(new AttributedAssemblyPartCatalog(Assembly.GetExecutingAssembly()));</pre></div>




<p>... and to look at this directory: 
  <br /></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:46bc690d-92a7-4837-b65b-e18d0e9a5009" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            catalog.Catalogs.Add(new DirectoryPartCatalog("PlugIns"));</pre></div>




<p>We can also observe the directory, to add plugins while the application is running:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image36.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="43" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb38.png" width="434" border="0" /></a> </p>

<p>Through the container we tell MEF that here is a plugin interface (the list with the import attribute) and start the &quot;compose&quot; process.</p>

<p><strong>HelloMEF.App - Plugins inside the assembly:</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:70acf3fc-80ea-4dbf-9b61-5eff6b6564bb" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">namespace HelloMEF.App
{
    public class HelloProgram
    {
	...
    }

    [Export(typeof(IHelloService))]
    public class MEFHelloService : IHelloService
    {
	...
    }

}</pre></div>

<p>The plugins could be placed inside the assembly. MEF find these plugins through this catalog: &quot;AttributeAssemblyPartCatalog&quot; </p>

<p><strong>The result:</strong></p>
<strong></strong>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image37.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="183" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb39.png" width="264" border="0" /></a> </p>

<p><strong>&#160;<a href="{{BASE_PATH}}/assets/files/democode/hellomef/hellomef.zip">[ Download Source Code ]</a></strong></p>
