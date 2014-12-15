---
layout: post
title: "Units and interfaces"
date: 2012-11-08 15:27
author: CI Team
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
<p>&nbsp;</p> 
 <p>Because of the object orientation developers are used to describe their working information’s in objects. For example:</p> <div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5c259567-01db-4ac9-98e7-de5bff57c86c" class="wlWriterSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre class="c#" name="code">public List&lt;Product&gt; GetProducts()
</pre>
</div>

<p>But what about basic characteristics? For the date we have the DateTime Object in the Framework but what about all the other units: meter, Gigabyte and so on? The easiest answer: Usually we have whole numbers so we are going to use an integer.</p>
<p>That’s what an interface could look like:</p>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2b7c53a2-4fac-47b4-b65a-732d7c46f92f" class="wlWriterSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre class="c#" name="code">public void SetMailboxSize(int mailboxSize)
</pre>
</div>

<p>Unfortunately this leaves the question what am I asked to enter? That’s what your colleague might answer:</p>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:64df532d-b5e3-42dd-896f-ed60e9073ea6" class="wlWriterSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre class="c#" name="code">public void SetMailboxSize(int sizeInKilobyte)
</pre>
</div>

<p>Okay, now we know what to enter into it. For me this worked well until we found out that while I calculated <a href="http://de.wikipedia.org/wiki/Bit">in Kibibit (of 2) he calculated in Kilobit (of 10)</a>. By mischance you won’t find out about this mistake until you are working with huge amounts of information’s because the difference for 1 Gigabyte is only 24 Megabyte.</p>
<p>Another problem is that you might hand the method a wrong unit. For example the developer passes a 1 because the user chooses 1 gigabyte on the surface. The problem is that an integer has no expressiveness for the unit and can’t be validated therefore. Everything that wants to go wrong goes wrong at some point…</p>
<p>Because of this it is useful to create a class for every unit you might need.</p>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:32582d50-0d2f-48bf-9b79-2f5957bc0671" class="wlWriterSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre class="c#" name="code">public void SetMailboxSize(DataSize mailboxSize)
</pre>
</div>

<p>Beside the fact that you can’t enter a wrong unit another advantage is that you have all the code for the conversion of the units at one point.</p>
<p>Here is an example for what such a DataSize class could look like:</p>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c673090f-fe36-4cbc-a093-2bb8e25dd1da" class="wlWriterSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre class="c#" name="code"> /// &lt;summary&gt;
    /// Stores information about the size of data. The base unit is Byte, multiples are expressed in powers of 2.
    /// &lt;/summary&gt;
    class DataSize
    {
        public enum Unit
        {
            Kilo = 1,
            Mega = 2,
            Giga = 3,
            Terra = 4,
            Peta = 5,
            Yotta = 6
        }
        public DataSize()
        { }
        /// &lt;summary&gt;
        /// Create a new DataSize Object
        /// &lt;/summary&gt;
        /// &lt;param name="bytes"&gt;number of bytes&lt;/param&gt;
        public DataSize(UInt64 bytes)
        {
            Bytes = bytes;
        }

        /// &lt;summary&gt;
        /// Size of the data in Bytes
        /// &lt;/summary&gt;
        public UInt64 Bytes { get; set; }

        /// &lt;summary&gt;
        /// converts the current value into
        /// &lt;/summary&gt;
        /// &lt;param name="unit"&gt;&lt;/param&gt;
        /// &lt;returns&gt;&lt;/returns&gt;
        public Decimal ConvertTo(Unit unit)
        {
            return Decimal.Divide(Bytes, (Decimal)Math.Pow(1024 ,(int)unit));
        }

        /// &lt;summary&gt;
        /// Loads an amount of bytes
        /// &lt;/summary&gt;
        /// &lt;param name="unit"&gt;unit to load&lt;/param&gt;
        /// &lt;param name="value"&gt;bytes to load&lt;/param&gt;
        public void GetFrom(Unit unit, Decimal value )
        {
            Bytes = Decimal.ToUInt64(value * (Decimal)Math.Pow(1024, (int)unit));
        }
    }
</pre>
</div>

<p>The information will be saved in a basic unit, in this example Byte, and converted into every possible other unit. It’s important that every real unit has an own data type that makes sure what it is about.</p>
