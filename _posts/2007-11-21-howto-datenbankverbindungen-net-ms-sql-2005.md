---
layout: post
title: "HowTo: Datenbankverbindungen - .NET & MS SQL 2005"
date: 2007-11-21 19:51
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.NET, Datenbank, HowTo, SQL, SQL Server 2005]
---
Datenbanken sind immer ein zentrales Thema, aber als Einsteiger in das Thema hatte ich damals keinen guten Überblick, wie man das ganze mit .NET zum Laufen bekommt. Daher hier eine kleine "Einführung" zum Thema Datenbankverbindungen - Datenbank X mit .NET.

<strong><u>Heute: .NET und Microsoft SQL 2005</u></strong>

Das Testprojekt ist sehr sehr simpel gehalten - das Thema ADO.NET ist sehr groß, daher wollte ich nur auf primitivste Art und Weise zeigen, wie man sich zu einer DB verbinden und dort Aktionen ausführen kann. Typisierte Datasets oder O/R Mapper wie Linq to SQL oder Subsonic etc. können ebenfalls genutzt werdne. Insbesondere mit Linq werde ich mich auch noch zuwenden, aber vorher mal zu den "Basics" ;)
<ul>
	<li><strong>Benötigte Software:</strong></li>
</ul>
Die Datenbank-Software - SQL ServerÂ 2005 Express Edition -Â gibts <a target="_blank" href="http://www.microsoft.com/germany/msdn/vstudio/products/express/sql/default.mspx">hier zum Runderladen</a>.
Die Management Software - SQL Server Management StudioÂ Express - gibts <a target="_blank" href="http://www.microsoft.com/downloads/details.aspx?FamilyID=c243a5ae-4bd1-4e3d-94b8-5a0f62bf7796&amp;DisplayLang=de">hier zum Runderladen</a>.
Visual Studio 2005 Express Edition gibts <a target="_blank" href="http://www.microsoft.com/germany/msdn/vstudio/products/express/default.mspx">hier zum Runterladen</a>.
<ul>
	<li><strong>Test Datenbank erstellen:</strong></li>
</ul>
Sobald unter den Windows Dienster der "SQL Server (SQLEXPRESS)" gestartet ist (nach der Installation ist dies standardmäßig automatisch der Fall), können wir über das SQL Management Studio Express unsere Testdatenbank anlegen.

<strong><a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image155.png"><img border="0" width="643" src="{{BASE_PATH}}/assets/wp-images/image-thumb134.png" alt="image" height="114" style="border-width: 0px" /></a> </strong>

Das anlegen einer Testdatenbank wurde <a target="_blank" href="http://code-inside.de/blog/artikel/howto-microsoft-pp-web-service-factory-service-factory-teil-3-praktisches-hello-world/">ebenfalls bereits bei den Software Factories behandelt</a>, sodass ich jetzt am Ende diese TestdatenbankÂ habe:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image156.png"><img border="0" width="285" src="{{BASE_PATH}}/assets/wp-images/image-thumb135.png" alt="image" height="85" style="border-width: 0px" /></a>
<ul>
	<li><strong>Konsolenprojekt erstellen</strong></li>
</ul>
Wir erstellen einfach ein kleines Konsolenprojekt und wollen einfach ein paar Eintragungen vornehmen, ein Eintrag abändern, die Daten auslesen und wieder löschen. Das selbe werden wir zudem später mit Oracle und MySQL versuchen.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image157.png"><img border="0" width="251" src="{{BASE_PATH}}/assets/wp-images/image-thumb136.png" alt="image" height="79" style="border-width: 0px" /></a>

Im "Server Explorer" fügen wir unsere Datenbankverbindung hinzu:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image158.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images/image-thumb137.png" alt="image" height="87" style="border-width: 0px" /></a>

Als Datenquelle geben wir "Microsoft SQL Server" an und als Datenanbieter ".NET Framework-Datenanbieter für SQL":

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image159.png"><img border="0" width="353" src="{{BASE_PATH}}/assets/wp-images/image-thumb138.png" alt="image" height="199" style="border-width: 0px" /></a>

Sobald man sich mit der jeweiligen Datenbank verbunden hat, sieht man in den Eigenschaften den "ConnectionString":

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image160.png"><img border="0" width="528" src="{{BASE_PATH}}/assets/wp-images/image-thumb139.png" alt="image" height="45" style="border-width: 0px" /></a>

Ansonsten brauchen wir diese Verbindung im VS eigentlich nicht. Es gibt aber Steuerelemente die darauf zugreifen können - in unserem sehr einfachen Beispiel benötigen wir das aber nicht.

Eine gute Auflistung von den ConnectionsStrings und ihrer Zusammensetzungen findet man hier: <a href="http://www.connectionsstrings.com">www.connectionsstrings.com</a>

Die Demoanwendung ist sehr einfach und kann weiter unten runtergeladen werden.

<strong>Teil 1: DB Verbindung öffnen</strong>

Über die Klasse "<a target="_blank" href="http://msdn2.microsoft.com/de-de/library/system.data.sqlclient.sqlconnection(VS.80).aspx">SqlConnection</a>" öffnen wir eine Verbindung zur Datenbank.
<u>Achtung:</u> Die DB Verbindung sollte unbedingt wieder am Ende geschlossen werden - man kann dies auch über das "<a target="_blank" href="http://msdn2.microsoft.com/en-us/library/yh598w02(vs.80).aspx">using-Statement</a>" erreichen

<div class="CodeFormatContainer">
<pre class="csharpcode">            SqlConnection connection = <span class="kwrd">new</span> SqlConnection(<span class="str">@"Data Source=REMAN-NOTEBOOK\SQLEXPRESS;Initial Catalog=Test;Integrated Security=True"</span>); 

Â            connection.Open();</pre></div>
<strong>Teil 2: Werte in die DB schreiben</strong>

Einen SQL Befehl an die DB schicken geht ganz einfach über die Klasse "<a target="_blank" href="http://msdn2.microsoft.com/de-de/library/system.data.sqlclient.sqlcommand(VS.80).aspx">SqlCommand</a>", wo wir noch unsere Verbindung als Parameter mitgeben und diese Ausführen. Der Rückgabewerte entspricht der Anzahl an Zeilen, welche durch den SqlBefehl angepasst werden mussten.
<div class="CodeFormatContainer">
<pre class="csharpcode">SqlCommand insertCommand = <span class="kwrd">new</span> SqlCommand(<span class="str">"INSERT INTO [Test].[dbo].[Test] ([value]) VALUES ('Test')"</span>, connection); 

Â            <span class="kwrd">int</span> i = insertCommand.ExecuteNonQuery();</pre></div>
<strong>Teil 3: Daten aus der Datenbank holen</strong>

Um auf die Werte aus der Datenbank zuzugreifen wird es ein klein wenig komplizierter. Unser SqlCommand (Select * From...) wird einem <a target="_blank" href="http://msdn2.microsoft.com/de-de/library/system.data.sqlclient.sqldataadapter(VS.80).aspx">SqlDataAdapter</a> übergeben, welcher eine <a target="_blank" href="http://msdn2.microsoft.com/en-us/library/system.data.datatable.aspx">DataTable</a> füllt. Diese DataTable enthält dann unsere gesamte Tabelle samt den Werten. Eine andere Vorgehensweise ist sicherlich auch möglich (Datasets/typisierte Datasets...) wurde hier aber aus den oben genannten Gründen nicht gemacht.
<div class="CodeFormatContainer">
<pre class="csharpcode">            SqlCommand readCommand = <span class="kwrd">new</span> SqlCommand(<span class="str">"SELECT * FROM [Test].[dbo].[Test]"</span>, connection); 

Â            SqlDataAdapter adapter = <span class="kwrd">new</span> SqlDataAdapter(readCommand); 

Â            DataTable datatable = <span class="kwrd">new</span> DataTable();            adapter.Fill(datatable); 

Â            <span class="kwrd">for</span> (<span class="kwrd">int</span> x = 0; x &lt; datatable.Rows.Count; x++) 

Â            { 

Â                <span class="kwrd">object</span>[] values = datatable.Rows[x].ItemArray; 

Â            }</pre></div>
In values[0] sind die Werte enthalten die in der Spalte "ID" stehen und in values[1] die in der Spalte "values". Diese kann man nun in andere Objekte casten usw.

<strong>Teil 4: Daten aus der Datenbank ändern</strong>

Entspricht der Vorgehensweise wie beim Werteschreiben, nur halt mit einem anderen Sql Befehl:
<div class="CodeFormatContainer">
<pre class="csharpcode">            SqlCommand updateCommand = <span class="kwrd">new</span> SqlCommand(<span class="str">"UPDATE [Test].[dbo].[Test] SET value = 'UpdatedTest'"</span>, connection); 

Â            <span class="kwrd">int</span> updatedReturnValue = updateCommand.ExecuteNonQuery();</pre></div>
<strong>Teil 5: Daten aus der Datenbank löschen</strong>

Ebenfalls so wie oben beschrieben:
<div class="CodeFormatContainer">
<pre class="csharpcode">SqlCommand deleteCommand = <span class="kwrd">new</span> SqlCommand(<span class="str">"DELETE FROM [Test].[dbo].[Test]"</span>, connection); 

Â                <span class="kwrd">int</span> deleteReturnValue = deleteCommand.ExecuteNonQuery();</pre>
<pre class="csharpcode">Â </pre></div>
<strong>Abschließende Bemerkung</strong>

In der praxis würde ich eher <a target="_blank" href="http://msdn2.microsoft.com/de-de/library/8bw9ksd6(VS.80).aspx">typisierte Datasets</a> oder andere O/R Mapper einsetzen. Die Software Factories (siehe <a target="_blank" href="http://code-inside.de/blog/artikel/howto-microsoft-pp-web-service-factory-service-factory-teil-3-praktisches-hello-world/">Service Factory</a>)bringen zudem ebenfalls einen "O/R" Mapper mit, welcher "zusammen klickbar" ist und daher die lästige Schreibarbeit für die CRUD Befehle erspart.
<a target="_blank" href="http://msdn2.microsoft.com/en-us/netframework/aa904594.aspx">LINQ to SQL</a> oder <a target="_blank" href="http://www.subsonicproject.com/">Subsonic</a> gehen ebenfalls in die Richtung O/R Mapper und sind ebenfalls sehr interessant, sodass dieser Post nur mal die "basics" vermitteln sollte.

<strong>Achtung:</strong> Zum Ausführen des Democodes muss natürlich der ConnectionString und die DB so erstellt sein, wie oben beschrieben. Auserdem sollte Visual Studio im Administrator-Modus laufen, ansonsten gibts leider einen Fehler.

<strong>[ </strong><a href="http://{{BASE_PATH}}/assets/files/democode/dotnetmssql/testdatenbankmssql.zip"><strong>Download Democode</strong></a><strong> ]</strong>
