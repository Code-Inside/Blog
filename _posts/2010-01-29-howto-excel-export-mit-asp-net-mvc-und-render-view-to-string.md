---
layout: post
title: "HowTo: Excel Export mit ASP.NET MVC und &quot;Render View To String&quot;"
date: 2010-01-29 01:29
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo; ASP.NET MVC; MVC; Excel]
---
<p><a href="{{BASE_PATH}}/assets/wp-images/image910.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="107" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb95.png" width="147" align="left" border="0"></a>Man kann relativ einfach auf seiner Seite einen Excel-Export bei tabellarischen Daten anbieten ohne großartige SDKs zu wälzen. Excel versteht von Haus aus auch HTML Tabellen. Man ist zwar eingeschränkt, aber es ist schnell gemacht. Bei einer ASP.NET MVC Anwendung wäre es nun noch schön, dass man das Markup der HTML Tabelle als View speichert. Über eine kleine Extension kann man sich den View auch als String ausgeben lassen.</p><!--more--> <p><strong>Unser Ziel: Excel Export</strong></p> <p>Wir möchten auf unserer Webseite einen Excelexport anbieten. Etwas ähnliches, nur etwas kurioser gemacht, habe ich auch <a href="http://code-inside.de/blog/2008/04/03/howto-excel-export-via-ajax/">schonmal auf dem Blog</a> geschrieben.</p> <p><strong>Was muss man dafür tun?</strong></p> <p>Im Grunde reicht es aus, wenn man in die Response eine HTML Tabelle rendert und als Contenttype "application/ms-excel" angibt. Wir möchten aber die Tabelle als View speichern um Sie einfacher editieren zu können und nicht hardcoded im Source Code zu pflegen.</p> <p><strong>RenderViewToString</strong></p> <p>Wir benötigen zu aller erst eine Komponente die einen View als String uns zurückgibt. Wichtig dabei ist, dass die Response während des Vorgangs nicht schon zum Client geschickt wird (<a href="http://msdn.microsoft.com/en-us/library/ms525560.aspx">Response.Flush()</a>), da man ansonsten den Contenttyp nicht mehr ändern kann! Eine der Lösungen in <a href="http://stackoverflow.com/questions/483091/render-a-view-as-a-string">diesem Thread</a> hat auch funktioniert - in ASP.NET MVC 2.0 muss man allerdings eine kleine Sache ändern -&gt; Siehe <a href="http://stackoverflow.com/questions/483091/render-a-view-as-a-string/1241257#1241257">Stackoverflow</a>.</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:754dc310-13cf-480c-8363-04be58ac17dd" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">/// &lt;summary&gt;Renders a view to string.&lt;/summary&gt;
public static string RenderViewToString(this Controller controller,
                                        string viewName, object viewData) {
    //Create memory writer
    var sb = new StringBuilder();
    var memWriter = new StringWriter(sb);

    //Create fake http context to render the view
    var fakeResponse = new HttpResponse(memWriter);
    var fakeContext = new HttpContext(HttpContext.Current.Request, fakeResponse);
    var fakeControllerContext = new ControllerContext(
        new HttpContextWrapper(fakeContext),
        controller.ControllerContext.RouteData,
        controller.ControllerContext.Controller);

    var oldContext = HttpContext.Current;
    HttpContext.Current = fakeContext;

    //Use HtmlHelper to render partial view to fake context
    var html = new HtmlHelper(new ViewContext(fakeControllerContext,
        new FakeView(), new ViewDataDictionary(), new TempDataDictionary()),
        new ViewPage());
    html.RenderPartial(viewName, viewData);

    //Restore context
    HttpContext.Current = oldContext;    

    //Flush memory and return output
    memWriter.Flush();
    return sb.ToString();
}

/// &lt;summary&gt;Fake IView implementation used to instantiate an HtmlHelper.&lt;/summary&gt;
public class FakeView : IView {
    #region IView Members

    public void Render(ViewContext viewContext, System.IO.TextWriter writer) {
        throw new NotImplementedException();
    }

    #endregion
}
</pre></div>
<p>Nun können wir über diese Methode einen String aus einem View erzeugen - schonmal nicht schlecht.</p>
<p>Jetzt kann man entweder direkt das <a href="http://msdn.microsoft.com/en-us/library/system.web.mvc.contentresult.aspx">ContentResult</a> nutzen oder man baut sich sein eigens <a href="http://stephenwalther.com/blog/archive/2008/06/16/asp-net-mvc-tip-2-create-a-custom-action-result-that-returns-microsoft-excel-documents.aspx">ExcelResult</a>:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:09b89d88-fede-4725-a128-00b8acb50f64" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public class ExcelResult : ActionResult
    {
        public string FileName { get; set; }
        public string Content { get; set; }

        public ExcelResult(string filename, string content)
        {
            this.FileName = filename;
            this.Content = content;
        }

        public override void ExecuteResult(ControllerContext context)
        {
            WriteFile(this.FileName, "application/ms-excel", this.Content);
        }

        private static void WriteFile(string fileName, string contentType, string content)
        {

            HttpContext context = HttpContext.Current;
            context.Response.Clear();
            context.Response.AddHeader("content-disposition", "attachment;filename=" + fileName);
            context.Response.Charset = "";
            context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            context.Response.ContentType = contentType;
            context.Response.Write(content);
            context.Response.End();
        }
    }</pre></div>
<p><strong>Die Anwendung</strong></p>
<p>Folgender <strong>View</strong> ist unser Exceltemplate (mit einem ViewModel)</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b1a8fc2f-c508-4d68-9930-e8d29d870063" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">%@ Import Namespace="MvcRenderToString.Models"%&gt;
&lt;%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl&lt;IList&lt;ExcelData&gt;&gt;" %&gt;

&lt;table&gt;
    &lt;tr&gt;
        &lt;% foreach(ExcelData excel in Model) { %&gt;
        &lt;td&gt;&lt;%=excel.Foobar %&gt;&lt;/td&gt;
        &lt;% } %&gt;
    &lt;/tr&gt;
&lt;/table&gt;</pre></div>
<p><strong>Und der Controller:</strong></p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1595e2ed-5345-4f9e-a466-75d03b545156" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        public ExcelResult Excel()
        {
            List&lt;ExcelData&gt; foobars = new List&lt;ExcelData&gt;();
            foobars.Add(new ExcelData() { Foobar = "HelloWorld!"});
            foobars.Add(new ExcelData() { Foobar = "HelloWorld!" });
            foobars.Add(new ExcelData() { Foobar = "HelloWorld!" });
            foobars.Add(new ExcelData() { Foobar = "HelloWorld!" });

            string content = this.RenderViewToString("Excel", foobars);
            return new ExcelResult("Foobar.xls", content);
        }</pre></div>
<p><strong>Das Ergebnis:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image911.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="176" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb96.png" width="244" border="0"></a> </p>
<p>Einziges Manko ist, dass Excel dem nicht ganz vertraut. Leider ist das <a href="http://blogs.msdn.com/vsofficedeveloper/pages/Excel-2007-Extension-Warning.aspx">ByDesign</a> so:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image912.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="75" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb97.png" width="520" border="0"></a> </p>
<p>Bei Bestätigung auf "Ja":</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image913.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="323" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb98.png" width="465" border="0"></a> </p>
<p>Fetzt, oder?</p>
<p><strong>Weitere Anwendungsmöglichkeiten</strong></p>
<p>Dadurch das wir eine HTML Tabelle benutzen, können wir die Tabelle auch genauso auf unserer normalen Webseite benutzen. Hierbei Rufe ich dann einfach RenderPartial etc. auf.</p>
<p>Man könnte so auch Email Templates als View ablegen. Die Möglichkeiten sind jedenfalls da :)</p>
<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/mvcrenderviewtostring/mvcrendertostring.zip">[ Download Democode ]</a></strong></p>
