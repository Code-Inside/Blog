---
layout: post
title: "Esent – die “uralte NoSQL DB” von Windows"
date: 2013-09-01 17:24
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [Esent]
language: de
---
{% include JB/setup %}
<p>Wer RavenDB verwendet, wird vermutlich bereits über Esent gestolpert sein. Unter der Haube verwendet RavenDB die “<a href="http://en.wikipedia.org/wiki/Extensible_Storage_Engine">Extensible Storage Engine</a>”, welche in Windows seit XP vorhanden ist. Hier schreibt Ayende warum er sich seit kurzem nach einer <a href="http://ayende.com/blog/162593/why-leveldb-all-of-a-sudden">Alternative umschaut</a> – wobei Esent generell wohl gute Dienste leistet. Aber das nur nebenbei…</p> <p>Esent wird von Microsoft in vielen Bereichen gebraucht – darunter das Active-Directory und Exchange Mailbox Daten, d.h. ziemlich große Datenmengen. Ich zitiere mal diesen <a href="http://www.jondavis.net/techblog/post/2010/08/30/Esent-The-Decade-Old-Database-Engine-That-Windows-(Almost)-Always-Had.aspx">Blogpost</a>, da die Features von ESENT ziemlich gut dargestellt wurden:</p> <p><em><b></b></em> <ul> <p><em><b>Features</b></em></p><em> <p><em>Significant technical features of ESENT include:</em></p> <p><em>- </em></em><em>ACID transactions with savepoints, lazy commits, and robust crash recovery. <br>- </em><em>Snapshot isolation. <br>- </em><em>Record-level locking (multi-versioning provides non-blocking reads). <br>- H</em><em>ighly concurrent database access. <br>- </em><em>Flexible meta-data (tens of thousands of columns, tables, and indexes are possible). <br>- </em><em>Indexing support for integer, floating point, ASCII, Unicode, and binary columns. <br>- </em><em>Sophisticated index types, including conditional, tuple, and multi-valued. <br>- </em><em>Columns that can be up to 2GB with a maximum database size of 16TB.</em></p> <ul></ul> <p><em>Note: The ESENT database file cannot be shared between multiple processes simultaneously. ESENT works best for applications with simple, predefined queries; if you have an application with complex, ad-hoc queries, a storage solution that provides a query layer will work better for you.</em></p></ul> <p>Wenn Esent sowohl in diesen Bereichen als auch von Ayende verwendet wird, kann doch ein Blick darauf nicht schaden.</p> <h3>Erste Schritte mit Esent- ManagedEsent</h3> <p>Natürlich kann man <a href="http://stackoverflow.com/questions/5311252/setting-up-a-basic-esent-for-c-example">Esent mit C++ ansprechen</a>, aber so richtig vertrauenserweckend wirkt das nicht. Etwas praktischer wirkt da schon:</p> <p><a href="http://managedesent.codeplex.com/"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image1915.png" width="438" height="83"></a> </p> <p>Das Projekt hat zwei Bestandteile:</p> <p>- ein .NET Wrapper zu Esent.dll</p> <p>- PersistentDictionary, welches den .NET Wrapper nimmt und eine nette API bietet</p> <p>Zudem gibt es einiges an Dokumentation dazu.</p> <p><strong>.NET Wrapper</strong></p> <p>Wer “purer” auf Esent zugreifen will, kann das über den .NET Wrapper machen. Wobei man schon die Internas von Esent kennen muss. Hier ist der Code einer <a href="http://managedesent.codeplex.com/wikipage?title=ManagedEsentSample&amp;referringTitle=ManagedEsentDocumentation">Sample-Applikation</a>, wobei diese Sample-App sehr “low-level” ist. </p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">namespace EsentSample
{
    using System;
    using System.Text;
    using Microsoft.Isam.Esent.Interop;

    public class EsentSample
    {
        /// &lt;summary&gt;
        /// Main routine. Called when the program starts.
        /// &lt;/summary&gt;
        /// &lt;param name="args"&gt;
        /// The arguments to the program.
        /// &lt;/param&gt;
        public static void Main(string[] args)
        {
            JET_INSTANCE instance;
            JET_SESID sesid;
            JET_DBID dbid;
            JET_TABLEID tableid;

            JET_COLUMNDEF columndef = new JET_COLUMNDEF();
            JET_COLUMNID columnid;

            // Initialize ESENT. Setting JET_param.CircularLog to 1 means ESENT will automatically
            // delete unneeded logfiles. JetInit will inspect the logfiles to see if the last
            // shutdown was clean. If it wasn't (e.g. the application crashed) recovery will be
            // run automatically bringing the database to a consistent state.
            Api.JetCreateInstance(out instance, "instance");
            Api.JetSetSystemParameter(instance, JET_SESID.Nil, JET_param.CircularLog, 1, null);
            Api.JetInit(ref instance);
            Api.JetBeginSession(instance, out sesid, null, null);

            // Create the database. To open an existing database use the JetAttachDatabase and 
            // JetOpenDatabase APIs.
            Api.JetCreateDatabase(sesid, "edbtest.db", null, out dbid, CreateDatabaseGrbit.OverwriteExisting); 

            // Create the table. Meta-data operations are transacted and can be performed concurrently.
            // For example, one session can add a column to a table while another session is reading
            // or updating records in the same table.
            // This table has no indexes defined, so it will use the default sequential index. Indexes
            // can be defined with the JetCreateIndex API.
            Api.JetBeginTransaction(sesid);
            Api.JetCreateTable(sesid, dbid, "table", 0, 100, out tableid);
            columndef.coltyp = JET_coltyp.LongText;
            columndef.cp = JET_CP.ASCII;
            Api.JetAddColumn(sesid, tableid, "column1", columndef, null, 0, out columnid);
            Api.JetCommitTransaction(sesid, CommitTransactionGrbit.LazyFlush);

            // Insert a record. This table only has one column but a table can have slightly over 64,000
            // columns defined. Unless a column is declared as fixed or variable it won't take any space
            // in the record unless set. An individual record can have several hundred columns set at one
            // time, the exact number depends on the database page size and the contents of the columns.
            Api.JetBeginTransaction(sesid);
            Api.JetPrepareUpdate(sesid, tableid, JET_prep.Insert);
            string message = "Hello world";
            Api.SetColumn(sesid, tableid, columnid, message, Encoding.ASCII);
            Api.JetUpdate(sesid, tableid);
            Api.JetCommitTransaction(sesid, CommitTransactionGrbit.None);    // Use JetRollback() to abort the transaction

            // Retrieve a column from the record. Here we move to the first record with JetMove. By using
            // JetMoveNext it is possible to iterate through all records in a table. Use JetMakeKey and
            // JetSeek to move to a particular record.
            Api.JetMove(sesid, tableid, JET_Move.First, MoveGrbit.None);
            string buffer = Api.RetrieveColumnAsString(sesid, tableid, columnid, Encoding.ASCII);
            Console.WriteLine("{0}", buffer);

            // Terminate ESENT. This performs a clean shutdown.
            Api.JetCloseTable(sesid, tableid);
            Api.JetEndSession(sesid, EndSessionGrbit.None);
            Api.JetTerm(instance);
        }
    }
}</pre>
<p>Das Ganze speichert einen Wert – nicht mehr. Uhhh… aber naja – so ist das im Low-Level Gebiet.</p>
<p>Etwas besseren Einblick bekommt man allerdings durch das <a href="http://managedesent.codeplex.com/SourceControl/latest#EsentInteropSamples/StockSample/StockSample.cs"><strong>Stock-Sample</strong></a>, hier wird über die ManagedEsent API eine “komplexere” Datenbank erzeugt und Aktiendaten gespeichert. Aber es geht noch einfacher:</p>
<p><strong>Persistent Dictionary</strong></p>
<p>Diese Variante verhält sich im Grunde wie ein Dictionary – nur das es als Esent-Datenbank gespeichert wird. In der <a href="http://managedesent.codeplex.com/wikipage?title=PersistentDictionaryDocumentation"><strong>Dokumentation</strong></a> steht noch einiges mehr.</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">public static void Main(string[] args)
        {
            var dictionary = new PersistentDictionary&lt;string, string&gt;("Names");

            Console.WriteLine("What is your first name?");
            string firstName = Console.ReadLine();
            if (dictionary.ContainsKey(firstName))
            {
                Console.WriteLine("Welcome back {0} {1}",
                    firstName,
                    dictionary[firstName]);
            }
            else
            {
                Console.WriteLine(
                    "I don't know you, {0}. What is your last name?",
                    firstName);
                dictionary[firstName] = Console.ReadLine();
            }
        }</pre>
<p>Der Code ist recht trivial – und im Hintergrund wird über die Esent API ein Ordner namens “Names” angelegt. Darin befinden sich die eigentliche Esent Datenbank:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1916.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1056.png" width="488" height="168"></a> </p>
<p>Wie und ob man die Daten auch irgendwie über ein Tool auslesen kann (also ohne Code), weiss ich aktuell leider nicht.</p>
<p><strong>Zur Performance</strong></p>
<p>Einfach 1.000.000 Eintrage in eine Datenbank zu schreiben dauerte über die PersistentDictionary-Variante einige Sekunden. Nahm ich GUIDs anstatt Integer dauerte es wesentlich länger. Vermutlich muss man sich näher damit beschäftigen um aussagekräftige Zahlen zu bekommen. Das Team hat ein paar Performance-Daten <a href="http://managedesent.codeplex.com/wikipage?title=SystemStats">hier</a> und <a href="http://managedesent.codeplex.com/wikipage?title=PersistentDictionaryDocumentation">hier</a> veröffentlicht.</p>
<p><strong>LINQ Support!</strong></p>
<p>Seit der <a href="http://blogs.msdn.com/b/laurionb/archive/2011/02/15/managedesent-1-6-released-linq-support-for-persistentdictionary.aspx">Version 1.6</a> gibt es auch LINQ support für die PersistentDictionary-Variante.</p>
<p><strong>Windows Store Apps </strong></p>
<p>Da Esent ein Bestandteil von Windows ist und vermutlich einige Bereiche gibt die diese API nutzen, kann man Esent auch in Windows Store Apps nutzen. Seit <a href="https://managedesent.codeplex.com/SourceControl/list/changesets">Version 1.8 geht es wohl</a> – wobei das PersistentDictionary aktuell wohl nicht unterstützt wird. Hier gibt es ein Blogpost der näher auf das Thema <a href="http://lunarfrog.com/blog/2012/09/23/extensible-storage-engine/">Esent und Windows 8 Apps</a> eingeht.</p>
<p><strong>Weitere Links zum Thema ManagedEsent</strong></p>
<p>- <a href="https://managedesent.codeplex.com/discussions/454692">Performace of Persitent Dictionary (CodePlex Discussion)</a><br>- <a href="https://github.com/ayende/managed-esent">Ayendes Fork</a> <br>- <a href="http://blogs.msdn.com/b/laurionb/">Blog über Esent und die ManagedEsent Api eines Microsoftis</a></p>
<h3>Esent Serialization </h3>
<p>Neben dem “PersistentDictionary” gibt es noch ein weitere Projekt, welches auf ManagedEsent setzt:</p>
<p><a href="http://esentserialize.codeplex.com/"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image1917.png" width="504" height="113"></a> </p>
<p>Im Grunde erlaut diese Projekt Datenstrukturen “einfach” in Esent reinzubringen. In <a href="http://esentserialize.codeplex.com/SourceControl/latest#DemoApp/Program.cs">diesem Demo</a> kann man die Funktionsweise erkennen.</p>
<h3></h3>
<h3>Fazit</h3>
<p>Esent hat eine nicht gerade angenehme API, wird aber selbst in Windows 8 nach wie vor verwendet. Durch die ManagedEsent Api, PersistentDictionary und Esent Serialization sind die ersten Schritte aber schnell gemacht. Ob man wirklich damit näher arbeiten möchte kommt natürlich immer auf den Einsatzzweck an – immerhin gibt es viele Alternativen die man nehmen kann. Das RavenDB auf Esent aufbaut bedeutet für mich aber, dass es durchaus eine Variante sein kann.</p>
<p>PS: Da der Code für den Blogpost <a href="http://managedesent.codeplex.com/">vollständig aus den offiziellen Quellen</a> kommt lade ich nix auf GitHub hoch. Die benötigten ManagedEsent.dll´s gibt es auf <a href="http://www.nuget.org/packages/ManagedEsent/">NuGet</a>.</p>
<h3>Frage: Jemand schon Erfahrung mit Esent?</h3>
<p>Hat jemand denn schon intensiver mit Esent gearbeitet? Oder ist das doch eher ein Nischen-Gebiet (so wie es mir auch vorkommt ;) )?</p>
