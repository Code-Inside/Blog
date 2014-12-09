---
layout: post
title: "Howto: Sharepoint Api (CSOM) per Javascript nutzen"
date: 2013-04-17 16:49
author: oliver.guhr
comments: true
categories: [HowTo]
tags: [Javascript]
language: de
---
{% include JB/setup %}
<p>Sharepoint Webparts können seit Sharepoint 2010 „selbständige“ Webseiten sein, die völlig getrennt vom Sharepoint laufen. Das gibt uns die Möglichkeit, endlich Sharepoint Webparts mit MVC zu erstellen. Um auf die Features vom Sharepoint zugreifen zu können, gibt es mit Sharepoint 2013 das umfangreiche Client Side Object Model kurz CSOM.  <p>Diese Features werden zurzeit von CSOM unterstützt:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1820.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb973.png" width="590" height="287"></a></p> <p>Um mit dem Sharepoint zu kommunizieren stehen dem Entwickler REST/OData, Javascript Bibliothek und C# Schnittstellen bereit.  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1821.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb974.png" width="590" height="248"></a>  <p>Als Javascript Entwickler hat man also 2 Möglichkeiten um Daten mit dem Sharepoint auszutauschen, entweder man nutzt die Javascript Bibliothek oder man benutzt die REST Schnittstelle per jQuery. Ich persönlich, finde die bereitgestellte Javascript Bibliothek nicht gelungen. Was im .net Code sinnvoll ist, wirkt im JS Code eigenartig unhandlich. Die breitgestellten Bibliotheken wurden mit Hinblick auf größtmögliche Konsistenz entworfen. Die Schnittstellen sollten sich in allen Welten möglichst gleich anfühlen. Dieser Ansatz ist durchaus nachvollziehbar aber zum Glück haben wir die Wahl J  <h3>&nbsp;</h3> <h3>CSOM JavaScript Library</h3> <p>&nbsp;</p><pre class="brush: js; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">var context = SP.ClientContext.get_current(); 
site = context.get_web(); 
context.load(site); 
context.executeQueryAsync(
	function(){console.log(site.get_title())},
	function(){console.log(‘error’)},
);
</pre>
<p>Die Idee hinter dieser Schnittstelle ist, dass man mit „context.get_web();“ sagt welchen Daten man laden möchte. Mit „context.load(site)“ fügt man es dem Request hinzu und „context.executeQueryAsync“ führt den Request dann schließlich aus. Wenn man sich die Objekte im Debugger seines lieblings Browsers anschaut, bekommt man oft einen Berg unleserlicher Variablennamen angezeigt – super für Menschen die ihren Spaß an Rätseln haben, für alle anderen unter Umständen eher anstrengend. Es gibt auch eine nicht minifizierte Variante der Bibliothek die diesen Nachteil beheben könnte, irgendwo im Netz, so sagte man. 
<h3>&nbsp;</h3>
<h3>CSOM REST Api mit JQuery</h3>
<p>&nbsp;</p><pre class="brush: js; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">var requestUri = _spPageContextInfo.webAbsoluteUrl + "/_api/web/?$select=Title";
$.ajax({
	url:requestUri, 
	beforeSend: function (request)
            {
                request.setRequestHeader("Accept", "application/json; odata=verbose");
            },
	success:function(data){console.log(data.d.Title)}
});
</pre>
<p>Das Schöne an dieser Variante ist, dass man die Urls zum Debuggen auch einfach mit dem Browser aufrufen kann und dann das Ganze als lesbares XML angezeigt bekommt. Wichtig bei dieser Variante ist, dass man den accept Header auf "application/json; odata=verbose" setzt. Ich hatte es zuerst mit jQuery’s getJSON versucht und mich über die „406 request is not acceptable“ Fehlermeldung gewundert. Das liegt daran, dass jQuery den accept Header "application/json“ setzt und sich der Sharepoint nicht so richtig wohl fühlt, wenn man ihm das „odata=verbose“ vorenthält. 
<p>Das Ergebnis ist in beiden Fällen das Gleiche. Für was man sich letztendlich entscheidet ist also Geschmacksache.
