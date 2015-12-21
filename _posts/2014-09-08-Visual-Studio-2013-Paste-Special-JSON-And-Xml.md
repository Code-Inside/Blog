---
layout: post
title: "Visual Studio 2013 Hidden Gem: Paste JSON or XML as C# Classes"
description: "Ever needed a strongly typed representation of your XML or JSON content? Visual Studio 2013 comes with a handy feature."
date: 2014-09-08 23:10
author: Robert Muehsig
tags: [Visual Studio 2013, XML, JSON]
language: en
---
{% include JB/setup %}

I was looking for an easy way to "convert" an XML structure to a normal C# structure and stumbled upon a handy feature of Visual Studio 2013. This also works for any JSON content as well.

## What you need:
Copy your XML or JSON in the __clipboard__ and make sure you have a __.NET 4.5 project__ selected. I'm not sure why this limitation is in place, but you can use the generated classes in .NET 4.0 and even lower I guess.

Then just click __Edit__ - __Paste Special__ - __Paste XML/JSON As Classes__.

![foo]({{BASE_PATH}}/assets/md-images/2014-09-08/vs.png "VS Screenshot")

## The generated classes:
The generated classes should work with JSON.NET or any XML Serializer. The Code for the XML is a bit messy, but works and gives you a starting point.

Sample from [here](http://en.wikipedia.org/wiki/JSON):


    public class Rootobject
    {
        public string firstName { get; set; }
        public string lastName { get; set; }
        public bool isAlive { get; set; }
        public int age { get; set; }
        public float height_cm { get; set; }
        public Address address { get; set; }
        public Phonenumber[] phoneNumbers { get; set; }
        public object[] children { get; set; }
        public object spouse { get; set; }
    }

    public class Address
    {
        public string streetAddress { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public string postalCode { get; set; }
    }

    public class Phonenumber
    {
        public string type { get; set; }
        public string number { get; set; }
    }


Note: There are many other web based XML/JSON to C# converter out there - so feel free to use whatever works for you. I didn't know this little feature.
