---
layout: post
title: "HowTo: Microsoft Silverlight 1.0 (Webanwendungen mit dynamischen SilverlightHosts verschönern)"
date: 2007-11-07 18:34
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [HowTo, Javascript, Silverlight]
---
{% include JB/setup %}
<p>Eine bestehende Webapplikation mit einem kleinen Silverlight Host die "Video" Fähigkeit beibringen ist nicht unbedingt schwierig, dass Problem was allerdings besteht ist, dass es bereits viele HTML Suchmasken oder Datenforumlare gibt.</p> <p>Wenn man nun nur kleine Silverlight Teile benötigt, wollen wir keine große Silverlight Anwendung haben, sondern&nbsp;mehrere kleine, da wir diese mit den bereits bestehenden Forumlaren verschmelzen wollen:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image143.png" atomicselection="true"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="357" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb122.png" width="431" border="0"></a> </p> <p>&nbsp;</p> <p><strong>Schritt 1: Template.xaml erstellen</strong></p> <p>Mit Microsofts Expression Blend 2 (August Preview) erstellen wir ein kleines Template, welches wir später befüllen wollen. Das Template ist ähnlich geartet wie das, welches ich bereits in <a href="{{BASE_PATH}}/artikel/howto-microsoft-silverlight-10-dynamische-spiegeleffekte/">diesem HowTo</a> beschrieben habe.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image144.png" atomicselection="true"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="158" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb123.png" width="240" border="0"></a> </p> <p>Es enthält ein gespiegeltes Textelement, welches wir dynamisch unseren Divs hinzufügen wollen.</p> <p>In diesem Template wurde die beiden Textelemente jeweils mit einem "x:Name='TitleText'" &amp; einem "x:Name='TitleShadow'" versehen damit wir es in Javascript ansprechen können.</p> <p><strong>Schritt 2:</strong> <strong>Silverlight Projekt anlegen / Silverlight.js dem Projekt hinzufügen &amp; Template einfügen</strong></p> <p>Ich hab in meinem Beispiel das <a href="http://msdn2.microsoft.com/en-us/library/bb404703.aspx">Silverlight 1.0 Template des SDKs</a> abgewandelt, aber ansonsten braucht man nur die Silverlight.js (aus dem Template z.B.) sowie unser Template aus dem Expression Blend Ordner (oder man hat die XAML Datei per Hand erstellt - ist am Ende egal) importieren.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image145.png" atomicselection="true"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="110" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb124.png" width="167" border="0"></a> </p> <p>Die Default.html enthält (neben dem&nbsp;Style und den JS Links):</p> <div class="CodeFormatContainer"><pre class="csharpcode">&lt;input type=<span class="str">"text"</span> name=<span class="str">"Count"</span> id=<span class="str">"Count"</span> /&gt;
&lt;button type=<span class="str">"button"</span> onclick=<span class="str">"createElements()"</span>&gt;Click&lt;/button&gt;
&lt;div id=<span class="str">"AppHost"</span>&gt;
&lt;/div&gt;</pre></div>
<p>In dem "AppHost" Div werden wir unsere Divs hinzufügen, welche dann wiederrum unsere SilverlightHosts darstellen.&nbsp;<br>In dem Inputfeld wird die Anzahl der Divs zum Erstellen angegeben welche bei "createElements()" erstellt werden.</p>
<p><strong>Schritt 3: Javascript zum dynamischen Erstellen implementieren</strong></p>
<p>In der Defaut.html.js liegt unsere "Logik":</p>
<p><u>createElements():</u></p>
<div class="CodeFormatContainer"><pre class="csharpcode">function createElements()
{
    var count = document.getElementById(<span class="str">'Count'</span>).<span class="kwrd">value</span>;
    <span class="kwrd">for</span>(var i = 0; i &lt; count; i++)
        {
        var itemDiv = document.createElement(<span class="str">'div'</span>);
        itemDiv.id = <span class="str">'element_'</span> + i;
        itemDiv.className = <span class="str">'Elements'</span>;
        
        var silverlightDiv = document.createElement(<span class="str">'div'</span>);
        silverlightDiv.id = <span class="str">'element_silverlight_'</span> + i;
        silverlightDiv.className = <span class="str">'Silverlights'</span>;
        itemDiv.appendChild(silverlightDiv);
        createSilverlight(silverlightDiv, i);
        document.getElementById(<span class="str">'AppHost'</span>).appendChild(itemDiv);
        }
}</pre></div>
<p>Die "createSilverlight(silverlightDiv, i)" Methode erstellt unsere SilverlightHosts - das "silverlightDiv" gibt dabei an, in welchen Div es erstellt werden soll und das "i" ist in diesen einfachen Fall meine Javascript-ID, welches unser Div repräsentiert. Im praktischen Umfeld könnte es aber z.B. ein JSON Objekt sein.</p>
<p><u>createSilverlight(parentDiv, id):</u></p>
<div class="CodeFormatContainer"><pre class="csharpcode">function createSilverlight(parentElement, id)
{
    var slPluginId = <span class="str">'SilverlightPlugIn_'</span> + id;
   Silverlight.createObjectEx({
      source: <span class="str">'Template.xaml'</span>,
      parentElement: parentElement,
      id: slPluginId,
      properties: {
         width: <span class="str">'295'</span>,
         height: <span class="str">'189'</span>,
         background:<span class="str">'#ffffffff'</span>,
            isWindowless: <span class="str">'false'</span>,
         version: <span class="str">'1.0'</span>
      },
      events: {
         onError: <span class="kwrd">null</span>,
         onLoad: onComplete
      },      
      context: id 
   });
}</pre></div>
<p>&nbsp;</p>
<p>Diese Methode erstellt den Silverlight Host mit der "<a href="http://msdn2.microsoft.com/en-us/library/bb412401.aspx">createObjectEx</a>" Methode. Allerdings können wir im Anschluss nicht direkt auf den SilverlightHost zugreifen und unsere beiden Textelemente je nachdem anpassen - daher definieren wir eine Javascript "<a href="http://msdn2.microsoft.com/en-us/library/bb412359.aspx">onload</a>" Methode namens "<a href="http://msdn2.microsoft.com/en-us/library/bb794710.aspx">onComplete</a>". <br>Der Aufruf dieser Methode geschiet nachdem das Silverlight Objekt angelegt wurde - allerdings benötigen wir noch eine ID, damit wir in der onComplete Methode auch wissen, bei welcher ID wir gerade sind.<br>Für das weitergeben des ID Parameters an das "onload" Event gibt es das context Objekt: In unserem Fall geben wir hier unsere ID weiter, damit wir dann in der "onComplete" Methode darauf zugreifen können.</p>
<p>Wie auch im vorherigen Abschnitt: Ein JSON Objekt könnte genauso gut weitergegeben werden.</p>
<p><u>onComplete(sender, userContext, eventArgs):</u></p>
<div class="CodeFormatContainer"><pre class="csharpcode">function onComplete(sender, usercontext, eventArgs)
{
   sender.content.FindName(<span class="str">"TitleText"</span>).Text = <span class="str">"My Item: "</span> + usercontext;
   sender.content.FindName(<span class="str">"TitleShadow"</span>).Text = <span class="str">"My Item: "</span> + usercontext;
}</pre></div>
<p>Mit den Informationen können wir nun unsere dynamischen Silverlight Hosts erstellen. Über den "sender" können wir auf den XAML Content zugreifen und über die "<a href="http://msdn2.microsoft.com/en-us/library/bb412364.aspx">FindName</a>" Methode unseren Text ändern.</p>
<p><strong>Ergebnis:</strong></p>
<p>Die Anwendung ist natürlich sehr zweifelhaft, allerdings soll es nur das Prinzip zeigen, wie man mehrere Silverlight Hosts nehmen kann, um einzelne Abschnitte der Website zu erweitern.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image146.png" atomicselection="true"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="398" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb125.png" width="291" border="0"></a> </p>
<p>&nbsp;</p>
<p><strong>Downloads / Demos:</strong></p>
<p>&nbsp;</p>
<p><strong>[ </strong><a href="http://code-developer.de/democode/multisilverlighthost/" target="_blank"><strong>Hier gehts zur Demoapplikation</strong></a><strong>&nbsp;| </strong><a href="{{BASE_PATH}}/assets/files/democode/multisilverlighthost/source.zip" target="_blank"><strong>Hier gibts den SourceCode</strong></a><strong>&nbsp;]</strong></p>
<p>&nbsp;</p>
<p><strong>Links:</strong></p>
<p><a href="{{BASE_PATH}}/artikel/howto-microsoft-silverlight-10-dynamische-spiegeleffekte/">HowTo: Microsoft Silverlight 1.0 (dynamische Spiegeleffekte erzeugen)</a><br><a href="http://www.microsoft.com/expression/products/features.aspx?key=blend2preview">Microsoft Expression Blend 2 August Preview</a><br><a href="http://msdn2.microsoft.com/en-us/library/bb404703.aspx">Silverlight SDK</a><br><a href="http://msdn2.microsoft.com/en-us/library/bb412401.aspx">Silverlight Plugin erstellen</a><br><a href="http://msdn2.microsoft.com/en-us/library/bb412359.aspx">Silverlight onLoad</a><br><a href="http://msdn2.microsoft.com/en-us/library/bb794710.aspx">Silverlight Events</a><br><a href="http://msdn2.microsoft.com/en-us/library/bb412364.aspx">Silverlight FindName</a></p>
