---
layout: post
title: "Erster Eindruck von ASP.NET MVC mit dem Visual Web Developer Express"
date: 2007-12-16 20:23
author: Robert Muehsig
comments: true
categories: [Allgemein]
tags: [.NET 3.5, ASP.NET, ASP.NET 3.5 Extensions, ASP.NET AJAX, ASP.NET MVC, Source]
language: de
---
{% include JB/setup %}
<p>Die ASP.NET Extension CTP ist schon eine <a href="{{BASE_PATH}}/2007/12/10/aspnet-35-extensions-december-ctp-verfgbar/" target="_blank">kleine Weile verfügbar</a>, jedoch bin ich erst heute dazu gekommen, mir dies mal anzuschauen.</p> <p>Da ich auf meinem privat Notebook kein Visual Studio 2008 Standard (oder höher) hab, benutze ich den Visual Web Developer 2008 (was wahrscheinlich bei vielen Leuten zutrifft).</p> <p><strong><u>Vorbereitung:</u></strong>&nbsp;</p> <ul> <li><a href="http://weblogs.asp.net/scottgu/archive/2007/11/13/asp-net-mvc-framework-part-1.aspx" target="_blank">Scotts Einführung Teil 1 (ASP.NET MVC Framework (Part 1))</a></li> <li><a href="http://weblogs.asp.net/scottgu/archive/2007/12/03/asp-net-mvc-framework-part-2-url-routing.aspx" target="_blank">Scotts Einführung Teil 2 (ASP.NET MVC Framework (Part 2): URL Routing)</a></li> <li><a href="http://weblogs.asp.net/scottgu/archive/2007/12/06/asp-net-mvc-framework-part-3-passing-viewdata-from-controllers-to-views.aspx" target="_blank">Scotts Einführung Teil 3 (ASP.NET MVC Framework (Part 3): Passing ViewData from Controllers to Views)</a></li> <li><a href="http://weblogs.asp.net/scottgu/archive/2007/12/09/asp-net-mvc-framework-part-4-handling-form-edit-and-post-scenarios.aspx" target="_blank">Scotts Einführung Teil 4 (ASP.NET MVC Framework (Part 4): Handling Form Edit and Post Scenarios)</a></li> <li>Folgende Blogs enthalten auch noch gute Informationen:</li> <ul> <li><a href="http://blog.wekeroad.com/" target="_blank">Rob Conery</a></li> <li><a href="http://www.hanselman.com/blog/" target="_blank">Scott Hanselman</a></li> <li><a href="http://blogs.msdn.com/brada/default.aspx" target="_blank">Brad Abrams</a></li> <li><a href="http://haacked.com/Default.aspx" target="_blank">Phil Haack</a></li> <li><a href="http://weblogs.asp.net/fredriknormen/default.aspx" target="_blank">Fredrik NormÃ©n</a></li></ul> <li>Als Software benötigen wir:</li> <ul> <li><a href="http://www.microsoft.com/express/vwd/" target="_blank">Visual Web Developer Express 2008</a></li> <ul> <li>Info: Natürlich geht auch VS 2008 Standard und co., ich werde zeigen, wie man die CTP mit einer "Web Site" nutzen kann (und keinem "Web Project").</li></ul> <li><a href="http://asp.net/downloads/3.5-extensions/" target="_blank">ASP.NET 3.5 Extensions (CTP)</a></li> <li>Evtl. auch noch das MVC Toolkit (siehe ASP.NET Extension Seite)</li></ul></ul> <p><strong><u>ASP.NET 3.5 Extensions installieren und Visual Web Developer Web Site "MVC tauglich" machen</u></strong></p> <p>Nachdem man die CTP installiert hat, findet man im Visual Web Developer zwar eine Vorlage für "ASP.NET 3.5 Extensions Web Site", allerdings unterstützt die CTP momentan nur Web Projects - daher nützt uns das nur sehr wenig.</p> <p>Eine Installationsanleitung befindet sich <a href="http://www.lazycoder.com/weblog/index.php/archives/2007/12/10/using-the-aspnet-mvc-framework-with-visual-web-developer-express/" target="_blank">hier</a>. Insbesondere muss man da auch die Kommentare lesen, dann wird es klarer. Aber nochmal zusammengefasst:</p> <ul> <li><strong>web.config unter dem Punkt "system.web"-"pages" anpassen:</strong></li></ul> <div class="CodeFormatContainer"><pre class="csharpcode">         &lt;namespaces&gt;
            &lt;add <span class="kwrd">namespace</span>=<span class="str">"System.Web.Mvc"</span>/&gt;
            &lt;add <span class="kwrd">namespace</span>=<span class="str">"System.Linq"</span>/&gt;
         &lt;/namespaces&gt;</pre></div>
<p><em>(warum weiß ich auch noch nicht so genau, das bekommen wir bestimmt noch raus ;) )</em></p>
<ul>
<li><strong>global.asax und Default Routing unter "Application_Start()" hinzufügen:</strong></li></ul>
<div class="CodeFormatContainer"><pre class="csharpcode">    <span class="kwrd">void</span> Application_Start(<span class="kwrd">object</span> sender, EventArgs e) 
    {
        RouteTable.Routes.Add(<span class="kwrd">new</span> Route
        {
            Url = <span class="str">"[controller]/[action]/[id]"</span>,
            Defaults = <span class="kwrd">new</span> { action = <span class="str">"Index"</span>, id = (<span class="kwrd">string</span>)<span class="kwrd">null</span> },
            RouteHandler = <span class="kwrd">typeof</span>(MvcRouteHandler)
        }); 

    }</pre></div>
<ul>
<li><strong>Ordnersturktur anpassen:</strong></li></ul>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image189.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="361" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb168.png" width="214" border="0"></a> </p>
<p><u>Erklärung:</u> Unter "App_Code" befinden sich unsere Controller und Models, die Views kommen ins Root Verzeichnis.</p>
<p>Die Default.aspx im Rootverzeichnis ist <u>komplett</u> leer.</p>
<p>Der Ordner "Shared" ist für Masterpages, User Controls etc. gedacht.</p>
<p>Mein .ASPX Seiten haben kein Codefile mehr, sondern erben direkt von "System.Web.Mvc.ViewPage", z.B.:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">&lt;%@ Page Language=<span class="str">"C#"</span> <br>    MasterPageFile=<span class="str">"~/Views/Shared/Site.master"</span> <br>    AutoEventWireup=<span class="str">"true"</span> <br>    Inherits=<span class="str">"System.Web.Mvc.ViewPage"<br>   </span> Title=<span class="str">"Bookstorage | Search"</span> %&gt;</pre>
</div>
<p>Die Masterseite ist normal, enthält aber kein "form" Tag und auch keinen ScriptManager für ASP.NET AJAX - da müsste man nochmal genau nachschauen wie&nbsp; man das geschickt macht (darauf komme ich später nochmal).</p>
<p><strong><u>Die Webapplikation strukturieren</u></strong></p>
<ul>
<li>Homeseite </li>
<ul>
<li>Index.aspx -View (default) -URL: <a href="http://localhost:56967/Intro/Home">http://localhost:56967/Intro/Home</a></li>
<ul>
<li>Gibt nur simplen Text zurück </li></ul></ul>
<li>Searchseite</li>
<ul>
<li>Index.aspx -View (default) -URL: <a href="http://localhost:56967/Intro/Search">http://localhost:56967/Intro/Search</a> </li>
<ul>
<li>Stellt Suchformular bereit</li></ul>
<li>Result.aspx -View -URL: <a href="http://localhost:56967/Intro/Search/Results/(SUCHBEGRIFF">http://localhost:56967/Intro/Search/Results/(SUCHBEGRIFF</a>)</li>
<ul>
<li>Stellt Suchergebnisse für den "SUCHBEGRIFF" dar</li></ul></ul></ul>
<p>Insgesamt ist die Website sehr simpel gehalten, daher bitte nicht wundern.</p>
<p><strong><u>Das Model</u></strong></p>
<p>Es gibt eine einfache "Book" Klasse sowie eine Klasse "BookCollection", welche von "List&lt;Book&gt;" erbt.<br>Der "BookCollectionManager" hat eine Methode "GetBookCollection", welche einfach so eine Collection zurückgibt.</p>
<p><strong><u>Die Controller</u></strong></p>
<p>Der HomeController macht nix großes bzw. sieht man das auch gut am SearchController wie ich diesen aufgebaut habe:</p>
<div class="CodeFormatContainer"><pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">class</span> SearchController : Controller
{

    [ControllerAction]
    <span class="kwrd">public</span> <span class="kwrd">void</span> Index()
    {
        RenderView(<span class="str">"Index"</span>);
    }

    [ControllerAction]
   <span class="kwrd">public</span> <span class="kwrd">void</span> Results(<span class="kwrd">string</span> query)
   {
        BookCollectionManager man = <span class="kwrd">new</span> BookCollectionManager();
        BookCollection data = man.GetBookCollection(query, 1);
        ViewData[<span class="str">"BookCollection"</span>] = data;
        RenderView(<span class="str">"Results"</span>);
   }
}</pre></div>
<p><font face="Trebuchet MS">In dem Controller geibts einmal den Index (der laut unserer Routingtabelle in der globals.asax der Default Controller ist) und sagt nur, dass er den View "Index(.aspx)" Rendern soll. Dabei sucht er genau in dieser Ordnerstruktur nach "Search" etc.</font></p>
<p>Unsere "Results" Methode ist eigentlich unsere Suchmethode und spricht unser Backend (was einfach nur eine Collection an 25 Einträgen zurück gibt) an. Die Daten werden dann in ViewData gespeichert und autoamtisch übergeben. Scott hat auch noch andere Methoden beschrieben - dies war erstmal die Einfachste. Dannach wird der View "Results" gerendert.</p>
<p><strong><u>Daten an den Controller übergeben</u></strong></p>
<p>Zwar haben wir jetzt unseren Controller, aber wie übergeben wir diesem was? </p>
<p>Ganz einfach über ein HTML Formular:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">&lt;asp:Content ID=<span class="str">"Content2"</span> ContentPlaceHolderID=<span class="str">"ContentPlaceHolderContent"</span> Runat=<span class="str">"Server"</span>&gt;
&lt;form id=<span class="str">"searchform"</span> action=<span class="str">"/Intro/Search/<strong>Results</strong>"</span> method=<span class="str">"post"</span>&gt;
    &lt;span&gt;Search:&lt;/span&gt;
    &lt;input type=<span class="str">"text"</span> name=<span class="str">"<strong>query</strong>"</span> /&gt;
    &lt;button type=<span class="str">"submit"</span>&gt;Suchen&lt;/button&gt;
&lt;/form&gt;

&lt;/asp:Content&gt;</pre></div>
<p>Die Form verweisst auf unsere "Results" Methode - wichtig dabei ist, dass der name des übergebenen Parameter mit dem der Methode übereinstimmt. Dies stößt unseren Controller an, welcher dann wiederrum den View rendert.</p>
<p><u>Problem mit ASP.NET AJAX:</u> <br>Hier will ich nochmal kurz mein Problem mit dem ScriptManager erläutern. Da ich in der Masterpage kein "form" hab (wie im normalen ASP.NET) üblich, sondern es nur dort einsetzen möchte, wo ich es für sinnvoll halte (wie z.B. hier) und die action URL je nachdem darauf ausrichten möchte, gibt es leider ein Problem mit ASP.NET AJAX.<br>Dadurch kann man den ScriptManager nur unschön in die MasterPage hinzufügen, da dieser ein "&lt;form runat="server"&gt;... verlangt. Eine Lösung gibt es bestimmt (vielleicht über das MVCToolkit) oder man fügt den ScriptManager auf den Seiten hinzu, wo man ihn benötigt. 2 Formuale (eine in der Masterpage &amp; eine auf der Contentpage) ist irgendwie "unschön", aber da müsste man nochmal nachschauen. Microsoft macht sich <a href="http://www.nikhilk.net/Ajax-MVC.aspx" target="_blank">selbst auch Gedanken</a> und ich denke, da kommt noch eine bessere Integration insgesamt, weil man zwar den ScriptManager einsetzen könnte, aber dann wiederrum die Controller etc. übergeht - und das ist ja nicht Sinn der Sache.</p>
<p><strong><u>Die übergebenen Daten darstellen</u></strong></p>
<p>In jedem View benutze ich meine simple Masterpage, daher ist dies der wesentliche Code in der "Result.aspx":</p>
<div class="CodeFormatContainer"><pre class="csharpcode">&lt;asp:Content ID=<span class="str">"Content2"</span> ContentPlaceHolderID=<span class="str">"ContentPlaceHolderContent"</span> Runat=<span class="str">"Server"</span>&gt;
Search Results:

&lt;table&gt;
&lt;%<span class="kwrd">foreach</span> (var returnBook <span class="kwrd">in</span> (BookCollection)ViewData[<span class="str">"BookCollection"</span>])  { %&gt;
&lt;tr&gt;
    &lt;td&gt;&lt;%= returnBook.Title %&gt;&lt;/td&gt;
    &lt;td&gt;&lt;%= returnBook.Description %&gt;&lt;/td&gt;
    &lt;td&gt;&lt;%= returnBook.PicUrl %&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;% } %&gt;
&lt;/table&gt;
&lt;/asp:Content&gt;</pre></div>
<p>Über "ViewData["BookCollection"]" greife ich auf meine Daten zu und gebe sie einfach so aus. Ob nun "var" (also ein anonymer Typ) da richtig ist, weiß ich noch nicht ganz ;) , es funktioniert jedenfalls:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image190.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="144" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb169.png" width="253" border="0"></a> </p>
<p><strong><u>Das Demoprojekt testen/download &amp; Fazit</u></strong></p>
<p>Startet nicht das Projekt wenn ihr gerade die ASPX Seiten geöffnet habt, da dann z.B. bei der Result.aspx eine Exception geworfen wird ;) - öffnet die leere Default.aspx und gebt dann manuell die jeweiligen URLs (siehe oben) ein.</p>
<p>Wenn man sich erstmal eingearbeitet hat, macht es sehr viel Freude, zu sehen, dass man diesmal volle Kontrolle über den HTML Code hat und es (jedenfalls für mich) klarer ist, wie man bestimmte HTML Elemente dynamisch rendert. Das es noch hier und da (ASP.NET AJAX) Schwierigkeiten gibt, ist natürlich bei so einer Preview verständlich.<br>Dies waren auch nur meine ersten Schritte, sodass ich wahrscheinlich noch nicht alles optimal gemacht habe ;)</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvcintro/mvcintro.zip" target="_blank">[ Download Source Code ]</a></strong></p>
