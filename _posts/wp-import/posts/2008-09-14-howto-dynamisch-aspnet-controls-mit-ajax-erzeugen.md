---
layout: post
title: "HowTo: Dynamisch ASP.NET Controls mit AJAX erzeugen"
date: 2008-09-14 23:34
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [AJAX, ASP.NET, ASP.NET AJAX, Dynamic, HowTo]
---
{% include JB/setup %}
<p>Die Idee (und einige Codezeilen) für dieses HowTo kommt von diesem <a href="http://weblogs.asp.net/sanjeevagarwal/archive/2008/07/22/Dynamically-create-ASP.NET-user-control-using-ASP.NET-Ajax-and-Web-Service.aspx">Blogeintrag</a> der ein tolles Beispiel zeigt. Da ich mir meistens Sachen besser merken kann, wenn ich diese selber mal prototypisch umsetze, schreibe ich auf dieser Basis das HowTo.</p> <p><strong>Worum geht es?<br></strong>Stellen wir uns vor, wir hätten viele UserControls geschrieben, welche Daten und Controls unterschiedlicher Art anzeigen können. <br>Wenn man nun allerdings eine schöne "Web 2.0" AJAX Anwendung bauen will, schickt man im einfachsten Fall JSON Daten hin und her und muss sich das Control über Javascript zusammenbauen. Das ganze ist natürlich nicht sehr wartbar (manches wird über ASP.NET gemacht, manches vielleicht über statisch eingebundene Controls und andere Sachen über Javascript) - schön wäre doch, <strong>wenn man die Controls dynamisch auf die Seite holen könnte</strong>. Und genau darum geht es heute...</p> <p><strong>Aufbau:</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image540.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="160" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb518.png" width="244" border="0"></a> </p> <p>Wir haben ein sehr simples "SampleUserControl":</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e7a4dbdb-94b6-4fd4-ad75-3f253f5147e3" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SampleUserControl.ascx.cs" Inherits="DynamicASPControls.SampleUserControl" %&gt;
&lt;div style="background-color: red; height: 200px; top: 200px"&gt;
    Fertig geladen \o/
&lt;/div&gt;</pre></div>
<p><strong>Der ScriptService:</strong></p>
<p>Für die Kommunikation zwischen Client und Server (und die AJAX Funktionalität) nutzen wir ASP.NET AJAX. Wie das geht und was man damit machen kann, habe ich <a href="{{BASE_PATH}}/artikel/howto-microsoft-aspnet-ajax-clientseitiger-aufruf-von-webmethoden/">hier</a> bereits beschrieben.</p>
<p>Im ScriptService (der auch das Attribut ScriptService trägt) erstellen wir uns dynamisch den HTML Code von einem beliebigen Usercontrol:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:73f11a0f-fca3-41fc-a6fe-d9304c39096b" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public class ScriptService : System.Web.Services.WebService
    {
        [WebMethod(EnableSession = true)]
        public string GetControlHtml(string controlLocation)
        {
            Page page = new Page();
            UserControl userControl = (UserControl)page.LoadControl(controlLocation);
            userControl.EnableViewState = false;
            HtmlForm form = new HtmlForm();
            form.Controls.Add(userControl);
            page.Controls.Add(form);
            StringWriter textWriter = new StringWriter();
            HttpContext.Current.Server.Execute(page, textWriter, false);
            return CleanHtml(textWriter.ToString());
        }

        /// &lt;summary&gt;
        /// Removes Form tags
        /// &lt;/summary&gt;
        private string CleanHtml(string html)
        {
            return Regex.Replace(html, @"&lt;[/]?(form)[^&gt;]*?&gt;", "", RegexOptions.IgnoreCase);
        }
    }</pre></div>
<p>Der "GetControlHtml" Methode wird die "Location" von dem Control mitgeiteilt und jetzt bauen wir uns dynamisch eine "<a href="http://msdn.microsoft.com/en-us/library/system.web.ui.page.aspx">Page</a>" zusammen und fügen eine "<a href="http://msdn.microsoft.com/de-de/library/system.web.ui.htmlcontrols.htmlform.defaultbutton.aspx">HtmlForm</a>" dazu und hängen dort das geladene Control dran.</p>
<p>Über "<a href="http://msdn.microsoft.com/en-us/library/system.web.httpserverutility.execute.aspx">HttpContext.Current.Server.Execute</a>" können wir nun unseren fertigen HTML Code in ein String verwandeln.</p>
<p>Die "CleanHtml" Methode entfernt die Form Tags am Anfang wieder - sodass wir möglichst nur noch das original Control-HTML übrig haben.</p>
<p><strong>Größenbeschränkung aufheben:</strong></p>
<p>Da man ja relativ viele Sachen in einem Control machen kann und das daraus resultierende HTML recht groß werden kann, müssen wir <a href="http://msdn.microsoft.com/en-us/library/system.web.script.serialization.javascriptserializer.maxjsonlength.aspx">dies in der Web.Config erst freischalten</a>:</p>
<p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ea39ae1b-f0cf-47e8-8659-8e7d0ef7814d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">  &lt;system.web.extensions&gt;
    &lt;scripting&gt;
      &lt;webServices&gt;
        &lt;jsonSerialization maxJsonLength="5000000" /&gt;
      &lt;/webServices&gt;
    &lt;/scripting&gt;
  &lt;/system.web.extensions&gt;</pre></div></p>
<p><strong>Fertige ASPX:</strong></p>
<p>Die fertige ASPX Seite ist bewusst einfach gehalten:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f7cc13f7-1941-43f9-9d5f-afa11300f334" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeBehind="Default.aspx.cs" Inherits="DynamicASPControls._Default" %&gt;

&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"&gt;

&lt;html xmlns="http://www.w3.org/1999/xhtml" &gt;
&lt;head runat="server"&gt;
    &lt;title&gt;Untitled Page&lt;/title&gt;
    
&lt;/head&gt;
&lt;body&gt;
    &lt;form id="form1" runat="server"&gt;
    &lt;asp:ScriptManager ID="ScriptManager1" runat="server"&gt;
        &lt;Services&gt;
            &lt;asp:ServiceReference Path="~/ScriptService.asmx" /&gt;
        &lt;/Services&gt;
    &lt;/asp:ScriptManager&gt;

    &lt;button type="button" onclick="generateUserControl()"&gt;Generate UserControl!&lt;/button&gt;
    &lt;div id="result"&gt;
       
    &lt;/div&gt;
    &lt;/form&gt;
    
        &lt;script type="text/javascript"&gt;       
        function generateUserControl()
        {
            document.getElementById("result").innerHTML = "Load...";
            DynamicASPControls.ScriptService.GetControlHtml("~/SampleUserControl.ascx", generateUserControlCompleted);
        }
    
        function ready(result)
        {
            alert(result);
        }
    
        function generateUserControlCompleted(result)
        {
            document.getElementById("result").innerHTML = result;
        }
        
        function failed(error)
        {
            alert(error);
        }
        
    &lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre></div>
<p>Über die JavaScript Methoden greifen wir auf den Service zu, welcher uns das HTML liefert. In der "generateUserControlCompleted" Methode schreiben wir das HTML nur noch in unser "result" div:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image541.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="98" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb519.png" width="193" border="0"></a> <br><em>(Design made by me ;) )</em></p>
<p><strong>Ein komplexeres Beispiel:</strong></p>
<p>Ein wesentlich komplexeres Beispiel findet <a href="http://weblogs.asp.net/sanjeevagarwal/archive/2008/07/22/Dynamically-create-ASP.NET-user-control-using-ASP.NET-Ajax-and-Web-Service.aspx">ihr in diesem Blogpost</a>, sowie eine <a href="http://weblogs.asp.net/sanjeevagarwal/archive/2008/07/29/Dynamically-create-ASP.NET-user-control-using-JQuery-and-JSON-enabled-Ajax-Web-Service.aspx">jQuery Variante in diesem Blogpost</a>.</p>
<p><strong>Wo es Probleme geben könnte:</strong></p>
<p>Da wir das HTML dynamisch zur Seite hinzufügen, funktioniert sicherlich das Postback System von ASP.NET nicht (bzw. könnte ich es mir vorstellen, dass es da Probleme gibt) - für ein einfaches Control, welches ohne PostBacks entwickelt wurde, ist es aber sicherlich eine tolle Sache.</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/dynamicaspcontrols/dynamicaspcontrols.zip">[ Download Sourcecode ]</a></strong></p>
