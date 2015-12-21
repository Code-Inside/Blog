---
layout: post
title: "HowTo: Objekte rekursiv durchlaufen - ein ObjectDumper fürs Logging mittels Reflection"
date: 2009-05-13 19:20
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [HowTo, log4net, logging, Reflection]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image739.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="111" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb717.png" width="115" align="left" border="0" /></a> Im letzten <a href="{{BASE_PATH}}/2009/05/08/howto-logging-mit-log4net/">HowTo ging es um das Logging mit Log4Net</a>.&#160; F&#252;r eine gute Fehleranalyse braucht man m&#246;glichst viele Details &#252;ber die Parameter die in eine Methode eingegangen sind. Das manuelle rausloggen ist sehr m&#252;hsam. Mittels <a href="http://de.wikipedia.org/wiki/Reflexion_(Programmierung)">reflection</a> kann man sich viel Arbeit ersparen: Ein ObjectDumper welcher Objekte rekursiv durchl&#228;uft und die Eigenschaften ausloggt ist die L&#246;sung :)</p> 
<!--more-->
  <p><strong>Reflection     <br /></strong>&#220;ber <a href="http://de.wikipedia.org/wiki/Reflexion_(Programmierung)">Reflection</a> kann man so ziemlich alle Details eines Objekts bzw. einer Klasse erfahren ohne genau zu wissen von welchem Typ diese ist. In dem Wikipedia Artikel ist das recht gut beschrieben.</p>  <p><strong>Logging + Reflection     <br /></strong>Einzelne Properties rauszuloggen ist recht m&#252;hsam und im Log ist es manchmal auch recht praktisch mehr als nur das Property X zu sehen, sondern alle Details des Objektes zu erfahren.     <br />Mit ein wenig Rekursion und Reflection kann man sich da sehr viel Arbeit ersparen. </p>  <p>In einem gr&#246;&#223;eren Projekt wurde der &quot;ObjectDumper&quot; erfolgreich eingesetzt. Im Internet findet man einige Varianten davon, ich selbst hatte mich <a href="{{BASE_PATH}}/2008/04/17/aspnet-mvc-actionfilter-zum-loggen-benutzen/">auch schon mal damit</a> besch&#228;ftigt.     <br />Diese Version stammt von Daniel Br&#252;ckner, welchen ich hier auch nochmal danken m&#246;chte, dass ich den Source Code ver&#246;ffentlichen darf :)</p>  <p><strong>Aufbau des &quot;ObjectDumpers&quot;:</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image740.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="357" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb718.png" width="411" border="0" /></a> </p>  <p>Im Logger Interface findet das &quot;logging&quot; statt:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:7bc6e9e9-c47b-4180-8fd2-47cc3d94cb06" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        #region Logger interface

        private static void LogMessage(String message)
        {
            ILog logger = LogManager.GetLogger(typeof (ObjectDumper));
            logger.Debug(message);
        }

        #endregion</pre></div>

<p>In der &quot;message&quot; steht das Property + der Value drin. Ich nutze in diesem &quot;Interface&quot; einfach <a href="{{BASE_PATH}}/2009/05/08/howto-logging-mit-log4net/">Log4Net</a> zum Loggen. Den restlichen Code k&#246;nnt ihr euch im Detail sp&#228;ter anschauen.</p>

<p><strong>Anwendung</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3ef4edd7-a504-41c5-a2a5-f5a79dc4ee5c" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            Person newPerson = new Person();
            newPerson.Age = 123;
            newPerson.Id = Guid.NewGuid();
            newPerson.Name = "hasdhaskjdh";
            ObjectDumper.DumpObject(newPerson, "newPerson", true);
</pre></div>

<p>Es werden 3 Parameter &#252;bergeben:</p>

<ul>
  <li>Das Objekt ansich</li>

  <li>Der Name des Objektes</li>

  <li>Und ob bereits &quot;ausgeloggte&quot; Elemente nochmal rausgeloggt werden, wenn diese angenommen im Objektbaum 2 mal vorkommen.</li>
</ul>

<p>Die Methoden sind auch entsprechend mit Kommentaren ausgestattet:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image741.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="64" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb719.png" width="503" border="0" /></a></p>

<p><strong>Spezial Features</strong>

  <br />Einige Sachen sollte man allerdings vermeiden zu loggen, z.B. Passw&#246;rter. Daf&#252;r gibt es eine String Array wo Propertynamen eingetragen werden k&#246;nnen, welche <strong>nicht</strong> geloggt werden:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:00bd39aa-4b4a-4431-8298-c8ca90b4506a" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        private static readonly String[] PasswordMemberNameParts = { "PASSWORD", "PWD" };</pre></div>

<p>Wenn man eine ganze Klasse nicht loggen m&#246;chte (z.B. die generierten Properties vom Entity Framework etc.) kann auch dieses Attribut nehmen:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:70206505-3aae-446d-ab95-2436bfc4c9ad" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Field)]
    public class DoNotDumpAttribute : Attribute { }
</pre></div>

<p><strong>Anwendungsfall</strong>

  <br />Angewendet kann der ObjectDumper an vielen stellen. Als ASP.NET MVC Entwickler k&#246;nnte es interessant sein z.B. die Request &amp; ViewData Daten <a href="{{BASE_PATH}}/2008/04/17/aspnet-mvc-actionfilter-zum-loggen-benutzen/">&#252;ber ein ActionFilter</a> zu loggen. Dies ist aber nur ein Beispiel :)</p>

<p><strong>Feedback</strong>

  <br />Wer gute Ideen hat bzw. Fehler in dem Code findet kann gern an dieser Stelle Feedback geben :)</p>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/objectdumpertest/objectdumpertest.zip">[ Download Source Code ]</a></strong></p>
