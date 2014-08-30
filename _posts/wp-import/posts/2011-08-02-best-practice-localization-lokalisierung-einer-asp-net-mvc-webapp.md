---
layout: post
title: "Best Practice Localization: Lokalisierung einer ASP.NET MVC WebApp"
date: 2011-08-02 23:21
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, Globalization, Localization, Lokalisierung]
---
{% include JB/setup %}
<p>(<a href="http://www.flickr.com/photos/usaid_images/5012422171/">Featured Foto Quelle</a>)</p> <p>Da es häufiger vorkommt, dass eine Website sowohl auf englisch als auch auf deutsch verfügbar sein muss (und mehr!), wollte ich mit diesen Blogpost die wichtigsten Best-Practices versuchen wiedergeben. Ich hatte bereits zu dem Thema einen <a href="{{BASE_PATH}}/2009/11/05/howto-globalizationlocalization-mit-asp-net-mvc/">älteren Blogpost</a> geschrieben, dieser ist aber nicht mehr ganz aktuell.</p> <p><strong>Was kann man alles mit “Standardmitteln” lokalisieren?</strong></p> <p>Das augenscheinlichste sind natürlich einfache Texte, welche über Resource Files (ich gehe mal davon aus, dass der Umgang damit bekannt ist. Ansonsten nach .resx suchen) ausgelesen werden. Ein weiteres großes Kapitel ist die Ausgabe von Beschreibungstexten für das Model bzw. Validierungsfehler.</p> <p><strong>Sample App</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1311.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 5px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb493.png" width="224" height="397"></a></p> <p>Angehangen an den Blogpost ist auch eine Sample App, welche allerdings noch keine Resourcen für Modelbeschreibungen bzw. für die Validierung nutzt – allerdings ist das schon mal ein guter Ausgangspunkt.</p> <p>Die Gelb markierten Sachen sind "besonders wichtig”. Der andere Source Code kommt entweder mit dem Template mit oder er hat sich in größeren Projekten als ganz nützlich herausgestellt – auch wenn es etwas nach Raketenwissenschaft aussieht.</p> <p>Wichtigster Teil: Der CurrentLanguageStore. Diese Komponente kann ich aufrufen um herauszufinden welche Sprache der User hat (diese Information schickt der Browser z.B. mit) oder ob der User explizit eine andere Sprache gewählt hat – dann kommt diese in meinem Beispiel aus dem Cookie.</p> <p>Eine WebApp kann nicht alle Sprachen unterstützen, daher muss irgendwo festgelegt werden, welche Sprachen definitiv unterstützt werden. Dies habe ich über ein Enum namens “LanguageKey” realisiert.</p> <p>&nbsp;</p> <p><strong>CurrentLanguageStore</strong></p> <p>Der CurrentLanguageStore besitzt zwei Methoden:</p> <p>- GetPreferredLanguage: Gib die bevorzugte Sprache des Nutzers zurück. </p> <p>- SetPreferredLanguage: Setze die bevorzugte Sprache explizit.</p> <p>Der Code ist etwas größer, weil er aus einem anderen Projekt ist und ich dort via <a href="{{BASE_PATH}}/2010/03/15/howto-dependency-injection-service-locator/">Dependency Injection</a> die benötigten Komponenten mit reinlade. Die “<strong>GetPreferredLanguage</strong>” Methode sucht nach einem Cookie und ob in diesem Cookie eine valide Sprache abgespeichert ist. Das Cookie kommt nur zum Tragen wenn ein User explizit (z.B. in einem Internet-Cafe) eine andere Sprache haben möchte als der Browser. Dieses Setzen erfolgt bei der “<strong>SetPreferredLanguage</strong>” Methode. Da ich an der Stelle viel mit Cookies arbeite, habe ich mir einen kleinen Helper gebaut. Den braucht man allerdings nicht unbedingt – man kann diese Speicherung auch <a href="{{BASE_PATH}}/2009/06/10/howto-cookies-mit-aspnet-mvc-erstellen-entfernen/">pur</a> vornehmen.</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:19f07c2f-07f1-4c0f-b28a-70c85200ca9b" class="wlWriterEditableSmartContent"><pre name="code" class="c#">
    public class CurrentLanguageStore
    {
        /// &lt;summary&gt;
        /// Cookie Repository for getting and setting cookie values.
        /// &lt;/summary&gt;
        private ICookieRepository _cookieRep;

        /// &lt;summary&gt;
        /// HttpContext for accessing the HttpRequests UserLanguages
        /// &lt;/summary&gt;
        private HttpContextBase _context;

        public CurrentLanguageStore()
        {
            this._cookieRep = new HttpCookieRepository();
            this._context = new HttpContextWrapper(HttpContext.Current);
        }

        /// &lt;summary&gt;
        /// Default ctor for a new instance.
        /// &lt;/summary&gt;
        /// &lt;param name="baseContext"&gt;HttpBaseContext for accessing the HttpRequest.&lt;/param&gt;
        /// &lt;param name="cookieRepository"&gt;Implementation of ICookieRepository.&lt;/param&gt;
        public CurrentLanguageStore(HttpContextBase baseContext, ICookieRepository cookieRepository)
        {
            _cookieRep = cookieRepository;
            _context = baseContext;
        }

        /// &lt;summary&gt;
        /// Gets the preferred language.
        /// &lt;/summary&gt;
        /// &lt;returns&gt;&lt;/returns&gt;
        public LanguageKey GetPreferredLanguage()
        {
            string[] browserLanguages = this._context.Request.UserLanguages;

            if (this._cookieRep.HasElement(CookieKey.UserLanguage))
            {
                string cookieResult = this._cookieRep.GetElement(CookieKey.UserLanguage);

                if (string.IsNullOrWhiteSpace(cookieResult))
                    return LanguageKey.En;

                if (cookieResult.ToLower() == LanguageKey.De.ToString().ToLower())
                    return LanguageKey.De;

                return LanguageKey.En;
            }

            if (browserLanguages == null)
                return LanguageKey.En;

            foreach (var language in browserLanguages)
            {
                if (language.StartsWith(LanguageKey.De.ToString().ToLower()))
                    return LanguageKey.De;
                else if (language.StartsWith(LanguageKey.En.ToString().ToLower()))
                    return LanguageKey.En;
            }

            return LanguageKey.En;

        }

        public void SetPreferredLanguage(LanguageKey key)
        {
            if (this._cookieRep.HasElement(CookieKey.UserLanguage))
            {
                this._cookieRep.UpdateElement(CookieKey.UserLanguage, key.ToString());
            }
            else
            {
                this._cookieRep.AddElement(CookieKey.UserLanguage, key.ToString());
            }
        }
    }</pre></div>
<p><strong></strong>&nbsp;</p>
<p>Meine Anwendung unterstützt nur Deutsch und Englisch – auch der regional Code z.B. für de-AT ist mir an der Stelle egal, wäre aber auch möglich.</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:84460820-6846-472b-90ba-b1b53e1719ce" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    public enum LanguageKey
    {
        De = 1031,
        En = 1033
    }</pre></div>
<p>&nbsp;</p>
<p>Das ist im Grunde die Infrastruktur (+ die Hilfsklassen für den Zugriff auf das Cookie) um die Lokalisierung zu machen.</p>
<p><strong>Der LanguageController</strong></p>
<p>Der LanguageController hat nur die Aufgabe dem Benutzer ein UI-Element anzuzeigen um die Sprache zu wechseln und den Aufruf auch an den CurrentLanguageStore weiterzugeben.</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:cf4fc8ac-2d37-429a-bed6-2a1684cb235f" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public class LanguageController : Controller
    {
        private CurrentLanguageStore _languageStore;

        public LanguageController()
        {
            this._languageStore = new CurrentLanguageStore();
        }

        public RedirectToRouteResult SwitchLanguage(LanguageKey key)
        {
            this._languageStore.SetPreferredLanguage(key);
            return RedirectToAction("Index", "Home");
        }

        public ActionResult LanguageBox()
        {
            LanguageKey languageNow = this._languageStore.GetPreferredLanguage();

            if (languageNow == LanguageKey.De) ViewBag.AvailableLanguage = LanguageKey.En;
            else ViewBag.AvailableLanguage = LanguageKey.De;

            return View();
        }</pre></div>
<p>&nbsp;</p>
<p><strong>Der View zur LanguageBox:</strong></p>
<p>Der Code hier ist nicht besonders schön (und geht schon schief wenn ich nur eine weitere Sprache unterstützen möchte), aber an der Stelle gibt es für euch noch Potenzial zum Verbessern <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images/wlEmoticon-winkingsmile9.png"></p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:741f2376-f8c4-4e99-8727-70330d35cdeb" class="wlWriterEditableSmartContent"><pre name="code" class="c#">@using MvcLocalization.WebApp.Infrastructure
@{
        Layout = "";
        var availableLanguageText = "";
        var availableLanguage = LanguageKey.De;
        if(ViewBag.AvailableLanguage == LanguageKey.De)
        {
            availableLanguageText = "Deutsch";
            availableLanguage = LanguageKey.De;
        } 
        else
        {
            availableLanguageText = "English";
            availableLanguage = LanguageKey.En;
        }
}

@Html.ActionLink(availableLanguageText, "SwitchLanguage", "Language", new { key = availableLanguage.ToString() }, null)</pre></div>
<p><strong></strong>&nbsp;</p>
<p><strong></strong>&nbsp;</p>
<p><strong>Ganz wichtig: Anwendung des CurrentLanguageStore über einen BaseController</strong></p>
<p>In dem alten Blogpost habe ich geschrieben, dass man nun den CurrentLanguageStore in einem ActionFilter einsetzen kann und dort die CurrentCulture des Threads zu manipulieren. Allerdings ist dieser Weg <strong>nicht richtig</strong>! </p>
<p><strong>Grund:</strong> Das Modelbinding + die Validierung wird ausgeführt bevor die ActionFilter zum Tragen kommen, daher muss die Lokalisierung vorher passieren!</p>


<p>Abhilfe schafft das Überschreiben der ExecuteCore Methode in einem Basis-Controller.</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:29212d3d-6c6f-499b-af1c-751fcb886e6e" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    public class BaseController : Controller
    {
        protected override void ExecuteCore()
        {
            CurrentLanguageStore store = new CurrentLanguageStore();
            LanguageKey key = store.GetPreferredLanguage();
            CultureInfo language = new CultureInfo(key.ToString());

            Thread.CurrentThread.CurrentCulture = language;
            Thread.CurrentThread.CurrentUICulture = language;
            base.ExecuteCore();
        }

    }</pre></div>
<p>&nbsp;</p>
<p><strong>Die Anwendung</strong></p>
<p>Damit sollte ich nun in der Lage sein, einfach über Resourcen Dateien meine Texte sowohl im Model als auch im View zu lokalisieren. Eine größere Beschreibung zum Thema findet sich auch auf <a href="http://afana.me/post/aspnet-mvc-internationalization.aspx">diesem Blog</a> – von der Herangehensweise ist es ähnlich wie meine Variante. Allerdings dort bereits mit Model-Lokalisierung ausgestattet –<u> ein Blick lohnt</u>!</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:fa1b56d5-7236-4756-a9fa-5f8a1d63d3e8" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;p&gt;
    @TestResource.Title
&lt;/p&gt;
</pre></div>
<p>&nbsp;</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvclocalization/mvclocalization.zip">[ Download Democode ]</a></strong></p>
