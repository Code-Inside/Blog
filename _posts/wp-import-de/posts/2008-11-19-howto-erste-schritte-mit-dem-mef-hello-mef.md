---
layout: post
title: "HowTo: Erste Schritte mit dem MEF (Hello MEF!)"
date: 2008-11-19 13:48
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [AddIns, HowTo, MEF, Plugins, System.AddIn]
language: de
---
{% include JB/setup %}
<p>In fast jeder Applikation kann man Plugins hinzuf&#252;gen. In .NET 4.0 kommt eine neue M&#246;glichkeit hinzu die man heute bereits ausprobieren kann. Die Rede ist von dem &quot;Managed Extensibility Framework&quot; - kurz MEF.    <br />MEF soll auch in Visual Studio 2010 selbst einzughalten (<a href="http://channel9.msdn.com/pdc2008/KYN02/">siehe PDC Keynote von Scott Guthrie</a>). Dazu kann ich auch die PDC Session von <a href="http://channel9.msdn.com/pdc2008/TL49/">Scott Hanselman &#252;ber sein &quot;BabySmash&quot;</a> empfehlen.</p>  <p><strong>Addins? Gab es da nicht schonmal was?      <br /></strong>Es gibt seit .NET 3.5 einen &quot;System.AddIn&quot; Namensraum. Meiner Meinung nach war es relativ kompliziert Addins zu entwickeln. <a href="http://blogs.msdn.com/kcwalina/archive/2008/06/13/MAFMEF.aspx">Allerdings soll MEF und System.Addin gut zusammenarbeiten</a>. </p>  <p><strong>Was braucht man?      <br /></strong>Alles was man braucht findet man auf der <a href="http://www.codeplex.com/MEF">Codeplex Seite</a>. Einfach den neusten Release runterladen und die 2 DLLs in eigene Projekte einsetzen <em>(Achtung - es befindet sich noch in Entwicklung und kann sich jederzeit &#228;ndern)</em>.</p>  <p><strong>Hello World! Hallo Welt! Hello MEF! - Vorbereitung</strong></p>  <p>Projektstruktur:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image565.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb543.png" width="175" border="0" /></a> </p>  <p>Wir haben einen einfachen Serviceinterface namens &quot;<strong>IHelloService</strong>&quot;:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c35ef68e-5110-43bd-89a1-248e08f1f4bf" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public interface IHelloService
    {
        string GetHelloMessage();
    }</pre></div>

<p>In dem <strong>HelloMEF.English / German</strong> Projekt haben wir folgenden Code (hier f&#252;r das englische Plugin) :</p>

<p></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b8f93327-b5bd-4c0e-8975-a01c7f9e8425" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">using System;
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

<br />Wichtig hier ist das &quot;Export&quot; Attribut aus dem &quot;System.ComponentModel.Composite&quot; (MEF) Namespace. 

<br /><u>Damit wird ausgedr&#252;ckt:</u> Dies ist ein Plugin des Typs IHelloService. 

<p></p>

<p>In diesen beiden Projekten kann man machen was man m&#246;chte. Hier muss man nur die Referenz auf die HelloMEF.App wegen des Interfaces machen. Ansonsten kennen sich die Applikationen nicht!</p>

<p><strong>Plugin Ordner 
    <br /></strong>Damit die Applikation &#252;berhaupt die beiden Plugins kennt, werfen wir beide DLLs in einen eigenen Ordner namens &quot;PlugIns&quot;:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image566.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="48" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb544.png" width="244" border="0" /></a> </p>

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

<p>In der &quot;HelloProgram&quot; Klasse haben wir eine Liste an &quot;IHelloServices&quot;, welches mit dem &quot;Import&quot; Attribute aus dem MEF Namensraum dekoriert ist. 
  <br /><u>Das bedeutet:</u> Ich nehme alles vom Typen IHelloService auf.</p>

<p>In unserer Ausgabe iterieren wir einfach &#252;ber diese Liste und rufen die GetHelloMessage auf. </p>

<p><strong>HelloMEF.App - Plugins suchen und finden:</strong></p>

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

<p>Wir schauen erstmal nach dem &quot;PluginIns&quot; Verzeichnis und erstellen es wenn n&#246;tig. Jetzt folgt pure MEF-Action. 
  <br />Die PlugIns werden in Katalogen verwaltet. Unserem Katalog sagen wir hier, dass es nach Plugins in dieser Assembly suchen soll: 

  <br /></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:54e02d6b-2ba6-4e75-b867-5dec99356fb7" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            catalog.Catalogs.Add(new AttributedAssemblyPartCatalog(Assembly.GetExecutingAssembly()));</pre></div>

<p></p>

<p>Und das es auch ein Verzeichnis &#252;berwachen soll: 
  <br /></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:46bc690d-92a7-4837-b65b-e18d0e9a5009" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            catalog.Catalogs.Add(new DirectoryPartCatalog("PlugIns"));</pre></div>

<p></p>

<p>Es gibt auch die M&#246;glichkeit das Verzeichnis &#252;berwachen zu lassen, sodass man zur Laufzeit Plugins hinzuf&#252;gen k&#246;nnte:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image567.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="43" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb545.png" width="434" border="0" /></a> </p>

<p>Durch den Container sagen wir MEF, dass wir hier eine Pluginschnittstelle haben (die Liste mit dem &quot;Import&quot; Attribut) und am Ende geben wir den &quot;Compose&quot; Befehl.</p>

<p><strong>HelloMEF.App - Plugins in derselben Assembly:</strong></p>

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

<p>Die Plugins k&#246;nnen auch in derselben Assembly stehen, MEF findet es durch den &quot;AttributeAssemblyPartCatalog&quot; ebenfalls.</p>

<p><strong>Das Ergebnis:</strong></p>
<strong></strong>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image568.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="183" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb546.png" width="264" border="0" /></a> </p>

<p><strong>&#160;<a href="{{BASE_PATH}}/assets/files/democode/hellomef/hellomef.zip">[ Download Source Code ]</a></strong></p>
