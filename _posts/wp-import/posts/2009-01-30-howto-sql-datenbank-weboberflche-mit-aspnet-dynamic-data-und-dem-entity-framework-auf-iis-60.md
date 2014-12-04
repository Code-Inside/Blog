---
layout: post
title: "HowTo: SQL Datenbank Weboberfläche mit ASP.NET Dynamic Data und dem Entity Framework (auf IIS 6.0)"
date: 2009-01-30 00:09
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Admin, ASP.NET Dynamic Data, Dynamic Data, HowTo, IIS 6.0, Routing]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image605.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="71" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb583.png" width="143" align="left" border="0" /></a> Ich habe meine ersten richtigen Programmiererfahrungen mit PHP in Zusammenhang mit MySQL gemacht. Als Datenbank-Administrationspanel diente eine sehr praktische Weboberfl&#228;che namens &quot;<a href="http://www.phpmyadmin.net/home_page/index.php">PhpMyAdmin</a>&quot;.    <br />Es hat zwar nicht den kompletten Komfort eines <a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=C243A5AE-4BD1-4E3D-94B8-5A0F62BF7796&amp;displaylang=de">SQL Management Studios</a>, allerdings war es mit jedem Browser zu erreichen und daher leicht f&#252;r jedermann nutzbar.     <br />Mit den <a href="http://www.asp.net/dynamicdata/">ASP.NET Dynamic Data</a> und <a href="http://msdn.microsoft.com/de-de/library/bb386976.aspx">Linq2Sql</a> bzw. dem <a href="http://msdn.microsoft.com/en-us/library/aa697427(VS.80).aspx">Entity Framework</a> kann man sich innerhalb von wenigen Minuten eine nette Administrationsoberfl&#228;che erstellen, fast ohne Programmieraufwand.</p> 
<!--more-->
  <p><strong>Einf&#252;hrung in ASP.NET Dynamic Data     <br /></strong>Dieses Feature kam mit .NET 3.5 SP1 hinzu. Wenn man ein neues Projekt anlegt findet man diese beiden Templates:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image606.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="162" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb584.png" width="505" border="0" /></a> </p>  <p>Beide Templates machen fast dasselbe, allerdings gibt es einen gro&#223;en Unterschied:</p>  <ul>   <li>Dynamic Data <strong>Entities</strong> Web Applications: Im Zusammenhang mit dem ADO.NET Entity Framework nutzbar</li>    <li>Dynamic Data Web Application: Im Zusammenhang mit Linq2Sql nutzbar</li> </ul>  <p><em>Falls man das Entity Framework nimmt und nicht das passende Template aussucht, kommt es sp&#228;ter zur Laufzeit zu diesem Fehler: &quot;The method 'Skip' is only supported for sorted input in LINQ to Entities&quot;&#160; - auch wenn der Kommentar in dem Templates aussagt, dass beides geht :/ (<a href="http://blogs.oosterkamp.nl/blogs/jowen/archive/2008/10/15/dynamic-data-choose-the-right-template.aspx">Quelle</a>)</em></p>  <p>Beide Templates nehmen eine Datacontext entgegen und bauen anhand dieser Informationen dynamisch die Oberfl&#228;che auf. Klassische CRUD Templates sind enthalten und k&#246;nnen auch nach belieben angepasst werden. </p>  <p><strong>Schritt 1: ASP.NET Dynamic Data Entites Web Projekt erstellen     <br /></strong>Wir w&#228;hlen also, da wir das Entity Framework benutzen, das Enties Projekt aus und sehen dann folgende Dateien:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image607.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb585.png" width="174" border="0" /></a> </p>  <p>Unter &quot;DynamicData&quot; findet sich auch zwei Templates Order:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image608.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="309" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb586.png" width="181" border="0" /></a> </p>  <p>Unter den PageTemplates findet man die Templates f&#252;r CRUD und die FieldTemplates beinhalten die Templates daf&#252;r, wie einzelne Felder (z.B. ein Datum) gerendert werden. Alles kann man editieren und erweitern.</p>  <p>Wir k&#246;nnen aber gut mit den Standardlayout leben und wollen auch nichts ver&#228;ndern, daher weiter zu Schritt 2.</p>  <p><strong>Schritt 2: Entity Model anlegen</strong>    <br /> Jetzt brauchen wir nat&#252;rlich noch unsere Datenbank, aus der das Entity Model generiert werden soll. Ich hab mich jetzt f&#252;r die Northwind Datenbank entschieden (wie diese auf einen SQL Server 2005/2008 zu installieren ist, kann <a href="{{BASE_PATH}}/2008/01/13/howto-beispieldatenbank-adventureworks-und-northwind-auf-sql-server-2005-installieren/">hier nachgelesen werden</a>).     <br />Wir legen nun das Model an:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image609.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="217" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb587.png" width="244" border="0" /></a> </p>  <p>Verbinden uns mit der Datenbank (wenn eure DB lokal l&#228;uft und der Express-Server ist bei Server &quot;.\SQLExpress&quot; eingeben) und w&#228;hlt alle Tabellen aus:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image610.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="305" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb588.png" width="343" border="0" /></a> </p>  <p><strong>Schritt 3: Datacontext &#252;bergeben     <br /></strong>Nun kommt der eigentlich spannende Teil: Wir &#252;bergeben dem DynamicData &quot;<a href="http://msdn.microsoft.com/de-de/library/system.web.dynamicdata.metamodel.aspx">MetaModel</a>&quot; den Datacontext, indem wir einfach das machen, was in den Kommentaren steht:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c13a7352-ff64-49e8-8080-12da11796598" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">MetaModel model = new MetaModel();

            //                    IMPORTANT: DATA MODEL REGISTRATION 
            // Uncomment this line to register LINQ to SQL classes or an ADO.NET Entity Data
            // model for ASP.NET Dynamic Data. Set ScaffoldAllTables = true only if you are sure 
            // that you want all tables in the data model to support a scaffold (i.e. templates) 
            // view. To control scaffolding for individual tables, create a partial class for 
            // the table and apply the [Scaffold(true)] attribute to the partial class.
            // Note: Make sure that you change "YourDataContextType" to the name of the data context
            // class in your application.
            
            //--&gt; Code-Inside Change HERE! 
            model.RegisterContext(typeof(NorthwindEntities), new ContextConfiguration() { ScaffoldAllTables = true });
</pre></div>

<p>NorthwindEntities ist mein Datacontext und &quot;ScaffoldAllTables&quot; ist prinzipell ein Sicherheitsrisiko&#178;, da damit alle Tabellen in der Anwendung zum freien Zugriff freigegeben werden. Man kann dies auch entsprechend umkonfigurieren, allerdings nutze ich dieses Feature auch nur um Webzugriff auf meine Datenbank zu haben und habe dies &#252;ber den IIS abgesichert.</p>

<p><strong>Resultat
    <br /></strong>Das Resultat (nach wenigen Klicks) sieht schon ordentlich aus:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image611.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="416" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb589.png" width="271" border="0" /></a> 

  <br />&#220;bersichtsseite</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image612.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="263" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb590.png" width="539" border="0" /></a> 

  <br />Auflistungen</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image613.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="304" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb591.png" width="303" border="0" /></a>&#160; <br />Detailseite</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image614.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="294" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb592.png" width="315" border="0" /></a> 

  <br />Editierseite</p>

<p><strong>Fazit</strong>

  <br />F&#252;r eine Adminseite ist es sehr gut und innerhalb weniger Minuten (wenn Linq2Sql oder EF eingesetzt wird!) funktionst&#252;chtig.

  <br />Ganz klappt der Vergleich mit dem PhpMyAdmin nat&#252;rlich nicht, denn man kann nat&#252;rlich das Mapping entsprechend so &#228;ndern, dass es nur noch wenig mit der Datenbank zutun hat - &#252;ber PhpMyAdmin kann man auch direkt SQL eingeben.</p>

<p><strong>Dynamic Data on IIS 6
    <br /></strong>Dynamic Data baut ebenfalls auf der Routing API auf, die auch ASP.NET MVC nutzt, dadurch kommen solche URLs zustande:

  <br /><a title="http://localhost:52016/Alphabetical_list_of_products/Edit.aspx?CategoryName=Beverages&amp;Discontinued=False&amp;ProductID=1&amp;ProductName=Chai" href="http://localhost:52016/Alphabetical_list_of_products/Edit.aspx?CategoryName=Beverages&amp;Discontinued=False&amp;ProductID=1&amp;ProductName=Chai">http://localhost:52016/Alphabetical_list_of_products/Edit.aspx?CategoryName=Beverages&amp;Discontinued=False&amp;ProductID=1&amp;ProductName=Chai</a></p>

<p>Damit das funktioniert, muss diese <a href="http://blog.codeville.net/2008/07/04/options-for-deploying-aspnet-mvc-to-iis-6/">Anleitung</a> befolgt werden. </p>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/dynamicdataadmin/dynamicdataadmin.zip">[ Download Democode (ohne DB) ]</a></strong></p>
