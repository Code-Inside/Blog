---
layout: post
title: "HowTo: Excel-Export via AJAX"
date: 2008-04-03 20:53
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [AJAX, ASP.NET, Excel, Export, Javascript, Json]
language: de
---
{% include JB/setup %}
<p>Wir (d.h. Oliver und ich) haben bei einem Projekt die Anforderung gehabt, in einer sehr AJAX und Javascriptlastigen Anwendung ein Excel Export mit einzubauen. </p>  <p>Durch ein Postback oder durch Aufruf einer Webmethode etc. ist dies sehr einfach zu l&#246;sen, allerdings gab es ein Problem:</p>  <p>Die letztendliche Ergebnisliste wird &#252;ber verschiedene Javascript Methoden bef&#252;llt, d.h. das momentan angezeigte (und in einem JSON Objekt befindliche) Ergebnis muss am besten direkt irgendwie &#252;bergeben werden.</p>  <p>Da die L&#246;sung etwas &quot;geschickt&quot; ist (der Erfinder ist Oliver) Schritt f&#252;r Schritt erkl&#228;rt:</p>  <p><strong><u>1. Grunds&#228;tzlicher Aufbau</u></strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image367.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="122" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb346.png" width="178" border="0" /></a> </p>  <p><strong><u>2. Default.aspx vorbereiten</u></strong></p>  <p>Die ASPX Seite (abgesehen von dem Javascript - welches gleich n&#228;her beschrieben wird) ist simpel:</p>  <p></p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ab1f408a-363e-4fb9-ac4e-2033f536d76e" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %&gt;

&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"&gt;

&lt;html xmlns="http://www.w3.org/1999/xhtml"&gt;
&lt;head runat="server"&gt;
    &lt;title&gt;Untitled Page&lt;/title&gt;
    &lt;script type="text/javascript"&gt;
    // wird gleich gezeigt
    &lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
    &lt;form id="form1" runat="server"&gt;
    &lt;div&gt;
        &lt;button type="button" onclick="createXlsData()"&gt;Create XLS&lt;/button&gt;
    &lt;/div&gt;
    &lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;</pre></div>

<p></p>

<p><strong>Zwischenbemerkung: Wie erstellt man eigentlich eine Excel List?</strong></p>

<p>Excel kann auch HTML Tabellen &quot;interpretieren&quot; und entsprechend darstellen.</p>

<p>Das HTML drumherum muss man weg lassen, um eine einfache Tabelle zu erzeugen muss man Excel sowas &#252;bergeben:</p>

<p></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:281f0813-8cbf-451e-b4e3-2469ffeb4e45" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;table&gt;
  &lt;tr&gt;
     &lt;td&gt;Sample&lt;/td&gt;
  &lt;/tr&gt;
&lt;/table&gt;</pre></div>

<p></p>

<p><strong><u>3. Im Javascript Tabelle vorbereiten: &quot;createXlsData()&quot;</u></strong></p>

<p>In diesem Teil k&#246;nnen wir nun auf unsere JSON Objekte zugreifen - ohne nochmal einen Webservice etc. zu befragen.</p>

<p></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:090f0ebf-6ea7-40e4-b14c-2bea485a69fe" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">function createXlsData()
    {
    var data = "&lt;table&gt;";
            data += "&lt;tr&gt;";
                data += "&lt;td&gt;Test 1&lt;/td&gt;";
                data += "&lt;td&gt;Test 2&lt;/td&gt;";
             data += "&lt;/tr&gt;"
        
    for(i=0; i &lt; 10; i++)
    {
        var singleLine = "&lt;tr&gt;";
                singleLine += "&lt;td&gt; Test Data1: " + i + "&lt;/td&gt;";
                singleLine += "&lt;td&gt; Test Data2: "  + i + "&lt;/td&gt;";
        singleLine += "&lt;/tr&gt;";
        data += singleLine;   
    }
        data += "&lt;/table&gt;";
    sendXlsData(data);
    }</pre></div>

<p></p>

<p><strong><u>4. Daten an Handler &#252;bermitteln und Handler aufrufen</u></strong></p>

<p>Da der String f&#252;r einen &quot;GET&quot; Request zu lang ist, muss er per &quot;POST&quot; an den Handler &#252;bermittelt werden . nat&#252;rlich mit AJAX.</p>

<p><strong>Problem:</strong> Wenn man dies per AJAX macht, sieht man nie dieses Fenster:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image368.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="188" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb347.png" width="244" border="0" /></a> </p>

<p><strong>L&#246;sung:</strong> Der Handler speichert die &#252;bergebenen Werte in der Session und das Javascript ruft expliziert nochmal den Handler aus, welcher die Daten aus der Session holt.</p>

<p>Hier der komplette Source-Code der Default.aspx:</p>

<p></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:adb36ab5-3773-4fbe-9283-db381fc8ca97" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %&gt;

&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"&gt;

&lt;html xmlns="http://www.w3.org/1999/xhtml"&gt;
&lt;head runat="server"&gt;
    &lt;title&gt;Untitled Page&lt;/title&gt;
    &lt;script type="text/javascript"&gt;
    var DataExchangeHttpRequest;

    function createXlsData()
    {
    var data = "&lt;table&gt;";
            data += "&lt;tr&gt;";
                data += "&lt;td&gt;Test 1&lt;/td&gt;";
                data += "&lt;td&gt;Test 2&lt;/td&gt;";
             data += "&lt;/tr&gt;"
        
    for(i=0; i &lt; 10; i++)
    {
        var singleLine = "&lt;tr&gt;";
                singleLine += "&lt;td&gt; Test Data1: " + i + "&lt;/td&gt;";
                singleLine += "&lt;td&gt; Test Data2: "  + i + "&lt;/td&gt;";
        singleLine += "&lt;/tr&gt;";
        data += singleLine;   
    }
        data += "&lt;/table&gt;";
    sendXlsData(data);
    }

    function sendXlsData(data)
    {
    if (window.XMLHttpRequest) // Mozilla, Safari, Opera, IE7
        {
        DataExchangeHttpRequest = new XMLHttpRequest();
        }
    else if (window.ActiveXObject) // IE6, IE5
        {
        DataExchangeHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");
        }

    DataExchangeHttpRequest.onreadystatechange = openXlsPage;
    DataExchangeHttpRequest.open('POST', 'ExcelHandler.ashx', true);
    DataExchangeHttpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
    DataExchangeHttpRequest.setRequestHeader('Content-Length',data.length);

    DataExchangeHttpRequest.send(data);
    }
    function openXlsPage()
    {
        if (DataExchangeHttpRequest.readyState == 4 &amp;&amp; DataExchangeHttpRequest.status == 200)
        {
        window.open("ExcelHandler.ashx?openXls=true","xls");
        }
    }
    &lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
    &lt;form id="form1" runat="server"&gt;
    &lt;div&gt;
        &lt;button type="button" onclick="createXlsData()"&gt;Create XLS&lt;/button&gt;
    &lt;/div&gt;
    &lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre></div>

<p></p>

<p><strong><u>5. Der ASHX Handler</u></strong></p>

<p></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:beaeefaf-a211-4548-a23d-f06b921a7291" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;%@ WebHandler Language="C#" Class="ExcelHandler" %&gt;

using System;
using System.Web;

public class ExcelHandler : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {

        if (context.Request.Params["openXls"] == "true")
        {
            // display data
            if (context.Session["ExcelData"] != null)
            {
                context.Response.ContentType = "application/vnd.ms-excel";
                context.Response.ContentEncoding = System.Text.Encoding.Default;
                context.Response.Write(context.Session["ExcelData"]);
            }
            else
            {
                context.Response.Write("session empty");
            }
        }
        else
        {
            // save data in session
            context.Response.ContentType = "application/vnd.ms-excel";
            string data = "";
            using (System.IO.StreamReader reader = new System.IO.StreamReader(context.Request.InputStream))
            {
                data = reader.ReadToEnd();
            }

            context.Session.Add("ExcelData", data);
        }
    }
    public bool IsReusable {
        get {
            return true;
        }
    }

}</pre></div>

<p></p>

<p>Durch den Content Type &quot;application/vnd.ms-excel&quot; wird diese Javascript-generierte Tabelle von Excel erkannt.</p>

<p><strong><u>Schematische Darstellung</u></strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image369.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="379" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb348.png" width="459" border="0" /></a> </p>

<p><strong><u>Als Nutzer sieht das dann so aus</u></strong></p>

<p>Klicken:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image370.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="38" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb349.png" width="103" border="0" /></a> </p>

<p>Fenster &#246;ffnet sich:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image371.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="188" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb350.png" width="244" border="0" /></a> </p>

<p>Im Excel sieht das dann so aus:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image372.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb351.png" width="179" border="0" /></a> </p>

<p>Bei der momentanen L&#246;sung kommt da allerdings am Anfang noch eine Warnung, dass eine ASHX versucht was an Excel zu schicken - das bekommt man sicherlich auch noch irgendwie raus.</p>

<p><strong><u>Wo macht das Sinn?</u></strong></p>

<p>Das ganze macht da Sinn, wo man mit viel Javascript und AJAX sich Daten z.B. in einem JSON Objekt gesammelt hat und diese nun auch an Excel exportieren m&#246;chte - was bei uns der Fall war. Wenn man nat&#252;rlich die Daten aus einer DB holen kann, ist sowas nat&#252;rlich &#252;ber ein Postback oder wie auch immer &quot;sauberer&quot;.</p>

<p>Das ganze geh&#246;rt eindeutig in die Kategorie: <strong>Freakige Sachen ;)</strong></p>

<p>[ <a href="{{BASE_PATH}}/assets/files/democode/ajaxexcel/ajaxexcel.zip">Download Source</a> ]</p>
