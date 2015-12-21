---
layout: page
title: "HowTo: Microsoft Silverlight 1.0 (dynamische Spiegeleffekte)"
date: 2007-09-11 22:35
author: Robert Muehsig
comments: true
categories: []
tags: []
permalink: /artikel/howto-microsoft-silverlight-10-dynamische-spiegeleffekte
---
{% include JB/setup %}
In dem vorherigen HowTo <a href="{{BASE_PATH}}/artikel/howto-microsoft-silverlight-10-spiegeleffekte-erzeugen/">(Microsoft Silverlight 1.0 (Spiegeleffekte erzeugen))</a> ging es grob darum, wie man mit Blend 2 arbeitet.
Heute kommt daher noch ein kleiner Abschnitt, der eigentlich noch mit in dem letzten HowTo mit reinkommen sollte: Wie dynamisiere ich das jetzt?

<strong>Schritt 1: Silverlight samt MS AJAX enabeld Projekt in Visual Studio erzeugen und den unsinnigen Kram rauswerfen</strong>

Wie ausführlich beschrieben <a href="{{BASE_PATH}}/artikel/howto-microsoft-silverlight-10-praktischer-anfang/">hier</a> beschrieben, erzeugen wir ein ASP.NET AJAX enabeld Project (oder eine Website) und laden die benötigten Komponenten rein:

- Silverlight.js (kommt direkt von MS und wurde von mir nicht angefasst)
- default.html.js (wurde durch das Projekttemplate aus dem vorherigen HowTo erstellt und dort angepasst) :
<pre class="csharpcode">function createSilverlight() 
{ 
var parentElement = document.getElementById(<span class="str">'SilverlightPlugInHost'</span>); 
    Silverlight.createObject( 
        <span class="str">"Page.xaml"</span>,                  <span class="rem">// Source property value.</span> 
        parentElement,                  <span class="rem">// DOM reference to hosting DIV tag.</span> 
        <span class="str">"mySilverlightPlugin"</span>,         <span class="rem">// Unique plug-in ID value.</span> 
        {                               <span class="rem">// Per-instance properties.</span> 
            width:<span class="str">'300'</span>,                <span class="rem">// Width of rectangular region of </span> 
                                        <span class="rem">// plug-in area in pixels.</span> 
            height:<span class="str">'300'</span>,               <span class="rem">// Height of rectangular region of </span> 
                                        <span class="rem">// plug-in area in pixels.</span> 
            inplaceInstallPrompt:<span class="kwrd">false</span>, <span class="rem">// Determines whether to display </span> 
                                        <span class="rem">// in-place install prompt if </span> 
                                        <span class="rem">// invalid version detected.</span> 
            background:<span class="str">'#D6D6D6'</span>,       <span class="rem">// Background color of plug-in.</span> 
            isWindowless:<span class="str">'false'</span>,       <span class="rem">// Determines whether to display plug-in </span> 
                                        <span class="rem">// in Windowless mode.</span> 
            framerate:<span class="str">'24'</span>,             <span class="rem">// MaxFrameRate property value.</span> 
            version:<span class="str">'1.0'</span>               <span class="rem">// Silverlight version to use.</span> 
        }, 
        { 
            onError:<span class="kwrd">null</span>,               <span class="rem">// OnError property value -- </span> 
                                        <span class="rem">// event handler function name.</span> 
            onLoad:<span class="kwrd">null</span>                 <span class="rem">// OnLoad property value -- </span> 
                                        <span class="rem">// event handler function name.</span> 
        }, 
        <span class="kwrd">null</span>);                          <span class="rem">// Context value -- event handler function name.</span> 
}</pre>
- Page.xaml (siehe vorheriges HowTo mit dem "HelloWorld")

und dann muss noch die Default.aspx angepasst werden:
<pre class="csharpcode">&lt;%@ Page Language=<span class="str">"C#"</span> AutoEventWireup=<span class="str">"true"</span> CodeBehind=<span class="str">"Default.aspx.cs"</span> Inherits=<span class="str">"MS_AJAX_Silverlight._Default"</span> %&gt;    

&lt;!DOCTYPE html PUBLIC <span class="str">"-//W3C//DTD XHTML 1.0 Transitional//EN"</span> <span class="str">"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"</span>&gt;    

&lt;html xmlns=<span class="str">"http://www.w3.org/1999/xhtml"</span> &gt; 
&lt;head runat=<span class="str">"server"</span>&gt; 
    &lt;title&gt;Untitled Page&lt;/title&gt; 
    &lt;script type=<span class="str">"text/javascript"</span> src=<span class="str">"Silverlight.js"</span>&gt;&lt;/script&gt; 
    &lt;script type=<span class="str">"text/javascript"</span> src=<span class="str">"Default.html.js"</span>&gt;&lt;/script&gt; 
&lt;/head&gt; 
&lt;body&gt;    

   &lt;div id=<span class="str">"SilverlightPlugInHost"</span>&gt; 
      &lt;script type=<span class="str">"text/javascript"</span>&gt; 
         createSilverlight(); 
      &lt;/script&gt; 
   &lt;/div&gt;    

    &lt;form id=<span class="str">"form1"</span> runat=<span class="str">"server"</span>&gt; 
        &lt;asp:ScriptManager ID=<span class="str">"ScriptManager1"</span> runat=<span class="str">"server"</span> /&gt; 
    &lt;div&gt;    

    &lt;/div&gt; 
    &lt;/form&gt; 
&lt;/body&gt; 
&lt;/html&gt;</pre>
Am Ende hat man eine ASP.NET AJAX Projekt mit den benötigten Silverlight 1.0 Datein.

<strong>Schritt 2: Mit Javascript den Text verändern</strong>

In der Page.xaml müssen wir 2 Veränderungen vornehmen, damit wir per Javascript auf die Elemente zugreifen können. In den "Run" Elemente (wo der Text drin steht), müssen wir eine Art ID vergeben:
<pre class="csharpcode">&lt;Run x:Name=<span class="str">"HelloWorld"</span> FontSize=<span class="str">"24"</span> Foreground=<span class="str">"#FFFFFFFF"</span> Text=<span class="str">"Hello World!"</span>/&gt;</pre>
Das x:Name Attribute muss noch an dem "gespiegelten" Run Element genauso dran - damit man später beide zugreifen kann. Das original nennt sich bei mir "HelloWorld" und das andere "HelloWorldMirror".
Jetzt fügen wir ganz trocken noch ein Input Feld und einen Button unter das Div, in welches das Silverlight geladen wird:
<pre class="csharpcode">&lt;input type=<span class="str">"text"</span> id=<span class="str">"textBox"</span> /&gt;&lt;button onclick=<span class="str">"writeToSilverlight()"</span>&gt;Klick&lt;/button&gt;</pre>
Nun noch die Javascriptfunktion erstellen und dort auf die DOM des Silverlights zugreifen (die Silverlight DOM ist ähnlich wie die normale DOM - die eigenschaftsnamen der Elemente sind wie die im XAML (kann es aber nicht garantieren)) :
<pre class="csharpcode">    &lt;script language=<span class="str">"javascript"</span>&gt; 
    function writeToSilverlight() 
    { 
           var silverlight = document.getElementById(<span class="str">"mySilverlightPlugin"</span>); 
            silverlight.content.findName(<span class="str">"HelloWorld"</span>).Text = document.getElementById(<span class="str">"textBox"</span>).<span class="kwrd">value</span>; 
            silverlight.content.findName(<span class="str">"HelloWorldMirror"</span>).Text = document.getElementById(<span class="str">"textBox"</span>).<span class="kwrd">value</span>; 
    }    

    &lt;/script&gt;</pre>
<strong>Erklärung:</strong> Zuerst holen wir uns in eine "silverlight" Variable die DOM der ID und hinterher können wir auf diese recht bequem zugreifen. Die "findName" Methode nimmt dabei sehr viel ab - damit finden wirunsere beiden Texte wieder und können die wie in alter Javascript Manier setzen.

<strong>Achtung: </strong>Bei "document.getElementById("mySilverlightPlugin")" ist NICHT die ID des DIVs gemeint, in der wir es reingeladen haben. In der createSilverlight Funktion (siehe oben) legen wir eine "unique Plug-In ID" fest - diese ist hier gemeint und nur darüber kommen wir in das Silverlight rein.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image16.png"><img border="0" width="337" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb16.png" alt="image" height="312" style="border-width: 0px" /></a>

<strong>Ein kleiner Tipp: </strong>Hier kann man sehen, dass man HTML Elemente und Silverlight Elemente gut mischen kann - auch einer Benutzung von Google Maps oder Virtual Earth steht dadurch nix im Wege - Silverlight kann "nebenher" laufen.

<strong>Schritt 3: Volle Kraft - MS AJAX und Silverlight</strong>

Damit das MS AJAX jetzt hier auch eine Verwendung findet, pimpen wir nun unsere Javascript Eingabe: Der Text geht an einen Webservice, welcher durch die AJAX Extensions eingebunden ist und geben die Ergebnisse dann letztendlich wieder als JSON in ein JS und das zeigt es im Silverlight an. Es soll eigentlich nur eine Inspiration sein, was man damit machen kann, vom Sinn her ists hier etwas mangelhaft ;)

Webservice erstellen und "ScriptService" Attribut über den Webservice schreiben:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image17.png"><img border="0" width="196" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb17.png" alt="image" height="36" style="border-width: 0px" /></a>
<pre class="csharpcode"><span class="kwrd">namespace</span> MS_AJAX_Silverlight 
{ 
    <span class="rem">/// &lt;summary&gt;</span> 
    <span class="rem">/// Zusammenfassungsbeschreibung für HelloWorld</span> 
    <span class="rem">/// &lt;/summary&gt;</span> 
    [WebService(Namespace = <span class="str">"http://tempuri.org/"</span>)] 
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)] 
    [ToolboxItem(<span class="kwrd">false</span>)] 
    [ScriptService] 
    <span class="kwrd">public</span> <span class="kwrd">class</span> HelloWorld : System.Web.Services.WebService 
    {    

        [WebMethod] 
        <span class="kwrd">public</span> <span class="kwrd">string</span> HelloWorldMethod(<span class="kwrd">string</span> name) 
        { 
            <span class="kwrd">return</span> <span class="str">"Hello World:"</span> + name; 
        } 
    } 
}</pre>
Das jetzt im ScriptManager auf der Default.aspx einbinden:

&lt;asp:ScriptManager ID="ScriptManager1" runat="server"&gt;
    &lt;Services&gt;
        &lt;asp:ServiceReference Path="HelloWorld.asmx" /&gt;
    &lt;/Services&gt;
&lt;/asp:ScriptManager&gt;

... und am Ende unser Javascript Funktion neu basteln:

&lt;script language="javascript"&gt;
function writeToSilverlight()
{
        MS_AJAX_Silverlight.HelloWorld.HelloWorldMethod(document.getElementById("textBox").value, onComplete);
}

function onComplete(result)
{
        var silverlight = document.getElementById("mySilverlightPlugin");
        silverlight.content.findName("HelloWorld").Text = result;
        silverlight.content.findName("HelloWorldMirror").Text = result;
}

&lt;/script&gt;

Fertig - das Ergebnis ist das selbe, allerdings diesmal komplett mit Webservice. Toll, oder?

<a href="{{BASE_PATH}}/artikel/howto-microsoft-silverlight-10-bilder-kippen-samt-spiegeleffekte/">[Hier gehts direkt zum nächsten HowTo: Microsoft Silverlight 1.0 (Bilder "kippen" mit Spiegeleffekten)]</a>
