---
layout: post
title: "Einstieg in mongoDB"
date: 2011-10-17 21:00
author: oliver.guhr
comments: true
categories: [Allgemein, HowTo]
tags: [.NET, HowTo, Javascript, LINQ to SQL, mongodb, NoSQL, Web 2.0]
language: de
---
{% include JB/setup %}
<p>Wer sich mit dem <a href="{{BASE_PATH}}/2011/10/13/nosql-bei-windows-server-azure-sql-server-mit-apache-hadoop/">Trend? Thema</a> NoSql beschäftigt wird früher oder später auch auf <a href="http://www.mongodb.org/">mongoDB</a> stoßen. Was <a href="http://www.mongodb.org/">mongoDB</a> für mich spannend macht, ist zu einem die versprochene Performance (auch wenn ich mit normalen Datenbank da noch nie an die Grenzen gestoßen bin) und zum anderen, das versprechen sich von diesem ganzen O/R Mapper Quatsch verabschieden zu können(und da stoße ich ständig an irgendwelche Grenzen).  <p>Robert hatte sich schon <a href="{{BASE_PATH}}/2011/07/05/nosql-mit-ravendb-und-asp-net-mvc/">hier</a> und <a href="{{BASE_PATH}}/2011/08/15/ravendb-als-embedded-datenbank-nutzen/">hier</a> mit <a href="http://ravendb.net/">RavenDB</a> beschäftigt und <a href="{{BASE_PATH}}/2011/07/26/umdenken-bei-nosql-datenkonsistenz-in-ravendb/">hier erste Ideen zum Design</a> von NoSql Strukturen gesammelt.&nbsp; <p>Wer sich jetzt Fragt: <strong>Was ist bitte der Unterschied zwischen mongoDB und RavenDB?</strong> (abgesehen vom cooleren Namen)  <p>Naja eigentlich ist das ein Thema für einen eigenen Blogeintrag. Um es ganz kurz zu machen: monogoDB scheint schneller zu sein, unterstützt mehr Sprachen und hat deshalb die größere Community wohingen RavenDB die (viel) bessere Integration in die .net Landschaft bietet. Für mich persönlich ist mongoDB interessanter weil ich es auch für kommerzielle Projekte kostenlos nutzen kann.  <p>So, toll… wo ist der Code?  <h1>Installieren</h1> <ol> <li>Hier lädt man sich mongoDB für Win, OSX, Solaris oder Linux runter: <a href="http://www.mongodb.org/downloads">http://www.mongodb.org/downloads</a>  <li>Das Einzige was man selber machen muss ist dieses Verzeichnis anlegen “C:\data\db”<br>Den Pfad kann man aber auch konfigurieren, nur wird mongoDB ihn nicht selber anlegen<br> <li>Unter Windows reicht ein auspacken der Zip Datei und der Doppelklick auf die mongod.exe<br>Wenn man will kann man mongoDB auch als Windows Service starten.<br> <li>Das war einfach <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images/wlEmoticon-winkingsmile11.png"></li></ol> <p>&nbsp;</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1378.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb560.png" width="439" height="232"></a></p> <h1>Code</h1> <p>1. Was wir noch brauchen ist der <u>mongoDB .Net Treiber</u> und den gibt’s hier:<br><a href="http://www.mongodb.org/display/DOCS/CSharp+Language+Center">http://www.mongodb.org/display/DOCS/CSharp+Language+Center</a></p> <p>2. Jetzt muss man diese beiden <u>Referenzen einbinden:</u></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1379.png"><img style="background-image: none; border-right-width: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb561.png" width="244" height="201"></a></p> <p>3. So jetzt können wir die <u>Verbindung herstellen:</u></p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f6b6209d-774b-40cc-a56f-fbcdb150cd93" class="wlWriterEditableSmartContent"><pre name="code" class="c#">MongoServer server = MongoServer.Create(); // connect to localhost                        

MongoDatabase demo = server.GetDatabase("demo");  // connect to database       

MongoCollection&lt;User&gt; users = demo.GetCollection&lt;User&gt;("users");</pre></div>
<p>&nbsp;</p>
<p>Mit Zeile 1 bauen wir die Verbindung auf, wenn nichts angegeben ist zu localhost und ohne Nutzername/Passwort. Zeile 3 gibt uns eine Datenbank zurück und Zeile 5 eine “Tabelle”. Mongo verhält sich hier wie eine normale Datenbank. </p>
<p>4. <u>Daten einfügen</u></p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e88a7462-3800-4e48-9885-7e1faa44945e" class="wlWriterEditableSmartContent"><pre name="code" class="c">//insert
for (int i = 0; i &lt; 10; i++)
{
  var result = users.Insert&lt;User&gt;(new User { Name = "Karl", Age = 20 });    
}</pre></div>
<p>5. <u>Daten lesen</u> </p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e82673c8-90ee-4fd0-a1ed-f45820884670" class="wlWriterEditableSmartContent"><pre name="code" class="c#">var userResult = users.FindAll();
foreach (var item in userResult)
{
 Console.WriteLine(string.Format("{0} - {1}",item.Name,item.Age));
}</pre></div>
<p>6. <u>Datenmodell</u></p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:cfcd158a-49cf-4861-ab1a-16edf25cf634" class="wlWriterEditableSmartContent"><pre name="code" class="c#">class User
{
    public ObjectId _id { get; set; }
    public string Name { get; set; }
    public int Age { get; set; }
    public List&lt;ObjectId&gt; Tags { get; set; }     
}</pre></div>
<p>Ich habe als Typ für die ID ObjectId (kommt mit dem mongo Treiber) und nicht Guid benutzt. Der Treiber kann zwar auch mit Guid umgehen, allerdings wird die dann BASE64 Codiert als Binärfeld in die DB geschrieben und ich vermute einfach mal, dass dann die hauseigene ObjectId schneller ist.</p>
<p><u>7. n:m-Beziehungen …</u></p>
<p>… sind auch möglich, einfach in dem man das über die ID’s verknüpft. Ob man seine Daten Normalisieren will/ muss ist eine andere Frage, möglich ist es auf jeden Fall.</p>
<p>&nbsp;</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:76ac3418-e1eb-48f1-b3d2-05a53374da43" class="wlWriterEditableSmartContent"><pre name="code" class="c#">//setup second collection
MongoCollection&lt;User&gt; tags = demo.GetCollection&lt;User&gt;("tags"); // add &amp; get a new collecton
tags.Drop(); 
List&lt;Tag&gt; initialTags = new List&lt;Tag&gt;() { new Tag("Cool"), new Tag("Fast"), new Tag("Jedi"), new Tag("Ninja") };
tags.InsertBatch(initialTags);
            
            
//add tags to a user (many to many) 
foreach (var item in userResult)
{
    var randomTags = initialTags.Take(new Random().Next(0, 4)).Select(x=&gt;x._id).ToList(); // add some random tags
    item.Tags = new List&lt;ObjectId&gt;(randomTags);
    users.Save(item); // saves changes to mongo
}</pre></div>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:aab518c1-96a8-4f8a-8ed9-9d516974af75" class="wlWriterEditableSmartContent"><pre name="code" class="c#">class Tag
{
    public Tag(string name)
    {            
        Name = name;
    }
    public ObjectId _id { get; set; }
    public string Name { get; set; }
}</pre></div>
<p>&nbsp;</p>
<p>Jetzt haben wir zwei “Tabellen” eine mit Nutzern und eine mit Tags die den Nutzern zugeordnet werden können. Diese Bespiel zeigt auch wie man bei NoSql DB’s eigentlich nicht vorgeht. (ist mir erst hinter aufgefallen) Normalerweise würde ich dem Nutzer einfach Tags als Text zuweisen und mir eine Map/Reduce Abfrage bauen, wenn ich z.B. die Tags zählen möchte und das kann so aussehen: <a href="http://cookbook.mongodb.org/patterns/count_tags/">http://cookbook.mongodb.org/patterns/count_tags/</a></p>
<p><u>Wie schnell bist du?</u></p>
<p>Performace Tests sind immer so eine Sache, weil sie von vielen Faktoren abhängig sind. Allerdings war ich irgendwie neugierig und wollte mal sehen was passiert, wenn ich viele Elemente anlege und wieder lese.<br>Also hab ich mal auf verschiede Arten 10000 User angelegt, gelesen und wieder gelöscht:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5af7acf4-73c7-4a38-b313-747f72d57272" class="wlWriterEditableSmartContent"><pre name="code" class="ruby">int UsersToAdd = 10000;
//setup some users
Func&lt;List&lt;User&gt;&gt; getTestUsers = () =&gt;
{
    var tmp = new List&lt;User&gt;();
    for (int i = 0; i &lt; UsersToAdd; i++)
    {
        tmp.Add(new User { Name = "Karl" + i, Age = 20 });
    }
    return tmp;
};

//insert           
Stopwatch insertTimer = new Stopwatch();
insertTimer.Start();
foreach (var item in getTestUsers())
{
    users.Insert&lt;User&gt;(item);
}
insertTimer.Stop();
Console.WriteLine(UsersToAdd + " users added in: " + insertTimer.ElapsedMilliseconds + "ms");

//bulk insert
insertTimer.Start();
users.InsertBatch&lt;User&gt;(getTestUsers());
insertTimer.Stop();
Console.WriteLine(UsersToAdd + " users added in an Batch: " + insertTimer.ElapsedMilliseconds + "ms");


//parallel insert
insertTimer.Start();
System.Threading.Tasks.Parallel.ForEach&lt;User&gt;(getTestUsers(), x =&gt; users.Insert&lt;User&gt;(x));
insertTimer.Stop();
Console.WriteLine(UsersToAdd + " users added parallel in: " + insertTimer.ElapsedMilliseconds + "ms");

//load all 
insertTimer.Start();
var all = users.FindAll();
insertTimer.Stop();
Console.WriteLine("all users loaded in: " + insertTimer.ElapsedMilliseconds + "ms");

//drop all 
insertTimer.Start();
users.Drop();
insertTimer.Stop();
Console.WriteLine("all users droped in: " + insertTimer.ElapsedMilliseconds + "ms");</pre></div>
<p>&nbsp;</p>
<p>Und hier sind meine Ergebnisse (4GB RAM QuadCore, HDD RAID5, keine SSD) </p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1380.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb562.png" width="497" height="263"></a></p>
<p>&nbsp;</p>
<h1>Verwaltung</h1>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1381.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb563.png" width="226" height="113"></a>Zum verwalten von mongoDB gibt es <a href="http://www.mongodb.org/display/DOCS/Admin+UIs">eine Reihe von Tools</a>. Ich hab fürs erste den MongoExplorer genommen. Das schicke Silverlight Tool kann man bequem direkt von der Webseite aus installieren.</p>
<p><a href="http://mongoexplorer.com/">http://mongoexplorer.com/</a></p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1382.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb564.png" width="591" height="470"></a></p>
<p>&nbsp;</p>
<h1>Abfragen</h1>
<p>Zum Thema Abfragen und Map/Reduce lohnt es sich einen eigenen Artikel zu schreiben. Nur so viel: steuern kann man mongoDB komplett mit Javascript. Mir persönlich hat diese ziemlich gute Präsentation viele Fragen beantwortet:</p>
<div style="width: 425px" id="__ss_4111399"><strong style="margin: 12px 0px 4px; display: block"><a title="Why MongoDB is awesome" href="http://www.slideshare.net/jnunemaker/why-mongodb-is-awesome" target="_blank">Why MongoDB is awesome</a></strong> <iframe height="355" marginheight="0" src="http://www.slideshare.net/slideshow/embed_code/4111399" frameborder="0" width="425" marginwidth="0" scrolling="no"></iframe>
<div style="padding-bottom: 12px; padding-left: 0px; padding-right: 0px; padding-top: 5px">View more <a href="http://www.slideshare.net/" target="_blank">presentations</a> from <a href="http://www.slideshare.net/jnunemaker" target="_blank">John Nunemaker</a> </div></div>
