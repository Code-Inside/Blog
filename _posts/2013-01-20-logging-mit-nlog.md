---
layout: post
title: "Logging mit NLog"
date: 2013-01-20 13:28
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, NLog]
---
<p>Da ich in letzter Zeit immer mal wieder mit dem Logging Tool <a href="http://nlog-project.org">NLog</a> zutun hatte, dachte ich mir ich schreib mal einen kurzen Einstieg – obwohl die Einstiegskonfiguration in 2 Minuten gemacht ist ;)</p> <p><em>Ich hatte auch schon vor Ewigkeiten ein <a href="http://code-inside.de/blog/2009/05/08/howto-logging-mit-log4net/">Log4Net Blogpost</a> geschrieben. Im Grunde unterscheiden die sich nicht großartig.</em></p> <p><strong>NLog via NuGet beschaffen</strong></p> <p>Als Demoprojekt hab ich ein ASP.NET MVC 4 Projekt angelegt und lad mir via NuGet das NLog Configuration Package herunter, welches mir bereits ein leeres NLog Config-File anlegt und die Bibliothek einbindet.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1711.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb867.png" width="591" height="403"></a></p> <p><strong>NLog konfigurieren</strong></p> <p></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1712.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; margin: 0px 10px 0px 0px; border-left: 0px; display: inline" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb868.png" width="234" height="322"></a> </p> <p>In der Konfigurationsdatei von NLog kann man so genannte “Targets” und “Rules” festlegen. Vermutlich geht noch mehr, jedoch würde ich hier einfach in die recht gute <a href="https://github.com/nlog/nlog/wiki/Configuration-file">Online-Doku</a> schauen.</p> <p>In meiner Konfiguration für den Blogpost möchte ich sowohl in den Debug Output Loggen als auch ein “tägliches” Logfile erzeugen.</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">&lt;?xml version="1.0" encoding="utf-8" ?&gt;
&lt;nlog xmlns="http://www.nlog-project.org/schemas/NLog.xsd"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"&gt;

  &lt;!-- 
  See http://nlog-project.org/wiki/Configuration_file 
  for information on customizing logging rules and outputs.
   --&gt;
  &lt;targets&gt;
    &lt;!-- add your targets here --&gt;
    &lt;target name="file" xsi:type="File"
            layout="${longdate} ${logger} ${message}"
            fileName="${basedir}/${shortdate}.log" /&gt;
    &lt;target name="debug" xsi:type="Debugger"/&gt;

    &lt;!--
    &lt;target xsi:type="File" name="f" fileName="${basedir}/logs/${shortdate}.log"
            layout="${longdate} ${uppercase:${level}} ${message}" /&gt;
    --&gt;
  &lt;/targets&gt;

  &lt;rules&gt;
    &lt;logger name="*" minlevel="Trace" writeTo="file" /&gt;
    &lt;logger name="*" minlevel="Trace" writeTo="debug" /&gt;
    &lt;!-- add your logging rules here --&gt;
    
    &lt;!--
    &lt;logger name="*" minlevel="Trace" writeTo="f" /&gt;
    --&gt;
  &lt;/rules&gt;
&lt;/nlog&gt;</pre>
<p>NLog direkt aufrufen</p>
<p>Nun rufen wir einfach noch den Logger auf:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">        public ActionResult Index()
        {
            NLog.Logger logger = NLog.LogManager.GetCurrentClassLogger();

            logger.Info("Yeahhhh...");

            ViewBag.Message = "Modify this template to jump-start your ASP.NET MVC application.";

            return View();
        }
</pre>
<p>&nbsp;<strong>Sollte dann dazu führen:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1713.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb869.png" width="433" height="341"></a></p>
<p><strong>Empfehlung</strong></p>
<p>Da es einige Log-Mechanismen gibt und manche Bibliotheken mal NLog oder mal Log4Net mitbringen wäre eine simple Facade um den eigentlichen Logger empfehlenswert – so kann man diese Komponente später einfacher austauschen. </p>
<p><strong>Log4Net vs NLog</strong></p>
<p>Wer sich diese Frage stellt, der sollte die <a href="http://stackoverflow.com/questions/710863/log4net-vs-nlog">erste Antwort auf Stackoverflow</a> anschauen. Grob verkürzt: Sowohl Log4Net als auch NLog bieten ähnliche Features. Einfach das nehmen, was ohnehin mit einer Bibliothek mitkommt und eine Facade benutzen.</p>
<p><strong>Es loggt nicht? Was mach ich falsch?</strong></p>
<p>Häufigstes Problem ist, dass NLog evtl. die Konfigurationsdatei nicht findet. In einem solchen Fall nochmal in die Online Doku schauen. Zum Testen ob es vielleicht an etwas anderem liegt kann man auch die Konfiguration <a href="https://github.com/nlog/nlog/wiki/Configuration-API">via Code</a> setzen.</p>
<p><a href="https://github.com/Code-Inside/Samples/tree/master/2013/NlogTest.Web"><strong>[ Demo Code @ GitHub ]</strong></a></p>
