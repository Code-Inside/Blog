---
layout: post
title: "HowTo: Asynchrone Methoden mit Unit Tests testen"
date: 2009-04-15 20:11
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Async, HowTo, Tests, Unit Tests]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image711.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="105" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb689.png" width="139" align="left" border="0" /></a>Im <a href="{{BASE_PATH}}/2009/04/12/howto-multithreading-in-net-asynchrone-programmierung-eventbasiert/">letzten HowTo</a> ging es um den Einstieg in die <a href="http://msdn.microsoft.com/de-de/library/ms228969(VS.80).aspx">asynchrone Programmierung</a>. Ein &quot;Problem&quot; dabei war, dass man nie genau wei&#223; wie lange die Operation dauert. Mit einem kleinen Trick lassen sich auch solche Sachen elegant in einem UnitTest (oder Integrationstest) automatisiert testen.</p> 
<!--more-->
  <p><strong>Szenario     <br /></strong>Ich nutze die Codebasis aus dem <a href="{{BASE_PATH}}/2009/04/12/howto-multithreading-in-net-asynchrone-programmierung-eventbasiert/">letzten HowTo</a> und m&#246;chte einfach pr&#252;fen, ob die &quot;<strong>GetCustomersAsync</strong>&quot; auch das Event aufruft. Nat&#252;rlich k&#246;nnte ich auch die Eventargs entsprechend auswerten.    <br />In einem <a href="{{BASE_PATH}}/2008/07/12/howto-eigene-net-events-definieren-und-mit-unit-tests-testen/">anderen HowTo</a> hatte ich breits geschrieben wie man Events mithilfe von anoymen Methoden testen kann. Damit ist der Unittest in sich &quot;geschlossen&quot;.</p>  <p><strong>Das &quot;Problem&quot;     <br /></strong>Da man nicht genau wei&#223; wann die Option durchgelaufen ist (da sie ja asynchron ist) m&#252;sste man im Test &quot;Thread.Sleep(1000)&quot; (oder sowas &#228;hnliches) schreiben, damit die Operation beendet ist bevor es zum &quot;<strong>Assert</strong>...&quot; kommt.</p>  <p><strong>Die &quot;L&#246;sung&quot;     <br /></strong>Die L&#246;sung meines Problems habe ich auf <a href="http://jasondotnet.spaces.live.com/blog/cns!BD40DBF53845E64F!170.entry">diesem Blog</a> gefunden. Mein Unittest sieht jetzt so aus:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e0ed1a4c-ff4b-4f90-bca1-2af280d42c26" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    [TestClass]
    public class CustomerRepositoryTests
    {
        [TestMethod]
        public void GetCustomersAsync_Raised_GetCustomersAsyncCompleted_Event()
        {
            CustomerRepository rep = new CustomerRepository();
            AutoResetEvent reset = new AutoResetEvent(false);
            bool eventRaised = false;

            rep.GetCustomersAsyncCompleted += delegate(object sender, GenericEventArgs&lt;List&lt;Customer&gt;&gt; args)
            {
                reset.Set();
                eventRaised = true;
            };
            rep.GetCustomersAsync();

            reset.WaitOne();
            Assert.IsTrue(eventRaised);
        }
    }</pre></div>

<p>Wichtig ist die &quot;<a href="http://msdn.microsoft.com/de-de/library/system.threading.autoresetevent(VS.80).aspx">AutoResetEvent</a>&quot; Klasse, welche in Zeile 8 initialisiert wird.

  <br />In Zeile 11-15 ist mein Eventhandler (als anoyme Methode). 

  <br />In Zeile 16 wird die asynchrone Operation ausgel&#246;st und normalerweise w&#252;rde nun unser Testframework sofort zum Assert gehen - allerdings braucht die asynchrone Operation eine kleine Weile bis sie durchgelaufen ist.</p>

<p>Das AutoResetEvent Objekt h&#228;lt allerdings den Thread solange an &quot;reset.WaitOne()&quot; bis &quot;reset.Set()&quot; aufgerufen wurde.</p>

<p><strong>Fazit</strong>

  <br />Ich finde die L&#246;sung recht einfach, auch wenn ich niemanden raten w&#252;rde jede asynchrone Operation in jedem Testdurchlauf mit zu testen, da es ja doch manchmal etwas l&#228;nger dauern kann. 

  <br />Als Integrationstest oder um manche Sachen automatisiert zu testen, ist die L&#246;sung aber ganz ok und kommen ohne viel Magie aus.</p>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/asyncintrotest/asyncintrotest.zip">[ Download Source Code ]</a></strong></p>
