---
layout: post
title: "POET vs. ASP.NET – ASP.NET Security Lücke"
date: 2010-09-20 22:00
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [ASP.NET, Security]
---
<p><a href="{{BASE_PATH}}/assets/wp-images/image1056.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb238.png" width="138" height="102" /></a> </p>  <p>Seit letztem Freitag ist eine Sicherheitslücke in ASP.NET bekannt und in diversen Blogs und Tweets heisst es, dass man unbedingt den Workaround einspielen soll. Doch was steckt hinter dieser Sicherheitslücke?</p>  <p>&#160;</p> <!--more-->  <p><strong>Die Attacke wird bekannt</strong></p>  <p>Letzte Freitag ist unter dem etwas kryptischen Titel "<a href="http://threatpost.com/en_us/blogs/new-crypto-attack-affects-millions-aspnet-apps-091310?utm_source=Threatpost&amp;utm_medium=Tabs&amp;utm_campaign=Today's+Most+Popular">Padding Oracle' Crypto Attack Affects Millions of ASP.NET Apps</a>” eine Sicherheitslücke in ASP.NET bekannt geworden. Da ich mich mit Verschlüsselung und co. nicht genau auskenne, werde ich es in meinen einfachen Worten wiedergeben, wie ich es selbst verstanden habe. <em>Das bedeutet aber auch, dass hier Mist stehen könnte ;)</em> </p>  <p>Der Viewstate oder irgendwelche ASP.NET Sessions werden im Cookie als Hash gespeichert. Um die Sachen wieder zu entschlüsseln wird der Machine Key von .NET genommen. Leider ist die Implementation von dem Verschlüsselungsalgorithmus anfällig. </p>  <p>Ich habe ein <a href="http://www.troyhunt.com/2010/09/fear-uncertainty-and-and-padding-oracle.html">super, genialen Blogpost</a> gefunden, der allgemein die gesamte Attacke beschreibt und nutze das auch selber als Quelle. </p>  <p><strong>Die Attacke</strong></p>  <p>"Oracle” hat nichts mit der Firma Oracle zutun, sondern wird in der Verschlüsselung verwendet. Der Angriff der aktuell gefahren wird, ist auch als "Oracle Padding” bekannt. Die "Pad Buster” Attacke selbst ist sehr gut in <a href="http://www.gdssecurity.com/l/b/2010/09/14/automated-padding-oracle-attacks-with-padbuster/">diesem Blogpost</a> beschrieben. Ganz grundsätzlich werden immer Blöcke mit einer festen Anzahl an Byte gefüllt, so z.B. hier als die Wörter "FIG”,”BANANA”, "AVOCADO”, "PLANTAIN” &amp; "PASSIONFRUIT”. Die "gepadded” Varianten müssen entsprechen noch mit Füllbytes ausgefüllt werden:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1057.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb239.png" width="518" height="289" /></a> </p>  <p>Im ASP.NET Universum schickt der Angreifer irgendwelche Hashs an eine bestimmte Adresse (komm ich weiter unten noch genauer drauf). </p>  <ul>   <li>Wenn der Webserver valide &amp; richtig "gepadded” Daten erhält bekommt der Aufrufer die Antwort (HTTP 200)</li>    <li>Wenn es nicht richtig "gepadded” wird, dann wird ein Fehler zurück gegeben (HTTP 500)</li>    <li>Wenn der Webserver zwar valide Daten, aber nicht richtig "gepadded” Daten enthält wird meist eine CustomErrorPage mit HTTP 200 zurückgegeben.</li> </ul>  <p>Nach und nach kann so der Angreifer durch einen Fehler im Framework den Key zum Hashen erraten. Wie gesagt, dass nur ganz grob. Genauer wird es <a href="http://www.gdssecurity.com/l/b/2010/09/14/automated-padding-oracle-attacks-with-padbuster/">hier</a>.</p>  <p><strong>Microsofts Reaktion</strong></p>  <p>Das Microsoft Security Research &amp; Defense hat einen <a href="http://blogs.technet.com/b/srd/archive/2010/09/17/understanding-the-asp-net-vulnerability.aspx">allgemeinen Blogpost zur Lücke</a> veröffentlicht. ScottGu hat hinterher noch einen <a href="http://weblogs.asp.net/scottgu/archive/2010/09/18/important-asp-net-security-vulnerability.aspx">"entwicklernaheren” Blogpost</a> veröffentlicht. Es gibt auch ein <a href="http://www.asp.net/media/782788/detectcustomerrorsdisabledv30.zip"><strong>.vbs Script</strong></a> mit dem man im IIS checken kann, ob irgendwelche Anwendungen betroffen sind.</p>  <p><strong>Die Lösung/Workaround die Microsoft vorschlägt</strong></p>  <p>Der Workaround klingt erst mal seltsam. <strong>ALLE</strong> Fehler die in der Webanwendung auftreten sollen ein und dieselbe Fehlerseite zurückliefern.</p>  <p><u>In ASP.NET V1.0 bis ASP.NET V3.5 in der web.config:</u></p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1a490abc-ae51-4d19-b07c-6458891a24fe" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;configuration&gt;        
   &lt;system.web&gt;
      &lt;customErrors mode="On" defaultRedirect="~/error.html" /&gt;
   &lt;/system.web&gt;        
&lt;/configuration&gt;</pre></div>

<p><u>In ASP.NET ASP.NET V3.5 SP1 &amp; ASP.NET 4.0 in der web.config:</u></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:13add540-1762-4701-9b3a-ef4102b9b397" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;configuration&gt;
   &lt;system.web&gt;
     &lt;customErrors mode="On" redirectMode="ResponseRewrite" defaultRedirect="~/error.aspx" /&gt;
   &lt;/system.web&gt;
&lt;/configuration&gt;</pre></div>

<p></p>

<p></p>

<p><u>Die Error.aspx:</u></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:78c3ab7f-176b-4ad8-93df-899192618ab8" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;%@ Page Language="C#" AutoEventWireup="true" %&gt;
&lt;%@ Import Namespace="System.Security.Cryptography" %&gt;
&lt;%@ Import Namespace="System.Threading" %&gt;

&lt;script runat="server"&gt;
   void Page_Load() {
      byte[] delay = new byte[1];
      RandomNumberGenerator prng = new RNGCryptoServiceProvider();

      prng.GetBytes(delay);
      Thread.Sleep((int)delay[0]);
        
      IDisposable disposable = prng as IDisposable;
      if (disposable != null) { disposable.Dispose(); }
    }
&lt;/script&gt;

&lt;html&gt;
&lt;head runat="server"&gt;
    &lt;title&gt;Error&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
    &lt;div&gt;
        An error occurred while processing your request.
    &lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;</pre></div>

<p><strong>Zur Erklärung:</strong></p>

<p>Egal ob ein Serverfehler wegen 404 oder 500 auftritt, es wird immer dieselbe Fehlerseite und Meldung zurückgegeben. Eine kleine Besonderheit um den Angreifer die Informationsquelle zu kappen: Beim Aufruf der Error.aspx wird eine zufällige Verzögerung verursacht.</p>

<p><strong>Wozu das?</strong></p>

<p>Wie weiter oben beschrieben, benötigt der Angreifer Informationen, ob der gehashte Wert komplett falsch war (HTTP 500) oder so nur nicht vorhanden (Fehlerseite, aber HTTP 200). Wenn man nun alle Fehler auf dasselbe führt weiß der Angreifer erst einmal weniger. Allerdings könnte der Angreifer anhand der Reaktionszeit des Server (vll. (?) ich bin kein Experte ;) ) schätzen, ob es HTTP 500 wäre oder nicht. Daher die zufällige Zeit zur Reaktion. So sollte der Angreifer nie genau wissen, ob der Hash langsam in die richtige Richtung geht oder nicht.</p>

<p><strong>Das klingt alles recht abstrakt... betrifft mich das?</strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1058.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb240.png" width="180" height="151" /></a> </p>

<p>Je nachdem wie die Anwendung gestrickt ist, kann das SEHR große Auswirkungen haben. Von den Entdeckern der Lücke gibt es ein recht beeindruckendes Video. Dabei knacken Sie recht schnell den Machine Key und erstellen sich einfach ein Cookie auf dem Client, mit dem man als SuperUser in .NET Nuke angemeldet ist:</p>

<p>&#160;</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:5737277B-5D6D-4f48-ABFC-DD9C333F4C5D:0df2b220-d01a-47ac-92cd-37ff67756d7a" class="wlWriterEditableSmartContent"><div><object width="425" height="355"><param name="movie" value="http://www.youtube.com/v/yghiC_U2RaM&amp;hl=en"></param><embed src="http://www.youtube.com/v/yghiC_U2RaM&amp;hl=en" type="application/x-shockwave-flash" width="425" height="355"></embed></object></div></div>

<p></p>

<p><strong>Ok... "Sessions” kapern... ScottGu schrieb das man auch .config Files runterladen könnte?!</strong></p>

<p>In <a href="http://weblogs.asp.net/scottgu/archive/2010/09/18/important-asp-net-security-vulnerability.aspx">ScottGus Blogpost</a> findet sich auch folgende Warnung:</p>

<p><em>An attacker using this vulnerability can request and download files within an ASP.NET Application like the web.config file (which often contains sensitive data). </em></p>

<p><em>At attacker exploiting this vulnerability can also decrypt data sent to the client in an encrypted state (like ViewState data within a page).</em></p>

<p>Ich fragte mich dann, wie man denn bitte auf die .config Files zugreifen könnte. Immerhin sollte dies über den IIS geblockt werden. Aber, es gibt ein kleines Feature namens WebResource.axd <a href="http://support.microsoft.com/kb/910442/de">(Webresources)</a>.</p>

<p>Scripts, CSS oder andere Sachen können über bestimmte URLs eingebunden werden:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:826f699d-d480-4a7e-9a36-c3c390983e79" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;script src="/WebResource.axd?d=8KdqlbnKlEkJNojRMjxtSxbXkp67u-rzhy_VoqsYA901&amp;amp;t=634200755509128189" type="text/javascript"&gt;&lt;/script&gt;</pre></div>

<p>Dabei steht der "d”-Parameter für einen verschlüsselten Pfad, den ASP.NET entsprechend (durch das entschlüsseln mit dem Machine Key) ausliesst und zurückliefert. D.h. wenn man den Key knackt, könnte man sich z.B. die web.config oder irgendwelche anderen Daten rein über eine HTTP Verbindung zurückgeben lassen.</p>

<p>Schon heftig, oder?</p>

<p><strong>Damit man nicht auf Heise.de landet...</strong></p>

<p>... sollte man bei jeglichen ASP.NET Anwendungen den Workaround anwenden. Sharepoint oder ASP.NET MVC Apps sind wahrscheinlich genauso betroffen. Bis auf die Entdecker der Lücke (und wahrscheinlich ein paar Profihacker ausserhalb und innerhalb von Microsoft) hat wahrscheinlich noch keiner ein simples "Script-Kiddy” Tool hergestellt. Das Python Script im dem YouTube Video wäre wahrscheinlich verherrender als die Java Version - mit der Javaversion hab ich es jedenfalls nicht geschafft ;)</p>

<p>Also: Wenn selbst die Micosoftis diese Lücke ernst nehmen - <strong>agieren, statt reagieren</strong>! In ScottGus Posts gibt es das <a href="http://www.asp.net/media/782788/detectcustomerrorsdisabledv30.zip">.vbs Script</a>. Einfach mal prüfen :)</p>

<p>Aufruf über</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9c3a11a8-9a7b-43d5-86c7-5bbd3527cf8c" class="wlWriterEditableSmartContent"><pre name="code" class="c#">cscript &lt;path&gt;/&lt;file&gt;.vbs</pre></div>

<p><strong>Quellen</strong></p>

<p>Ich kann folgenden Blogposts nur empfehlen:</p>

<ul>
  <li><a href="http://www.troyhunt.com/2010/09/fear-uncertainty-and-and-padding-oracle.html">Fear, uncertainty and and the padding oracle exploit in ASP.NET</a></li>
</ul>
