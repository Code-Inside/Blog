---
layout: post
title: "HowTo: ASP.NET MVC Projekt erstellen (erster Einstieg)"
date: 2008-10-14 22:06
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, MVC; HowTo]
language: de
---
{% include JB/setup %}
<p>Im letzten <a href="{{BASE_PATH}}/2008/10/06/howto-aspnet-mvc-was-ist-es-und-warum-sollte-man-es-sich-anschauen/">MVC HowTo ging es um die Beweggründe für ASP.NET MVC</a> - heute werfen wir einen ersten Blick auf das MVC Framework. Das ganze werde ich direkt praktisch in meinem "<a href="{{BASE_PATH}}/category/howtocode/">ReadYou</a>" Projekt verwenden (das derzeit aufgrund von Zeitmangel etwas schleift).</p> <p><strong><u>Die Projektvorlage:</u></strong></p> <p>Wenn man sich die aktuelle <a href="http://www.asp.net/mvc/default.aspx?wwwaspnetrdirset=1">ASP.NET MVC Version runtergeladen hat</a> (momentan sind wir bei <a href="http://www.codeplex.com/aspnet/Wiki/View.aspx?title=MVC&amp;referringTitle=Home">Preview 5 auf Codeplex</a>) und ein neues Projekt anlegt, sieht man folgendes neue Item:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image550.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="248" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb528.png" width="387" border="0"></a></p> <p><strong><u>Anmerkung:</u></strong> Wenn man das deutsche Visual Studio benutzt, scheint die Projektvorlage nicht mit aufzutauchen, dazu muss man die Project- und Itemtemplates von 1033 in 1031 (<em>z. B. C:\Program Files (x86)\Microsoft Visual Studio 9.0\Common7\IDE\ProjectTemplates\CSharp\Web\1031 bzw. \1033</em>) kopieren und danach per Kommandozeile "devenv /installvstemplates" aufrufen. - Danke an "GarlandGreene" für den Hinweis.</p> <p>Nachdem man dies ausgewählt hat kommt dieses Fenster:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image551.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="264" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb529.png" width="394" border="0"></a></p> <p>Es wird angeboten sofort ein Unittest Projekt anzulegen. "Visual Studio Unit Test" (MS Test) ist per Default ausgewählt - später sollen allerdings noch weitere Test Frameworks (NUnit etc.) folgen.</p> <p><strong>Projektstruktur:</strong></p> <p>Nachdem die beiden Wizards durchgelaufen sind finden wir ungefähr (ich hab das UnitTest Projekt verschoben und umbenannt) so aus:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image552.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="363" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb530.png" width="192" border="0"></a></p> <p>Aus der Ordnerstruktur ist auch bereits das MVC zu erkennen:</p> <ul> <li><strong>Kurzüberblick:</strong>  <ul> <li>Controller: Logik  <li>Models: Die eigentlichen Businessdaten  <li>Views: Wie werden die Daten angezeigt </li></ul></li></ul> <p><strong>Views, Controller &amp; Model:</strong></p> <p>Im ausgelieferten Stand besitzt das Template 2 Controller, 3 View-Ordner und ein Model-Ordner:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image553.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb531.png" width="217" border="0"></a></p> <ul> <li>Im "<strong>Shared</strong>" Ordner werden alle Viewelemente gehalten, die für jeden View nützlich sind, wie z.B. die Masterpage oder eine Errorseite falls etwas schief läuft.  <li>Jeder Controller besitzt seinen eigenen Ordner ("<strong>Account</strong>Controller" - "<strong>Account</strong>" / "<strong>Home</strong>Controller" - "<strong>Home</strong>")  <li>Diese "Pfade" können allerdings über Interfaces angepasst werden - ein Beispiel findet man z.B. hier "<a href="http://blog.codeville.net/2008/07/30/partitioning-an-aspnet-mvc-application-into-separate-areas/">Partitioning an ASP.NET MVC application into separate "Areas"</a>" oder <a href="http://blog.wekeroad.com/blog/my-mvc-starter-template/">Rob Conery Version</a>.  <li>Im Models Ordner können normale Klassen gespeichert werden - allerdings kann man diesen Ordner auch leer lassen, wenn man für die normalen Klassen bereits eine Klassenbibliothek hat. </li></ul> <p><strong>Ein Blick auf die Seite:</strong></p> <p>Um einen ersten Blick auf die Funktionsweise des MVC Frameworks zu erhaschen ist die Startanwendung (welche bereits mit dem Membershipsystem, Masterpages etc.) ausgeliefert wird, ein guter Anfangspunkt:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image554.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="160" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb532.png" width="397" border="0"></a></p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image555.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="211" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb533.png" width="395" border="0"></a></p> <p><strong><u>Der Request Flow:</u></strong></p> <p><a href="http://www.codethinked.com/author/Justin%20Etheredge.aspx">Justin Etheredge</a> hat auf seinem Blog gut dargestellt, wie der Request einer MVC Anwendung verarbeitet wird und wo es überall die Möglichkeit gibt, selber einzugreifen: <a href="http://www.codethinked.com/post/2008/09/27/ASPNET-MVC-Request-Flow.aspx">ASP.NET MVC Request Flow </a></p> <p><strong><u>Kommunikation zwischen Controller und View: Vom Controller zum View</u></strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image559.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="151" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb537.png" width="541" border="0"></a></p> <p>&nbsp;</p> <p>Der Controller wird durch den Request Flow (siehe oben) aufgerufen - ich werde später noch eigene Controller in einem seperaten HowTo erstellen. Dabei kann man das ViewData Dictionary nutzen:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:74cd4e71-443f-4b20-afdb-3b53f3c81731" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre class="c#" name="code">public ActionResult Index()
        {
            ViewData["Title"] = "Home Page";
            ViewData["Message"] = "Welcome to ASP.NET MVC!";

            return View();
        }</pre></div>
<p>Durch den Aufruf der "<strong>View()</strong>"-Methode wird der View namens "<strong>Index</strong>" (weil die ControllerAction "<strong>Index</strong>" heisst) im "<strong>Home</strong>" Ordner aufgerufen (weil der Controller "<strong>Home</strong>" heisst).</p>
<p>Im View "Index.aspx" ist folgender Quellcode:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:11ac1b28-7c0c-448e-b6ec-4308d1624787" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre class="c#" name="code">&lt;%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="ReadYou.WebApp.Views.Home.Index" %&gt;

&lt;asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server"&gt;
    &lt;h2&gt;&lt;%= Html.Encode(ViewData["Message"]) %&gt;&lt;/h2&gt;
    &lt;p&gt;
        To learn more about ASP.NET MVC visit &lt;a href="http://asp.net/mvc" title="ASP.NET MVC Website"&gt;http://asp.net/mvc&lt;/a&gt;.
    &lt;/p&gt;
&lt;/asp:Content&gt;</pre></div>
<p>Durch das einbinden der Masterpage ("MasterPageFile") wird natürlich auch die Masterpage aufgerufen:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:77bf3548-3ca7-43ba-9bb5-69c8ba4b70bf" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre class="c#" name="code">...
&lt;head runat="server"&gt;
    &lt;meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /&gt;
    &lt;title&gt;&lt;%= Html.Encode(ViewData["Title"]) %&gt;&lt;/title&gt;
&lt;/head&gt;
...</pre></div>
<p>Die Daten in dem "ViewData" werden sowohl in der Masterpage als auch in dem eigentlichen View angezeigt - ähnlich wie bei klassischem ASP.</p>
<p><strong>Stark Typisierte Variante</strong></p>
<p>Da das Dictionary nicht besonderes typisiert ist, kann man natürlich die ViewData auch noch streng typisiert hinterlegen. Dafür muss man in der Codebehinde Datei der ViewPage, welche im Ausgangszustand so aussieht:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b0d4c0a1-26fd-409c-956d-d70dc9b3f4a8" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre class="c#" name="code">namespace ReadYou.WebApp.Views.Home
{
    public partial class Index : ViewPage
    {
    }
}
</pre></div>
<p>Einen eigenen ViewData Typ hinterlegen:</p>
<p>Index.aspx.cs:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:16d2c25a-102f-4351-a04a-71d7fccc2062" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre class="c#" name="code">namespace ReadYou.WebApp.Views.Home
{
    public class IndexViewData
    {
        public string Text { get; set; }
    }

    public partial class Index : ViewPage&lt;IndexViewData&gt;
    {
    }
}
</pre></div>
<p>Index.aspx:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:74ea2dce-f8d0-480b-868f-6e42a64c4877" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre class="c#" name="code">&lt;%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="ReadYou.WebApp.Views.Home.Index" %&gt;

&lt;asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server"&gt;
    &lt;h2&gt;&lt;%= Html.Encode(ViewData.Model.Text) %&gt;&lt;/h2&gt;
    &lt;p&gt;
        To learn more about ASP.NET MVC visit &lt;a href="http://asp.net/mvc" title="ASP.NET MVC Website"&gt;http://asp.net/mvc&lt;/a&gt;.
    &lt;/p&gt;
&lt;/asp:Content&gt;</pre></div>
<p>HomeController.cs:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3adeb871-fa85-44dc-b508-318a63a8d7c3" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre class="c#" name="code">        public ActionResult Index()
        {
            ViewData["Title"] = "Home Page";
            IndexViewData data = new IndexViewData();
            data.Text = "Hallo streng typisierter Text";
            ViewData.Model = data;
            return View();
        }</pre></div>
<p><u>Hinweis:</u> Das ViewData["Title"] wird nach wie vor von der Masterpage ausgewertet. In einer MVC Anwendung müssen <strong>alle</strong> Daten vom Controller übergeben werden - es existiert momentan (Preview 5) nur eine experimentelle Funktion, welche es erlaubt, dass der View sich Daten aus anderen Quellen holt - allerdings entspricht dies nicht der MVC Norm!</p>
<p><strong>Mehr Informationen</strong> findet man in dem Blogpost von Scott Guthrie (damals Preview 3 - Konzept ist gleich geblieben, manche Sachen sind allerdings geändert wurden):<br><a href="http://weblogs.asp.net/scottgu/archive/2007/12/06/asp-net-mvc-framework-part-3-passing-viewdata-from-controllers-to-views.aspx">ASP.NET MVC Framework (Part 3): Passing ViewData from Controllers to Views</a></p>
<p>&nbsp;</p>
<p><strong><u>Kommunikation zwischen Controller und View: Vom View zum Controller</u></strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image560.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="172" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb538.png" width="528" border="0"></a>&nbsp;</p>
<p>Der View kann über normale Links oder HTML Formulare die Daten an einen Controller schicken. Ein Beispiel ist bereits in dem Template eingebaut: Der Login-Mechanismus - dafür schauen wir uns die Login.aspx an:</p>
<p><strong>Variante 1: Per GET oder der "ActionLink"</strong></p>
<p>Für alle die noch nicht angemeldet sind, gibt es auf der Loginseite einen kleinen Link zum Registrieren:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image558.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="133" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb536.png" width="467" border="0"></a></p>
<p>Im Code:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d5c1306b-70b8-4cb0-a9b3-62c5f8d9a11d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre class="c#" name="code">&lt;p&gt;
        Please enter your username and password below. If you don't have an account,
        please &lt;%= Html.ActionLink("register", "Register") %&gt;.
    &lt;/p&gt;</pre></div>
<p>Dieser Html Helper generiert den Link damit die Daten beim Klicken zum "AccountController" (der View befindet sich im "Account" Ordner) zur "Register" ActionMethode kommen.</p>
<p><strong>Variante 2: Per POST</strong></p>
<p>Der Username / Password wird in einem normalen Html Forumlar eingegeben:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4b1cf111-4e8a-4e15-a96b-854da3911470" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre class="c#" name="code">    &lt;form method="post" action="&lt;%= Html.AttributeEncode(Url.Action("Login")) %&gt;"&gt;
        &lt;div&gt;
            &lt;table&gt;
                &lt;tr&gt;
                    &lt;td&gt;Username:&lt;/td&gt;
                    &lt;td&gt;&lt;%= Html.TextBox("username") %&gt;&lt;/td&gt;
                &lt;/tr&gt;
                &lt;tr&gt;
                    &lt;td&gt;Password:&lt;/td&gt;
                    &lt;td&gt;&lt;%= Html.Password("password") %&gt;&lt;/td&gt;
                &lt;/tr&gt;
                &lt;tr&gt;
                    &lt;td&gt;&lt;/td&gt;
                    &lt;td&gt;&lt;input type="checkbox" name="rememberMe" value="true" /&gt; Remember me?&lt;/td&gt;
                &lt;/tr&gt;
                &lt;tr&gt;
                    &lt;td&gt;&lt;/td&gt;
                    &lt;td&gt;&lt;input type="submit" value="Login" /&gt;&lt;/td&gt;
                &lt;/tr&gt;
            &lt;/table&gt;
        &lt;/div&gt;
    &lt;/form&gt;</pre></div>
<p>Die action-URL wird wieder über einen Html Helper generiert. Wenn der Nutzer das Formular abschickt, kommen die Daten in der "Login" ActionMethode des "AccountControllers" an:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b5520bfc-d749-4a9d-ac1c-79c68bee2348" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre class="c#" name="code">        public ActionResult Login(string username, string password, bool? rememberMe)
        {

            ViewData["Title"] = "Login";

            // Non-POST requests should just display the Login form 
            if (Request.HttpMethod != "POST")
            {
                return View();
            }

            // Basic parameter validation
            List&lt;string&gt; errors = new List&lt;string&gt;();

            if (String.IsNullOrEmpty(username))
            {
                errors.Add("You must specify a username.");
            }
...
        }</pre></div>
<p>Es gibt im MVC Framework einen eingebauten Mechanismus, der Formularwerte direkt auf Methoden-Parameter mappen kann (dies ist (natürlich) auch anpassbar). Dies ist nützlich, damit man die Methode besser mit UnitTests testen kann und kein Request Objekt sich erzeugen muss, sondern nur die Parameter entsprechend befüllen.</p>
<p>In der Methode werden Validierungen etc. vorgenommen. Man kann hier auch auf das normale Request Objekt zugreifen - allerdings sollte man um eine hohe Testbarkeit zu erreichen nicht direkt auf die Request Parameter zugreifen, sondern versuchen das Parametermapping zu verwenden. <a href="http://weblogs.asp.net/stephenwalther/archive/2008/07/11/asp-net-mvc-tip-18-parameterize-the-http-context.aspx">Stephen Walther</a> hat dazu ein netten Blogpost darüber geschrieben.</p>
<p>Die Html Helper können auch "streng typisierte" sein und somit braucht man nicht unbedingt mit Strings Arbeiten (bei dem Actionlink z.B. direkt den Methodenaufruf über eine Expression anstatt "Register" als String zu schreiben) - <a href="http://www.asp.net/learn/mvc-videos/video-361.aspx?redir=true">Scott Hanselman hat einen Screencast</a> dazu gemacht.</p>
<p><strong><u>"Best Practices", Tipps und Anlaufstellen</u></strong></p>
<p>Da das MVC Framework noch nicht mal Beta ist, gibt es natürlich noch keine "Best Practices" - allerdings gibt es bereits mehrere interessante Projekte, welche mit MVC erstellt werden und Tipps geben:</p>
<ul>
<li><a href="http://weblogs.asp.net/stephenwalther/">Stephen Walthers Blog</a> 
<li><a href="http://blog.wekeroad.com/mvc-storefront/">Rob Conerys MVC Storefront</a> 
<li><a href="http://www.hanselman.com/blog/CategoryView.aspx?category=ASP.NET+MVC">Scott Hanselman</a> 
<li><a href="http://weblogs.asp.net/scottgu/archive/tags/MVC/default.aspx">Scott Guthrie</a> 
<li><a href="http://www.asp.net/mvc/default.aspx?wwwaspnetrdirset=1">ASP.NET MVC Seite</a> 
<li><a href="http://forums.asp.net/1146.aspx">ASP.NET MVC Forum</a> 
<li><a href="http://www.asp.net/learn/mvc-videos/">ASP.NET MVC Videos</a> 
<li><a href="http://www.dotnetkicks.com/tags/MVC">DotNetKicks - MVC</a> </li></ul>
<p>Im nächsten HowTo werde ich dann genauer auf einzelne Teile eingehen - dies soll als Einstieg genügen.</p>
