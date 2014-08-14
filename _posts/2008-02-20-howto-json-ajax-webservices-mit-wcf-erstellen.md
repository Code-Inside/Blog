---
layout: post
title: "HowTo: JSON / AJAX - Webservices mit WCF erstellen"
date: 2008-02-20 23:46
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.NET, .NET 3.5, AJAX, HowTo, Json, WCF]
---
<p>Das Thema ist eigentlich schon alt - wie kann man .NET Methoden aus Javascript aufrufen. Mit ASMX Webservices ging dies recht einfach - <a href="http://code-inside.de/blog/artikel/howto-microsoft-aspnet-ajax-clientseitiger-aufruf-von-webmethoden/">siehe HowTo</a> - doch geht das auch mit WCF?</p> <p>Seit .NET 3.5 und Visual Studio 2008 strahlte mich dieses Itemtemplate an:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image275.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="331" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb254.png" width="503" border="0"></a> </p> <p>"AJAX-enabled WCF Service" klingt schonmal gut.</p> <p>Daraus wird dann sowas (ich hab die Standardmethode mal abgewandelt) :</p> <div class="CodeFormatContainer"><pre class="csharpcode"><span class="kwrd">using</span> System;
<span class="kwrd">using</span> System.Linq;
<span class="kwrd">using</span> System.Runtime.Serialization;
<span class="kwrd">using</span> System.ServiceModel;
<span class="kwrd">using</span> System.ServiceModel.Activation;
<span class="kwrd">using</span> System.ServiceModel.Web;

[ServiceContract(Namespace = <span class="str">""</span>)]
[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
<span class="kwrd">public</span> <span class="kwrd">class</span> Service
{
   <span class="rem">// Add [WebGet] attribute to use HTTP GET</span>
   [OperationContract]
   <span class="kwrd">public</span> DateTime GetDateTime()
   {
        <span class="kwrd">return</span> DateTime.Now;
   }

   <span class="rem">// Add more operations here and mark them with [OperationContract]</span>
}</pre></div>
<p>Wie üblich, muss man den ScriptManager diesen Service (<em>mit der .svc Endung</em>) noch registrieren:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">    &lt;asp:ScriptManager ID=<span class="str">"ScriptManager1"</span> runat=<span class="str">"server"</span>&gt;
        &lt;Services&gt;
            &lt;asp:ServiceReference Path=<span class="str">"~/Service.svc"</span> /&gt;
        &lt;/Services&gt;
    &lt;/asp:ScriptManager&gt;</pre></div>
<p>Wenn man dies jetzt einfach mal so ausführt, bekommt man folgendes (im Firebug) zu sehen:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image276.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="85" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb255.png" width="503" border="0"></a> </p>
<p>Schauen wir uns das Ergebnis jetzt mal per Javascript an:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image277.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="66" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb256.png" width="244" border="0"></a> </p>
<p>Eigentlich ist es genau dasselbe wie bei den "alten" ASMX Webservices - nur diesmal mit WCF.</p>
<p><strong>Doch im Detail gibt es Unterschiede</strong></p>
<p>Um dies deutlich zu machen, folgender Aufbau der Website:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image278.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="127" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb257.png" width="244" border="0"></a> </p>
<p>Ich habe einmal einen WCF und einen ASMX Webservice erstellt, mit folgenden Methoden:</p>
<p><em>- GetDateTime:</em> Gibt ein DateTime Objekt zurück<br><em>- GetComplexOne:</em> Gibt einen eigenen Objekttyp "Complex" zurück<br><em>- GetComplexList</em>: Gibt eine Collection an "Complex" Typen zurück.</p>
<p><strong>Beschreibung von eigenen Objekttyp "Complex"</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image279.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="173" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb258.png" width="178" border="0"></a></p>
<p>"GetList" und "GetOne" sind beide statisch. "Number" ist vom Typ integer und die anderen beiden sind Strings.</p>
<p><strong>Erstellung des ASMX Webservice</strong></p>
<p>Der ASMX Webservice ist nicht weiter schwierig:</p>
<div class="CodeFormatContainer"><pre class="csharpcode"><span class="kwrd">using</span> System;
<span class="kwrd">using</span> System.Collections;
<span class="kwrd">using</span> System.Linq;
<span class="kwrd">using</span> System.Web;
<span class="kwrd">using</span> System.Web.Services;
<span class="kwrd">using</span> System.Web.Services.Protocols;
<span class="kwrd">using</span> System.Xml.Linq;
<span class="kwrd">using</span> System.Collections.Generic;

<span class="rem">/// &lt;summary&gt;</span>
<span class="rem">/// Summary description for WebService</span>
<span class="rem">/// &lt;/summary&gt;</span>
[WebService(Namespace = <span class="str">"http://tempuri.org/"</span>)]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
<span class="rem">// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. </span>
[System.Web.Script.Services.ScriptService]
<span class="kwrd">public</span> <span class="kwrd">class</span> WebService : System.Web.Services.WebService {

    <span class="kwrd">public</span> WebService () {

    }

    [WebMethod]
    <span class="kwrd">public</span> DateTime GetDateTime()
    {
        <span class="kwrd">return</span> DateTime.Now;
    }

    [WebMethod]
    <span class="kwrd">public</span> ComplexType GetComplexOne()
    {
        <span class="kwrd">return</span> ComplexType.GetOne();
    }

    [WebMethod]
    <span class="kwrd">public</span> List&lt;ComplexType&gt; GetComplexList()
    {
        <span class="kwrd">return</span> ComplexType.GetList();
    }
}&nbsp; </pre></div>
<p>Wichtige Attribute sind hier das für die Ajax-Integration wichtige "<a href="http://asp.net/AJAX/Documentation/Live/mref/T_System_Web_Script_Services_ScriptServiceAttribute.aspx">ScriptServiceAttribut</a>", sowie das "<a href="http://msdn2.microsoft.com/en-us/library/byxd99hx(VS.71).aspx">WebMethodAttribut</a>". Wer mehr Infos möchte, dem sei dieser <a href="http://msdn2.microsoft.com/de-de/library/bb532367.aspx">MSDN Artikel</a> ans Herz gelegt.</p>
<p> Im Javascript werden diese Webmethoden in solch einen Wrapper gesetzt:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image280.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="109" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb259.png" width="564" border="0"></a> </p>
<p><strong>Erstellung des WCF Services</strong></p>
<p>Der WCF Service ist ähnlich vom Aufbau, allerdings sind andere Attribute und Klassen im Gebrauch:</p>
<div class="CodeFormatContainer"><pre class="csharpcode"><span class="kwrd">using</span> System;
<span class="kwrd">using</span> System.Linq;
<span class="kwrd">using</span> System.Runtime.Serialization;
<span class="kwrd">using</span> System.ServiceModel;
<span class="kwrd">using</span> System.ServiceModel.Activation;
<span class="kwrd">using</span> System.ServiceModel.Web;
<span class="kwrd">using</span> System.ServiceModel.Description;
<span class="kwrd">using</span> System.Collections.Generic;

[ServiceContract(Namespace = <span class="str">""</span>)]
[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
<span class="kwrd">public</span> <span class="kwrd">class</span> Service
{
   <span class="rem">// Add [WebGet] attribute to use HTTP GET</span>
   [OperationContract]
   <span class="kwrd">public</span> DateTime GetDateTime()
   {
        <span class="kwrd">return</span> DateTime.Now;
   }

    [OperationContract]
    <span class="kwrd">public</span> ComplexType GetComplexOne()
    {
        <span class="kwrd">return</span> ComplexType.GetOne();
    }
    
    
    [OperationContract]
    <span class="kwrd">public</span> List&lt;ComplexType&gt; GetComplexList()
    {
        <span class="kwrd">return</span> ComplexType.GetList();
    }
   <span class="rem">// Add more operations here and mark them with [OperationContract]</span>
}
</pre></div>
<p>Das wichtigste Attribut für den JSON Webserive ist das "<a href="http://msdn2.microsoft.com/en-us/library/system.servicemodel.activation.aspnetcompatibilityrequirementsattribute.aspx">AspNetCompatibilityRequirementsAttribute</a>" und dann für WCF typisch das "<a href="http://msdn2.microsoft.com/en-us/library/system.servicemodel.operationcontractattribute.aspx">OperationContractAttribute</a>".</p>
<p>Wenn man das nun so kompiliert und die beiden Services in den ScriptManager einbindet, bekommen wir einen Fehler in unserem WCF Service!</p>
<p><strong>Den "ComplexType" für WCF zugänglich machen</strong></p>
<p>WCF serializiert nur das, was konfiguriert wurde (um es mal einfach auszudrücken). Dafür müssen über dem Typen ein "<a href="http://msdn2.microsoft.com/en-us/library/system.runtime.serialization.datacontractattribute.aspx">DataContractAttribute</a>" gesetzt werden und über jeden Member ein "<a href="http://msdn2.microsoft.com/en-us/library/system.runtime.serialization.datamemberattribute.aspx">DataMemberAttribute</a>".</p>
<p>Sobald dies gemacht wurde, sieht man im Javascript folgendes:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image281.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="116" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb260.png" width="618" border="0"></a> </p>
<p>Die serializierten Objekte sind identisch mit der ASMX Variante.</p>
<p>Mehr zum Thema JSON Serializierung: <a href="http://msdn2.microsoft.com/en-us/library/bb412170.aspx">Stand-Alone JSON Serialization</a>.</p>
<p><strong>Zwischenfazit</strong></p>
<p>Läuft schonmal ganz gut und bis auf die Sache mit dem "DataContract/MemberAttributen" sind kaum Unterschiede. Wenn man etwas mehr ins Detail geht, findet man allerdings noch das ein oder andere, was anders ist:</p>
<p><strong>Unterschiede Namespaces:</strong></p>
<p>Wenn man um die ASMX "WebService" Klasse ein Namespace "WebServiceNamespace" zieht, wird aus dem Javascript Wrapper folgendes:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image282.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="154" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb261.png" width="583" border="0"></a> </p>
<p>Wenn man um den WCF Service einen Namespace zieht, passiert erstmal garnix - warum weiß ich spontan auch leider nicht. Um jedoch den selben Effekt zu erzielen wie bei der ASMX Variante muss man im "<a href="http://msdn2.microsoft.com/en-us/library/system.servicemodel.servicecontractattribute.aspx">ServiceContractAttribute</a>" einen Namespace setzen:</p>
<p>[ServiceContract(Namespace = "ServiceNamespace")]</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image283.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="162" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb262.png" width="587" border="0"></a> </p>
<p><strong>Unterschiede HttpContext / ASP.NET Integration:</strong></p>
<p>In einem WCF Service kann man nicht auf <a href="http://msdn2.microsoft.com/en-us/library/system.web.httpcontext.aspx">HttpContext</a> zugreifen, sondern auf einen <a href="http://msdn2.microsoft.com/en-us/library/system.servicemodel.operationcontext.aspx">OperationContext</a>. Dies und mehr ist auf der MSDN ganz gut beschrieben:</p>
<p><a href="http://msdn2.microsoft.com/en-us/library/aa702682.aspx">WCF Services and ASP.NET</a></p>
<p><strong>Weitere Infos &amp; Fazit:</strong></p>
<p>Auf der MSDN ist noch ein weiteres <a href="http://msdn2.microsoft.com/en-us/library/bb924552.aspx">einfaches Beispiel</a> zu finden. <br>Hier sind auch noch zwei andere Blogposts zu dem Thema:</p>
<ul>
<li><a href="http://pluralsight.com/blogs/fritz/archive/2008/02/01/50126.aspx">Creating JSON-enabled WCF services in .NET 3.5 - an even simpler approach</a></li>
<li><a href="http://pluralsight.com/blogs/fritz/archive/2008/01/31/50121.aspx">Creating JSON-enabled WCF services in .NET 3.5</a></li></ul>
<p>WCF Serivces sind eine mächtige Alternative zu den ASMX Webservices und die Integration in eine AJAX Anwendung ist kaum schwieriger als die ASMX Variante - wenn man die Möglichkeit hat und etwas rumexperimentieren möchte, der sollte dies wahrnehmen. Hier noch der Democode:</p>
<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/ajaxwcf/ajaxwcf.zip">[ Download Democode ]</a></strong></p>
