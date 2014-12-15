---
layout: post
title: "NoSQL with RavenDB and ASP.NET MVC"
date: 2011-08-31 15:34
author: CI Team
comments: true
categories: [Uncategorized]
tags: [NoSQL; RavenDB; ASP.NET MVC]
language: en
---
{% include JB/setup %}
&nbsp;

<strong> </strong>

For a loooong time (at least for me <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile25.png" alt="Zwinkerndes Smiley" /> ) it was a fact that files have to be in a database. Usual files are saved in a relational database and linked. But in a while there exists resistance – <a href="http://en.wikipedia.org/wiki/NoSQL">NoSQL</a> is the word.

<strong>What are NoSQL database? </strong>

There are several types of NoSQL database – for a first view I recommend you the <a href="http://en.wikipedia.org/wiki/NoSQL#Taxonomy">Wikipedia article</a>.

Prominent representatives are <a href="http://www.mongodb.org/">MongoDB</a> and <a href="http://couchdb.apache.org/">CouchDB</a>.

<strong> </strong>

<strong>RavenDB?</strong>

<a href="http://ravendb.net/">RavenDB</a> is a quite young representative of the document database. The Quellcode is <a href="https://github.com/ravendb/ravendb/">Open Source</a> but you need a <a href="http://ravendb.net/licensing">Closed-Source application licence</a>. The developer is <a href="http://ayende.com/blog">Ayende Rahien</a> which Blog works with RavenDB as data source as well.

The main different to the other NoSQL databases is the well done integration into Windows &amp; .NET platforms.

<strong>Data storage with RavenDB…</strong>

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb471.png" border="0" alt="image" width="555" height="250" />

Different to an SQL database schema less JSON document will be saved in RavenDB. It’s also possible to apply LINQ based Indexes. The documentation is also quite good for a <a href="http://ravendb.net/documentation">first entry</a>. At least first-time user should read “<a href="http://ravendb.net/documentation/docs-document-design">Document Structure Design Considerations</a>”.

<strong>Introduction…</strong>

<strong> </strong>

<a href="{{BASE_PATH}}/assets/wp-images-en/image1290.png"><img style="background-image: none; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; padding-top: 0px; border: 0px;" title="image1290" src="{{BASE_PATH}}/assets/wp-images-en/image1290_thumb.png" border="0" alt="image1290" width="150" height="240" align="left" /></a>RavenDB could be downloaded at the <a href="http://ravendb.net/download">Download-side</a>. In this package are several Samples, the RavenDB server and various Client-libraries included. The most interesting folder is the “Server” folder and (at least for the introduction) the folder “Samples”.

To start RavenDB there are various options:

- As <a href="http://ravendb.net/documentation/docs-deploy-debug">console application</a> on Port 8080

- As <a href="http://ravendb.net/documentation/docs-deployment-iis">Website</a> in IIS

- As Windows <a href="http://ravendb.net/documentation/docs-deployment-service">service</a>

Probably I forget something <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile25.png" alt="Zwinkerndes Smiley" />

The easiest way is the console application.

All you have to do is run the “Raven.Server.exe” in the folder “Server” (as admin!):

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb473.png" border="0" alt="image" width="368" height="195" />

<strong>RavenDB management interface </strong>

<strong> </strong>

After the start of the server should the management interface open in the browser. The RavenDB management studio is in Silverlight and it looks quite nice. In this management interface it’s possible to take a look at the documents and edit them. I think it’s related to the SQL management studio.

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb474.png" border="0" alt="image" width="244" height="196" /><a href="{{BASE_PATH}}/assets/wp-images-de/image1292.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb474.png" border="0" alt="image" width="244" height="196" /></a>

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb476.png" border="0" alt="image" width="518" height="319" />

<strong>To use RavenDB in projects…</strong>

You can get the assemblies from the download folder or you get the <a href="http://nuget.org/List/Packages/RavenDB">NuGet package</a>.

<strong>Now to the Coding…</strong>

After we’ve talked about the concepts and the server works we are now going to talk about the Coding. Some Code-parts are from the Blogsystem of <a href="https://github.com/ayende/RaccoonBlog/">Ayende – named Raccoon.</a>

I’ve taken some Infrastructure-code from the Raccoon project.

This code makes it easier to get access to the RavenDB and it’s easy to call from every Controller.

The following code is “Infrastructure” Code. Maybe it’s possible to make it shorter but then it’s not that classy <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile25.png" alt="Zwinkerndes Smiley" />

<strong>RavenActionFilterAttribute.cs</strong>

The attribute in my example is also integrated as Global Filter in the Global.ascx
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b99980f6-677c-4804-9c2c-38c0d8e97f92" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
            filters.Add(new RavenActionFilterAttribute());
        }</pre>
</div>
The code of the filter:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:342b2c3e-f68f-48d2-9308-e9904421582d" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">/// &lt;summary&gt;
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
    }</pre>
</div>
<strong>DocumentStoreHelper.cs</strong>

<strong> </strong>

In fact this is where the connection to the store and the access will be warranted. I’m not sure what else the function is <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile25.png" alt="Zwinkerndes Smiley" />

<pre class="c#"> 
    /// &lt;summary&gt;
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
    }
</pre>


<strong>BaseController for all Controllers which want to access on the RavenDB </strong>


To get access to the RavenDB on the Controller we will make a BaseController which has all iDocumentSessions as Property:

Till this part the Code is “Ayende” checked because it’s from the <a href="https://github.com/ayende/RaccoonBlog/">Racoon-Blog</a> – so it should be good <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile25.png" alt="Zwinkerndes Smiley" />

<strong>An easy model </strong>

I’ve chosen a very simple model without any connections to other objects. This will follow later on.

<pre class="c#">
public class Word
    {
        public Guid Id { get; set; }
        public string Value { get; set; }
        public string Description { get; set; }
        public string LcId { get; set; }
        public int UpVotes { get; set; }
        public int DownVotes { get; set; }
    }
</pre>

<strong>CRUD with RavenDB</strong>

<pre class="c#">
public class WordsController : BaseController
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
    }
</pre>

All in all – totally easy. Let’s see how it goes on…

<strong>Result</strong>

That’s it about the introduction to RavenDB. This is just a small infrastructure that makes it easy to get in touch with RavenDB. You will find the whole Source Code on <a href="http://businessbingo.codeplex.com/SourceControl/changeset/view/90671#1795027">Codeplex in BusinessBingo Repository</a>.


<strong>Links</strong>

Of course I recommend you the blog of Ayende – there are some posts of RavenDB. Also there are some <a href="http://ravendb.net/tutorials">RavenDB tutorials</a>. And if that’s not enough take a look on <a href="http://codeofrob.com/">the page of Rob Ashton</a>.
