---
layout: post
title: "HowTo: AJAX und ASP.NET MVC"
date: 2009-08-25 22:34
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [AJAX, ASP.NET MVC, MVC]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image808.png"><img style="border-right-width: 0px; margin: 0px 10px 0px 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image-thumb786.png" width="102" height="107" /></a> Das gute <a href="{{BASE_PATH}}/?s=ajax">AJAX</a> gehört ja heutzutage schon zum gutem Ton in der Webentwicklung. Auch im <a href="http://asp.net/mvc">ASP.NET MVC Framework</a> gibt es ein paar kleine Helferlein. In dem Post will ich ein paar Varianten zeigen - von jQuery über Ajax.ActionLinks und Ajax Forms. <strong>Update für ASP.NET MVC 3:</strong> <a href="{{BASE_PATH}}/2011/04/11/howto-ajax-actionlink-asp-net-mvc-3/">hier</a></p>  <p></p>  <p></p>  <p><strong>Update: Für ASP.NET MVC 3 gibts <a href="{{BASE_PATH}}/2011/04/11/howto-ajax-actionlink-asp-net-mvc-3/">hier</a> ein Update!</strong></p>  <p><strong>Grundlagen über ASP.NET MVC</strong></p>  <ul>   <li><a href="{{BASE_PATH}}/2008/10/14/howto-aspnet-mvc-erstellen-erster-einstieg/">HowTo: ASP.NET MVC Projekt erstellen (erster Einstieg)</a> </li>    <li><a href="{{BASE_PATH}}/2009/04/02/howto-daten-vom-view-zum-controller-bermitteln-bindings-in-aspnet-mvc/">HowTo: Daten vom View zum Controller übermitteln / Modelbinders in ASP.NET MVC</a> </li> </ul>  <p><strong>Was braucht man dafür?</strong></p>  <p>Damit die AJAX Sachen klappen, müssen unbedingt die Javascript Datein (z.B. in der Masterpage eingebunden werden). Im Normalfall sind diese Scripts <strong>nicht</strong> eingebunden:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image809.png"><img style="border-right-width: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb787.png" width="244" height="149" /></a></p>  <p>In dem Ordner gibt es jeweils einmal immer eine Debug und eine &quot;Produktivvariante&quot;. In meinem Beispiel nehme ich diese 3 Scripts:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:788ef995-33cc-4c63-94a9-703904bbfbae" class="wlWriterSmartContent">   <pre class="c#" name="code">    &lt;script src=&quot;../../Scripts/jquery-1.3.2.js&quot; type=&quot;text/javascript&quot;&gt;&lt;/script&gt;
    &lt;script src=&quot;../../Scripts/MicrosoftAjax.js&quot; type=&quot;text/javascript&quot;&gt;&lt;/script&gt;
    &lt;script src=&quot;../../Scripts/MicrosoftMvcAjax.js&quot; type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</pre>
</div>

<p><strong>Helper</strong></p>

<p>Wer ein wenig mit ASP.NET MVC rumspielt wird bereits die Helper in den Views entdeckt haben - wer mal =Ajax. eingibt wird sowas in der Art sehen:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image810.png"><img style="border-right-width: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb788.png" width="226" height="208" /></a>&#160;</p>

<p><strong>Ajax.ActionLink</strong></p>

<p>Ein sehr einfacher, aber nette Sache ist der ActionLink. Er dient dazu, dass man über einen Link über AJAX einen Controller aufruft. Besonders nützlich dabei sind die <a href="http://msdn.microsoft.com/en-us/library/system.web.mvc.ajax.ajaxoptions.aspx">AjaxOptions</a> die man als Parameter mit angeben kann:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:16229742-b17d-46da-a503-b354bac431c8" class="wlWriterSmartContent">
  <pre class="c#" name="code">        &lt;%=Ajax.ActionLink(&quot;Ajax.ActionLink + Replace&quot;,
                           &quot;ItemData&quot;,
                           &quot;Ajax&quot;,
                           new AjaxOptions() { HttpMethod = &quot;GET&quot;, 
                                               InsertionMode = InsertionMode.Replace,
                                               UpdateTargetId = &quot;AjaxResult&quot; })%&gt; &lt;br /&gt;
        &lt;%=Ajax.ActionLink(&quot;Ajax.ActionLink + InsertAfter&quot;,
                           &quot;ItemData&quot;,
                           &quot;Ajax&quot;,
                           new AjaxOptions() { HttpMethod = &quot;GET&quot;,
                                               InsertionMode = InsertionMode.InsertAfter,
                                               UpdateTargetId = &quot;AjaxResult&quot;}) %&gt; &lt;br /&gt;
        &lt;%=Ajax.ActionLink(&quot;Ajax.ActionLink + InsertAfter + Loading&quot;,
                           &quot;ItemData&quot;,
                           &quot;Ajax&quot;,
                           new AjaxOptions() { HttpMethod = &quot;GET&quot;,
                                               InsertionMode = InsertionMode.InsertAfter,
                                               UpdateTargetId = &quot;AjaxResult&quot;,
                                               LoadingElementId = &quot;Loading&quot; })%&gt; &lt;br /&gt;</pre>
</div>

<p><u>Kurze Erklärung:</u> Der erste Parameter ist nur der Text des Links, danach folgt ActionMethod &amp; Controllername. Die Unterscheidung liegt in den AjaxOptions</p>

<p><strong>Variante 1:</strong> Hier ruf ich einfach &quot;ItemData&quot; vom &quot;Ajax&quot; Controller über einen GET Aufruf auf und packe das Ergebnis in ein HTML Element Namens &quot;AjaxResult&quot;.</p>

<p>Ein kurzer Blick auf die Action Method:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9e556cc7-287f-4ce9-8632-d4e1a7d33e90" class="wlWriterSmartContent">
  <pre class="c#" name="code">        public ActionResult ItemData()
        {
            return View();
        }</pre>
</div>

<p>... und der ItemData View (den ich hier zurückgebe) :</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:00cb703a-6d75-4f0f-b93a-4ab9b4ca25bd" class="wlWriterSmartContent">
  <pre class="c#" name="code">&lt;%@ Page Language=&quot;C#&quot; Inherits=&quot;System.Web.Mvc.ViewPage&quot; %&gt;
- Item</pre>
</div>

<p>Bei jedem Aufruf (über AJAX) kommt vom Controller &quot;- Item&quot; zurück und wird in das DIV &quot;AjaxResult&quot; eingefügt.</p>

<p><strong>Variante 2:</strong> Hier wird das Ergebnis (&quot;- Item&quot;) an den Content von &quot;AjaxResult&quot; angehangen.</p>

<p><strong>Variante 3:</strong> Hier wird während des AJAX Calls sogar ein Ladeicon angezeigt bzw. wird ein Element angezeigt.</p>

<p>Diese Variante ist sehr nett, wenn man auf Knopfdruck z.B. weitere Informationen nachladen möchte. Wenn man viele Daten übertragen möchte, würde ich lieber zur nächsten Variante tendieren:</p>

<p><strong>Ajax.BeginForm</strong></p>

<p>Wenn man ein ganzes Formular mit Daten per AJAX schicken möchte, gibt es auch den &quot;Ajax.BeginForm&quot; Helper:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b3c13542-8c45-41a2-9500-4267d2391150" class="wlWriterSmartContent">
  <pre class="c#" name="code">        &lt;%using (Ajax.BeginForm(&quot;ItemEdit&quot;,
                                &quot;Ajax&quot;,
                                new AjaxOptions() { HttpMethod = &quot;POSt&quot;,
                                                    InsertionMode = InsertionMode.InsertBefore,
                                                    UpdateTargetId = &quot;AjaxResult&quot; }))
          {
		  %&gt; &lt;br /&gt;
            &lt;%=Html.TextBox(&quot;Input&quot;) %&gt;
            &lt;button type=&quot;submit&quot;&gt;Ok&lt;/button&gt;
        &lt;%
		} %&gt;</pre>
</div>

<p>Dieser ist wieder ähnlich gestrickt wie der Ajax.ActionLink. Natürlich kann man dann beim Controller auch <a href="{{BASE_PATH}}/2009/04/02/howto-daten-vom-view-zum-controller-bermitteln-bindings-in-aspnet-mvc/">Modelbinder etc.</a> nutzen.</p>

<p><strong>jQuery</strong></p>

<p>Als letzte Variante möchte ich hier noch die pure jQuery AJAX Alternative zeigen:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:65cda6f6-dd48-4a12-9a28-ff0d18785f69" class="wlWriterSmartContent">
  <pre class="c#" name="code">	ï»¿function ajaxCall() {
	    $.ajax(
	        {
	            type: &quot;POST&quot;,
	            url: &quot;&lt;%=Url.Action(&quot;ItemData&quot;,&quot;Ajax&quot;) %&gt;&quot;,
	            success: function(result) {
	                $(&quot;#AjaxResult&quot;).html(result);
	            }
	        });
	    } </pre>
</div>

<p>Wie man sieht ist auch das recht unkritisch und ist einfach gemacht. Man sollte aber aufpassen, wenn man diese Javascript-Geschichten in ein extra .js File auslagert. Ich lass mir die URL vom Server über den Url Helper erzeugen, wenn man dies nun auslagert, muss man sich Gedanken machen, woher man die URL bezieht bzw. darf nix am Routing rumschrauben.</p>

<p><strong>Fazit</strong></p>

<p>Kleine AJAX Spielerein sind mit ganz traditionellen Mitteln (ohne böse ASP.NET AJAX UpdatePanels etc.) in ASP.NET MVC ganz einfach. Es gibt bestimmt noch mehr Varianten und hinter den AjaxOptions verstecken sich noch viele coole Sachen.</p>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvcajax/mvcajax.zip">[ Download Demosource ]</a></strong></p>
