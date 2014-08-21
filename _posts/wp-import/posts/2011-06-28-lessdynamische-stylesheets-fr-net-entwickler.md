---
layout: post
title: ".LESS–dynamische Stylesheets für .NET Entwickler"
date: 2011-06-28 23:52
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.LESS, Combres, CSS]
---
{% include JB/setup %}
<p>.LESS kommt ursprünglich aus der Ruby Welt und hilft dabei einige Unzulänglichkeiten von CSS zu beseitigen. .LESS lehnt sich an den gewöhnlichen CSS Syntax an, erweitert ihn aber um ein paar nette Funktionen, darunter z.B. Variablen (um bestimmte Werte nicht doppelt schreiben zu müssen) oder Funktionen (um z.B. Abstände zu addieren). Eine komplette Liste der Möglichkeiten findet <a href="http://lesscss.org/">ihr dazu hier</a>. Um mal ein Blick auf den Syntax zu werfen:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e299c53b-b831-45bd-b60a-ddb6fa8a4dc0" class="wlWriterEditableSmartContent"><pre name="code" class="c#"> @color: #4D926F;

#header {
  color: @color;
}
h2 {
  color: @color;
}</pre></div>
<p>&nbsp;</p>
<p>Da die Browser trotzdem natürlich nur den gewöhnlichen CSS Syntax verstehen muss das mit .LESS gemachte Stylesheet umgewandelt werden. Dazu gibt es mehrere Herangehensweisen.</p>
<p><strong>Umwandlung per Javascript</strong></p>
<p>Unter <a href="http://lesscss.org">http://lesscss.org</a> gibt es auch ein Javascript-File, welches genau diese Umwandlung auf dem Client im Browser vornimmt. Dazu muss einfach das Javascript File referenziert werden und fertig.</p>
<p>Mehr dazu <a href="http://lesscss.org/#-client-side-usage">hier</a>.</p>
<p><strong>Umwandlung zur Entwicklungszeit in normales CSS</strong></p>
<p>Die dauerhafteste Lösung aus dem .LESS Style wieder gewöhnliches CSS zu machen ist es eine Transformation vor dem Deployment bzw. während der Entwicklungszeit vorzunehmen. Der Vorteil in dieser Methode liegt darin, dass ein komplettes CSS erstellt wird und dies mit den gewöhnlichen CSS-Toolstack auch weiterverarbeiten kann. Es wirkt sich allerdings nachteilig aus, wenn man die gemachten Änderungen später auch wieder in die .LESS Form rückführen möchte. Letzteres ist zwar nicht unmöglich, würde aber das Konzept irgendwie “verwässern” <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images/wlEmoticon-winkingsmile3.png"></p>
<p>Für .NET Entwickler ist das <a href="http://www.dotlesscss.org/">dotless Projekt</a> am besten geeignet. Das dotless Projekt ist eine Portierung des ursprünglichen Ruby Projektes auf .NET. In den <a href="https://github.com/dotless/dotless/downloads">Downloads</a> dabei ist auch ein “Compiler”, welchen man über die CMD aufrufen kann. Es gibt allerdings auch einen “Watcher”, sodass das manuelle Anstoßen des Compile Prozess entfällt. Mehr dazu kann man im <a href="https://github.com/dotless/dotless/wiki">Wiki</a> nachlesen.</p>
<p><strong>Umwandlung zur Laufzeit – mit dotless</strong></p>
<p>Bei dieser Variante wird die Transformation erst zur Laufzeit gemacht – man selbst erstellt also kein CSS File. Hierbei gibt es verschiedene Varianten - im Grunde wird aber überall das dotless Projekt genutzt.</p>
<p>Hierbei müssen wir natürlich das dotless auch in unser Webprojekt verlinken (z.B. über NuGet)</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1287.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb469.png" width="543" height="202"></a></p>
<p>Über diese Bibliothek können wir auch vom Code heraus die Transformation starten. Wie das genau aussehen kann wird hier recht gut beschrieben (auch wenn es schon etwas älter ist) : <a href="http://schotime.net/blog/index.php/2010/07/02/dynamic-dot-less-css-with-asp-net-mvc-2/">Dynamic Dot Less Css With Asp.net MVC 2</a></p>
<p><strong>Umwandlung zur Laufzeit – mit dotless und Combres</strong></p>
<p>Combres ist eine nette Bibliothekt, um statischen Content (wie JS oder CSS Dateien) “besser” zum Client zu schicken (<a href="{{BASE_PATH}}/2010/02/08/howto-javascript-und-css-datein-gebndelt-und-komprimiert-mit-combres-asp-net-mvc-ausliefern/">ab und an hatte ich bereits über die Combres Bibliothek</a> gebloggt). Combres bietet von Haus aus auch Unterstützung für dotLess an. Combres (samt MVC Helper) gibt es zudem auch als NuGet Package:<br></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1288.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb470.png" width="342" height="203"></a></p>
<p>Die Anwendung von Combres nach der Installation ist simpel (und zudem recht gut beschrieben in den ReadMe Files). Combres selbst kann Dateien über Filter vor der Auslieferung “manipulieren”. Mit eingebaut ist unter anderem auch ein Filter für DotLess (den Code kann man sich <a href="http://www.codeproject.com/KB/aspnet/combres2.aspx">unter anderem auch hier</a> anschauen). In der Combres.xml muss nur der DotLessCssFilter mit angegeben werden und die .LESS Css Datei als Resource mit aufgenommen werden.</p>
<p>&nbsp;</p>
<p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6d810266-a839-4327-8652-669985d26417" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;combres xmlns='urn:combres'&gt;
  &lt;filters&gt;
    &lt;filter type="Combres.Filters.FixUrlsInCssFilter, Combres" /&gt;
    &lt;filter type="Combres.Filters.DotLessCssFilter, Combres" /&gt;
  &lt;/filters&gt;
  &lt;resourceSets url="~/combres.axd"
                defaultDuration="30"
                defaultVersion="auto"
                defaultDebugEnabled="false"
                defaultIgnorePipelineWhenDebug="true"
                localChangeMonitorInterval="30"
                remoteChangeMonitorInterval="60"
                &gt;
    &lt;resourceSet name="siteCss" type="css"&gt;
      &lt;resource path="~/content/Less.css" /&gt;
    &lt;/resourceSet&gt;
  &lt;/resourceSets&gt;
&lt;/combres&gt;
</pre></div></p>


<p>&nbsp;</p>
<p>In der Layout Master wird dann nur noch der Combres HTML Helper genutzt:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:93fcf2da-b273-41ab-bac1-8daa53943df9" class="wlWriterEditableSmartContent"><pre name="code" class="c#">@using Combres.Mvc;

&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
	...
    @Html.CombresLink("siteCss")
	...</pre></div>
<p>&nbsp;</p>
<p>Das Ergebnis davon kann im einfachsten Fall so aussehen – egal welche Variante man am Ende nutzt. Die Unterscheidung der Varianten liegt eigentlich nur bei dem Zeitpunkt der Ausführung der Transformation – auch wenn ich persönlich die Javascript Variante für gewagt halte <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images/wlEmoticon-winkingsmile3.png"></p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d1d06ca1-e859-4348-b893-029675954e1a" class="wlWriterEditableSmartContent"><pre name="code" class="c#">  // LESS

@color: #4D926F;

#header {
  color: @color;
}
h2 {
  color: @color;
}</pre></div>
<p>&nbsp;</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:38e0ebb9-81f9-4516-8674-af75835ee8f6" class="wlWriterEditableSmartContent"><pre name="code" class="c#">/* Compiled CSS */

#header {
  color: #4D926F;
}
h2 {
  color: #4D926F;
}</pre></div>
