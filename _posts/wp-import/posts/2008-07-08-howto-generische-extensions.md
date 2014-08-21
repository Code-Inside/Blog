---
layout: post
title: "HowTo: Generische Extensions"
date: 2008-07-08 20:07
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [C# 3.0, DRY, Extensions, generics, HowTo]
---
{% include JB/setup %}
<p>C# 3.0 bringt ein nettes Feature mit: <a href="http://weblogs.asp.net/scottgu/archive/2007/03/13/new-orcas-language-feature-extension-methods.aspx">Extensions</a>.</p> <p>Generell sind die recht einfach, allerdings sind die meisten Beispiele ohne Generics gemacht.</p> <p><strong>Meine Problemsituation:</strong><br>In einem Projekt waren einige Klasse von List&lt;...&gt; abgeleitet:</p> <p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d14c5b64-0ca0-4a3f-a229-ae2a73deef2b" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class MyList : List&lt;MyObject&gt;
    {
        ...
    }</pre></div><br>Jede dieser "Listenklassen" hatte eine kleine Methode, welche diese Liste durchgeht und eine Aktion auslöst.<br><br><strong>Ganz nach dem Prinzip: Keep it DRY</strong><br><a href="http://en.wikipedia.org/wiki/Don%27t_repeat_yourself">Don´t repeat yourself</a> - daher müssen diese eigentlich gleichen Methoden weg und in eine Extension Methode. Da der Syntax von den generischen Extensions mir etwas Zeit geraubt hat, stell ich ihn mal der Allgemeinheit offen.</p>
<p><strong>In unserem Beispiel:<br></strong>Wir wollen eine kleine Extension schreiben, welche mehrere Elemente an eine <a href="http://msdn.microsoft.com/en-us/library/92t2ye13.aspx">ICollection</a> anfügt - kann man auch über <a href="http://msdn.microsoft.com/en-us/library/z883w3dc(VS.80).aspx">AddRange</a> lösen, aber z.B. hat die <a href="http://msdn.microsoft.com/en-us/library/ms668604.aspx">ObservableCollection</a> das nicht - daher nehmen wir einfach mal dieses Beispiel.</p>
<p><strong>Source Code:</strong><br>Main:
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:34d5b948-9282-4b87-8d39-112196256f49" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">class Program
    {
        static void Main(string[] args)
        {
            List&lt;int&gt; intList = new List&lt;int&gt;();
            intList.Add(1);
            intList.Add(2);
            intList.Add(3);

            List&lt;int&gt; newIntList = new List&lt;int&gt;();
            newIntList.Add(4);
            newIntList.Add(5);

            intList.Add(newIntList);

            foreach (int myInt in intList)
            {
                Console.WriteLine(myInt); // Should be 1,2,3,4,5
            }
           
            Console.ReadLine(); 
        }
    }</pre></div></p>
<p>Extension:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8a822c41-2798-4f56-b2d1-39b9f91bfc0e" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public static class Extensions
    {
        public static ICollection&lt;T&gt; Add&lt;T&gt;(this ICollection&lt;T&gt; src, ICollection&lt;T&gt; addingElements)
        {
            foreach (T element in addingElements)
            {
                src.Add(element);
            }
            return src;
        }
    }</pre></div>
<p><strong>Resultat: Viele Ts und eine kleine generische Extension.</strong></p>
<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/genericextensions/genericextensions.zip">[ Download Source Code ]</a></strong></p>
