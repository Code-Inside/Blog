---
layout: post
title: "HowTo: Dynamischen Content auf ASP.NET MVC Masterpages bringen"
date: 2009-01-22 02:31
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC; MVC, HowTo]
---
<p>In fast jedem ASP.NET Projekt wird es eine Masterpage geben und diese wird was &quot;dynamisches&quot; Anzeigen - sei es eine Tagcloud oder allein der Seitentitel. Allerdings ist sowas im MVC Sinne nicht ganz trivial. Ich arbeite gerade in einem kleinen Projekt mit dem <a href="http://www.asp.net/mvc">ASP.NET MVC</a> Framework &#252;ber das ich schon <a href="http://code-inside.de/blog/2008/10/14/howto-aspnet-mvc-erstellen-erster-einstieg/">ab und an mal</a> gebloggt habe. </p> 
<!--more-->
  <p>Zwei Beispiele von solch einem dynamischen Content:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image592.png"><a href="{{BASE_PATH}}/assets/wp-images/image593.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb570.png" width="237" border="0" /></a></a>&#160; </p>  <p><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="32" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb571.png" width="244" border="0" /></p>  <p>ASP.NET mit seinem Control System l&#228;sst sowas sehr einfach zu. Jedes Control ist f&#252;r seine Datenbeschaffung selbst zust&#228;ndig.   <br />Das MVC Pattern besagt jedoch, dass alle Daten von einem Controller kommen und der View diese nur anzeigt. Daten &#252;ber die Codebehind auf eine Masterpage schreiben geht auch in ASP.NET MVC - allerdings verfehlt man damit etwas das MVC Konzept.     <br /><a href="http://weblogs.asp.net/stephenwalther/archive/2008/08/12/asp-net-mvc-tip-31-passing-data-to-master-pages-and-user-controls.aspx">Stephen Walther</a> hat eine recht &quot;komplexe&quot; L&#246;sung aufgezeigt - die sicherlich dem &#228;hnelt was ich hier beschreibe.</p>  <p><strong>Was wollen wir erreichen?</strong></p>  <p>Wir wollen die Standard ASP.NET MVC Vorlage etwas &quot;dynamischer&quot; machen, die rot umrahmten Teile wollen wir durch dynamischen Content ersetzen:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image594.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="108" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb572.png" width="244" border="0" /></a> <a href="{{BASE_PATH}}/assets/wp-images/image595.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="104" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb573.png" width="244" border="0" /></a> </p>  <p><strong>Die Start-Projektstruktur:</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image596.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb574.png" width="212" border="0" /></a> </p>  <p><strong>Schritt 1: ViewData &quot;Objekthierarchie&quot; anlegen</strong></p>  <p>Wenn man Masterpage nutzt, hat die Masterpage bestimmte Daten und die eigentliche Seite auch ihre Daten zum anzeigen - es kommt zu einer Hierarchie, die wir erstmal relativ simpel abbilden:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image597.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="79" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb575.png" width="244" border="0" /></a> </p>  <p>ViewDataBase ist unser &quot;Root&quot; Objekt...</p>  <p>   <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:930c8418-2aa6-4fcb-96fd-0e74c0d661f7" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class ViewDataBase
    {
        public SiteMasterViewData SiteMasterViewData { get; set; }
    }</pre></div>
</p>

<p>... dieses Enth&#228;lt auch ein spezielles Objekt f&#252;r die Site.Master um z.B. den Titel dynamisch zu &#228;ndern:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:387c22f5-f583-4aa2-a853-a287969049f4" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class SiteMasterViewData
    {
        public string Title { get; set; }
    }</pre></div>

<p><strong>Schritt 2: Strongly-Typed Viewdata in der Masterpage registrieren</strong></p>

<p>Damit die Site.Master das nun auch mitbekommt, nehmen wir die ViewDataBase als Viewdata Typ:</p>

<p>
  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5c635c30-70f9-4b59-8bad-b1eac12b2585" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public partial class Site : System.Web.Mvc.ViewMasterPage&lt;ViewDataBase&gt;
    {
    }</pre></div>
</p>

<p>... und zeigen im Frontend den Titel an:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1d1f8955-cb1c-4fa4-9aec-ed6b86e38a94" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            &lt;div id="title"&gt;
                &lt;h1&gt;&lt;%= Html.Encode(ViewData.Model.SiteMasterViewData.Title) %&gt;&lt;/h1&gt;
            &lt;/div&gt;</pre></div>

<p><strong>Schritt 3: ActionFilter f&#252;gen Masterpage Daten hinzu</strong></p>

<p>ActionFilter sind ein netter ASP.NET MVC Mechanismus: &#220;ber so genannte Filter kann man das Ergebnis eines Requests vor dem Eintreffen auf die eigentliche Action Methode beeinflussen oder hinterher (z.B. <a href="http://code-inside.de/blog/2008/04/17/aspnet-mvc-actionfilter-zum-loggen-benutzen/">siehe hier</a>). Dazu f&#252;gen wir einen Ordner &quot;Filters&quot; hinzu:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image598.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="115" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb576.png" width="244" border="0" /></a> </p>

<p>Hier f&#252;gen wir nun dem &quot;<strong>TempData</strong>&quot; ein Eintrag namens &quot;<strong>ViewData</strong>&quot; mit einem dynamischen Seitentitel (&quot;Master Dynamisch + Datum&quot;) vor dem eigentlichen Methodenaufruf hinzu:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1b9ed230-b240-4b23-ac13-4f897579855d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            ViewDataBase data = new ViewDataBase();
            data.SiteMasterViewData = new SiteMasterViewData();
            data.SiteMasterViewData.Title = "Master Dynamisch @ " + DateTime.Now.ToShortDateString();

            // remove existing viewdata
            filterContext.Controller.TempData.Remove("ViewData");

            filterContext.Controller.TempData.Add("ViewData", data);
        }</pre></div>

<p><strong>Schritt 4: &quot;Home&quot; Views vorbereiten</strong></p>

<p>Bevor wir weitermachen, hinterlegen wir f&#252;r die beiden Home-Views jeweils eine ViewData Typ Klasse, welche von ViewDataBase ableitet:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image599.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="63" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb577.png" width="150" border="0" /></a> </p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image600.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="132" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb578.png" width="244" border="0" /></a> </p>

<p>Hier am Beispiel der AboutViewData:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:12fea772-36d0-45b8-9375-c30326445553" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class AboutViewData : ViewDataBase
    {
        public AboutViewData(SiteMasterViewData siteMaster)
        {
            base.SiteMasterViewData = siteMaster;
        }

        public string Text { get; set; }
    }</pre></div>

<p>In der About.aspx muss es wie folgt aussehen:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:676eb932-126e-4aa7-a11c-75fe59e562a6" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;h2&gt;&lt;%= Html.Encode(ViewData.Model.Text) %&gt;&lt;/h2&gt;
    &lt;p&gt;
        TODO: Put &lt;em&gt;about&lt;/em&gt; content here.
    &lt;/p&gt;</pre></div>

<p><strong>Schritt 5: HomeController mit Filter dekorieren</strong></p>

<p>&#220;ber den HomeController setzen wir nun noch unseren Filter, der unseren tollen Titel mitgibt:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c3721370-5ee2-4a20-b16d-bd150b871f83" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    [HandleError]
    [AddSiteMasterViewData]
    public class HomeController : Controller
    {</pre></div>

<p><strong>Schritt 6: Action Methods anpassen</strong></p>

<p>Nun m&#252;ssen noch die ActionMethods angepasst werden. Dazu holen wir uns die ViewDataBase Daten aus dem TempData, welches in dem &quot;AddSiteMasterViewData&quot; Filter bef&#252;llt wird und bef&#252;llen das IndexViewData bzw. das AboutViewData Objekt .</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:405f70cc-e653-4446-9b50-63c66a6a9cf4" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        public ActionResult Index()
        {
            ViewDataBase masterData = (ViewDataBase)this.ControllerContext.Controller.TempData["ViewData"];

            IndexViewData viewData = new IndexViewData(masterData.SiteMasterViewData);
            viewData.Text = "Welcome to ASP.NET MVC!";

            return View(viewData);
        }

        public ActionResult About()
        {
            ViewDataBase masterData = (ViewDataBase)this.ControllerContext.Controller.TempData["ViewData"];

            AboutViewData viewData = new AboutViewData(masterData.SiteMasterViewData);
            viewData.Text = "About Page";

            return View(viewData);
        }</pre></div>

<p><strong>Ergebnis:</strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image601.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="83" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb579.png" width="244" border="0" /></a> </p>

<p>Der Content ist nun dynamisch und beide Werte k&#246;nnen angepasst werden. Man baut sich dadurch eine Hierarchie auf - in unserem Beispiel:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image602.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="379" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb580.png" width="505" border="0" /></a> </p>

<p>Allerdings k&#246;nnte man auch zwei oder drei Masterpages verschachteln - ActionFilter werden nacheinander abgearbeitet, d.h. man k&#246;nnte also auch sowas sich zusammenbauen:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image603.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="363" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb581.png" width="484" border="0" /></a> </p>

<p><em>Notiz am Rande: Eigentlich wollte ich auch zwei Masterpages verschachteln - dann h&#228;tte man so eine Hierarchie wie in diesem Bild gesehen. Allerdings ist der Text ohnehin schon lang genug, aber f&#252;r das Funktionsprinzip sollte es ausreichen :)</em></p>

<p><strong>Negatives und Positives</strong></p>

<p>Ich muss allerdings zugeben, dass ich nicht restlos mit der L&#246;sung zufrieden bin. Das schreiben in dieses &quot;TempData&quot; (das wohl wahrscheinlich wegen solchen F&#228;llen auch mit erschaffen wurde) gef&#228;llt mir nicht. Das Gute daran ist allerdings, dass man in einem nachfolgenden Filter wieder einlesen kann und entsprechend darauf reagieren.
  <br />Der &quot;SiteMasterFilter&quot; k&#246;nnte z.B. pr&#252;fen ob der Nutzer gerade angemeldet ist oder nicht - dies kann dann der nachfolgende Filter oder die Action Method auch wieder nutzen.</p>

<p>So ganz gl&#252;cklich bin ich mit den Bezeichnungen auch nicht. Allerdings wenn man sich vorher Gedanken macht, was man entsprechend braucht, kann man damit robuste L&#246;sungen auf Basis von MVC entwickeln. Die Filter kann man auch &#252;ber Unit-Tests testen.</p>

<p><strong>Um es Einzusetzen ist allerdings solch eine Hierachie Pflicht.</strong> Wenn ich den mitgelieferten Account Controller <strong>nur</strong> mit dem SiteMaster Filter ausstatte, passiert noch garnix - in meiner jetzigen Version crasht daher auch der Account Controller, weil er eben nicht die SiteMasterViewData mitliefert.</p>

<p>Was haltet ihr von der L&#246;sung? Gut, Schlecht, Mittel oder gar Epic Fail? Wenn jemand (im MVC Sinne) eine andere gute L&#246;sung hat, dann immer her damit :)</p>

<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/mvcnestedmasterpagesdynamiccontent/mvcnestedmasterpagesdynamiccontent.zip">[ Download Demosource ]</a></strong></p>
