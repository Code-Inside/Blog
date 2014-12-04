---
layout: post
title: "ComRegisterFunction & ComUnregisterFunction debuggen"
date: 2013-03-25 21:30
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [COM]
language: de
---
{% include JB/setup %}
<p>Der Post scheint wie aus einer vergangen Zeit (COM???), aber ich hatte erst kürzlich damit zutun. Ich hab ehrlich gesagt auch sehr wenig Ahnung was COM überhaupt macht, aber ich hatte die Aufgabe in einer bestehenden COM-Register-Function Code zu ändern. Ohne Debugging ist das allerdings etwas heiss.</p> <p><strong>ComRegisterFunction &amp; ComUnregisterFunction</strong></p> <p>Vereinfacht: Die Methode die mit den <a href="http://msdn.microsoft.com/en-us/library/system.runtime.interopservices.comregisterfunctionattribute.aspx">Attributen</a> versehen ist, werden bei der jeweiligen Aktion aufgerufen.</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">    [ComVisible(true)]
    [Guid("E041712F-D936-4B5B-A3F0-5DB66C4634B0"), ProgId("Foobar")]
    public class Foobar
    {
        [ComRegisterFunction]
        public static void RegisterFunction(Type type)
        {
            Console.WriteLine("Register of Foobar...");
        }

        [ComUnregisterFunction]
        public static void UnregisterFuntion(Type type)
        {
            Console.WriteLine("Unregister of Foobar...");
        }

        public string Buzz()
        {
            return Guid.NewGuid().ToString();
        }

    }</pre>
<p><strong>Das Registrieren übernimmt das Tool “<a href="http://msdn.microsoft.com/en-us/library/tzat5yw6(v=vs.71).aspx">RegAsm</a>”</strong></p>
<p>Das Tool befindet sich hier (bzw. im jeweiligen Framework Order):</p>
<p>C:\Windows\Microsoft.NET\Framework\v4.0.30319\regasm.exe</p>
<p>Beim Aufruf des Tools + Angabe der Assembly wird auch unser Code ausgeführt:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1795.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb949.png" width="543" height="104"></a> </p>
<p><strong>Zum Debugging</strong></p>
<p>Zum Debuggen muss man das Projekt nur auf das regasm.exe Tool lenken und den Output als Argument mit angeben:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1796.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb950.png" width="530" height="299"></a> </p>
<p>&nbsp;</p>
<p>Damit sollte auch das Debugging funktionieren:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1797.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb951.png" width="536" height="212"></a> </p>
<p>&nbsp;</p>
<p>Hoffentlich braucht ihr das nicht allzu oft ;)</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1799.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb953.png" width="471" height="356"></a></p>
