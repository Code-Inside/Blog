---
layout: post
title: "Human readable and editable config files with YAML"
description: "What is YAML and how to serialize and deserialize stuff with YamlDotNet."
date: 2015-02-09 21:20
author: robert.muehsig
tags: [YAML, Configuration]
language: en
---
{% include JB/setup %}

YAML ( __Y__ AML __A__ in't __M__ arkup __L__ anguage, or in the beginning __Y__ et __A__ nother __M__ arkup __L__ anguage) is a pretty common config language in the Ruby world. Because of its clear nature it is a perfect fit for human readable configuration files.

Sample from the [Jekyll Configuration](http://jekyllrb.com/docs/configuration/):

    source:      .
    destination: ./_site
    plugins:     ./_plugins
    layouts:     ./_layouts
    data_source: ./_data
    safe:         false
    include:      [".htaccess"]
    exclude:      []
    keep_files:   [".git", ".svn"]
    encoding:     "utf-8"
    ...

# Why using YAML and not XML or JSON?
As you can see above (hopefully...), its pretty small in contrast to XML with its heavy markup (<HeavyStuff>...</HeavyStuff>) and more readable than JSON ({{{...}}}), so for a config, which should be readable for humans, its really usefull.

# YamlDotNet & Sample Code

The easiest way to use parse YAML is to use the [YamlDotNet NuGet Package](http://www.nuget.org/packages/YamlDotNet/). The project can also be found on [__GitHub__](https://github.com/aaubry/YamlDotNet)

In my scenario I will serialize and deserialize the following config structure:

    public class DemoConfig
    {
        public int Foo { get; set; }
        public string SimpleItem { get; set; }
        public List<string> SimpleList { get; set; }
        public List<DemoConfigSettingElement> ComplexList { get; set; }
    }

    public class DemoConfigSettingElement
    {
        public string Name { get; set; }
        public List<string> Attributes { get; set; }
        public string Test { get; set; }
    }

As you can see, we have simple and complex types and lists - this should cover most cases. My sample program is a simple console app, serializing the object, writing it to the Console output and to a file and later reading this file. Pretty simple:

    class Program
    {
        static void Main(string[] args)
        {
            DemoConfig sample = new DemoConfig();

            sample.SimpleItem = "Hello World!";

            sample.Foo = 1337;

            sample.SimpleList = new List<string>();
            sample.SimpleList.Add("Foobar 1");
            sample.SimpleList.Add("Foobar 2");
            sample.SimpleList.Add("Foobar 3");
            sample.SimpleList.Add("Foobar 4");

            sample.ComplexList = new List<DemoConfigSettingElement>();

            DemoConfigSettingElement element1 = new DemoConfigSettingElement();
            element1.Name = "Element 1";
            element1.Attributes = new List<string>();
            element1.Attributes.Add("Foobarbuzz 1");
            element1.Attributes.Add("Foobarbuzz 2");
            element1.Attributes.Add("Foobarbuzz 3");
            element1.Attributes.Add("Foobarbuzz 4");
            element1.Attributes.Add("Foobarbuzz 5");
            sample.ComplexList.Add(element1);


            DemoConfigSettingElement element2 = new DemoConfigSettingElement();
            element2.Name = "Element 2";
            element2.Attributes = new List<string>();
            element2.Attributes.Add("Foobarbuzzi 1");
            element2.Attributes.Add("Foobarbuzzi 2");
            element2.Attributes.Add("Foobarbuzzi 3");
            element2.Attributes.Add("Foobarbuzzi 4");
            element2.Attributes.Add("Foobarbuzzi 5");
            element2.Test = "Only defined in element2";
            sample.ComplexList.Add(element2);

            YamlDotNet.Serialization.Serializer serializer = new Serializer();
            StringWriter strWriter = new StringWriter();

            serializer.Serialize(strWriter, sample);
            serializer.Serialize(Console.Out, sample);

            using (TextWriter writer = File.CreateText("test.yml"))
            {
                writer.Write(strWriter.ToString());
            }

            using (TextReader reader = File.OpenText(@"test.yml"))
            {

                Deserializer deserializer = new Deserializer();
                var configFromFile = deserializer.Deserialize<DemoConfig>(reader);
            }


            Console.Read();

        }
    }

__The test.yml file:__

    Foo: 1337
    SimpleItem: Hello World!
    SimpleList:
    - Foobar 1
    - Foobar 2
    - Foobar 3
    - Foobar 4
    ComplexList:
    - Name: Element 1
      Attributes:
      - Foobarbuzz 1
      - Foobarbuzz 2
      - Foobarbuzz 3
      - Foobarbuzz 4
      - Foobarbuzz 5
    - Name: Element 2
      Attributes:
      - Foobarbuzzi 1
      - Foobarbuzzi 2
      - Foobarbuzzi 3
      - Foobarbuzzi 4
      - Foobarbuzzi 5
      Test: Only defined in element2

# When should you not use YAML?

In my opionion YAML is really great if the content needs to be human readable or editable. For machine to machine communication, interface definitions or more "complex" definitions XML, JSON or any other format might be better. The strength of YAML is based on the easy to read and edit fact, thats all.  

	  
Thanks to [Antoine Aubry](http://aaubry.net/) for the awesome work! 

The complete demo code can also be found on [__GitHub__](https://github.com/Code-Inside/Samples/tree/master/2015/YamlSample)
	  
Hope this helps!
