---
layout: post
title: "HowTo: Dynamisch Webseiten-Screenshots erzeugen"
date: 2008-09-10 22:49
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Screenshots]
language: de
---
{% include JB/setup %}
<p>In diesem HowTo geht es darum, dynamisch ein Screenshot von einer beliebigen Seite zu erstellen.</p> <p><strong>Der Sinn dahinter<br></strong>Bei vielen News-Aggregator (oder wie man diese nun nennen mag) Seiten gibt es kleine Vorschaubilder, wie z.B. bei <a href="http://dotnetkicks.com">dotnetkicks.com</a> oder <a href="http://yigg.de">yigg.de</a>:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image536.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="94" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb514.png" width="244" border="0"></a> <br><a href="{{BASE_PATH}}/assets/wp-images-de/image537.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="189" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb515.png" width="197" border="0"></a> </p> <p>Da das ganz nett aussieht (und es sicherlich auch noch viele andere Anwendungsfälle gibt) wollen wir das mal mit .NET versuchen</p><strong></strong> <p><strong>Klingt schwerer als es ist:</strong></p> <p>Der <strong>gesamte</strong> Code um ein Screenshot zum Erzeugen ist folgender:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:76e48c26-b9f8-4b22-81c9-06593f59cd23" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Drawing;

namespace WebPageScreenshots
{
    class Program
    {
        [STAThread]
        static void Main(string[] args)
        {
            WebBrowser wb = new WebBrowser();
            wb.ScrollBarsEnabled = false;
            wb.ScriptErrorsSuppressed = true;
            wb.Navigate("http://code-inside.de");
            while (wb.ReadyState != WebBrowserReadyState.Complete) { Application.DoEvents(); }

            wb.Width = wb.Document.Body.ScrollRectangle.Width;
            wb.Height = wb.Document.Body.ScrollRectangle.Height;

            Bitmap bitmap = new Bitmap(wb.Width, wb.Height);
            wb.DrawToBitmap(bitmap, new Rectangle(0, 0, wb.Width, wb.Height));
            wb.Dispose();

            bitmap.Save("C://screenshot.bmp");

        }
    }
}
</pre></div>
<p>Wir benutzen einfach den "<a href="http://msdn.microsoft.com/en-us/library/system.windows.forms.webbrowser.aspx">WebBrowser</a>" aus der "System.Windows.Forms" Assembly. <br>Mit diesem <a href="http://msdn.microsoft.com/en-us/library/system.windows.forms.webbrowser.navigate.aspx">Navigieren</a> wir zu einer beliebigen Adresse und warten ab, bis die Seite geladen ist (die while Schleife).</p>
<p>Jetzt laden wir die Seite über "DrawToBitmap" in ein Bitmap (Assembly "System.Drawing" benötigt) und speichern dies (... ganz schlampig auf C ;)).</p>
<p><strong>Verstecktes "Feature" im WebBrowser<br></strong>Auf der MSDN findet man nichts was auf "DrawToBitmap" hindeutet und auch über IntelliSense wird es nicht angezeigt:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image538.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="146" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb516.png" width="334" border="0"></a> </p>
<p>Wenn man mit der Maus allerdings über die Methode drüber geht erscheint folgender Text:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image539.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="65" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb517.png" width="458" border="0"></a>&nbsp;</p>
<p><strong>Warnung<br></strong>Es ist sehr leicht solch ein Bitmap zu erzeugne, ist allerdings für den Prozessor etwas rechenintensiv und auch allgemein für die Performance eher schlecht. Daher wird z.B. bei dotnetkicks immer erst dieses "Warte Bild" gezeigt. <br>Da das ganze auch nicht wirklich supportet ist, sollte man etwas vorsichtig damit umgehen.</p>
<p>Das ganze habe ich <a href="http://pietschsoft.com/post/2008/07/C-Generate-WebPage-Thumbmail-Screenshot-Image.aspx">auf diesem Blog gefunden</a> (und den Source Code ungefähr auch so übernommen - also nicht wundern).</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/webpagescreenshots/webpagescreenshots.zip">[ Download Sourcecode ]</a></strong></p>
