---
layout: post
title: "HowTo: Time-controlled & recurrent functions in .NET & ASP.NET"
date: 2010-09-26 17:34
author: CI Team
comments: true
categories: [HowTo]
tags: [HowTo, Timer, Timers, Zeit]
language: en
---
{% include JB/setup %}
<p><img style="border-right-width: 0px; margin: 0px 10px 0px 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image1038.png" width="134" height="134" /></p>  <p>During a project we had the order to run a specific SQL request after several minutes or seconds and to evaluate them in order to the results. You can solve this problem a little bit "dirty" by using a while(true) loop and Thread.Sleep, or you use a timer.</p> <!--more--><strong>Example:</strong>  
  <p>For example we are going to build a console application which is used to write something on the commando line every 10 seconds.</p>  <p><strong>The "Dirty" way..</strong></p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:aff75203-b58c-48bd-b4d3-217615c6b02a" class="wlWriterSmartContent">   <pre class="c#">            while (true)
            {
                Thread.Sleep(1000);
                Console.WriteLine(&quot;Bla!&quot;);
            }</pre>
</div>

<p>This alternative works but it isn´t very classy. And especially if you are planning to do two or three things in order you are going to have a problem.</p>

<p><strong>.NET Framework <strong>Timer</strong></strong></p>

<p>Particularly for this problem there are several classes of timer in .NET Framework. An older <a href="http://msdn.microsoft.com/en-us/magazine/cc164015.aspx">MSDN Articel</a> describes three different types:</p>

<ul>
  <li><a href="http://msdn.microsoft.com/de-de/library/system.windows.forms.timer(VS.80).aspx">System.Windows.Forms.Timer</a> </li>

  <li><a href="http://msdn.microsoft.com/en-us/library/system.timers.timer.aspx">System.Timers.Timer</a> </li>

  <li><a href="http://msdn.microsoft.com/de-de/library/system.threading.timer(VS.80).aspx">System.Threading.Timer</a> </li>
</ul>

<p>At the end of the article there is a really good comparison:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1039.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb222.png" width="523" height="209" /></a></p>

<p>In my opinion the "System.Windows.Forms.Timer" is only useful for Windows.Forms applications.</p>

<p><strong>Interesting is the difference between "System.Timers.Timer" and "System.Threading.Timer"</strong></p>

<p>The Timer in "Threading" namespace is without any additional work not thread safe.The System.Timers.Timer is based on the System.Threading.Timer. However for easy applications the System.Timers.Timer is a good choice. Here you can find a little&#160; <a href="http://stackoverflow.com/questions/1416803/system-timers-timer-vs-system-threading-timer">Stackoverflow-Discussion</a>.</p>

<p><strong>Using System.Timers.Timer</strong></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:67d14628-1490-4bd2-8a93-e2c134a8aa90" class="wlWriterSmartContent">
  <pre class="c#">using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Timers;

namespace Timers.ConsoleApp
{

    class Program
    {

        static void Main(string[] args)
        {
            Timer timer = new Timer();
            timer.Interval = 1000;
            timer.Elapsed += new ElapsedEventHandler(timer_Elapsed);
            timer.Enabled = true;

            Console.ReadLine();
        }

        static void timer_Elapsed(object sender, ElapsedEventArgs e)
        {
            Console.WriteLine(&quot;Elapsed!&quot;);
        }
    }
}</pre>
</div>

<p>According to the interval the conformable Event is opened. A Thread is taken from the Threadpool.</p>

<p><strong>Another alternative : AutoResetEvent</strong></p>

<p>For me a totally unknown class till today: <a href="http://msdn.microsoft.com/en-us/library/system.threading.autoresetevent.aspx">AutoResetEvent</a></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c56fc62e-794c-42bb-80dd-0f0446f11a6e" class="wlWriterSmartContent">
  <pre class="c#">            AutoResetEvent _isStopping = new AutoResetEvent(false);
            TimeSpan waitInterval = TimeSpan.FromMilliseconds(1000);

            for (; !_isStopping.WaitOne(waitInterval); )
            {
                Console.WriteLine(&quot;Bla!&quot;);
            }</pre>
</div>

<p>In Fact it looks like the whole while(true) story and I´m sure it also works equal.</p>

<p>Other alternatives you will found on the <a href="http://stackoverflow.com/questions/2822441/system-timers-timer-threading-timer-vs-thread-with-whileloop-thread-sleep-for-p">Stackoverflow-discussion</a> .</p>

<p><strong>Timer in ASP.NET applications </strong></p>

<p>In my example I talked about a console application but am it possible to create this for an ASP.NET application as well? Yes and No.</p>

<p>Stackoverflow found out a little trick to implement a "background job".<a href="http://blog.stackoverflow.com/2008/07/easy-background-tasks-in-aspnet/">Easy Background Tasks in ASP.NET</a></p>

<p><strong>The Trick </strong>works by laying down an item into the cache for a specific time. When the time runs out an event will be created. In this event the time-controlled action will be started and you have to lay down a new item into the cache and so on...</p>

<p>The Problem: usually the IIS Process is going to shut down after a while and then you can´t go on working with it.</p>

<p><strong>So many alternatives. And now?</strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1040.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; margin-left: 0px; border-left-width: 0px; margin-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb223.png" width="128" height="146" /></a></p>

<p>Like already mentioned, the easiest solution is the System.Timers.Timer. While working with ASP.NET I would like to recommend you to not use time-controlled applications because you never know when the AppPool is going to shut down. It´s better to use the timer in a windows service. But if there is no other way you better try one of the other alternatives I presented to you.</p>

<p><strong>Probably </strong>there exist a lot more alternatives. How are you solving any time-controlled problems? Of course you can solve it with a Sheduled Task or a program for consoles but that isn´t very classy as well. Aren´t it? ;) <strong></strong></p>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/timers/timers.zip">[ Download Democode ]</a></strong></p>
