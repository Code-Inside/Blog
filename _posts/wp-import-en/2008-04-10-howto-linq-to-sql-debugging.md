---
layout: post
title: "HowTo: LINQ to SQL debugging"
date: 2008-04-10 20:12
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Debugging, HowTo, LINQ, LINQ to SQL]
language: en
---
{% include JB/setup %}
<p>I`m working on a project where I use LINQ to SQL. It&#180;s very cool (and sometimes tricky ;) ), but what if I need deeper information about the &quot;LINQ to SQL magic&quot; - how can I debug the LINQ to SQL stuff?</p>  <p><strong>1. Option: Visual Studio</strong></p>  <p>The simplest option is of course Visual Studio itself. Just checking the objects - very easy. </p>  <p>If you want to know which SQL statement is send to the SQL Server you need another tool:</p>  <p><strong>2. Option: LINQ to SQL Debug Visualizer</strong></p>  <p>A powerful tool: <a href="http://weblogs.asp.net/scottgu/archive/2007/07/31/linq-to-sql-debug-visualizer.aspx">LINQ to SQL Debug Visualizer</a>. I can&#180;t understand why Microsoft hide this handy tool.</p>  <p><strong>3. Option: DataContext.Log</strong></p>  <p>A build-in option for logging is the <a href="http://msdn2.microsoft.com/de-de/library/system.data.linq.datacontext.log.aspx">DataContext.Log</a> property. It is very useful in a consol application - but not in a class library. I found a very smart &quot;Output Logger&quot; class on this blog: <a href="http://www.u2u.info/Blogs/Kris/Lists/Posts/Post.aspx?ID=11">Sending the LINQ To SQL log to the debugger output window</a>. Each generated sql statement will be send to the output window.</p>  <p>This are my &quot;debugging&quot; tools - maybe could &quot;<a href="http://www.linqpad.net/">LinqPad</a>&quot; another nice tool.</p>  <p>Any other suggestion? Feel free to comment (you can even comment my english ;) ).</p>
