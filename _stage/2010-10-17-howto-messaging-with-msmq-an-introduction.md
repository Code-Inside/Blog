---
layout: post
title: "HowTo: Messaging with MSMQ, an introduction"
date: 2010-10-17 17:31
author: oliver.guhr
comments: true
categories: [HowTo]
tags: []
language: en
---
{% include JB/setup %}
<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb224.png" border="0" alt="image" width="171" height="129" align="left" />A short time ago I found MSMQ. To say it easy: MSMQ is a system where messages are able to be classified into queues and be converted piece by piece.

<!--more-->

<strong>Why should I use this?</strong>

<strong> </strong>

MSMQ is a system of queues. You put your message into it and than somebody will take it and convert it. This could be very useful in distributed applications for example. So for example it is possible to generate E-Mails, put them in a queue and send them out piece by piece so the server won´t be overloaded. Of course there are a lot more possibilities but this is just an introduction.

Later I´m going to talk about some more advantages and disadvantages and I would be very glad to get some comments from you.

<strong>Requirements</strong>

<strong> </strong>

The infrastructure is included every ware since XP (?). You only need to activate it in the windows functions:

<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb225.png" border="0" alt="image" width="310" height="111" />

Afterwards you are able to see MSMQ Services in the Computer-Management and Service:

<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb226.png" border="0" alt="image" width="259" height="256" />

Click right and you will be able to look into already existing queues and to create new ones:

<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb227.png" border="0" alt="image" width="579" height="100" />

Here it is also possible to take a look into the several massages:

<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb228.png" border="0" alt="image" width="222" height="244" />

For my demo code it is necessary to create the "test" queue beneath the private queues.

<strong>The Code:</strong>

<strong> </strong>

In .NET Framework you will find everything you need to start:

<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb229.png" border="0" alt="image" width="563" height="321" />

<strong>Write a new message into the queue: </strong>

<strong> </strong>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c2e44e40-8ab7-4612-ae91-3643b92ae43a" class="wlWriterEditableSmartContent" style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px">
<pre class="c#">            MessageQueue queue = new MessageQueue(@".\private$\test");
            queue.Send("test");</pre>
</div>
<strong>Read the message:</strong>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:95492638-483a-47d9-92b0-7dc30c4c6a89" class="wlWriterEditableSmartContent" style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px">
<pre class="c#">MessageQueue queue = new MessageQueue(@".\private$\test");
Console.WriteLine(queue.Receive().Body.ToString());</pre>
</div>
Easy, isn´t it? If you click on "receive" the first message of the queue will be chosen.

Afterwards the message won´t be reachable for other clients as well.

<strong>Extensive file types: </strong>

Of course it is possible to send extensive file types as well. These file types will be written into the message by the XmlSerializer.

Here is my Example:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1e997a08-6a76-4013-b4de-565ab57d950c" class="wlWriterEditableSmartContent" style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px">
<pre class="c#">using System;
using System.Collections.Generic;
using System.Messaging;
using System.Text;

namespace MSMQ
{
    public class User
    {
        public string Name { get; set; }
        public DateTime Birthday { get; set; }
    }

    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Simple Text");
            Console.WriteLine("Input for MSMQ Message:");
            string input = Console.ReadLine();

            MessageQueue queue = new MessageQueue(@".\private$\test");

            queue.Send(input);

            Console.WriteLine("Press Enter to continue");
            Console.ReadLine();

            Console.WriteLine("Output for MSMQ Queue");
            Console.WriteLine(queue.Receive().Body.ToString());
            Console.ReadLine();

            Console.WriteLine("Complex Text");

            User tester = new User();
            tester.Birthday = DateTime.Now;
            tester.Name = "Test Name";
            queue.Send(tester);

            Console.WriteLine("Output for MSMQ Queue");
            User output = (User)queue.Receive().Body;
            Console.WriteLine(output.Birthday.ToShortDateString());
            Console.ReadLine();

        }
    }
}</pre>
</div>
<strong>It works. And now? WHY should I use MSMQ?</strong>

<strong> </strong>

You are right. It is possible to make this whole queue thing with SQL ore other self made applications. So why should you take a look on MSMQ?

<strong>Advantages- and Disadvantages: (took it from the <a href="http://stackoverflow.com/questions/483108/msmq-vs-temporary-table-dump">stack overflow</a>)</strong>

<strong> </strong>

<strong> </strong>

<strong>Cons: </strong>
<ul>
	<li>Each queue can only be 2GB.</li>
	<li>Each message 4MB (altough the 4MB limit can be fixed by using MSMQ with WCF).</li>
	<li>Only for Windows so you´re limited to use it with .NET, C/C++ or COM library for COM-enabled environments.</li>
</ul>
<strong>Pros: </strong>
<ul>
	<li>Supports Windows Network Load Balancer.</li>
	<li>Supports Microsoft Cluster Service.</li>
	<li>Integrated with Active Directory.</li>
	<li>Ships with Windows.</li>
	<li>Supports transactions.</li>
	<li>MSMQ messages can be tracked by audit messages in the Windows Event log.</li>
	<li>Messages can be automatically authenticated (signed) or encrypted upon sending, and verified and decrypted upon reception.</li>
</ul>
<strong> </strong>

<strong>Questions to you...</strong>

<strong> </strong>

Do you use MSMQ already? Ore do you prefer a simple SQL data base? Of course the pros sound nice but isn´t this possible with SQL as well? Are you having any more extensive examples?

In my opinion it isn´t easy to clarify which option is the better one but maybe some of you know about some additional frameworks ore some absolutely no-go´s? ;)
