---
layout: post
title: "HowTo: Datenbankverbindungen - .NET & MySQL"
date: 2007-11-27 20:52
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.NET, Datenbank, HowTo, MySQL, SQL]
---
{% include JB/setup %}
In diesem <a target="_blank" href="http://code-inside.de/blog/2007/11/21/howto-datenbankverbindungen-net-ms-sql-2005/">HowTo</a>Â ging es um die Datenverbindung zwischen .NET und MS SQL. Natürlich bietet .NET von Haus aus einen MS SQL Provider, aber wie sieht es mit MySQL aus? Wie kann man mit .NET auf eine MySQL Datenbank zugreifen?

Daher geht es um dieses Thema:

<strong><u>Heute: .NET und MySQL</u></strong>

Das Testprojekt wird ähnlich wie das MS SQL Beispiel sein.
<ul>
	<li><strong>Benötigte Software:</strong></li>
</ul>
Die Datenbank Software MySQL - aus Einfachheitsgründen nehmen wir einfach ein vorgefertigtes Paket, welches unter PHP Entwicklern wohl bekannt ist: <a target="_blank" href="http://www.apachefriends.org/en/xampp-windows.html">XAMPP</a> - Apache, PHP, MySQL etc. im Bundel. Wer bereits einen MySQL Server hat braucht das natürlich nicht.
Um mit .NET darauf zuzugreifen benötigen wir noch den <a target="_blank" href="http://dev.mysql.com/downloads/connector/net/5.0.html">MySQL Daten Provider - MySQL Connector .NET 5.0</a>.
(und natürlich VS - siehe erstes HowTo).
<ul>
	<li><strong>Test Datenbank erstellen (MySQL mit XAMPP)</strong></li>
</ul>
Sobald XAMPP erfolgreich auf dem System installiert wurde, öffnet man das Control Panel und startet den Apachen sowie den MySQL Server.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image163.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images/image-thumb142.png" alt="image" height="190" style="border: 0px" /></a>

Bei Vista (und wahrscheinlich auch bei XP SP2) meckert die Firewall - die beiden Sachen nicht blocken.

Unter der Webadresse <a href="http://localhost/xampp/index.php">http://localhost/xampp/index.php</a> findet man nun das Administrationspanel. Im Menü auf der linken Seite befindet sich der für uns wichtigste Punkt:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image164.png"><img border="0" width="139" src="{{BASE_PATH}}/assets/wp-images/image-thumb143.png" alt="image" height="71" style="border: 0px" /></a>

Über phpMyAdmin legen wir unser Datenbank an ("<strong>dotnet</strong>") und dann unsere Tabelle "<strong>test</strong>"Â mit Spalte "<strong>id</strong>" als "autoincrement int" und "<strong>value</strong>" als "varchar" für unseren Text.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image165.png"><img border="0" width="441" src="{{BASE_PATH}}/assets/wp-images/image-thumb144.png" alt="image" height="293" style="border: 0px" /></a>

Danach auf "Speichern" und fertig ist unser DB.

Wichtig: Den MySQL Server die ganze Zeit über anlassen - den brauchen wir bis zuletzt ;)
<ul>
	<li><strong>MySQL Connector installieren</strong></li>
</ul>
Damit wir einen MySQL Datenprovider bekommen, müssen wir nun den Connector installieren.
<ul>
	<li><strong>Konsolenprogramm erstellen</strong></li>
</ul>
In unserem Konsolenprogramm fügen wir nun noch die Referenz zu der MySQL.Data DLL hinzu, sodass wir den Namespace später verwenden können:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image166.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images/image-thumb145.png" alt="image" height="216" style="border: 0px" /></a>

Unter dem Punkt "MySQL.Data" finden wir dann unseren Connector:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image167.png"><img border="0" width="642" src="{{BASE_PATH}}/assets/wp-images/image-thumb146.png" alt="image" height="303" style="border: 0px" /></a>

Dadurch steht uns jetzt die Namespaces MySql.Data &amp; MySql.Data.MySqlClient zur verfügen welche wir einbinden:
<pre class="csharpcode"><span class="kwrd">using</span> MySql.Data; 
<span class="kwrd">using</span> MySql.Data.MySqlClient;</pre>
<strong>Teil 1: DB Verbindung öffnen</strong>

Der Namespace MySqlClient enthält alles was wir generell brauchen und ist ähnlich sturkturiert wie SqlClient für MS SQL. Anstatt einer <strong>SqlConnection</strong> Klasse gibt es halt eine <strong>MySqlConnection</strong> Klasse.
<pre class="csharpcode">            MySqlConnection connection = <span class="kwrd">new</span> MySqlConnection(<span class="str">@"Server=127.0.0.1;Uid=root;Pwd=;Database=dotnet;"</span>); 
            connection.Open();</pre>
<u>Wichtig: </u>Der Connectionsstring ist etwas anders - MySQL stellt allerdings ein <a target="_blank" href="http://dev.mysql.com/doc/refman/5.1/de/connector-net-using-connecting.html">kleines Tutorial</a> bereit, sowie bei speziellen Fragen auch ein <a target="_blank" href="http://forums.mysql.com/list.php?38">Forum</a>.
<u>Achtung:</u> DB Verbindung wird am Ende unseres Beispieles wieder geschlossen.

<strong>Teil 2: Werte in die DB schreiben</strong>

Hier sieht man ebenfalls die Anlehnung an die SqlCommand Klasse - es gibt eine <strong>MySqlCommand</strong> Klasse, welche alle (bzw. die "wichtigsten") Methoden ebenso enthält:
<pre class="csharpcode">            MySqlCommand insertCommand = <span class="kwrd">new</span> MySqlCommand(<span class="str">"INSERT INTO test (value) VALUES ('Test')"</span>, connection); 
            <span class="kwrd">int</span> i = insertCommand.ExecuteNonQuery();</pre>
<strong>Teil 3: Werte aus der DB lesen</strong>

Für das befüllen eines <a target="_blank" href="http://msdn2.microsoft.com/en-us/library/system.data.dataset.aspx">Datasets</a> oder einer <a target="_blank" href="http://msdn2.microsoft.com/En-US/library/system.data.datatable.aspx">Datatable</a> gibt es den MySqlDataAdapter mit der "Fill(...)" Methode (gleiches System wie bei MS SQL, nur mal mit MySql davor ;) ).
<pre class="csharpcode">            MySqlCommand readCommand = <span class="kwrd">new</span> MySqlCommand(<span class="str">"SELECT * FROM test"</span>, connection); 
            MySqlDataAdapter adapter = <span class="kwrd">new</span> MySqlDataAdapter(readCommand); 
            DataTable datatable = <span class="kwrd">new</span> DataTable();  

            adapter.Fill(datatable); 
            <span class="kwrd">for</span> (<span class="kwrd">int</span> x = 0; x &lt; datatable.Rows.Count; x++) 
            { 
                <span class="kwrd">object</span>[] values = datatable.Rows[x].ItemArray; 
            }</pre>
<strong>Teil 4: Daten in der DB ändern</strong>

Ebenso implementieren wie das schreiben von Daten, nur anderes SQL Statement &amp; wieder benutzen wir MySqlCommand dafür.
<pre class="csharpcode">            MySqlCommand updateCommand = <span class="kwrd">new</span> MySqlCommand(<span class="str">"UPDATE test SET value = 'UpdatedTest'"</span>, connection); 
            <span class="kwrd">int</span> updatedReturnValue = updateCommand.ExecuteNonQuery();</pre>
<strong>Teil 5: Daten aus der DB löschen</strong>

Ebenso wie oben beschrieben &amp; gleiches Prinzip wie bei unserem MS SQL Beispiel.
<pre class="csharpcode">                MySqlCommand deleteCommand = <span class="kwrd">new</span> MySqlCommand(<span class="str">"DELETE FROM test"</span>, connection); 
                <span class="kwrd">int</span> deleteReturnValue = deleteCommand.ExecuteNonQuery();</pre>
<pre class="csharpcode"><a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image168.png"></a> <a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image168.png"><img border="0" width="555" src="{{BASE_PATH}}/assets/wp-images/image-thumb147.png" alt="image" height="277" style="border: 0px" /></a></pre>
<strong>Abschließende Bemerkung</strong>

Der .NET Connector von MySQL erlaubt es auf sehr einfache Art und Weise auf eine MySQL DB zuzugreifen - wer bereits mit MS SQL und .NET zutun hatte, kann ebenso "leicht" mit MySQL arbeiten. Die tiefergehenden Sachen sollten dann direkt bei MySql nachgeschaut werden, wie z.B. <a target="_blank" href="http://dev.mysql.com/doc/refman/5.1/de/connector-net-using-stored.html">der Zugriff auf gespeicherte Prozeduren</a> oder <a target="_blank" href="http://dev.mysql.com/doc/refman/5.1/de/connector-net-using-blob.html">BLOB Daten verarbeiten</a>.
Wie auch bei dem MS SQL Beispiel gilt auch hier: Der Code soll nur demonstrieren, wie man ganz primitiv auf die DB zugreift.Â Es gibt bestimmt bessere Methoden, allerdings soll dies nur eine Einführung sein und zeigt schon ganz gut, das man .NET und MySQL auch sehr gut zusammen nutzen kann.

<strong>Infos für den Source Code:</strong>

Die Tabelle sollte "test" heißen und die Spalten "id" und "value". Die Datenbank sollte "dotnet" heißen oder der Connectionstring sollte geändert werden. Falls man eine bereits eingerichtete MySql DB nutzt, muss man natürlich die Zugangsdaten entsprechend anpassen.

<strong><a target="_blank" href="{{BASE_PATH}}/assets/files/democode/dotnetmysql/testdatenbankmysql.zip">[ Download Source Code ]</a></strong>
