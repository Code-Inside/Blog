---
layout: post
title: "HowTo: generische Listen => Lambda Ausdrücke"
date: 2008-07-03 09:32
author: oliver.guhr
comments: true
categories: [Allgemein, HowTo]
tags: [.NET 3.5, =&gt;, C#3.0, HowTo, Lambda, List]
language: de
---
{% include JB/setup %}
<p>Seit der .Net Version 3.5 gibt es für Listen und Arrays eine Reihe neuer Funktionen um die Objekte zu durchsuchen, zu sortieren und zu ordnen. Um ein "Gefühl" für die neuen Funktionen zu bekommen habe ich eine kleine Demoanwendung geschrieben um ein Paar dieser neuen Funktionen auszuprobieren. </p> <p>Grundlegende Informationen zu den Lambda Ausdrücken finden man hier: <a title="http://weblogs.asp.net/scottgu/archive/2007/04/08/new-orcas-language-feature-lambda-expressions.aspx" href="http://weblogs.asp.net/scottgu/archive/2007/04/08/new-orcas-language-feature-lambda-expressions.aspx">http://weblogs.asp.net/scottgu/archive/2007/04/08/new-orcas-language-feature-lambda-expressions.aspx</a>&nbsp;</p> <p><a title="http://www.outofcoffeeexception.de/2008/04/28/LambdaAusdruumlcke+In+C+30.aspx" href="http://www.outofcoffeeexception.de/2008/04/28/LambdaAusdruumlcke+In+C+30.aspx">http://www.outofcoffeeexception.de/2008/04/28/LambdaAusdruumlcke+In+C+30.aspx</a></p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1a12e375-57e5-4365-8a1b-42ebad284c33" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            List&lt;Person&gt; Employees = PersonManager.GetRandomData(19);            
            
            Console.WriteLine("shows all employees");          
            ViewPersonList(Employees);
            
            Console.ReadLine();
            Console.Clear();
            Console.WriteLine("shows all Liza's (Where)");           
            ViewPersonList(Employees.Where(x =&gt; x.Firstname == "Liza").ToList());

            Console.ReadLine();
            Console.Clear();
            Console.WriteLine("order's all employees by PersonalId (OrderBy)");            
            ViewPersonList(Employees.OrderBy(x =&gt; x.PersonalId).ToList());
            
            
            Console.ReadLine();
            Console.Clear();
            Console.WriteLine("order's all employees by surename and firstname (OrderBy)");
            ViewPersonList(Employees.OrderBy(x =&gt; x.Surname).ThenBy(x =&gt; x.Firstname).ToList());

            Console.ReadLine();
            Console.Clear();
            Console.WriteLine("employee statistics (Min,Max,Sum,Average)");
            Console.WriteLine("the youngest employee is:\t" + Employees.Min(x =&gt; x.Age) + "\tyears old");
            Console.WriteLine("the oldest employee is:\t\t" + Employees.Max(x =&gt; x.Age) + "\tyears old");
            Console.WriteLine("all employee's are:\t\t" + Employees.Sum(x =&gt; x.Age) + "\tyears old");
            Console.WriteLine("the average age is:\t\t" + Employees.Average(x =&gt; x.Age));

            
            Console.ReadLine();
            Console.Clear();
            Console.WriteLine("groups's all employees by age(GroupBy)");
            Console.WriteLine("order's all groups by age(OrderBy)");
            Console.WriteLine("order's all employees in group's by surename(OrderBy)");
            IEnumerable&lt;IGrouping&lt;int, Person&gt;&gt; query = Employees.GroupBy(x =&gt; x.Age);
            foreach (IGrouping&lt;int, Person&gt; AgeGroup in query.OrderBy(x =&gt; x.Key ))
            {
                Console.WriteLine("----------Age:" + AgeGroup.Key + "------------------");
                ViewPersonList(AgeGroup.ToList().OrderBy(x =&gt; x.Surname).ToList());
            }
            Console.ReadLine();</pre></div>
<br/>
<a href='{{BASE_PATH}}/assets/wp-images-de/lamda.zip' title='Lamda'>Den Beispielcode gibts hier.</a>
