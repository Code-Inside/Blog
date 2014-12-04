---
layout: post
title: "HowTo: Zeitgesteuerte & wiederkehrende Funktionen in .NET & ASP.NET"
date: 2010-09-06 22:47
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Timer, Timers, Zeit]
language: de
---
{% include JB/setup %}
<p><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image1038.png" width="134" height="134" /></p>  <p>Wir hatten in einem Projekt die Anforderung, dass alle X-Minuten oder Sekunden ein bestimmte SQL Abfrage ausgeführt wird und je nach Ergebnis die Daten verarbeitet werden. Dies kann man etwas "dirty” mit einer while(true) Schleife und Thread.Sleep bauen, oder man nutzt einen Timer.</p>  <p><strong>Beispiel Szenario</strong></p>  <p>Als kleines Beispiel wollen wir eine Konsolenanwendung bauen, die aller 10 Sekunden auf der Kommandozeile was ausgibt.</p>  <p><strong>"Dirty” Variante</strong></p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:aff75203-b58c-48bd-b4d3-217615c6b02a" class="wlWriterEditableSmartContent"><pre name="code" class="c#">
            while (true)
            {
                Thread.Sleep(1000);
                Console.WriteLine("Bla!");
            }
</pre></div>

<p>Diese Variante geht, ist aber nicht besonders edel. Und besonders wenn man zwei oder drei Sachen nach einer bestimmten Zeit machen will, kommt man wahrscheinlich nicht weit.</p>

<p><strong>Timer im .NET Framework</strong></p>

<p>Genau für solche Zwecke gibt es im .NET Framework mehrere Timer Klassen. Ein etwas älterer <a href="http://msdn.microsoft.com/en-us/magazine/cc164015.aspx">MSDN Artikel</a> beschreibt 3 Vertreter:</p>

<ul>
  <li><a href="http://msdn.microsoft.com/de-de/library/system.windows.forms.timer(VS.80).aspx">System.Windows.Forms.Timer</a></li>

  <li><a href="http://msdn.microsoft.com/en-us/library/system.timers.timer.aspx">System.Timers.Timer</a></li>

  <li><a href="http://msdn.microsoft.com/de-de/library/system.threading.timer(VS.80).aspx">System.Threading.Timer</a></li>
</ul>

<p>Am Ende des Artikels findet sich ein guter Vergleich:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1039.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb222.png" width="523" height="209" /></a> </p>

<p>Der "System.Windows.Forms.Timer” kommt für mich eigentlich nur in Windows.Forms Anwendungen in Frage.</p>

<p><strong>Interessant ist der Unterschied zwischen "System.Timers.Timer” und "System.Threading.Timer”.</strong></p>

<p>Der Timer im "Threading” Namespace ist ohne weiteres zutun nicht thread safe. System.Timers.Timer baut intern auf den System.Threading.Timer auf. Für einfache Sachen ist der System.Timers.Timer sehr einfach. Hier der Link zu einer kleinen <a href="http://stackoverflow.com/questions/1416803/system-timers-timer-vs-system-threading-timer">Stackoverflow-Diskussion</a>.</p>

<p><strong>Variante mit System.Timers.Timer</strong></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:67d14628-1490-4bd2-8a93-e2c134a8aa90" class="wlWriterEditableSmartContent"><pre name="code" class="c#">using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Timers;

namespace Timers.ConsoleApp
{


    class Program
    {


        static void Main(string[] args)
        {
            Timer timer = new Timer();
            timer.Interval = 1000;
            timer.Elapsed += new ElapsedEventHandler(timer_Elapsed);
            timer.Enabled = true;

            Console.ReadLine();
        }

        static void timer_Elapsed(object sender, ElapsedEventArgs e)
        {
            Console.WriteLine("Elapsed!");
        }
    }
}
</pre></div>

<p>Je nach Interval wird das entsprechende Event aufgerufen. Es wird ein Thread aus dem Threadpool genommen.</p>

<p><strong>Noch eine andere Herangehensweise: AutoResetEvent</strong></p>

<p>Mir bis vor kurzem ein total unbekannte Klasse: <a href="http://msdn.microsoft.com/en-us/library/system.threading.autoresetevent.aspx">AutoResetEvent</a></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c56fc62e-794c-42bb-80dd-0f0446f11a6e" class="wlWriterEditableSmartContent"><pre name="code" class="c#">            AutoResetEvent _isStopping = new AutoResetEvent(false);
            TimeSpan waitInterval = TimeSpan.FromMilliseconds(1000);

            for (; !_isStopping.WaitOne(waitInterval); )
            {
                Console.WriteLine("Bla!");
            }
</pre></div>

<p></p>

<p></p>

<p>Im Grunde sieht es so aus wie die while(true) Geschichte. Funktioniert wahrscheinlich auch ähnlich ;)</p>

<p>Weitere Varianten werden in dieser <a href="http://stackoverflow.com/questions/2822441/system-timers-timer-threading-timer-vs-thread-with-whileloop-thread-sleep-for-p">Stackoverflow-Diskussion</a> vorgestellt.</p>

<p><strong>Timer in ASP.NET Applikationen</strong></p>

<p>In meinem Beispiel gehe ich von einer Konsolenapplikation aus, aber könnte man sowas auch in einer ASP.NET Applikation machen? Jein.</p>

<p>Stackoverflow selbst soll wohl über einen <a href="http://www.codeproject.com/KB/aspnet/ASPNETService.aspx">kleinen Trick</a> so einen "Background-Job” implementiert haben: <a href="http://blog.stackoverflow.com/2008/07/easy-background-tasks-in-aspnet/">Easy Background Tasks in ASP.NET</a></p>

<p><strong>Der Trick </strong>besteht darin ein Item für eine bestimmte Dauer in den Cache zu legen. Läuft die Zeit ab, wird ein Event geworfen. In diesem Event wird die zeitgesteuerte Aktion ausgelöst und man hinterlegt wieder ein neues Item im Cache - und so weiter... </p>

<p>Das Problem: Im Normalfall fährt sich irgendwann der IIS Prozess runter und dann kann man da keine Aktionen mehr damit machen.</p>

<p><strong>Viele Variante, was macht man nun?</strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1040.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; margin-left: 0px; border-top: 0px; margin-right: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb223.png" width="128" height="146" /></a> </p>

<p>Am einfachsten kommt mir der <a href="http://msdn.microsoft.com/en-us/library/system.timers.timer.aspx">System.Timers.Timer</a> vor. In ASP.NET Applikationen würde ich Abstand von zeitgesteuerten Sachen nehmen, da man nicht genau kalkulieren kann, wann der AppPool sich runterfährt. Besser einen Windows Service nehmen und dort über den Timer gehen - außer es geht nicht anders und man bastelt mit den anderen Varianten ;)</p>

<p><strong>Wahrscheinlich...</strong></p>

<p>... gibt es noch weit mehr Varianten. Wie macht ihr irgendwelche zeitgesteuerten Jobs? Gut wäre natürlich eine skalierbare Lösung. Man kann das natürlich auch <a href="{{BASE_PATH}}/2010/04/21/howto-scheduled-tasks-mit-schtasks-lokal-remote-per-kommandozeile-administrieren/">per Scheduled Task</a> und einem Konsolenprogramm lösen, aber elegant ist das ja auch nicht ;)

  <br />Wo meine Gedanken gerade Richtung Multithreading abschweifen: Richtig kompliziert wird es ja in Desktop-Apps bei multithreaded Geschichten wieder in den UI Thread zu schreiben - das ist aber ein anderes Thema :)</p>

<p>Also, wie macht ihr das? :)</p>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/timers/timers.zip">[ Download Democode ]</a></strong></p>
