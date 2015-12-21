---
layout: post
title: "HowTo: Logging mit Log4Net"
date: 2009-05-08 21:29
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [HowTo, log4net, logging]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image723.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="93" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb701.png" width="148" align="left" border="0" /></a>Sobald die Anwendung l&#228;uft und die ersten Bugs vom Kunden werden ist es enorm wichtig zu wissen, was eigentlich vorgegangen ist und wie es zu dem Fehler gekommen ist. An wichtigen Punkten ein Logging einzubauen ist deshalb sehr hilfreich beim Debuggen. <a href="http://logging.apache.org/log4net/download.html">Log4Net</a> ist eine sehr schicke Logging Bibliothek, die fast jeden Wunsch erf&#252;llt und das ganze in nur wenigen Minuten aufgesetzt.</p> 
<!--more-->
  <p><strong>Log4Net     <br /></strong>Log4Net ist eine sehr praktische .NET Bibliothek, welche das Logging vereinfach. Dabei gibt es verschiedene &quot;Log Stufen&quot; (Debug, Error, Info...) und verschiedene Arten des Loggings (&quot;Appender&quot;), so kann man beispielsweise ins Visual Studio Debug Fenster &quot;loggen&quot; oder in eine Datei, DB etc.    <br />Das ganze kann &#252;ber XML zur Laufzeit auch konfiguriert werden, sodass man auch auf dem Produktivsystem die entsprechenden Log Stufen setzen kann.</p>  <p>Eine gute Einf&#252;hrung findet sich auf den <a href="http://logging.apache.org/log4net/release/manual/introduction.html">Log4Net Seiten</a>.</p>  <p><strong>Praktischer Einstieg</strong>    <br />Um das ganze mal sehr einfach zu Demonstrieren, lege ich ein Consolen Program an und binde die Log4Net DLL ein. Die &quot;log4net.dll&quot; bekommt man von <a href="http://logging.apache.org/log4net/download.html">hier</a>.</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image724.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="191" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb702.png" width="244" border="0" /></a> </p>  <p><strong>Konfiguration von Log4Net     <br /></strong>Log4Net kann man sehr simpel &#252;ber die App/Web.Config konfigurieren. Daf&#252;r legen wir in unserem Beispiel die &quot;App.config&quot; an:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a9c24add-2a46-453a-8ec0-84352dd1f0d2" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-8" ?&gt;
&lt;configuration&gt;
  &lt;configSections&gt;
    &lt;section name="log4net" type="log4net.Config.Log4NetConfigurationSectionHandler, log4net"/&gt;
  &lt;/configSections&gt;
  &lt;log4net&gt;
    &lt;appender name="DebugAppender" type="log4net.Appender.DebugAppender" &gt;
      &lt;layout type="log4net.Layout.PatternLayout"&gt;
        &lt;conversionPattern value="%date [%thread] %-5level %logger [%property{NDC}] - %message%newline" /&gt;
      &lt;/layout&gt;
    &lt;/appender&gt;
    &lt;appender name="ConsoleAppender" type="log4net.Appender.ConsoleAppender"&gt;
      &lt;layout type="log4net.Layout.PatternLayout"&gt;
        &lt;conversionPattern value="%date [%thread] %-5level %logger [%property{NDC}] - %message%newline" /&gt;
      &lt;/layout&gt;
    &lt;/appender&gt;
    &lt;root&gt;
      &lt;level value="All" /&gt;
      &lt;appender-ref ref="DebugAppender" /&gt;
      &lt;appender-ref ref="ConsoleAppender" /&gt;
    &lt;/root&gt;
  &lt;/log4net&gt;
&lt;/configuration&gt;</pre></div>

<p>Erkl&#228;rung:
  <br />Oben definieren wir uns eine eigene ConfigSections, sodass alles zentral geregelt werden kann.

  <br />In dieser log4net-Section kommen die verschiedenen &quot;Appender&quot; zum Einsatz. Je nach Appender wird anders geloggt, der &quot;ConsoleAppender&quot; loggt beispielsweise auf die Kommandozeile und der &quot;DebugAppender&quot; in das Visual Studio Output Fenster. Weitere Appender finden sich hier: <strong><a href="http://logging.apache.org/log4net/release/config-examples.html">Config Examples</a></strong>. In einem Appender kann jeweils noch Layout vorgegeben werden, sodass man die Log Message entsprechend anpassen kann.</p>

<p>Im letzten Abschnitt legen wir das Level fest, welches geloggt werden soll - bei uns erstmal alles und wir nutzen die beiden definierten Appender. </p>

<p><strong>&quot;Logging Code&quot;</strong>

  <br /></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:96847d47-2092-4839-80e2-637d19aeb067" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    class Program
    {
        static void Main(string[] args)
        {
            log4net.Config.XmlConfigurator.Configure();
            ILog logger = LogManager.GetLogger(typeof (Program));

            logger.Debug("Hello World!");
            logger.Error("D´oh!");

            Console.ReadLine();
        }
    }</pre></div>

<p>In der Zeile 5 veranlassen wir Log4Net in der XML Config nachzusehen und dann holen wir uns unseren Logger. Der Logger hat dabei f&#252;r jedes &quot;Log Level&quot; eine Methode:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image725.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="209" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb703.png" width="221" border="0" /></a> </p>

<p><strong>Ergebnis:</strong></p>

<p>Wenn ich nun die Anwendung starte, habe ich folgende Ausgabe in der Konsole:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image726.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="60" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb704.png" width="487" border="0" /></a> </p>

<p>... und dies im Output Fenster im Visual Studio:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image727.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="92" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb705.png" width="509" border="0" /></a> </p>

<p><strong>Wo genau soll man loggen?</strong></p>

<p>Eine Grundregel habe ich nicht gefunden, allerdings ist der Sinn des Loggens ja, nachzuverfolgen wie ein Fehler zustande kam. Daher k&#246;nnte man z.B. bei einer Methode die Parameter rausloggen, wichtige &quot;Aufrufe von anderen Services&quot; sowie die Ausgabe loggen. So bekommt man ein Gef&#252;hl daf&#252;r wie der Code intern tickt.
  <br />Insbesondere mit dem &quot;DebugAppender&quot; ist es ganz witzig wenn man einen Button auf der Webseite dr&#252;ckt und man sieht wie der Request durch die Schichten geht und die Werte rausloggt - ein nerdiges Vergn&#252;gen :)</p>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/log4netintro/log4netintro.zip">[ Download Democode ]</a></strong></p>
