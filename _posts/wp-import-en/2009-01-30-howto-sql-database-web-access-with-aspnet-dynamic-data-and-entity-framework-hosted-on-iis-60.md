---
layout: post
title: "HowTo: SQL Database web access with ASP.NET Dynamic Data and Entity Framework (hosted on IIS 6.0)"
date: 2009-01-30 01:48
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [Admin, ASP.NET Dynamic Data, Dynamic Data, HowTo, IIS 6.0, Routing]
language: en
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image40.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; border-right-width: 0px" height="71" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb44.png" width="143" align="left" border="0" /></a> I started my programming career with PHP and MySQL and I used very often a webbased mysql admin panel called &quot;<a href="http://www.phpmyadmin.net/home_page/index.php">PhpMyAdmin</a>&quot;.     <br />It has (of course) not all features of the <a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=C243A5AE-4BD1-4E3D-94B8-5A0F62BF7796&amp;displaylang=de">SQL Management Studios</a>, but if I only want to have a quick look at the database it is very cool - and you only need a simple browser.     <br />You can create such an tool with <a href="http://www.asp.net/dynamicdata/">ASP.NET Dynamic Data</a> and <a href="http://msdn.microsoft.com/de-de/library/bb386976.aspx">Linq2Sql</a> or the <a href="http://msdn.microsoft.com/en-us/library/aa697427(VS.80).aspx">Entity Framework</a> within minutes.</p> 



<p><strong>Intro ASP.NET Dynamic Data      <br /></strong>This feature was a part of the .NET 3.5 SP1. If you create a new projects you&#180;ll see two different project templates:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image41.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="162" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb45.png" width="505" border="0" /></a> </p>
<p>Both templates are nearly the same, but there is a difference:</p>  <ul>   <li>Dynamic Data <strong>Entities</strong> Web Applications: Use it only with ADO.NET Entity Framework </li>    <li>Dynamic Data Web Application: Use it only with Linq2Sql </li> </ul>
<p><em>If you try to use the EF in the wrong template you&#180;ll get a runtime error: &quot;The method 'Skip' is only supported for sorted input in LINQ to Entities&quot;&#160; (<a href="http://blogs.oosterkamp.nl/blogs/jowen/archive/2008/10/15/dynamic-data-choose-the-right-template.aspx">Source and more info</a>)</em></p>
<p>Both templates take a datacontext (Linq2Sql or EF) and create at runtime CRUD and list pages. It use a templating system and you could change everything if you want it. </p>
<p><strong>Step 1: Create ASP.NET Dynamic Data Entites Web Projekt     <br /></strong>We choose the entity web project and should see the following project structure:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image42.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb46.png" width="174" border="0" /></a> </p>
<p>The &quot;DynamicData&quot; folder contains all the templates, pictures etc.:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image43.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="309" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb47.png" width="181" border="0" /></a> </p>
<p>&quot;PageTemplates&quot; holds all CRUD and the List templates. The &quot;FieldTemplates&quot; render the different types (e.g. a DateTime).</p>
<p>I&#180;ll keep the default behaviour, templates and styles for this HowTo.</p>
<p><strong>Step 2: Create the Entity Model </strong>    <br />Now we need a entity model - that&#180;s why we now need a database. I choose the <a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=06616212-0356-46A0-8DA2-EEBC53A68034&amp;displaylang=en">Northwind sample database</a>.    <br />Now we create the model:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image44.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="217" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb48.png" width="244" border="0" /></a> </p>
<p>In the next screen you have to establish the connection to your database. Use &quot;.\SQLExpress&quot; if you have a local running SQL Express Server and add everything you want:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image45.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="305" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb49.png" width="343" border="0" /></a> </p>
<p><strong>Step 3: Setup Dynamic data with the datacontext      <br /></strong>This is the important step: Just add the datacontext to the DynamicData &quot;<a href="http://msdn.microsoft.com/de-de/library/system.web.dynamicdata.metamodel.aspx">MetaModel</a>&quot;, read the comments and paste your datacontext into the metamodel:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c13a7352-ff64-49e8-8080-12da11796598" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
<pre name="code" class="c#">MetaModel model = new MetaModel();

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

</pre>
</div>


<p>NorthwindEntities is my datacontext and I set the &quot;ScaffoldAllTables&quot; to true. <strong>But be carefull with this setup</strong> - it allows anybody to create, read, update and delate everything on your model/database. Limit the access via configuration or (the easy way) the IIS settings.</p>

<p><strong>Result
    <br /></strong>The result (after few minutes) :</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image46.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="416" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb50.png" width="271" border="0" /></a>&#160; <br />Overview</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image47.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="263" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb52.png" width="539" border="0" /></a>&#160; <br />List</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image48.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="304" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb53.png" width="303" border="0" /></a>&#160; <br />Details</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image49.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="294" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb54.png" width="315" border="0" /></a>&#160; <br />Edit</p>

<p>
  <br />If you just need a plain admin panel for your application (and use Linq2Sql or EF) this is a very nice. </p>

<p><strong>Dynamic Data on IIS 6 
    <br /></strong>Dynamic Data use the Routing API like ASP.NET MVC, thats why you have such URLs: 

  <br /><a title="http://localhost:52016/Alphabetical_list_of_products/Edit.aspx?CategoryName=Beverages&amp;Discontinued=False&amp;ProductID=1&amp;ProductName=Chai" href="http://localhost:52016/Alphabetical_list_of_products/Edit.aspx?CategoryName=Beverages&amp;Discontinued=False&amp;ProductID=1&amp;ProductName=Chai">http://localhost:52016/Alphabetical_list_of_products/Edit.aspx?CategoryName=Beverages&amp;Discontinued=False&amp;ProductID=1&amp;ProductName=Chai</a></p>

<p>If you have only an IIS 6.0, you should read this great <a href="http://blog.codeville.net/2008/07/04/options-for-deploying-aspnet-mvc-to-iis-6/">blogpost</a>.</p>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/dynamicdataadmin/dynamicdataadmin.zip">[ Download Democode (without DB) ]</a></strong></p>
