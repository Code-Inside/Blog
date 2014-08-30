---
layout: post
title: "HowTo: O/R Mapper LINQ to SQL - Einführung in den Designer & 1:N Beziehungen"
date: 2008-01-21 20:16
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.NET, .NET 3.5, HowTo, LINQ, LINQ to SQL, Northwind, O/R Mapper]
---
{% include JB/setup %}
<p>Im letzten HowTo rund um LINQ to SQL ging es mehr darum, ein Grundverständnis zu vermitteln. Das manuelle Mapping ist eine Methode, wie man LINQ to SQL nutzen kann - mit Visual Studio 2008 (selbst in der Express Edition) ist auch ein LINQ to SQL Designer Template mit dazugekommen:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image230.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="107" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb209.png" width="173" border="0"></a> </p> <p><strong><u>Variante A: Unser einfaches Costumer Beispiel diesmal mit dem Designer</u></strong></p> <p><strong>Schritt 1: .dbml Datei erstellen</strong></p> <p>Nachdem eine solche "xxx.dbml" Datei erstellt hat - in unserem Beispiel wollen wir wieder die Costumer Tabelle aus der Northwind Database auslesen (Installationsanleitung), daher "Costumers.dbml" - sieht man nur eine solche Meldung:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image231.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="72" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb210.png" width="404" border="0"></a> </p> <p><strong>Schritt 2: DB Verbindung hinzufügen</strong></p> <p>Über den DB Explorer legen wir eine Verbindung zu einem Microsoft SQL Server Database File her:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image232.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="140" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb211.png" width="244" border="0"></a> </p> <p>Danach wählen wir unserer Northwind.MDF (Standardinstallationspfad: "C:\SQL Server 2000 Sample Databases\NORTHWND.MDF").</p> <p><strong>Schritt 3: Tabellen auf die Designer Oberfläche ziehen</strong></p> <p>Im nächsten Schritt ziehen wir einfach die jeweiligen Tabellen die wir haben wollen (in unserem Fall die Costumers) auf die Oberfläche:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image233.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="88" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb212.png" width="244" border="0"></a> </p> <p>Visual Studio 2008 erstellt daraufhin folgende Sturktur:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image234.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="57" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb213.png" width="198" border="0"></a> </p> <ul> <li>Customer.dbml.layout = XML Beischreibung  <li>Costomer.dbml.cs = Der eigenliche Code mit sämtlichen Attributen und dem </li></ul> <p>Allerdings landet in der Customer.designer.cs nicht nur wie bei dem vorherigen HowTo die MappingInformationen der Tabelle, sondern es wird zugleich auch gleich eine spezielle DataContext Klasse "CostumerDataContext" gebildet:</p> <p>&nbsp;</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image235.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="259" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb214.png" width="549" border="0"></a> </p> <p>Die Interfaces INotifyPropertyChanging &amp; INotifyPropertyChanged wurden ebenfalls implementiert - WPF benutzt dies zum Beispiel im Kontext mit Databinding, was hier ja quasi ebenfalls passiert.</p> <p>&nbsp;<strong>Schritt 4: Daten abrufen, verändern und löschen</strong></p> <p>Jetzt können wir die selben Befehle ausführen, wie in unserem anderen Beispiel:</p> <div class="CodeFormatContainer"><pre class="csharpcode"><span class="kwrd">using</span> System;
<span class="kwrd">using</span> System.Collections.Generic;
<span class="kwrd">using</span> System.Linq;
<span class="kwrd">using</span> System.Data.Linq;
<span class="kwrd">using</span> System.Text;

<span class="kwrd">namespace</span> LinqToSqlDesigner
{
    <span class="kwrd">class</span> Program
    {
        <span class="kwrd">static</span> <span class="kwrd">void</span> Main(<span class="kwrd">string</span>[] args)
        {
            CustomerDataContext context = <span class="kwrd">new</span> CustomerDataContext();
            Table&lt;Customer&gt; customerTable = context.GetTable&lt;Customer&gt;();

            var customerResult = from customer <span class="kwrd">in</span> customerTable 
                                 <span class="kwrd">where</span> customer.City == <span class="str">"London"</span>
                                 select customer;

            <span class="kwrd">foreach</span> (Customer oneCustomer <span class="kwrd">in</span> customerResult)
            {
                Console.WriteLine(oneCustomer.CompanyName);
            }
            
            Console.ReadLine();
            
        }
    }
}
</pre></div>
<p>Diese Variante ist so nicht zu empfehlen - jedenfalls sollte die dbml nicht nach einer Tabelle genannt werden. In der nächsten Variante sieht man gut, wie man eine größere Datenbank mit einer dbml abbilden kann.</p>
<p><strong><u>Variante B: 1:N Beziehungen mit dem Designer</u></strong></p>
<p>Das war ja jetzt nicht sonderlich spannend, allerdings ist es auch möglich direkt im Designer 1:N Beziehungen vorzunehmen.<br>Dazu erstellen wir uns wieder unsere LINQ to SQL "Northwind.dbml" und wählen jetzt mal den Customers und die Orders aus:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image236.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="265" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb215.png" width="374" border="0"></a> <br>Der "Pfeil", also die Association, zwischen CustomerID aus der Customer Klasse/Tabelle und der CustomerID aus der Order Klasse/Tabelle wird automatisch gebildet (wahrscheinlich weil diese Assoziation bereits im DB System bekannt ist - ob das Mapping auch anhand des Namens erfolgt, habe ich momentan nicht getestet). Man kann diese Assoziation allerdings auch selber bearbeiten, indem man in den Eigenschaften des "Pfeils" schaut:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image237.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="114" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb216.png" width="244" border="0"></a> </p>
<p>Eigenschaften:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image238.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="131" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb217.png" width="358" border="0"></a> </p>
<p>Der <a href="http://msdn2.microsoft.com/en-us/library/bb384429.aspx" target="_blank">LINQ to SQL O/R&nbsp; Designer</a> besitzt ebenso eine eigene Toolbox, mit welchen man auch einige eigene Sachen erstellen kann:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image239.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="146" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb218.png" width="209" border="0"></a> </p>
<p>Wenn man nun noch zwei weitere Tabellen in den Designer zieht, macht das langsam einen recht schicken Eindruck:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image240.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="318" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb219.png" width="254" border="0"></a> </p>
<p>Dadurch habe wir innerhalb weniger Minuten bereits folgende fertige Klassen zur Verfügung:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image241.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="129" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb220.png" width="189" border="0"></a> </p>
<p>Jetzt machen wir mal wieder unsere Abfrage um zu zeigen, was man damit machen kann:</p>
<div class="CodeFormatContainer"><pre class="csharpcode"><span class="kwrd">using</span> System;
<span class="kwrd">using</span> System.Collections.Generic;
<span class="kwrd">using</span> System.Linq;
<span class="kwrd">using</span> System.Text;
<span class="kwrd">using</span> System.Data.Linq;

<span class="kwrd">namespace</span> LinqToSqlDesigner
{
    <span class="kwrd">class</span> Program
    {
        <span class="kwrd">static</span> <span class="kwrd">void</span> Main(<span class="kwrd">string</span>[] args)
        {
            NorthwindDataContext context = <span class="kwrd">new</span> NorthwindDataContext();
            Table&lt;Customer&gt; customerTable = context.GetTable&lt;Customer&gt;();

            var cust = from c <span class="kwrd">in</span> customerTable
                       <span class="kwrd">where</span> c.City == <span class="str">"London"</span>
                       select c;

            <span class="kwrd">foreach</span>(Customer customer <span class="kwrd">in</span> cust)
            {
                Console.WriteLine(customer.CompanyName);
                <span class="kwrd">if</span>(customer.Orders.Count &gt; 0)
                {
                    Console.WriteLine(<span class="str">"Customer Orders"</span>);
                    <span class="kwrd">foreach</span>(Order order <span class="kwrd">in</span> customer.Orders)
                    {
                        <span class="kwrd">if</span>(order.Order_Details.Count &gt; 0)
                        {
                            Console.WriteLine(<span class="str">" - "</span> + order.Order_Details[0].Product.ProductName);
                        }
                    }

                }
            }

            Console.ReadLine();
        }
    }
}
</pre></div>
<p>Hierbei holen wir uns erst alle Kunden aus "London", welche wir auf der Konsole ausgeben. Danach prüfen wir, ob der Kunde eine Bestellung offen hat und welche dazugehörige Produkte er dazu gekauft hat. Resultat:<br><a href="{{BASE_PATH}}/assets/wp-images/image242.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="198" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb221.png" width="389" border="0"></a> </p>
<p><strong>Was verbirgt sich hinter den 1:N Beziehungen?</strong></p>
<p>Wenn wir jetzt mal in den generierten Code reinschauen, z.B. bei der Customer Klasse, finden wir folgenden Abschnitt:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">      <span class="kwrd">private</span> EntitySet&lt;Order&gt; _Orders;

        <span class="kwrd">public</span> Customer()
        {
            <span class="kwrd">this</span>._Orders = <span class="kwrd">new</span> EntitySet&lt;Order&gt;(<span class="kwrd">new</span> Action&lt;Order&gt;(<span class="kwrd">this</span>.attach_Orders), <span class="kwrd">new</span> Action&lt;Order&gt;(<span class="kwrd">this</span>.detach_Orders));
            OnCreated();
        }</pre></div>
<p>Ein <a href="http://msdn2.microsoft.com/en-us/library/bb341748.aspx" target="_blank">"EntitySet" (Streng Typisiert)</a> dient dabei als Datenspeicher der Beziehungsdaten. Das Gegenstück von EntitySet ist <a href="http://msdn2.microsoft.com/en-us/library/bb348960.aspx" target="_blank">EntityRef</a>.</p>
<p>Schematisch wäre dies grob so:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image243.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="65" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb222.png" width="342" border="0"></a> </p>
<p>Der Customer hat Orders in seinem EnitySet gespeichert. Die Orders halten wiederrum die Verweise als EntityRef fest. Nachzulesen lässt sich das (und auch das Thema Many-to-Many-Relations, auch in der MSDN: <a href="http://msdn2.microsoft.com/en-us/bb386950.aspx" target="_blank">How to: Map Database Relationships (LINQ to SQL)</a></p>
<p>Natürlich kann man auch mit dieser Basis die ganzen CRUD Sachen aus diesem <a href="{{BASE_PATH}}/2008/01/15/howto-or-mapper-linq-to-sql-einfhrung-einfaches-manuelles-mapping/" target="_blank">Blogpost</a> machen.</p>
<p><strong><u>Fazit</u></strong></p>
<p>LINQ to SQL bietet einen sehr netten Designer, mit dem man schnell zu Ergebnissen kommt. Wie ich selber aber gemerkt habe, ist sicherlich erst eine Grundsätzlich Einarbeitung in den Abfrage Syntax von LINQ notwenidig um gute und performante Abfragen zu gestalten. </p>
<p>Jeder der mit Microsoft SQL und .NET 3.5 zutun hat, sollte sich die Möglichkeiten von LINQ to SQL nicht entgehen lassen!<br>Es gibt sicherlich noch mehr Themen rund um LINQ to SQL - das war ja auch erst der zweite Post zu diesem Thema ;)</p>
<p>Downloaden könnt ihr das Testprojekt auch, allerdings musste ich aus Platzgründen die Northwind.mdf (und die log Datei) aus dem Verzeichnis entfernen - <a href="{{BASE_PATH}}/2008/01/13/howto-beispieldatenbank-adventureworks-und-northwind-auf-sql-server-2005-installieren/" target="_blank">installiert die Northwind Datenbank</a> einfach und kopiert die beiden Datein mit in das Verzeichnis. Visual Studio 2008 (mit Administrator Rechten) ist bei .NET 3.5 Pflicht.</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/linqtosqldesigner/linqtosqldesigner.zip" target="_blank">[ Download Sourcecode ]</a></strong></p>
