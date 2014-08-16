---
layout: post
title: "HowToCode: Macht ein eigenes Model ohne Linq2Sql/ADO.NET EF Magic!"
date: 2009-03-13 02:30
author: robert.muehsig
comments: true
categories: [HowToCode]
tags: [ADO.NET EF;]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image669.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="174" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb647.png" width="128" align="left" border="0" /></a> Der Einsatz von <a href="http://msdn.microsoft.com/de-de/library/bb386976.aspx">Linq2Sql</a> oder der Einsatz vom <a href="http://msdn.microsoft.com/de-de/magazine/cc163399.aspx">ADO.NET Entity Framework</a> ist sehr einfach - die Einstiegsh&#252;rden sind erstmal niedrig und man bastelt seine Datenbank, generiert daraus sein Model und dann kann man schon loslegen und alles ist heile Welt. Der Titel hier ist etwas provokant, allerdings muss ich immer wieder erleben dass der Einsatz solcher Tools/Frameworks (es gibt sicherlich noch andere dieser Art) auch richtig sch&#246;n schief gehen kann.</p> 
<!--more-->
  <p><strong>Erstmal langsam... es gibt ja auch gute Seiten     <br /></strong>Ich bezieh mich hier nur auf Linq2Sql oder dem ADO.NET EF, sicherlich gibt es noch andere Beispiele wo es &#228;hnlich ist. Beide Technologien sind eigentlich ganz nett, das EF wird sicherlich in Version 2 dann fortschritte machen und Linq2Sql ist halt sehr einfach.     <br />Das tolle ist ja, dass ich mir keine Gedanken mehr um die SQL Code Generierung machen muss und (ich habe jetzt mal die Northwind DB genommen) auch alles sch&#246;n da:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image670.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb648.png" width="203" border="0" /></a> </p>  <p>Und im Code hat man ebenfalls den kompletten Zugriff auf die Verzweigtesten Sachen (auch wenn das so kein Sinn macht) :</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:de0deba1-2c8e-4703-a609-dd8fb409e794" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            Products test = new Products();
            test.Categories.CategoryName;
            test.Suppliers.Address;
            
            Customers cust = new Customers();
            cust.Orders.First().Order_Details.First().Products;</pre></div>

<p>Durch den Context kann man auch jedes Teil entsprechen nachladen oder beim EF kann man &#252;ber &quot;Load&quot; Daten nachladen, wenn diese noch nicht geladen wurden.</p>

<p><strong>Die Probleme dabei...
    <br /></strong><strong>1. Problem ist, dass mein Model aufgebl&#228;ht ist mit Sachen, die mich nicht interessieren:</strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image671.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="213" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb649.png" width="170" border="0" /></a> </p>

<p>Darunter &quot;EntityKey&quot;, &quot;EntityState&quot;, Orders (was n&#252;tzlich ist) und &quot;OrdersReference&quot; - wenn man diese Objekte nun z.B. nach JSON serialisieren will, kann man in arge Schwierigkeiten kommen.</p>

<p><strong>2. Problem ist, dass man durch &quot;Load()&quot; oder durch den Einsatz des Contextes &#252;berall Daten laden kann:</strong>

  <br />Wenn man aus jeder Schicht (sei es Businesslogik oder UI Schicht) Daten nachladen kann, dann kommt am Ende sowas raus:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image672.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb650.png" width="182" border="0" /></a> </p>

<p>Das Problem kann man umgehen, wenn man stark darauf achtet, dass es nur eine Stelle gibt an der Daten geladen werden. So wird auch im <a href="http://code-inside.de/blog/2009/03/11/kostenloses-aspnet-mvc-tutorial-kapitel-sample-application-nerddinner/">MVC Buch von ScottGu</a> etc. empfohlen:</p>

<p><em>&quot;For small applications it is sometimes fine to have Controllers work directly against a LINQ to SQL DataContext class, and embed LINQ queries within the Controllers. As applications get larger, though, this approach becomes cumbersome to maintain and test. It can also lead to us duplicating the same
    <br />LINQ queries in multiple places.

    <br />One approach that can make applications easier to maintain and test is to use a &#8220;repository&#8221; pattern. A repository class helps encapsulate data querying and persistence logic, and abstracts away the implementation details of the data persistence from the application. In addition to making application

    <br />code cleaner, using a repository pattern can make it easier to change data storage implementations in the future, and it can help facilitate unit testing an application without requiring a real database.&quot;</em></p>

<p><strong>3. Problem ist, dass es trotzdem sehr leicht ist die Architektur kaputt zu machen:</strong>

  <br />Selbst wenn man ein Repository Pattern implementiert, bleiben viele EF oder Linq2Sql Sachen am Objekt h&#228;ngen und man kommt sehr leicht dazu, &quot;einfach mal so&quot; auf die DB zu gehen. In einem gr&#246;&#223;eren Team kann das durchaus recht schnell passieren.</p>

<p><strong>4. Problem ist, dass nicht alles mit dem Entity Framework / Linq2Sql abgedeckt werden kann:
    <br /></strong>Selbst wenn ich mit den vielen Objektreferenzen leben kann und auch wirklich sehr sauber Arbeite, habe ich ein Problem wenn man z.B. pl&#246;tzlich ein Webservice mit einbindet. Pl&#246;tzlich hat man ein Teil der Klassen durch das EF generiert und ein anderer Teil kommt irgendwo anders her und kann sich auch anders Verhalten.</p>

<p><strong>5. Problem ist, dass man dadurch sich sehr schnell festlegt und sp&#228;ter Probleme bekommt:</strong>

  <br />Auch wenn momentan das Entity Framework von Microsoft weiterentwickelt wird, heisst das ja nicht, dass es sich nicht in 2 Jahren wieder &#228;ndern k&#246;nnte. Wenn man nun in seiner Applikation &#252;berall mit dem Context rumgespielt hat und fiese Tricks angewandt hat, steht man vielleicht irgendwann vor einem Problem. </p>

<p><strong>Daher: Von den Abh&#228;ngigkeiten l&#246;sen und eine Abstraktionsschicht mehr
    <br /></strong>Ich mach es bei meinen Applikationen immer nach diesem Muster:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image673.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="158" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb651.png" width="485" border="0" /></a> </p>

<p>Das Mapping ist im Grund auch sehr einfach und hab ich mir damals bei <a href="http://blog.wekeroad.com/mvc-storefront/asp-net-mvc-mvc-storefront-part-2/">Rob Conerys MVC Storefront</a> abgeschaut - der Code kommt auch aus diesem Projekt:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:41ca2599-d0c6-41c0-abf8-435f0b1330fb" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public IQueryable&lt;ProductReview&gt; GetReviews() {


            return from rv in _db.ProductReviews
                   select new ProductReview
                   {
                       ID = rv.ProductReviewID,
                       Author = rv.Author,
                       Body = rv.Body,
                       CreatedOn = rv.ReviewDate,
                       Email = rv.Email,
                       ProductID = rv.ProductID
                   };


        }
</pre></div>

<p>Man macht einen ganz normalen Query und macht dann im select Statement sein Mapping auf seine <a href="http://en.wikipedia.org/wiki/Plain_Old_CLR_Object">POCOs</a> - das wars :)</p>

<p><strong>Fazit: 
    <br /></strong>Es gibt sicherlich Nachteile bei der Variante, insbesondere wenn eine Persistenzschicht haben m&#246;chte und die mit Events um sich wirft sobald irgendwas ge&#228;ndert wurde, aber das juckt mich nicht.

  <br />Die Vorteile &#252;berwiegen meiner Meinung nach mehr. Man ist v&#246;llig flexibel und hat auch die volle Kontrolle, auch wenn man etwas mehr Tippen muss. Aber ich f&#252;r meinen Teil habe festgestellt, dass Tipparbeit wesentlich unaufw&#228;ndiger ist als rauszubekommen, warum man diverse Sachen nicht einfach serialisieren kann ;)</p>
