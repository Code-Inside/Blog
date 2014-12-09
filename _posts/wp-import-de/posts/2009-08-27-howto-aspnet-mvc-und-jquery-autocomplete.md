---
layout: post
title: "HowTo: ASP.NET MVC und jQuery Autocomplete"
date: 2009-08-27 22:35
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, Autocomplete, jQuery, MVC]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image811.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="123" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb789.png" width="185" align="left" border="0"></a> Eine Autocomplete Funktion für Input Felder ist spätestens seit <a href="http://www.google.com/webhp?complete=1&amp;hl=de">Google Suggest</a> bei vielen bekannt. Für den Benutzer ist solch eine Funktion sehr praktisch und auch mit jQuery und <a href="http://asp.net/mvc">ASP.NET MVC</a> ist dies recht schnell umgesetzt. </p><p><strong>Schritt 1: jQuery Autocomplete Plugin besorgen</strong></p> <p>Es gibt viele jQuery Autocomplete bzw. Suggest Plugins. Ich habe mich für dieses (das vermutlich bekannteste) entschieden:</p> <ul> <li><a href="http://jquery.bassistance.de/autocomplete/jquery.autocomplete.zip">Download</a></li> <li><a href="http://docs.jquery.com/Plugins/Autocomplete">Plugin Page</a></li> <li><a href="http://jquery.bassistance.de/autocomplete/demo/">Demo Page</a></li></ul> <p><strong>Schritt 2: ASP.NET MVC Projekt erstellen und jQuery + Plugin einbinden</strong></p> <p>In dem Download ZIP findet man zwei interessante Datein:</p> <ul> <li>jquery.autocomplete.pack.js </li> <li>jquery.autocomplte.css</li></ul> <p>Diese packt man mit in Ordner im ASP.NET MVC Projekt und bindet diese noch in der Master Page ein:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:52a1379e-24f6-4baf-8c3e-6b65e4b37704" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;link href="../../Content/Site.css" rel="stylesheet" type="text/css" /&gt;
    &lt;link href="../../Content/jquery.autocomplete.css" rel="stylesheet" type="text/css" /&gt;
    &lt;script src="../../Scripts/jquery-1.3.2.min.js" type="text/javascript"&gt;&lt;/script&gt;
    &lt;script src="../../Scripts/jquery.autocomplete.pack.js" type="text/javascript"&gt;&lt;/script&gt;
    
    &lt;asp:ContentPlaceHolder ID="ScriptContent" runat="server" /&gt;</pre></div>
<p>jQuery wurde natürlich ebenfalls noch referenziert. Da wir im nächsten Schritt noch ein Javascript nach dem "OnLoad" ausführen wollen, habe ich noch ein ContentPlaceHolder für Scripts eingefügt.</p>
<p><strong>Schritt 3: Input Feld + Javascript schreiben</strong></p>
<p>Das Input Feld:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4d2379a6-b238-40dc-89ad-98826bd27ff2" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;p&gt;
        &lt;input type="text" id="search" /&gt;
    &lt;/p&gt;</pre></div>
<p>Und nun in dem ContentPlaceHolder das Javascript:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:08e128cf-b95b-4b97-af2d-3a7a579c4900" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;asp:Content ID="script" ContentPlaceHolderID="ScriptContent" runat="server"&gt;
&lt;script language="javascript" type="text/javascript"&gt;
    $(document).ready(function() {
        $("#search").autocomplete('&lt;%=Url.Action("Search") %&gt;', {
                                    width: 300,
                                    multiple: true,
                                    matchContains: true,
                                    dataType: 'json',
                                    parse: function(data) {
                                          var rows = new Array();
                                          for(var i=0; i&lt;data.length; i++){
                                              rows[i] = { data:data[i], value:data[i], result:data[i] };
                                          }
                                          return rows;
                                      },
                                    formatItem: function(row, i, n) {
                                          return row;
                                      }
                                });

    });
&lt;/script&gt;
&lt;/asp:Content&gt;</pre></div>
<p>Am wichtigsten ist das "autocomplete" mit der URL. Alles weitere ist besser auf der <a href="http://docs.jquery.com/Plugins/Autocomplete">jQuery Plugin Projektseite</a> erklärt.<br><em>Hinweis:</em> <em>In meinem </em><a href="{{BASE_PATH}}/2009/08/25/howto-ajax-und-aspnet-mvc/"><em>AJAX und ASP.NET MVC Blogpost</em></a><em> erkläre ich noch andere AJAX Features.</em></p>
<p><strong>Schritt 4: Controller + Action</strong></p>
<p>Wie in dem Javascript zu sehen, wird per AJAX etwas an eine "Search" ActionMethod geschickt. Die Methode habe ich mit in den "Home" Controller gepackt:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8ef8cbf5-9c6e-42bd-957d-dbc952e5e5d3" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        public JsonResult Search(string q, int limit)
        {
            List&lt;string&gt; result = new List&lt;string&gt;();

            for(int i = 0; i &lt;= limit; i++)
            {
                result.Add(q + "xxx...");
            }

            return Json(result);
        }</pre></div>
<p>Das jQuery Plugin kann sehr gut mit <a href="http://de.wikipedia.org/wiki/JavaScript_Object_Notation">JSON</a> umgehen, daher nutzen wir das <a href="http://msdn.microsoft.com/en-us/library/system.web.mvc.jsonresult.aspx">JsonResult</a> und hängen an den Suchparameter "q" (das ist das "Suchwort", was wir über das Plugin verschicken) ein paar Buchstaben dran. <br>An dieser Stelle müsste man entsprechend seine Suchlogik einbauen.</p>
<p><strong>Fertig</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image812.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="201" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb790.png" width="267" border="0"></a> </p>
<p>Recht einfach zu realisieren und durch das Plugin gibt es noch dutzende Möglichkeiten. So kann man sich überall mit Javascript einhängen - was passiert wenn man etwas ausgewählt hat, wieviele Items sollen angezeigt werden etc. Hier kann man sich gut austoben :)</p>
<p>Ein weiteres Beispiel findet man auf <a href="http://blog.schuager.com/2008/09/jquery-autocomplete-json-apsnet-mvc.html">diesem Blog</a>.</p><a href="{{BASE_PATH}}/assets/files/democode/mvcajaxsuggestion/mvcajaxsuggestion.zip"><strong>[ Download Source Code ]</strong></a>
