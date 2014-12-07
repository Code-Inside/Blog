---
layout: post
title: "HowTo: Erstellen eines Silverlight 1.0 Videoplayers mal auf einfache Weise"
date: 2007-12-12 00:12
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET, ASP.NET AJAX, HowTo, Silverlight, Silverlight 1.0, Videoplayer]
language: de
---
{% include JB/setup %}
<p>Silverlight ist Microsofts Antwort auf Flash und wurde direkt für den Einsatz als Videoplayer entwickelt, doch wie genau funktioniert das? Wie bindet man ein Video ein und ist das kompliziert?</p> <p><u>Die Antwort:</u> Nein, es ist sehr leicht einen <strong>simplen</strong> Videoplayer zu erstellen - genau das will ich heute zeigen.</p> <p><u><strong>Alternativen zu meiner Lösung:</strong></u></p> <p>Mein Beispiel soll nur die Grundlagen zeigen und auf simple Art und Weise das zeigen, was z.B. mit dem <a href="http://www.microsoft.com/expression/products/overview.aspx?key=encoder" target="_blank">Expression Encoder</a> oder <a href="http://www.popfly.ms/" target="_blank">Popfly</a> möglich ist.</p> <p><strong><u>Schritt 1: MS AJAX Enabled Website erstellen und Silverlight.js hinzufügen</u></strong></p> <p>Wir erstellen einfach (aus Gewohnheit) ein ASP.NET AJAX enabled Website und fügen die Silverlight.js aus dem SDK hinzu (und fügen diese Javascript Datei noch der Default.aspx hinzu) :</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image186.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="110" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb165.png" width="228" border="0"></a> </p> <p><strong><u>Schritt 2: Videoplayer XAML erstellen</u></strong></p> <p>Als nächstes erstellen wir das XAML für den Videoplayer. In unserem Fall werden wir uns auf das wesentliche beschränken und werden über normale HTML Buttons das Video steuern.</p> <p><u>Hier erstmal das XAML:</u></p> <div class="CodeFormatContainer"><pre class="csharpcode">&lt;Canvas
   xmlns=<span class="str">"http://schemas.microsoft.com/client/2007"</span>
   xmlns:x=<span class="str">"http://schemas.microsoft.com/winfx/2006/xaml"</span>
   Width=<span class="str">"399"</span> Height=<span class="str">"360"</span>
   OpacityMask=<span class="str">"#FF000000"</span>
   RenderTransformOrigin=<span class="str">"0.5,0.5"</span>
   &gt;
   &lt;MediaElement
   x:Name=<span class="str">"Player"</span>
   Source=<span class="str">"{{BASE_PATH}}/assets/files/democode/silverlightvideoplayer/Lake.wmv"</span>
   AutoPlay=<span class="str">"True"</span>
   Stretch=<span class="str">"Fill"</span>/&gt;
&lt;/Canvas&gt;</pre></div>
<p>In unserm <a href="http://msdn2.microsoft.com/en-us/library/bb188312.aspx" target="_blank">Canvas</a> Element, welches das Root Element ist, fügen wir das <a href="http://msdn2.microsoft.com/en-us/library/bb188356.aspx" target="_blank">MediaElement</a> ein, welches unser Video einbindet.</p>
<p><u>Wichtig beim MediaElement:</u> Damit wir es über Javascript ansprechen müssen, müssen wir einen "x:Name" vergeben - in unserem Fall "Player" und noch eine "Source" setzen.<br><strong>Interessanter Hinweis noch dazu:</strong></p>
<p>Das Video wird bei mir auf code-inside.de gehostet - die Anwendung selbst läuft auf code-developer.de:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image187.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="229" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb166.png" width="333" border="0"></a> </p>
<p><strong><u>Schritt 3: SilverlightHost einfügen und ein paar Buttons</u></strong></p>
<p>Sobald unsere Seite aufgebaut ist, wird das Silverlight in dem "<strong>SilverlightVideoHost-Div</strong>" erstellt und darüber sind 3 schnöde Buttons mit den jeweiligen Javascript Funktionen:</p>
<ul>
<li>Play 
<li>Stop 
<li>Pause</li></ul>
<div class="CodeFormatContainer"><pre class="csharpcode">&lt;body onload=<span class="str">"createSilverlight()"</span>&gt;
    &lt;form id=<span class="str">"form1"</span> runat=<span class="str">"server"</span>&gt;
        &lt;asp:ScriptManager ID=<span class="str">"ScriptManager1"</span> runat=<span class="str">"server"</span> /&gt;
        &lt;div&gt;
            &lt;button onclick=<span class="str">"play()"</span>&gt;Play&lt;/button&gt;
            &lt;button onclick=<span class="str">"stop()"</span>&gt;Stop&lt;/button&gt;
            &lt;button onclick=<span class="str">"pause()"</span>&gt;Pause&lt;/button&gt;
        &lt;/div&gt;
        &lt;div id=<span class="str">"SilverlightVideoHost"</span>&gt;
        &lt;/div&gt;
    &lt;/form&gt;
&lt;/body&gt;</pre></div>
<p><strong><u>Schritt 4: SilverlightHost erstellen und Funktionalität implementieren</u></strong></p>
<p>Als finalen Schritt rufen wir jetzt die Silverlight.js auf und erstellen unseren Videoplayer:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">    function createSilverlight()
    {
    Silverlight.createObjectEx({
      source: <span class="str">"Videoplayer.xaml"</span>,
      parentElement: document.getElementById(<span class="str">"SilverlightVideoHost"</span>),
      id: <span class="str">"SilverlightControl"</span>,
      properties: {
         width: <span class="str">"100%"</span>,
         height: <span class="str">"100%"</span>,
         version: <span class="str">"1.0"</span>
      },
      events: {
         onError: <span class="kwrd">null</span>,
         onLoad: <span class="kwrd">null</span>
      }

   });
   }</pre></div>Wichtig hier ist die "<strong>source</strong>" - unser "<strong>Videoplayer.xaml</strong>" - sowie das übergeben unseres "<strong>SilverlightVideoHost</strong>" als "<strong>parentElement</strong>" und vergeben noch eine "<strong>id</strong>" "<strong>SilverlightControl</strong>". 
<p>Jetzt statten wir noch die 3 Buttons mit einer Funktion aus:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">   function play()
   {
   var control = document.getElementById(<span class="str">"SilverlightControl"</span>);
   control.Content.FindName(<span class="str">"Player"</span>).play();   
   }
   
   function stop()
   {
   var control = document.getElementById(<span class="str">"SilverlightControl"</span>);
   control.Content.FindName(<span class="str">"Player"</span>).stop();
   }
   
   function pause()
   {
   var control = document.getElementById(<span class="str">"SilverlightControl"</span>);
   control.Content.FindName(<span class="str">"Player"</span>).pause();   
   }</pre></div>
<p>Wir greifen hier direkt über Javascript auf das Silverlight zu. Um auf das Silverlight Plugin zuzugreifen bekommt man es über <strong>document.getElementById(SILVERLIGHT_ID) - nicht zu verwechseln mit der SilverlightHostID:</strong></p>
<ul>
<li><strong>SilverlightControl =</strong> Ist ID des generierten "objects" und erlaubt es auf die Silverlight DOM zuzugreifen <a href="http://weblogs.asp.net/jgalloway/archive/2007/10/31/silverlight-doesn-t-require-any-javascript.aspx" target="_blank">(siehe hier für weitere Infos)</a>
<li><strong>SilverlightVideoHost = </strong>Ist ID des Hosts des Silverlight Plugins</li></ul>
<p> Über das Silverlight Plugin haben wir nun die Möglichkeit die jeweiligen Methoden des MediaElements aufzurufen:</p>
<ul>
<li><a href="http://msdn2.microsoft.com/en-us/library/bb188290.aspx" target="_blank">play()</a></li>
<li><a href="http://msdn2.microsoft.com/en-us/library/bb188291.aspx" target="_blank">stop()</a></li>
<li><a href="http://msdn2.microsoft.com/en-us/library/bb188289.aspx" target="_blank">pause()</a></li></ul>
<p>Als Ergebniss haben wir dann unseren simplen Videoplayer:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image188.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="173" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb167.png" width="244" border="0"></a> </p>
<p>&nbsp;</p>
<p><strong>[ <a href="http://code-developer.de/democode/silverlightvideoplayer/" target="_blank">Demoanwendung</a> | <a href="{{BASE_PATH}}/assets/files/democode/silverlightvideoplayer/silverlightvideoplayer.zip" target="_blank">Source Code Downloaden</a> ]</strong></p>
