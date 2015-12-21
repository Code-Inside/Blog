---
layout: post
title: "HowTo: Javascript Event &quot;onscroll&quot; nutzen"
date: 2007-11-21 23:39
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Javascript]
language: de
---
{% include JB/setup %}
<p>Der Javascript Eventhandler "onscroll" wird oftmals vergessen, z.B. wird er auch bei <a href="http://de.selfhtml.org/javascript/sprache/eventhandler.htm" target="_blank">Selfhtml</a> nicht gelistet, allerdings ist dieses Event doch sehr nützlich.</p> <p>So hat Microsoft bei seiner <a href="http://search.live.com/images/results.aspx?q=paris&amp;FORM=BIRE" target="_blank">Live Bildersuche</a>&nbsp;das onscroll Event genutzt um die Suchergebnisse dynamisch mit AJAX hinzuzufügen um so das typische "Seite 1, 2, 3, 4, 5, 6... 100" (siehe Google Suche) Layout zu umgehen. Der Vorteil daran ist, dass der Nutzer einfach wieder nach oben scrollen kann ohne das sich die Seite wieder lädt. Eingesetzt habe ich es selber z.B. bei der <a href="http://code-developer.de/opensourceprojects/shoppingmap/" target="_blank">Shoppingmap Demoanwendung</a>&nbsp;welche über AJAX dynamisch Amazon nach Suchtreffern abfragt und die Covers anzeigt.</p> <p><strong>Browserunterstützung</strong></p> <p>Das onscroll Event wird von allen gängigen Browsern unterstützt: IE6/7, Firefox, Opera und ich denke auch das Apple dieses Event unterstützt.&nbsp;In der&nbsp;<a href="http://msdn2.microsoft.com/en-us/library/ms536966.aspx" target="_blank">MSDN</a> und bei <a href="http://developer.mozilla.org/en/docs/DOM:window.onscroll" target="_blank">Mozilla Developer</a> ist sogar ein Eintrag vorhanden. Daher kann man es eigentlich ohne Probleme einsetzen.</p> <p>&nbsp;</p> <p><strong>Simples Demoprojekt - der Aufbau</strong></p> <p>Wir haben im Prinzip nur ein Element, welches eine bestimmte Höhe hat und durch "overflow: auto" dazu genötigt wird, bei einem Übergroßen Content die Scrollbars einzublenden. Darüber haben wir noch eine kleine Debug (bzw. zum Verständnis brauchbare) Meldung.</p> <p>In dem Element, in unserem Fall eine Liste (ul) sind bereits einige Standardeinträge vorhaden. Wenn man nun scrollt sollen neuen Elemente hinzugefügt werden.</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image161.png" atomicselection="true"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="129" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb140.png" width="240" border="0"></a> </p> <p>HTML:</p> <div class="CodeFormatContainer"><pre class="csharpcode">    &lt;ul id=<span class="str">"ScrollElement"</span> <strong>onscroll=<span class="str">"nextElements()"</span></strong> style=<span class="str">"height: 100px; width: 300px; overflow: auto; border: solid 1px black;"</span>&gt;
       &lt;li&gt;Item&lt;/li&gt;
       &lt;li&gt;Item&lt;/li&gt;
       &lt;li&gt;Item&lt;/li&gt;
       &lt;li&gt;Item&lt;/li&gt;
       &lt;li&gt;Item&lt;/li&gt;
       &lt;li&gt;Item&lt;/li&gt;
       &lt;li&gt;Item&lt;/li&gt;
       &lt;li&gt;Item&lt;/li&gt;
       &lt;li&gt;Item&lt;/li&gt;
       &lt;li&gt;Item&lt;/li&gt;
    &lt;/ul&gt;</pre></div>
<p>Diesem "ScrollElement" haben wir nun, ähnlich wie onclick, einfach das onscroll Event hinzugefügt.</p>
<p>&nbsp;</p>
<p><strong>Simples Demoprojekt - die "Scroll Logik" implementieren</strong></p>
<p>Dies ist der Javascript Code welcher beim Scrollen immer aufgerufen wird.</p>
<div class="CodeFormatContainer"><pre class="csharpcode">    var global_block = <span class="kwrd">false</span>;
    var global_counter = 0;
    
    function nextElements()
    {
     var element = document.getElementById(<span class="str">'ScrollElement'</span>);
     var height = element.scrollHeight;
     var scroll = element.scrollTop;

     var diff = height - scroll;
     
     document.getElementById(<span class="str">'Debug'</span>).innerHTML = diff;
     
     <span class="kwrd">if</span>(diff &lt;= 200 &amp;&amp; global_block == <span class="kwrd">false</span>)
     {
     global_block = <span class="kwrd">true</span>;
     
     appendNewElements();
     }
    }</pre></div>
<p>Es wurde eine globale Variable "<strong>global_block</strong>" definiert, welche verhindert, dass sobald nach unten gescrollt wird sofort neue Elemente an das Zielelement drangehangen werden. Insbesondere wenn man (sinnvollerweise) AJAX Requests macht, wie bei dem Shoppingmap Projekt, würde man dadurch den Client belasten, weil er viele Requests losschicken muss. Diese Variable verhindert dies, indem sobald ein Request aktiv ist, die Variable auf "true" gesetzt wird. Dadurch werden weitere Requests solange unterbunden, bis die Aktion ausgeführt wurde. Dannach kann man weiterscrollen.</p>
<p>Die Eigenschaft "<a href="http://developer.mozilla.org/en/docs/DOM:element.scrollHeight" target="_blank">scrollHeight</a>" gibt die gesamte Höhe des Elementes wieder (auch das was man nicht sieht).<br>Die Eigenschaft "<a href="http://developer.mozilla.org/en/docs/DOM:element.scrollTop" target="_blank">scrollTop</a>" gibt den Abstand nach oben an. Die verlinkten Mozilla Seiten geben dies auch gut anhand von Screenshots wieder.</p>
<p>Wenn nun zu weit nach unten gescrollt wird und die Differenz unter einem bestimmten Wert fällt und noch kein Request losgeschickt wurde, dann werden neuen Elemente angehangen.</p>
<p><strong>Simples Demoprojekt - das Anhängen neuer Elemente</strong></p>
<p>Das Anhängen neuer Elemente läuft ganz einfach über createElement und appendChild ab. Bei jedem "Request" werden 10 Einträge hinzugefügt.&nbsp;</p>
<div class="CodeFormatContainer"><pre class="csharpcode">    function appendNewElements()
    {
     <span class="kwrd">for</span>(var i=0; i&lt;10; i++)
     {
      global_counter++;
      var newListElement = document.createElement(<span class="str">'li'</span>);
      newListElement.innerHTML = <span class="str">'AppendedItem: '</span> + global_counter;
      
      var parentElement = document.getElementById(<span class="str">'ScrollElement'</span>);
      parentElement.appendChild(newListElement);
     }
     global_block = <span class="kwrd">false</span>;
    }</pre></div>
<p>Am Ende wird die "blockierende" Variable wieder auf "false" gesetzt.</p>
<p><strong>Resultat - das unendliche Scrollen</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image162.png" atomicselection="true"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="133" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb141.png" width="240" border="0"></a> </p>
<p>Man kann nun theoretisch unendlich lang nach unten scrollen. Nette Spielerei.</p>
<p><strong>Wo ist das sinnvoll?</strong></p>
<p>Sinnvoll ist so eine Funktionalität vor allem dort, wo viele Bilder oder Videos (oder Silverlight&nbsp;Content) nachgeladen werden. Da der Browser schlecht 300 Bilder auf einmal ziehen kann, sondern vielleicht nur immer 20, aber man selbst&nbsp;trotzdem dieses "Seite 1, 2, 3, 4" leid ist, kann man diese&nbsp;Technik sehr gut mit AJAX kombinieren.</p>
<p>Dadurch erleichert man auch dem Nutzer das "zurückscrollen", indem man zuvor geladen&nbsp;Sachen&nbsp;gleich ansehen kann und nicht erst warten muss bis der Browser zur vorherigen Seite zurück gegangen ist.<br>In dem <a href="http://code-developer.de/opensourceprojects/shoppingmap/" target="_blank">ShoppingMap Demoprojekt</a> ist die Funktionalität z.B. sehr nützlich und bietet einen interessanten Ansatz.</p>
<p><strong>Democode Live:</strong></p>
<p><a href="http://code-developer.de/democode/javascriptonscroll/default.htm" target="_blank"><strong>[ Source Code +&nbsp; Demoanwendung ]</strong></a></p>
<p><strong>Links:</strong></p>
<p><a href="http://code-developer.de/opensourceprojects/shoppingmap/" target="_blank">ShoppingMap Demoprojekt</a><br><a href="http://de.selfhtml.org/javascript/sprache/eventhandler.htm" target="_blank">Selfhtml Javascript Eventhandler</a><br><a href="http://developer.mozilla.org/en/docs/DOM:window.onscroll" target="_blank">Mozilla Developer - onscroll</a><br><a href="http://msdn2.microsoft.com/en-us/library/ms536966.aspx" target="_blank">MSDN - onscroll</a><br><a href="http://developer.mozilla.org/en/docs/DOM:element.scrollHeight" target="_blank">Mozilla Developer - scrollHeight</a><br><a href="http://developer.mozilla.org/en/docs/DOM:element.scrollTop" target="_blank">Mozilla Developer - scrollTop</a><br><a href="http://search.live.com/images/results.aspx?q=paris&amp;FORM=BIRE" target="_blank">Microsoft Live Bildersuche</a></p>
