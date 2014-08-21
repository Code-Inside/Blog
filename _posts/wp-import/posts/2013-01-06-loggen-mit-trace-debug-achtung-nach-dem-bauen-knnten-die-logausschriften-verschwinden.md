---
layout: post
title: "Loggen mit Trace & Debug – Achtung, nach dem Bauen könnten die Logausschriften “verschwinden”"
date: 2013-01-06 23:17
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Debug, Log, logging, Trace]
---
{% include JB/setup %}
<p>Im Framework gibt es zwei einfache Logging Komponenten: <a href="http://msdn.microsoft.com/en-us/library/system.diagnostics.trace.aspx">Trace</a> &amp; <a href="http://msdn.microsoft.com/en-us/library/system.diagnostics.debug.aspx">Debug</a> – diese können allerdings tückisch sein, wenn man nicht genau versteht was die tun. Wofür und ob man diese einsetzen sollte schreib ich dann noch am Ende.</p> <p><em><strong>TL;DR:</strong> Trace und Debug verschwindet wenn die Konstanten “TRACE” und “DEBUG” während des Bauenes fehlen. </em></p> <p>Kurzes Demoprogramm:</p><pre>    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");

            Trace.WriteLine("Hello Tracing-World!");

            Debug.WriteLine("Hello Debug-World!");
        }
    }
</pre>
<p></p>
<p>Der Output im Debug Mode ist recht eindeutig:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1699.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb857.png" width="472" height="385"></a> </p>
<p>Die “Console” Ausgabe erfolgt natürlich in der Konsole, die anderen beiden Enden im Debug Output vom Visual Studio, wobei man auch <a href="http://msdn.microsoft.com/en-us/library/sk36c28t.aspx">andere “Listener” in der App.config anhängen</a> kann.</p>
<p>Eigentlich Prima, oder? Es gibt auch einige Framework Komponenten die diese Art von Logging nutzen, daher kann es ja nicht so schlecht sein.</p>
<p><strong>Keine Logs nach dem Release Build? Worauf man achten sollte bei Trace und Debug…</strong></p>
<p>Trace und Debug sind sehr "einfache” Loggingmechanismen, daher war ich erst einmal verwundert, warum es nach dem Release-Build nicht “loggte”. Grund ist, dass beide Komponenten während des Builds darauf achten ob eine Konstante mitgegeben wird – genau das ist auch das tückische an diesen Komponenten:</p>
<p>Im Debug Modus (Standardeinstellung)</p>
<p>&nbsp;<a href="{{BASE_PATH}}/assets/wp-images/image1710.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image17_thumb.png" width="563" height="275"></a> </p>
<p>Es werden hier zwei Konstanten angegeben “DEBUG” und “TRACE”. Wenn diese gesetzt sind, dann sieht der Code nach dem Kompilieren auch “richtig” aus (hier mit <a href="http://ilspy.net/">ILSpy</a> den Code dekompiliert) und mit dem entsprechenden Listener wird auch ein Logfile erstellt.</p>
<p>&nbsp;<a href="{{BASE_PATH}}/assets/wp-images/image13100.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image13_thumb.png" width="561" height="341"></a></p>
<p><strong>Entferne ich beide Konstanten, dann gibt es die beiden Zeilen auch nach dem Bauen nicht mehr:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image4101.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image4_thumb1.png" width="578" height="274"></a> </p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1700.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb858.png" width="587" height="352"></a> </p>
<p><strong>Standard-Einstellung unter Release ist diese hier:</strong></p>
<p>&nbsp;</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image9100.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px; display: inline; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image9_thumb.png" width="588" height="263"></a> </p>
<p><strong>Warum verschwindet der Code?</strong></p>
<p>Die Methoden die ich benutze wurden mit dem <a href="http://msdn.microsoft.com/en-us/library/system.diagnostics.conditionalattribute.aspx">Conditional Attribute</a> versehen:</p><pre>    [Conditional("DEBUG")]
    public static void Write(string message)
    {
      TraceInternal.Write(message);
    }
</pre>
<p>&nbsp; Natürlich kann ich dieses Attribute auch in meinem eigenen Code verwenden:
<p><a href="{{BASE_PATH}}/assets/wp-images/image1701.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb859.png" width="595" height="281"></a> 
<p><strong>Konstanten via MSBuild angeben:</strong></p>
<p>Natürlich kann man diese Parameter auch via MSBuild mitgeben:</p><pre>msbuild traceanddebug.csproj /t:Rebuild /p:Configuration=Release /p:DefineCons<br>tants="DEBUG;TRACE" </pre>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p><strong>Wann Trace und wann Debug?</strong></p>
<p>Auf <a href="http://stackoverflow.com/questions/179868/trace-vs-debug-in-net-bcl">Stackoverflow</a> gibt es eine nette Diskussion wann man was nehmen könnte. Wobei dort auch oft gesagt wird, dass Trace nach dem Release erhalten bleibt. Dies stimmt natürlich nur, wenn man die Einstellungen nicht verändert und die “TRACE” Konstante beim Bauen mit übergeben wird.</p>
<p><strong>Sollte ich Trace und Debug überhaupt nehmen?</strong></p>
<p>Die Logging Funktionalität ist recht “einfach” und bietet nicht die Vielfalt von <a href="{{BASE_PATH}}/2009/05/08/howto-logging-mit-log4net/">Log4Net</a> oder <a href="http://nlog-project.org/">NLog</a>. Wer allerdings eine einfache Bibliothek für dritte schreibt, der ist vielleicht ganz gut damit bedient, weil man keine anderen Komponenten braucht – so zwingt man niemanden zur Verwendung von Log4Net etc.</p>
<p>Ich persönlich bin ansonsten kein Fan davon, weil ich es etwas zu unberechenbar finde (“Ohhh… kein Log, weil das Buildscript die Logs rausgekickt hatte…”) und dafür Log4Net oder NLog in ihrer Flexibilität bevorzuge.</p>
<p>
<stong><a href="https://github.com/Code-Inside/Samples/tree/master/2013/TraceAndDebug">Source Code auf GitHub</a></strong>
</p>
