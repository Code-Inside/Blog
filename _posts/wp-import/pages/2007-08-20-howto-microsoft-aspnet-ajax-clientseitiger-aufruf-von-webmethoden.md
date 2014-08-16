---
layout: page
title: "HowTo: Microsoft ASP.NET AJAX (Clientseitiger Aufruf von Webmethoden)"
date: 2007-08-20 19:22
author: robert.muehsig
comments: true
categories: []
tags: []
permalink: /artikel/howto-microsoft-aspnet-ajax-clientseitiger-aufruf-von-webmethoden
---
{% include JB/setup %}
Diese mal geht es um das eigentlich tollste Feature von Microsofts ASP.NET AJAX Framework. Wie wiederholt <a href="http://code-inside.de/blog/2007/06/07/gute-und-schlechte-seiten-des-updatepanels/" title="böses Updatepanel">erwähnt</a>Â ist das UpdatePanel nicht wirklich ideal, da es erstmal alle Daten zum Server hinschickt und hinterher die Antwort zwar etwas weniger ist, aber trotzdem bei weitem nicht optimal ist.

Daher gibt es so genannte "Scriptmethoden" - es ist eigentlich das, was viele Anfänger in der Webprogrammierung machen wollen: Aus Javascript eine C#/.NET Methode aufrufen.

Wie man das ASP.NET AJAX Framework installiert, ist <a href="http://code-inside.de/blog/artikel/howto-microsoft-aspnet-ajax-praktischer-anfang/" title="HowTo: Microsoft ASP.NET AJAX">hier</a> beschrieben.

<strong>Schritt 1: ASP.NET AJAX enabled Web Site erstellen</strong>

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images/image-thumb.png" alt="image" height="127" style="border: 0px" /></a>Â 

Durch das Template bekommt man am Ende den App_Data Ordner sowie die Default.aspx und die bereits angepasste Web.Config. In der Web.Config sind allerhand Assemblys etc.Â registriert. Wer interessiert ist, kann sich diese gerne anschauen, allerdings sind da keine weiteren Änderungen notwendig.

Der wichtigeste Teil steht jetztin der Default.aspx: Der <a target="_blank" href="http://asp.net/AJAX/Documentation/Live/overview/ScriptManagerOverview.aspx" title="MS ASP.NET AJAX ScriptManager">Scriptmanager</a>. Dieser ScriptManager übernimmt später die "hässliche" Drecksarbeit - aber dazu erst später.

<strong>Schritt 2: Ein Webservice erstellen und "pimpen"</strong>

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image1.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images/image-thumb1.png" alt="image" height="175" style="border: 0px" /></a>

Jetzt erstellen wir einen neuen Webservice - der z.B. Datenbanken abfragen kann oder andere Berechnungen durchführen könnte. Bei unserem Beispiel gibt der Webservice nur ein kleinen dummen Text zurück.

Unserer Webservice - die HelloWorld.asmx - verweisst auf die Codebehinde-Datei HelloWorld.cs und dort drin steht unser eigentlicher Code.
Momentan ists es noch genau so, wie bei einem normalen XML Webdienst, nun kommt allerdings das i-Tüpfelchen drauf: Das <a target="_blank" href="http://asp.net/AJAX/Documentation/Live/mref/N_System_Web_Script_Services.aspx" title="MS ASP.NET AJAX ScriptService Attribut">ScriptService Attribut</a>.
Dieses versteckt sich im System.Web.Script.Services Namespace und muss daher vorher eingebunden werden.
<pre class="csharpcode"><em><span class="kwrd">using</span> System;<span class="kwrd">using</span> System.Web;        

<span class="kwrd">using</span> System.Collections;        

<span class="kwrd">using</span> System.Web.Services;        

<span class="kwrd">using</span> System.Web.Services.Protocols;        

<span class="kwrd">using</span> System.Web.Script.Services;<span class="rem">/// &lt;summary&gt;</span>        

<span class="rem">/// Zusammenfassungsbeschreibung für HelloWorld</span>        

<span class="rem">/// &lt;/summary&gt;</span>        

[ScriptService]        

[WebService(Namespace = <span class="str">"http://tempuri.org/"</span>)]        

[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]        

<span class="kwrd">public</span> <span class="kwrd">class</span> HelloWorld : System.Web.Services.WebService {        

<span class="kwrd">public</span> HelloWorld () {        

<span class="rem">//Auskommentierung der folgenden Zeile bei Verwendung von Designkomponenten aufheben </span>        

Â        <span class="rem">//InitializeComponent(); </span>        

Â    }        

[WebMethod]        

Â    <span class="kwrd">public</span> <span class="kwrd">string</span> HelloWorldTest(<span class="kwrd">string</span> name) {        

Â        <span class="kwrd">return</span> <span class="str">"Hello World" </span>+ name;        

Â    }        

}        

</em></pre>
Ganz oben ist der ScriptService eingebunden - ansonsten bleibt alles gleich.

<strong>Schritt 3: Dem ScriptManager sagen, dass es den Service gibt</strong>

Damit unser ScriptManager auf der Default.aspx auch weiß, dass es den Service gibt und beim Aufruf einen Javascript-Wrapper drum rum setzt, muss er erst bekannt gemacht werden. Der ScriptManager kann auch auf einer Masterpage eingesetzt werden - allerdings ist pro Seite nur einer erlaubt. Mehr wäre auch unsinnig.Â Hier der benötigte Code:

<style>                            <!--  .csharpcode, .csharpcode pre  {  	font-size: small;  	color: black;  	font-family: consolas, "Courier New", courier, monospace;  	background-color: #ffffff;  	/*white-space: pre;*/  }

.csharpcode pre { margin: 0em; }

.csharpcode .rem { color: #008000; }

.csharpcode .kwrd { color: #0000ff; }

.csharpcode .str { color: #006080; }

.csharpcode .op { color: #0000c0; }

.csharpcode .preproc { color: #cc6633; }

.csharpcode .asp { background-color: #ffff00; }

.csharpcode .html { color: #800000; }

.csharpcode .attr { color: #ff0000; }

.csharpcode .alt   {  	background-color: #f4f4f4;  	width: 100%;  	margin: 0em;  }

.csharpcode .lnum { color: #606060; }

--></style>
<pre class="csharpcode"><em>        &lt;asp:ScriptManager ID=<span class="str">"ScriptManager1"</span> runat=<span class="str">"server"</span>&gt;</em></pre>
<pre class="csharpcode"><em>Â            &lt;Services&gt;        

Â                &lt;asp:ServiceReference Path=<span class="str">"HelloWorld.asmx"</span> /&gt;        

Â            &lt;/Services&gt;        

Â        &lt;/asp:ScriptManager&gt;        

</em></pre>
<pre class="csharpcode">Â </pre>
<strong>Schritt 4: Das Javascript bauen und die Methode ausprobieren</strong>

Jetzt werden wir mal testen, ob das auch wirklich so funktioniert:
<pre class="csharpcode">    &lt;script language=<span class="str">"javascript"</span> type=<span class="str">"text/javascript"</span>&gt;</pre>
<pre class="csharpcode">    function ladefunktion()Â </pre>
<pre class="csharpcode">     {        

Â    HelloWorld.HelloWorldTest(<span class="str">"Reman"</span>, onComplete);        

Â    }        

function onComplete(result)        

Â    {        

Â    alert(result);        

Â    }        

&lt;/script&gt;</pre>
Die "ladefunktion()" schreiben wir einfach in das body Element als onload oder sonstwo hin und schon sehen wir, ob das klappt: Bei mir klappts. Der Javascript Aufruf der Webmethode ist entweder [Klasse].[MethodenName]([Parameter], [Javascript-Callbacks]) oder [Namespace].[Klasse].[MethodenName]([Parameter], [Javascript-Callbacks]).

<strong>Schritt 5: Verstehen was passiert</strong>

Der ScriptManager macht wie gesagt die Drecksarbeit davon, er bastelt im Hintergrund einen Javascript Wrapper um die Webmethode. Man kann das auch mit einer Methode machen, welche man im Codebehinde hat, allerdings ist das heute nicht das Thema.
Der Spannende Teil ist der Aufruf der Methode: Er ist identisch mit dem Aufruf als würde ich ihn im Codebehinde ansprechen - mit einem Unterschied - ich übergebe hier 2 Parameter. Einmal meinen direkten Parameter und einmal eine Callback Javascript Methode. Man kann bis zu 3 Callback Methoden angeben. Wenn man nur ein Parameter zusätzlich angibt, ist das die Methode wenn die Anfrage komplett abgearbeitet wurde. Die 2 anderen Parameter die möglich sind, sind für Fehlerfälle gedacht. Leider kann ich momentan nicht sagen, in welcher Reihenfolge die man angeben muss.

Das was als "result" bei der onComplete zurück kommt ist ein JSON - jedenfalls wenn man nichts anderes sagt. Man kann bei dem Service noch ein weiteres Attribute angeben: Das ResponseFormate - wo man zwischen JSON und XML wählen kann:
<pre class="csharpcode">    [WebMethod]Â </pre>
<pre class="csharpcode">    [ScriptMethod(ResponseFormat.Xml)]        

Â    <span class="kwrd">public</span> <span class="kwrd">string</span> HelloWorldTest(<span class="kwrd">string</span> name) {        

Â        <span class="kwrd">return</span> <span class="str">"Hello World"</span> + name;        

Â    }</pre>
<pre class="csharpcode">Â </pre>
Man kann noch ein paar mehr Parameter angeben, aberÂ so genau wollen wirs ja nicht machen. JSON istÂ ein sehr schickes, schmales Format, wasÂ auch sehr leicht verständlich ist.Â Auf die Objekte in dem JSON greift man dann so zuÂ "Objekt.Objekt.Objekt..."Â - ähnlich wie im Codebehinde.

<strong>Schritt 6:Â AJAX Ladebalken einbauen</strong>

Einen tollen Ladebalken kann man auch leicht implementieren - ohne irgendwelche komplexen Dinge aus dem Toolkit. Einfach bei der "ladeFunktion" das AJAX-Loader Gif auf "display: block" setzen und bei onComplete wieder auf "display: none".

Jetzt hat man ne coole Web 2.0 Seite mit dem ASP.NET AJAX Framework gemacht ;)

<strong>Fazit:</strong>

Also mit diesen tollen Feature kann man sehr schnell seine ganzen Webservices sehr leicht per Javascript erreichen. Natürlich geht das auch ohne das AJAX Framework, aber dadurch geht es doch sehr schnell. Man kann somit jetzt eine ASP.NET Seite bauen, welche im Prinzip nur aus Javascript und Webservices besteht - schöne neue Welt ;)
