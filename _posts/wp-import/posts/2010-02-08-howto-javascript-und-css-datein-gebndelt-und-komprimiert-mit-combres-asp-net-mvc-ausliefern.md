---
layout: post
title: "HowTo: Javascript und CSS Datein gebündelt und komprimiert mit Combres & ASP.NET MVC ausliefern"
date: 2010-02-08 01:06
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, Combres, HowTo, Http, Performance]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image924.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="108" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb109.png" width="108" align="left" border="0"></a> Für eine performante Webapplikationen gilt es einiges zu beachten. Ein Punkt bei dem <a href="http://developer.yahoo.com/performance/rules.html">Y-Slow Test</a> ist, dass man den client nicht zu viele HTTP Aufrufe zumuten soll und CSS und Javascript jeweils in großen Bündeln dem Client übergeben soll, da sonst der Browser alle anderen Ladevorgänge <a href="http://www.stevesouders.com/blog/2010/02/07/browser-script-loading-roundup/">blockiert</a>. Mit dem "<a href="http://combres.codeplex.com/">Combres</a>" kann man das sehr gut lösen.</p><!--more--> <p><strong>"Combres"</strong></p> <p><a href="http://combres.codeplex.com/">Combres</a> ist ein ein Open Source Projekt, mit welchem man CSS und Javascript "gebündelt" und komprimiert dem Client zur Verfügung stellt. </p> <p>Ungünstig an Combres ist, dass man viele DLLs in sein Projekteinbinden muss, damit es auch funktioniert. </p> <p><strong>Schritt für Schritt</strong></p> <p><strong>1. <a href="http://combres.codeplex.com/">Combres</a> runterladen</strong> (neben den dlls sind auch Samples vorhanden)</p> <p>Das sind die DLLs die ich auch mit in das Projekt eingebunden habe:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image925.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="186" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb110.png" width="239" align="left" border="0"></a> Evtl.&nbsp; kann man 1 oder zwei weglassen, aber Combres, log4net, DotCommon, DotCommon.Web braucht er unbedingt. Danach hatte ich einfach alles eingebunden. Das ist etwas ärgerlich.</p> <p>&nbsp;</p> <p>&nbsp;</p> <p><strong>2. Web.config Eintrag hinzufügen</strong></p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:13fcd3c1-a680-4610-acef-42bbf917c8af" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">	&lt;configSections&gt;
    		&lt;section name="combres" type="Combres.ConfigSectionSetting, Combres" /&gt;
		...
	&lt;/configSections&gt;
  	&lt;combres definitionUrl="~/App_Data/combres.config"/&gt;</pre></div>
<p><strong> 3. Combres.config</strong></p>
<p>In der Combres.config (oder .xml) konfiguriert man nun alles. Bereits in der aktuellen Version kann man sehr, sehr viel konfigurieren. Ich habe die config aus dem Sample genommen und es ein wenig nach meinen Bedürfnissen angepasst:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:616574bf-63a2-46c3-8174-ef76b29e2999" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-8" ?&gt;
&lt;combres xmlns='urn:combres'&gt;
  &lt;filters&gt;
    &lt;filter type="Combres.Filters.FixUrlsInCssFilter, Combres" acceptedResourceSets="siteCss" /&gt;
    &lt;filter type="Combres.Filters.HandleCssVariablesFilter, Combres" /&gt;
  &lt;/filters&gt;
  &lt;cssMinifiers&gt;
    &lt;minifier name="yui" type="Combres.Minifiers.YuiCssMinifier, Combres"&gt;
      &lt;param name="CssCompressionType" type="string" value="StockYuiCompressor" /&gt;
      &lt;param name="ColumnWidth" type="int" value="-1" /&gt;
    &lt;/minifier&gt;
  &lt;/cssMinifiers&gt;
  &lt;jsMinifiers&gt;
    &lt;minifier name="yui2" type="Combres.Minifiers.YuiJSMinifier, Combres" /&gt;
    &lt;minifier name="yui" type="Combres.Minifiers.YuiJSMinifier, Combres"&gt;
      &lt;param name="IsVerboseLogging" type="bool" value="false" /&gt;
      &lt;param name="IsObfuscateJavascript" type="bool" value="true" /&gt;
      &lt;param name="PreserveAllSemicolons" type="bool" value="false" /&gt;
      &lt;param name="DisableOptimizations" type="bool" value="false" /&gt;
      &lt;param name="LineBreakPosition" type="int" value="-1" /&gt;
    &lt;/minifier&gt;
    &lt;minifier name="msajax" type="Combres.Minifiers.MSAjaxJSMinifier, Combres" binderType="Combres.Binders.SimpleObjectBinder, Combres"&gt;
      &lt;param name="CollapseToLiteral" type="bool" value="true" /&gt;
      &lt;param name="EvalsAreSafe" type="bool" value="true" /&gt;
      &lt;param name="LocalRenaming" type="Microsoft.Ajax.Utilities.LocalRenaming, ajaxmin" value="CrunchAll" /&gt;
      &lt;param name="OutputMode" type="Microsoft.Ajax.Utilities.OutputMode, ajaxmin" value="SingleLine" /&gt;
      &lt;param name="RemoveUnneededCode" type="bool" value="true" /&gt;
      &lt;param name="StripDebugStatements" type="bool" value="true" /&gt;
    &lt;/minifier&gt;
    &lt;minifier name="closure" type="Combres.Minifiers.ClosureJSMinifier, Combres"&gt;
      &lt;param name="ApiUrl" type="string" value="http://closure-compiler.appspot.com/compile" /&gt;
      &lt;param name="CompilationLevel" type="string" value="ADVANCED_OPTIMIZATIONS" /&gt;
    &lt;/minifier&gt;
  &lt;/jsMinifiers&gt;
  &lt;resourceSets url="~/combres.axd"
                defaultDuration="30"
                defaultVersion="auto"
                defaultCssMinifierRef="off"
                defaultJSMinifierRef="off"
                defaultDebugEnabled="auto"
                localChangeMonitorInterval="30"
                remoteChangeMonitorInterval="60"
                &gt;
    &lt;resourceSet name="siteCss" type="css" version="21" minifierRef="yui" debugEnabled="false"&gt;
      &lt;resource path="~/content/site.css" /&gt;
      &lt;resource path="~/content/jquery-ui-1.7.2.custom.css" mode="Dynamic" /&gt;
    &lt;/resourceSet&gt;
    &lt;resourceSet name="siteJs" type="js" minifierRef="msajax" debugEnabled="false"&gt;
      &lt;resource path="~/scripts/jquery-1.3.2.min.js" /&gt;
      &lt;resource path="~/scripts/MicrosoftAjax.js" /&gt;
      &lt;resource path="~/scripts/MicrosoftMvcAjax.js" /&gt;
      &lt;resource path="~/scripts/jquery-ui-1.7.2.custom.min.js" /&gt;
    &lt;/resourceSet&gt;
  &lt;/resourceSets&gt;
&lt;/combres&gt;
</pre></div>
<p>Als "resource path" kann man auch eine URL angeben und so z.B. jQuery von Googles oder Microsofts CDN zu holen. </p>
<p>Jedem "set" gibt man einen Namen, Typen und einen "minifier" an (der den Code noch zusätzlich "komprimiert") sowie eine Version.</p>
<p><strong>4. Global.asax -&gt; Routing ändern</strong></p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f19e2233-66c3-4558-9c81-bd8a0526d383" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.AddCombresRoute("Combres");
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.MapRoute(
                "Default",                                              // Route name
                "{controller}/{action}/{id}",                           // URL with parameters
                new { controller = "Home", action = "Index", id = "" }  // Parameter defaults
            );

        }</pre></div>
<p>Wichtig ist, dass die "CombresRoute" zuerst hinzugefügt wird, ansonsten spinnt das Routing und er findet die CSS/JS Datein nicht.</p>
<p><strong>5. Javascript und CSS Datein verlinken</strong></p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:22bb304e-315c-434d-940d-187403e19fd0" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;link href="&lt;%= Html.CombresUrl("siteCss")%&gt;" rel="stylesheet" type="text/css" /&gt;
    &lt;%= Html.CombresLink("siteJs")%&gt;</pre></div>
<p>Diese Helper stecken im "Combres" Namespace.</p>
<p><strong>Fertig</strong></p>
<p>Der erste Aufruf eines Clients ist erstmal etwas langsamer, aber dann legt der Browser das File in den Cache und wahrscheinlich cacht das Framework auch selber (jedenfalls sind dann neue Aufrufe auch schneller). Insgesamt würde ich meinen, dass diese Technik sich erst dann bezahlt macht, wenn man ganz viele jQuery Plugins etc. benutzt. </p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image926.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="61" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb111.png" width="507" border="0"></a></p>
<p>Auf dieses Framework bin ich durch diesen <a href="http://weblogs.asp.net/gunnarpeipman/archive/2009/07/04/asp-net-mvc-how-to-combine-scripts-and-other-resources.aspx">Blogpost</a> aufmerksam geworden, allerdings hat sich bereits die Konfiguration geändert.</p>
<p>In meinem Beispiel benutze ich auch <a href="{{BASE_PATH}}/2009/03/19/howto-iis7-als-development-server-im-visual-studio-2008-einrichten/">den normalen IIS</a> um realistische Daten zu bekommen. </p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvccombine/mvccombine.zip">[ Download Democode ]</a></strong></p>
