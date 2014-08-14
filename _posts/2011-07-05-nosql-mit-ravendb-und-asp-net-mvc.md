---
layout: post
title: "NoSQL mit RavenDB und ASP.NET MVC"
date: 2011-07-05 00:15
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, HowTo, NoSQL, RavenDB]
---
{% include JB/setup %}
<p>Lange, lange Zeit (jedenfalls für mich <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images/wlEmoticon-winkingsmile4.png"> ) galt, dass Daten ganz klar in eine Datenbank kommen. Die Daten werden gewöhnlich in einer relationalen Datenbank gespeichert und miteinander verknüpft. Seit einiger Zeit jedoch gibt es “Widerstand” – <a href="http://en.wikipedia.org/wiki/NoSQL">NoSQL</a> ist das Stichwort. </p> <p><strong>Was sind NoSQL Datenbanken?</strong></p> <p>Es gibt verschiedenste Ausprägung von NoSQL Datenbanken – für einen <a href="http://en.wikipedia.org/wiki/NoSQL#Taxonomy">ersten Eindruck</a> ist der Wikipedia Artikel gut. </p> <p>Prominente Vertreter sind <a href="http://www.mongodb.org/">MongoDB</a> sowie <a href="http://couchdb.apache.org/">CouchDB</a>. </p> <p><strong>RavenDB?</strong></p> <p><a href="http://ravendb.net/">RavenDB</a> ist ein recht junger Vertreter der Dokumentendatenbanken. Der Quellcode ist <a href="https://github.com/ravendb/ravendb/">Open Source</a>, allerdings benötigt man für eine <a href="http://ravendb.net/licensing">Closed-Source Anwendung eine Lizenz</a>. Entwickelt ist es von <a href="http://ayende.com/blog">Ayende Rahien</a>, dessen Blog mittlerweile auch mit RavenDB als Datenquelle läuft.</p> <p>Der größte Unterschied zu den anderen NoSQL Datenbanken liegt vermutlich in der guten Integration auf der Windows &amp; .NET Plattform. </p> <p><strong>Datenspeicherung mit RavenDB…</strong></p> <p><strong></strong><a href="{{BASE_PATH}}/assets/wp-images/image1289.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb471.png" width="555" height="250"></a></p> <p>Anders als bei einer SQL Datenbank werden in RavenDB schemalose JSON Dokumente gespeichert. Es können auch LINQ basierte Indexe angelegt werden. Die Dokumentation ist für einen <a href="http://ravendb.net/documentation">ersten Einstieg</a> auch recht gut. Insbesondere die “<a href="http://ravendb.net/documentation/docs-document-design">Document Structure Design Considerations</a>” sollten Neulinge in NoSQL sich mal durchlesen.</p> <p><strong>Einstieg…</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1290.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 5px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb472.png" width="153" height="244"></a>RavenDB kann über die <a href="http://ravendb.net/download">Download-Seite runtergeladen werden</a>. In diesem Package sind einige Samples, der RavenDB Server und diverse Client-Bibliotheken. Am interessantesten ist der Ordner “Server” und (jedenfalls für den Einstieg) der Ordner “Samples”.</p> <p>Zum Starten von RavenDB gibt es mehrere Möglichkeiten: </p> <p>- Als <a href="http://ravendb.net/documentation/docs-deploy-debug">Konsolenanwendung</a>, welche auf Port 8080 lauscht<br>- Als <a href="http://ravendb.net/documentation/docs-deployment-iis">Webseite</a> im IIS<br>- Als Windows <a href="http://ravendb.net/documentation/docs-deployment-service">Dienst</a><br></p> <p>Vermutlich habe ich andere Optionen noch vergessen <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images/wlEmoticon-winkingsmile4.png"></p> <p>Am einfachsten ist allerdings die Konsolenanwendung.</p> <p>Dazu einfach im Ordner “Server” die “Raven.Server.exe” ausführen (als Admin!) :</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1291.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb473.png" width="368" height="195"></a></p> <p><strong>RavenDB Management Oberfläche</strong></p> <p>Nach dem Start des Servers sollte sich die Management Oberfläche im Browser öffnen. Das RavenDB Management Studio ist in Silverlight umgesetzt und macht jedenfalls optisch einen netten Eindruck. In dieser Management Oberfläche kann man sich Dokumente anschauen und natürlich bearbeiten. Ich vermute einfach mal, dass es ähnlich ist wie das SQL Management Studio.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1292.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 5px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb474.png" width="244" height="196"></a><a href="{{BASE_PATH}}/assets/wp-images/image1293.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb475.png" width="265" height="199"></a></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1294.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb476.png" width="518" height="319"></a></p>    <p><strong>Um RavenDB im Projekt nutzen zu können…</strong></p> <p>Kann man entweder die Assemblies aus dem Download Ordner nehmen oder man holt sich das <strong><a href="http://nuget.org/List/Packages/RavenDB">NuGet Package</a></strong>.</p> <p><strong>Kommen wir zum Coding…</strong></p> <p>Nachdem nun die Konzepte wenigstens im Ansatz angeschnitten wurden und auch der Server läuft kommen wir nun zum Coding. Einige Code-Teile stammen aus dem <a href="https://github.com/ayende/RaccoonBlog/">Blogsystem vom Ayende – genannt Raccoon</a>.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1295.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 5px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb477.png" width="239" height="244"></a></p> <p>Aus dem Raccoon Projekt habe ich etwas Infrastruktur-Code mitgenommen.</p> <p>Dieser Code erleichtert einfach den Zugriff auf die RavenDB und ist in jedem Controller einfach aufzurufen.</p> <p>Nachfolgender Code ist “Infrastruktur”-Code. Wahrscheinlich kann man es auch kürzer fassen, aber dann wird es vermutlich nicht so elegant <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images/wlEmoticon-winkingsmile4.png"></p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p><strong>RavenActionFilterAttribute.cs</strong></p> <p>Dieses Attribute ist in meinem Beispiel auch als Globaler Filter eingebunden in der Global.ascx</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5aff0839-6c92-4232-9d00-f5e21af52761" class="wlWriterEditableSmartContent"><pre name="code" class="c#">        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
            filters.Add(new RavenActionFilterAttribute());
        }</pre></div>
<p>&nbsp;</p>
<p>Der Code des Filters:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:43be1378-fccd-4886-950a-95028128974c" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    /// &lt;summary&gt;
    /// This filter will manage the session for all of the controllers that needs a Raven Document Session.
    /// It does so by automatically injecting a session to the first public property of type IDocumentSession available
    /// on the controller.
    /// &lt;/summary&gt;
    public class RavenActionFilterAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.IsChildAction)
            {
                DocumentStoreHolder.TrySetSession(filterContext.Controller, (IDocumentSession)filterContext.HttpContext.Items[this]);
                return;
            }
            filterContext.HttpContext.Items[this] = DocumentStoreHolder.TryAddSession(filterContext.Controller);
        }

        public override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            if (filterContext.IsChildAction)
                return;
            DocumentStoreHolder.TryComplete(filterContext.Controller, filterContext.Exception == null);
        }
    }</pre></div>
<p>&nbsp;</p>


<p><strong>DocumentStoreHelper.cs</strong></p>
<p>Im Grunde wird hier die Verbindung zum Store hergestellt und der Zugriff gewährleistet. Ich bin mir selber nicht ganz sicher, was er sonst noch macht <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images/wlEmoticon-winkingsmile4.png"></p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8856419c-ac9d-4f82-82fb-08711c239ae7" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    /// &lt;summary&gt;
    /// This class manages the state of objects that desire a document session. We aren't relying on an IoC container here
    /// because this is the sole case where we actually need to do injection.
    /// &lt;/summary&gt;
    public class DocumentStoreHolder
    {
        private static IDocumentStore documentStore;

        public static IDocumentStore DocumentStore
        {
            get { return (documentStore ?? (documentStore = CreateDocumentStore())); }
        }

        private static IDocumentStore CreateDocumentStore()
        {
            var store = new DocumentStore
            {
                ConnectionStringName = "RavenDB"
            }.Initialize();

            return store;
        }

        private static readonly ConcurrentDictionary&lt;Type, Accessors&gt; AccessorsCache = new ConcurrentDictionary&lt;Type, Accessors&gt;();


        private static Accessors CreateAccessorsForType(Type type)
        {
            var sessionProp =
                type.GetProperties().FirstOrDefault(
                    x =&gt; x.PropertyType == typeof(IDocumentSession) &amp;&amp; x.CanRead &amp;&amp; x.CanWrite);
            if (sessionProp == null)
                return null;

            return new Accessors
            {
                Set = (instance, session) =&gt; sessionProp.SetValue(instance, session, null),
                Get = instance =&gt; (IDocumentSession)sessionProp.GetValue(instance, null)
            };
        }


        public static IDocumentSession TryAddSession(object instance)
        {
            var accessors = AccessorsCache.GetOrAdd(instance.GetType(), CreateAccessorsForType);

            if (accessors == null)
                return null;

            var documentSession = DocumentStore.OpenSession();
            accessors.Set(instance, documentSession);

            return documentSession;
        }

        public static void TryComplete(object instance, bool succcessfully)
        {
            Accessors accesors;
            if (AccessorsCache.TryGetValue(instance.GetType(), out accesors) == false || accesors == null)
                return;

            using (var documentSession = accesors.Get(instance))
            {
                if (documentSession == null)
                    return;

                if (succcessfully)
                    documentSession.SaveChanges();
            }
        }

        private class Accessors
        {
            public Action&lt;object, IDocumentSession&gt; Set;
            public Func&lt;object, IDocumentSession&gt; Get;
        }

        public static void Initailize()
        {
            //RavenProfiler.InitializeFor(DocumentStore,
            //    //Fields to filter out of the output
            //    "Email", "HashedPassword", "AkismetKey", "GoogleAnalyticsKey", "ShowPostEvenIfPrivate", "PasswordSalt", "UserHostAddress");

        }

        public static void TrySetSession(object instance, IDocumentSession documentSession)
        {
            var accessors = AccessorsCache.GetOrAdd(instance.GetType(), CreateAccessorsForType);

            if (accessors == null)
                return;

            accessors.Set(instance, documentSession);
        }
    }</pre></div>
<p><strong>BaseController für alle Controller, welche auf die RavenDB zugreifen wollen</strong></p>
<p>Um in den Controllern nun Zugriff auf die RavenDB zu bekommen, machen wir einen BaseController, welche als Property die IDocumentSession inne hat:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c1ae2fee-917d-4f59-b809-1e854066c5c8" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    public abstract class BaseController : Controller
    {
        public new IDocumentSession Session { get; set; }
    }</pre></div>
<p>&nbsp;</p>
<p>Bis hier hin ist der Code auch “Ayende”-geprüft, da er fast so aus dem <a href="https://github.com/ayende/RaccoonBlog/">Raccoon-Blog</a> übernommen wurde – muss also bis hierhin auch gut sein <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images/wlEmoticon-winkingsmile4.png"></p>
<p><strong>Ein einfaches Model</strong></p>
<p>Ich hab ein sehr simples Model, welches auch keine “Verbindungen” zu anderen Objekten hat. Das folgt zu einem späteren Zeitpunkt.</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:aef8e86d-f308-44ea-bc83-bcc9496bc0d7" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    public class Word
    {
        public Guid Id { get; set; }
        public string Value { get; set; }
        public string Description { get; set; }
        public string LcId { get; set; }
        public int UpVotes { get; set; }
        public int DownVotes { get; set; }
    }</pre></div>
<p>&nbsp;</p>
<p><strong>CRUD mit RavenDB</strong></p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ea45b4ab-9b8b-49f5-b8e1-5d1802722094" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    public class WordsController : BaseController
    {
        public ViewResult Index()
        {
            var words = Session.Query&lt;Word&gt;().ToList();
            return View(words);
        }

        //
        // GET: /Words/Details/5

        public ViewResult Details(Guid id)
        {
            Word word = Session.Load&lt;Word&gt;(id);
            return View(word);
        }

        //
        // GET: /Words/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /Words/Create

        [HttpPost]
        public ActionResult Create(Word word)
        {
            if (ModelState.IsValid)
            {
                Session.Store(word);
                Session.SaveChanges();
                return RedirectToAction("Index");  
            }

            return View(word);
        }
        
        //
        // GET: /Words/Edit/5
 
        public ActionResult Edit(Guid id)
        {
            Word word = Session.Load&lt;Word&gt;(id);
            return View(word);
        }

        //
        // POST: /Words/Edit/5

        [HttpPost]
        public ActionResult Edit(Word word)
        {
            if (ModelState.IsValid)
            {
                Session.Store(word);
                Session.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(word);
        }

        //
        // GET: /Words/Delete/5
 
        public ActionResult Delete(Guid id)
        {
            Word word = Session.Load&lt;Word&gt;(id);
            return View(word);
        }

        //
        // POST: /Words/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(Guid id)
        {
            Word word = Session.Load&lt;Word&gt;(id);
            Session.Delete(word);
            Session.SaveChanges();
            return RedirectToAction("Index");
        }
    }</pre></div>
<p>&nbsp;</p>
<p>Alles in allem – total easy. Mal sehen wie es weitergeht…</p>
<p>Fazit oder TL;DR</p>
<p>Das wäre es erst mal zur Einführung von RavenDB. Wir haben nun eine kleine Infrastruktur, mit der man leicht an die RavenDB rankommt und die API erscheint erstmal recht simpel. <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-smile" alt="Smiley" src="{{BASE_PATH}}/assets/wp-images/wlEmoticon-smile4.png">&nbsp; Der gesamte Soure Code steht auch auf <a href="http://businessbingo.codeplex.com/SourceControl/changeset/view/90671#1795027">Codeplex im BusinessBingo Repository zur Verfügung</a>.</p>
<p><strong>Weiterführende Links</strong></p>
<p>Definitiv ist der Blog von Ayende zu empfehlen – dort finden sich einige RavenDB Posts. Desweiteren gibt es auch einige <a href="http://ravendb.net/tutorials">RavenDB Tutorials</a>. Die <a href="http://codeofrob.com/">Serie von Rob Ashton</a> ist auch sehr zu empfehlen.</p>
