---
layout: post
title: "HowTo: Messaging mit MSMQ, ein Einstieg"
date: 2010-09-07 22:53
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, MSMQ]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1041.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb224.png" width="171" height="129" /></a> </p>  <p>Erst vor kurzem bin ich auf <a href="http://msdn.microsoft.com/en-us/library/ms711472(VS.85).aspx">MSMQ</a> gestoßen. MSMQ ist vereinfach gesagt ein System, in dem Nachrichten in Queues, also Warteschlangen, verarbeitet (angelegt/ausgelesen) werden können.</p>  <p>&#160;</p> <!--more-->  <p><strong>Wofür überhaupt?</strong></p>  <p><a href="http://msdn.microsoft.com/en-us/library/ms711472(VS.85).aspx">MSMQ</a> ist ein Warteschlangen System. Man steckt Nachrichten ein und irgendeiner holt diese ab und verarbeitet diese. Die kann in verteilten Anwendungen z.B. praktisch sein. So kann man z.B. Emails generieren und diese in eine Queue schreiben und Stück für Stück langsam verschicken, damit der Email-Server nicht in die Knie geht. Es gibt bestimmt noch weit, weit mehr Szenarien, aber das soll nur ein Einstieg sein :)</p>  <p>Weiter unten gehe ich noch weiter auf ein paar Vor- und evtl. Nachteile ein. Hier wäre ich auch sehr froh Feedback von euch zu bekommen :)</p>  <p><strong>Voraussetzungen</strong></p>  <p>Die Infrastruktur für MSMQ ist seit XP (?) überall dabei. Man muss es nur in den Windows Funktionen mit aktivieren:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1042.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb225.png" width="310" height="111" /></a> </p>  <p>Danach ist im Computer-Management und Services der MSMQ Dienst zu sehen:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1043.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb226.png" width="259" height="256" /></a> </p>  <p>Man kann über das Kontextmenü (Rechtsklick) auch neue Warteschlangen einrichten und in die Warteschlangen auch reinschauen. </p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1044.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb227.png" width="579" height="100" /></a></p>  <p>Dort kann man auch die einzelnen Nachrichten ansehen:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1045.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb228.png" width="222" height="244" /></a> </p>  <p>Für mein <strong>Democode ist es notwendig</strong>, dass man unter den Privaten Warteschlangen die "<strong>Test</strong>” Queue erstellt.</p>  <p><strong>Zum Code</strong></p>  <p>Im .NET Framework gibt es in der <a href="http://msdn.microsoft.com/en-us/library/system.messaging.aspx">System.Messaging Assembly</a> bereits alles, was man zum Starten braucht:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1046.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb229.png" width="563" height="321" /></a> </p>  <p><strong>Neue Message in die Queue schreiben:</strong></p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:04a8db24-3d66-4925-b522-449835b2c89f" class="wlWriterEditableSmartContent"><pre name="code" class="c#">            MessageQueue queue = new MessageQueue(@".\private$\test");
            queue.Send("test");
</pre></div>

<p><strong>Message auslesen:</strong></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e3a477da-8aed-46aa-8247-2612f1a32a7c" class="wlWriterEditableSmartContent"><pre name="code" class="c#">            MessageQueue queue = new MessageQueue(@".\private$\test");
            Console.WriteLine(queue.Receive().Body.ToString());</pre></div>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p>Easy, oder? Bei "<a href="http://msdn.microsoft.com/en-us/library/system.messaging.messagequeue.receive.aspx">Receive</a>” wird die erste Nachricht aus der Queue genommen. Diese ist dann für andere Clients auch nicht mehr erreichbar.</p>

<p><strong>Komplexe Datentypen</strong></p>

<p>Man kann natürlich auch komplexe Datenstrukturen senden, diese werden dann über den XmlSerializer in die Nachricht geschrieben und ausgelesen. </p>

<p>Hier mein komplettes Beispiel:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:7005c711-c55e-4f38-9fc9-efe67304b706" class="wlWriterEditableSmartContent"><pre name="code" class="c#">using System;
using System.Collections.Generic;
using System.Messaging;
using System.Text;

namespace MSMQ
{
    public class User
    {
        public string Name { get; set; }
        public DateTime Birthday { get; set; }
    }

    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Simple Text");
            Console.WriteLine("Input for MSMQ Message:");
            string input = Console.ReadLine();
            
            MessageQueue queue = new MessageQueue(@".\private$\test");

            queue.Send(input);

            Console.WriteLine("Press Enter to continue");
            Console.ReadLine();

            Console.WriteLine("Output for MSMQ Queue");
            Console.WriteLine(queue.Receive().Body.ToString());
            Console.ReadLine();

            Console.WriteLine("Complex Text");

            User tester = new User();
            tester.Birthday = DateTime.Now;
            tester.Name = "Test Name";
            queue.Send(tester);

            Console.WriteLine("Output for MSMQ Queue");
            User output = (User)queue.Receive().Body;
            Console.WriteLine(output.Birthday.ToShortDateString());
            Console.ReadLine();


        }
    }
}
</pre></div>

<p><strong>Funktioniert, und weiter? Warum MSMQ benutzen?</strong></p>

<p>Man kann solche Queuing Geschichten natürlich auch durch SQL oder andere Eigenentwicklungen umsetzen. Lohnt sich der Blick auf MSMQ?</p>

<p><strong>Vor- und Nachteile</strong> (von <a href="http://stackoverflow.com/questions/483108/msmq-vs-temporary-table-dump">diesem Stackoverflow Thread</a>)</p>

<p><strong>Cons:</strong> </p>

<ul>
  <li>Each queue can only be 2GB.</li>

  <li>Each message 4MB (altough the 4MB limit can be fixed by using MSMQ with WCF).</li>

  <li>Only for Windows so you're limited to use it with .NET, C/C++ or COM library for COM-enabled environments.</li>
</ul>

<p><strong>Pros:</strong> </p>

<ul>
  <li>Supports Windows Network Load Balancer.</li>

  <li>Supports Microsoft Cluster Service.</li>

  <li>Integrated with Active Directory.</li>

  <li>Ships with Windows.</li>

  <li>Supports transactions.</li>

  <li>MSMQ messages can be tracked by audit messages in the Windows Event log.</li>

  <li>Messages can be automatically authenticated (signed) or encrypted upon sending, and verified and decrypted upon reception.</li>
</ul>

<p><strong>Frage an euch...</strong></p>

<p>Nutzt ihr MSMQ? Oder doch lieber eine simple SQL Datenbank und flache Tabelle dafür nutzen? Zwar klingen die Pros gut, aber könnte ich dies nicht alles auch mit einer SQL DB bekommen? Gibt es irgendwo komplexere Beispiele, mit Transaktionen etc.? </p>

<p>Wahrscheinlich kann man am Ende nicht direkt sagen, was besser ist. Aber vielleicht hat jemand von euch ein paar gute Zusatzframeworks parat oder sagt irgendwelche No-Gos :)</p>

<p><strong>Links</strong></p>

<ul>
  <li><a href="http://www.codeproject.com/KB/dotnet/mgrmsmq.aspx">Programming MSMQ with .NET</a></li>

  <li>Sehr interessant ist auch die Kombination <a href="http://code.msdn.microsoft.com/msmqpluswcf">WCF + MSMQ</a></li>

  <li><a href="http://msdn.microsoft.com/en-us/library/ms731093.aspx">Best Practices for Queued Communication</a>&#160;</li>
</ul>

<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/msmq/msmq.zip">[ Download Democode ]</a></strong></p>
