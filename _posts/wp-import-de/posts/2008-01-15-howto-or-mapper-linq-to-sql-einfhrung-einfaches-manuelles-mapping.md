---
layout: post
title: "HowTo: O/R Mapper LINQ to SQL - Einführung & einfaches manuelles Mapping"
date: 2008-01-15 23:43
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.NET 3.5, C# 3.0, HowTo, LINQ, LINQ to SQL]
language: de
---
{% include JB/setup %}
<p><a href="http://weblogs.asp.net/scottgu/archive/2007/05/19/using-linq-to-sql-part-1.aspx" target="_blank">LINQ to SQL</a> ist Microsofts <a href="http://msdn2.microsoft.com/en-us/netframework/aa904594.aspx" target="_blank">LINQ</a> Provider für das Hauseigene Datenbanksystem SQL Server 2005 (und 2008 - und noch mehr?). Das Konzept von LINQ sollte man vorher bereits verstehen - hier eine Kurzeinführung:</p> <p><strong>LINQ? Was ist das?</strong></p> <p>In jeder Applikation arbeitet man mit Daten, Objekten und noch mehr Ansammlungen von Objekten. Externe Datenquellen (XML, Datenbanken) muss man über ihre jeweiligen Abfragesprachen ansprechen - SQL oder XPath. Objektcollections oder komplexe Objekte in C# 2.0 haben kein solches Abfragesystem gehabt - man musste über Foreach-Schleifen die Collections durchgehen und dann immer wieder mit dem Suchwort vergleichen.</p> <p>Hier tritt LINQ ins Spiel - LINQ erlaubt es, .NET Objekte mit einem SQL ähnlichen Syntax zu durchsuchen, allerdings mit allen Vorteilen die Visual Studio und Objekte bieten: Einfaches Debugging möglich, man arbeitet mit direkten Objekten und die IntelliSense hilft natürlich auch kräftig. Am Ende einer LINQ Abfrage kann man direkt ein "var" Objekt erzeugen (was das ist, wurde <a href="{{BASE_PATH}}/2008/01/13/howto-c-30-var-keyword-und-andere-kleine-c-30-features-verstehen/" target="_blank">hier</a> besprochen). Da man nicht nur Objekte so durchsuchen kann, sondern auch andere Daten, zeigt z.B. der <a href="http://www.hookedonlinq.com/Default.aspx?Page=LINQtoXML5MinuteOverview&amp;AspxAutoDetectCookieSupport=1" target="_blank">LINQ to XML</a> oder der LINQ to SQL Provider.</p> <p>Microsoft hat LINQ so gestaltet, dass viele solche Provider erstellt werden können, sodass es momentan z.B. folgene Provider in Entwicklung befinden:</p> <ul> <li><a href="http://www.codeplex.com/LINQtoSharePoint" target="_blank">LINQ to SharePoint</a></li> <li><a href="http://weblogs.asp.net/fmarguerie/archive/2006/06/26/Introducing-Linq-to-Amazon.aspx" target="_blank">LINQ to Amazon</a></li> <li><a href="http://www.codeplex.com/LINQtoAD" target="_blank">LINQ to Active Directory (LDAP)</a></li> <li><a href="http://iqueryable.com/2007/04/05/LINQToNHibernate.aspx" target="_blank">LINQ to NHibernate</a></li> <li><a href="http://code2code.net/DB_Linq/" target="_blank">LINQ to MySQL / Oracle / SQLite</a></li> <li><a href="http://www.codeplex.com/LINQFlickr" target="_blank">LINQ to Flickr</a></li></ul> <p>Wir beschäftigen uns heute mit LINQ to SQL - dabei werden wir einmal nur in einer sehr einfachen Abfrage LINQ to SQL anschauen und später ein etwas komplexeres Mapping per Hand vornehmen. <br>Der LINQ to SQL Designer wird später behandelt!</p> <p><strong>Vorbereitung &amp; Dokumente</strong></p> <p>Ich halte mich hier an das Hand on Lab von Microsoft, welches es <a href="http://download.microsoft.com/download/0/e/2/0e255cf3-b11f-44cb-b42c-7d55ed7b556c/LINQ_to_SQL_Hands_on_Lab.doc" target="_blank">hier</a> kostenlos zum Runterladen gibt. Desweiteren benötigen wir die Northwind Datenbank - eine Installationsanleitung gibt es <a href="{{BASE_PATH}}/2008/01/13/howto-beispieldatenbank-adventureworks-und-northwind-auf-sql-server-2005-installieren/" target="_blank">hier</a>. Natürlich benötigen wir <a href="http://download.microsoft.com/download/0/e/2/0e255cf3-b11f-44cb-b42c-7d55ed7b556c/LINQ_to_SQL_Hands_on_Lab.doc" target="_blank">Visual Studio 2008 Express Edition</a>. Visual Studio und das SQL Management Studio sollten im Administratormodus laufen (und bei meinem Demoprojekt muss hinterher der ConnectionString angepasst werden)</p> <p><strong>Erster Schritt mit LINQ to SQL</strong></p> <p>Als erstes benötigen wir die System.Data.Linq.dll, damit wir die entsprechenden Namespaces verwenden können.<br>Danach erstellen wir unser erstes Mapping (wie bereits oben erwähnt, werden wir hier ein manuelles Mapping vornehmen um das System besser zu verstehen).</p> <p>Schauen wir uns mal die Tabellen der Northwind Datenbank an:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image224.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb203.png" width="195" border="0"></a> </p> <p>Wir wollen einfach eine kleine Konsolen-Applikation haben, welche die Kundendaten bearbeitet.</p> <p><strong>LINQ to SQL - Schritt 1: Das Mapping</strong></p> <p>Die Kundendaten stehen in der "Customers" Tabelle - daher legen wir eine "Customers" Klasse an:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image225.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="210" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb204.png" width="244" border="0"></a> </p> <p>Dabei verwenden wir den Namespace "<a href="http://msdn2.microsoft.com/en-us/library/system.data.linq.mapping.aspx" target="_blank">System.Data.Linq.Mapping</a>" in der "Customer.cs".<br>Das Mapping erfolgt über das Zuweisen von Attributen zu der Klasse (das <a href="http://msdn2.microsoft.com/en-us/library/system.data.linq.mapping.columnattribute.aspx" target="_blank">Table Attribut</a>) und den Properties (das <a href="http://msdn2.microsoft.com/en-us/library/system.data.linq.mapping.columnattribute.aspx" target="_blank">Column Attribut</a>).</p> <p><u>Quellcode sagt meist mehr als tausend Wort:</u></p> <div class="CodeFormatContainer"><pre class="csharpcode"><span class="kwrd">using</span> System;
<span class="kwrd">using</span> System.Collections.Generic;
<span class="kwrd">using</span> System.Linq;
<span class="kwrd">using</span> System.Text;
<span class="kwrd">using</span> System.Data.Linq.Mapping;

<span class="kwrd">namespace</span> LinqToSqlTest
{
    [Table(Name = <span class="str">"Customers"</span>)]
    <span class="kwrd">public</span> <span class="kwrd">class</span> Customer
    {
        [Column(IsPrimaryKey = <span class="kwrd">true</span>)]
        <span class="kwrd">public</span> <span class="kwrd">string</span> CustomerID;

        [Column]
        <span class="kwrd">public</span> <span class="kwrd">string</span> Address { get; set; }

        <span class="kwrd">private</span> <span class="kwrd">string</span> _City;

        [Column(Storage = <span class="str">"_City"</span>)]
        <span class="kwrd">public</span> <span class="kwrd">string</span> City
        {
            get { <span class="kwrd">return</span> <span class="kwrd">this</span>._City; }
            set { <span class="kwrd">this</span>._City = <span class="kwrd">value</span>; }
        }
    }

}</pre></div>
<p><u>Erklärung:</u></p>
<p>Das Mapping erfolgt durch die Zuweisungen der entsprechenen Attribute (<a href="http://msdn2.microsoft.com/en-us/bb386971.aspx" target="_blank">Attribute-based Mapping</a>) - beim Klassennamen "Customer" wird das Tabel Attribut verwendet - das "Name" dort verbindet die "Costumers" Tabelle mit dieser Klasse. Der Name kann auch weggelassen werden, wenn <strong>DB Tabellennamen == Klassenname</strong> (in unserem Fall fehlt ein "s" im Klassennamen).<br>Die einzelnen Spalten werden über das Column Attribut den Properties zugewiesen (MSDN Artikel: <a href="http://msdn2.microsoft.com/en-us/bb386983.aspx" target="_blank">How to: Represent Columns as Class Members (LINQ to SQL)</a>).</p>
<p>Das Mapping erfolgt hierbei wieder anhand des Namens der <strong>DB Spalte und des entsprechenden Properties.</strong> Falls dies abweicht, gibt es noch ein <a href="http://msdn2.microsoft.com/en-us/system.data.linq.mapping.dataattribute.name.aspx" target="_blank">Name</a> Property (wie bei dem Tabellen Attribut oben). <br>Standardmäßig wird dann der DB Wert in das Property geschrieben, welches zugewiesen wurde. Wenn man als Datenhalterobjekt z.B. ein privates Property verwenden möchte, kann man dies über das "<a href="http://msdn2.microsoft.com/en-us/system.data.linq.mapping.dataattribute.storage.aspx" target="_blank">Storage</a>" Property zuweisen.</p>
<p><strong>LINQ to SQL - Schritt 2: Die DB Abfrage</strong></p>
<p>In unserer Program.cs wollen wir nun eine einfache Abfrage der Kunden einbauen.</p>
<p>Als erstes müssen wireinen <a href="http://msdn2.microsoft.com/en-us/library/system.data.linq.datacontext.aspx" target="_blank">DataContext</a> aufbauen, welchen wir den ConnectionString übergeben. Danach veranlassen wir den Datacontext das Mapping über die <a href="http://msdn2.microsoft.com/en-us/library/bb357220.aspx" target="_blank">GetTable</a> Methode zu "starten":</p>
<div class="CodeFormatContainer"><pre class="csharpcode">DataContext db = <span class="kwrd">new</span> DataContext(<span class="str">@"Data Source=REMAN-NOTEBOOK\SQLEXPRESS;Initial Catalog=Northwind;Integrated Security=True"</span>);
Table&lt;Customer&gt; Customers = db.GetTable&lt;Customer&gt;();</pre></div>
<p>Um zu sehen, was für SQL Befehle ausgeführt werden, gibt es auch ein <a href="http://msdn2.microsoft.com/en-us/library/system.data.linq.datacontext.log.aspx" target="_blank">Log Property</a>, wo wir unsere Console anheften:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">db.Log = Console.Out;</pre></div>
<p>Jetzt zur eigentlichen Abfrage mit LINQ (und der Ausgabe):</p>
<div class="CodeFormatContainer"><pre class="csharpcode">            var custs =
                from c <span class="kwrd">in</span> Customers
                <span class="kwrd">where</span> c.City == <span class="str">"London"</span>
                select c;

            <span class="kwrd">foreach</span> (var cust <span class="kwrd">in</span> custs)
            {
                Console.WriteLine(<span class="str">"ID={0}, City={1}, Address={2}"</span>, cust.CustomerID, cust.City, cust.Address);
            }</pre></div>
<p>Mit der Abfrage werden alle Kunden aus London in "var custs" (das Konzept von "var" ist <a href="{{BASE_PATH}}/2008/01/13/howto-c-30-var-keyword-und-andere-kleine-c-30-features-verstehen/" target="_blank">hier</a> beschrieben) gespeichert. </p>
<p><u>Hinweis:</u> Mit GetTable&lt;...&gt;() werden noch keine Daten vom SQL Server geholt - erst beim Zugriff auf Customers wird die Abfrage gemacht (<a href="http://blogs.msdn.com/charlie/archive/2007/12/13/deferred-execution-video.aspx" target="_blank">Siehe Video</a>). </p>
<p><u>Ergebnis:</u></p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image226.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="237" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb205.png" width="467" border="0"></a> </p>
<p><u>Vollständiger Quellcode:</u></p>
<div class="CodeFormatContainer"><pre class="csharpcode"><span class="kwrd">using</span> System;
<span class="kwrd">using</span> System.Collections.Generic;
<span class="kwrd">using</span> System.Linq;
<span class="kwrd">using</span> System.Text;
<span class="kwrd">using</span> System.Data.Linq;
<span class="kwrd">using</span> System.Data.Linq.Mapping;

<span class="kwrd">namespace</span> LinqToSqlTest
{
    <span class="kwrd">class</span> Program
    {
        <span class="kwrd">static</span> <span class="kwrd">void</span> Main(<span class="kwrd">string</span>[] args)
        {
            <span class="rem">// Use a standard connection string</span>
            DataContext db = <span class="kwrd">new</span> DataContext(<span class="str">@"Data Source=REMAN-NOTEBOOK\SQLEXPRESS;Initial Catalog=Northwind;Integrated Security=True"</span>);
            Table&lt;Customer&gt; Customers = db.GetTable&lt;Customer&gt;();

            db.Log = Console.Out;

            <span class="rem">// Query for customers in London</span>
            var custs =
                from c <span class="kwrd">in</span> Customers
                <span class="kwrd">where</span> c.City == <span class="str">"London"</span>
                select c;

            <span class="kwrd">foreach</span> (var cust <span class="kwrd">in</span> custs)
            {
                Console.WriteLine(<span class="str">"ID={0}, City={1}, Address={2}"</span>, cust.CustomerID, cust.City, cust.Address);
            }

            Console.ReadLine();
        }
    }
}
</pre></div>
<p><strong>LINQ to SQL - Schritt 3: Änderung an der DB vornehmen - einen neuen Eintrag anfügen</strong></p>
<p>Ein neuen Eintrag hinzufügen geht recht schnell:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">            Customer newCostumer = <span class="kwrd">new</span> Customer();
            newCostumer.City = <span class="str">"Dresden"</span>;
            newCostumer.Address = <span class="str">"Riesaer Str. 5"</span>;
            newCostumer.CustomerID = <span class="str">"DDMMS"</span>;
            newCostumer.CompanyName = <span class="str">"T-Systems MMS"</span>;

            Customers.InsertOnSubmit(newCostumer);
            db.SubmitChanges();</pre></div>
<p>Hierbei musste ich aber noch ein neues Property für den Costumer hinzufügen: CompanyName - weil dieser (ebenso wie CustomerID) NOT NULL sein muss:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image227.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="43" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb206.png" width="244" border="0"></a> </p>
<p>Wie oben zu sehen ist, wird einfach ein neuer Customer angelegt und über Customers wird dieses Objekt an (die wir über den DataContext bekommen haben) die Methode "<a href="http://msdn2.microsoft.com/en-us/library/bb763516.aspx" target="_blank">InsertOnSubmit</a>" weitergereicht und dort vorgemerkt, beim "Submitten" in die DB eingetragen zu werden.</p>
<p>Das "Submitten" wird über "<a href="http://msdn2.microsoft.com/en-us/library/system.data.linq.datacontext.submitchanges.aspx" target="_blank">SubmitChanges</a>" vom DataContext gestartet.</p>
<p><strong>LINQ to SQL - Schritt 4: Änderung an der DB vornehmen - einen Eintrag editieren</strong></p>
<p>Das Dateneditiere wird direkt an den Objekten vorgenommen:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">            var upObjects = from test <span class="kwrd">in</span> Customers
                             <span class="kwrd">where</span> test.CompanyName == <span class="str">"T-Systems MMS"</span>
                             select test;

            upObjects.First().Address = <span class="str">"Straße"</span>;
            db.SubmitChanges();</pre></div>
<p>Hier erfolgt nur ein "SubmitChanges" und der erste gefundene Eintrag (über First()) wird entsprechend geändert.</p>
<p><strong>LINQ to SQL - Schritt 5: Änderung an der DB vornehmen - einen Eintrag entfernen</strong></p>
<p>Den eben angelegten Eintrag kann man auch wieder entfernen:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">var delObjects = from test <span class="kwrd">in</span> Customers 
                             <span class="kwrd">where</span> test.CompanyName == <span class="str">"T-Systems MMS"</span>
                             select test;

            Customers.DeleteOnSubmit(delObjects.First());
            db.SubmitChanges();</pre></div>
<p>Hier holen wir uns einfach unser eben erstelltes Objekt wieder und nehmen wieder über die First() Methode das erste gefundene (da es sowieso nur einen Eintrag dort gibt) Ergebnis. Löschen kann man es einfach über "<a href="http://msdn2.microsoft.com/en-us/library/bb763473.aspx" target="_blank">DeleteOnSubmit</a>".</p>
<p><strong>Der gesamte Source Code (download weiter unten):</strong></p>
<div class="CodeFormatContainer"><pre class="csharpcode"><span class="kwrd">using</span> System;
<span class="kwrd">using</span> System.Collections.Generic;
<span class="kwrd">using</span> System.Linq;
<span class="kwrd">using</span> System.Text;
<span class="kwrd">using</span> System.Data.Linq;
<span class="kwrd">using</span> System.Data.Linq.Mapping;

<span class="kwrd">namespace</span> LinqToSqlTest
{
    <span class="kwrd">class</span> Program
    {
        <span class="kwrd">static</span> <span class="kwrd">void</span> Main(<span class="kwrd">string</span>[] args)
        {
            <span class="rem">// Use a standard connection string</span>
            DataContext db = <span class="kwrd">new</span> DataContext(<span class="str">@"Data Source=REMAN-NOTEBOOK\SQLEXPRESS;Initial Catalog=Northwind;Integrated Security=True"</span>);
            Table&lt;Customer&gt; Customers = db.GetTable&lt;Customer&gt;();

            <span class="rem">// Logging</span>
            db.Log = Console.Out;

            <span class="rem">// CREATE</span>
            Customer newCostumer = <span class="kwrd">new</span> Customer();
            newCostumer.City = <span class="str">"Dresden"</span>;
            newCostumer.Address = <span class="str">"Riesaer Str. 5"</span>;
            newCostumer.CustomerID = <span class="str">"DDMMS"</span>;
            newCostumer.CompanyName = <span class="str">"T-Systems MMS"</span>;

            Customers.InsertOnSubmit(newCostumer);
            db.SubmitChanges();
            
            <span class="rem">// READ</span>
            var custs =
                from c <span class="kwrd">in</span> Customers
                <span class="kwrd">where</span> c.City == <span class="str">"Dresden"</span>
                select c;

            <span class="rem">// Debugging - Console.WriteLine</span>
            <span class="kwrd">foreach</span> (var cust <span class="kwrd">in</span> custs)
            {
                Console.WriteLine(<span class="str">"ID={0}, City={1}, Address={2}"</span>, cust.CustomerID, cust.City, cust.Address);
            }
            
            <span class="rem">// UPDATE</span>
            var upObjects = from test <span class="kwrd">in</span> Customers
                             <span class="kwrd">where</span> test.CompanyName == <span class="str">"T-Systems MMS"</span>
                             select test;

            upObjects.First().Address = <span class="str">"Straße"</span>;
            db.SubmitChanges();

            <span class="rem">// Debugging - Console.WriteLine</span>
            <span class="kwrd">foreach</span> (var cust <span class="kwrd">in</span> custs)
            {
                Console.WriteLine(<span class="str">"ID={0}, City={1}, Address={2}"</span>, cust.CustomerID, cust.City, cust.Address);
            }

            <span class="rem">// DEL</span>
            var delObjects = from test <span class="kwrd">in</span> Customers 
                             <span class="kwrd">where</span> test.CompanyName == <span class="str">"T-Systems MMS"</span>
                             select test;

            Customers.DeleteOnSubmit(delObjects.First());
            db.SubmitChanges();
            
            Console.ReadLine();
        }
    }
}
</pre></div>
<p><strong>Wichtiger Hinweis:</strong></p>
<p>Die Anwendung läuft nur einmal durch, da die CustomerID eindeutig sein muss - aber das hier soll nur der Anfang sein um LINQ to SQL mehr zu verstehen.<br>Das die LINQ Abfragen hier sicherlich verbesserungswürdig sind, ist eine andere Sache (und wird sicherlich in einem anderen HowTo unterkommen).</p>
<p>Das Mapping erfolge hier sehr einfach über das manuelle dazu schreiben der Attribute - es gibt einen direkten LINQ to SQL Designer.</p>
<p><strong>Empfehlung an alle die sich für LINQ to SQL interessieren:</strong></p>
<p>Das <a href="http://download.microsoft.com/download/0/e/2/0e255cf3-b11f-44cb-b42c-7d55ed7b556c/LINQ_to_SQL_Hands_on_Lab.doc" target="_blank">HoL über LINQ to SQL</a>, was ich bereits oben erwähnt hatte, geht noch auf andere Aspekte ein. Einige davon werde ich sicherlich selber noch in HowTos packen, allerdings bis dahin dient es als gute Anlaufstelle zu Themen wie:</p>
<ul>
<li>LINQ to SQL Designer</li>
<li>Beziehungen zwischen einzelnen Tabellen modellieren</li>
<li>Streng-typisierte DataContext Objekte</li>
<li>Transaktionen (Sehr interessantes Thema!)</li>
<li>Mapping a stored procedure</li></ul>
<p>Das Thema wird sicherlich bei mir noch häufiger anzutreffen sein (und das war heute mein erster richtiger Berührungspunkt mit LINQ to SQL - ich hoffe, dass das Konzept (und wie es intern tickt) etwas klarer ist ;) )</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/linqtosqltest/linqtosqltest.zip" target="_blank">[ Download Demoanwendung ]</a></strong></p>
