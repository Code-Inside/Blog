---
layout: post
title: "Parsing XML Schemas in .NET"
description: "XML can be very verbose and seems to be old-fashioned, but the good part around XML is, that there is a hugh pile of standardized mechanics around it. In this blogpost I will show you how to parse an XSD from code."
date: 2016-03-06 08:15
author: Robert Muehsig
tags: [XML, .NET, XSD]
language: en
---
{% include JB/setup %}

## XML Schemas

XML can be very verbose and seems to be old-fashioned, but the good part around XML is, that there is a hugh pile of standardized mechanics around it. 
To query XML documents you can use [XPath](https://en.wikipedia.org/wiki/XPath), for transforming you could use[XSLT](https://en.wikipedia.org/wiki/XSLT) and for validation you can use __[XML Schemas](https://en.wikipedia.org/wiki/XML_Schema_(W3C))__ or in short a "XSD" (XML Schema Definition).

## Parsing the XSD Tree

A XSD is just a Xml-Document that describes the valid XML tree. Because its just a normal XML element (with a fancy XML-namespace), so you could parse it via the normal XDocument, but things are way easier for you when you look at the [System.Xml.Schema-Namespace](https://msdn.microsoft.com/de-de/library/system.xml.schema(v=vs.110).aspx).

## Code

The basic code was taken from [the MSDN](https://msdn.microsoft.com/en-us/library/ms255932(v=vs.110).aspx) and I added the recursive part to get all possible elements.

	public static void AnalyseSchema(XmlSchemaSet set)
    {
        // Retrieve the compiled XmlSchema object from the XmlSchemaSet
        // by iterating over the Schemas property.
        XmlSchema customerSchema = null;
        foreach (XmlSchema schema in set.Schemas())
        {
            customerSchema = schema;
        }

        // Iterate over each XmlSchemaElement in the Values collection
        // of the Elements property.
        foreach (XmlSchemaElement element in customerSchema.Elements.Values)
        {
            RecursiveElementAnalyser(" ", element);
        }

    }

    public static void RecursiveElementAnalyser(string prefix, XmlSchemaElement element)
    {
        string elementName = prefix + element.Name;

        string dataType = element.ElementSchemaType.TypeCode.ToString();

        Console.WriteLine(elementName + " (" + dataType + ")");

        // Get the complex type of the Customer element.
        XmlSchemaComplexType complexType = element.ElementSchemaType as XmlSchemaComplexType;

        if (complexType != null)
        {
            // If the complex type has any attributes, get an enumerator 
            // and write each attribute name to the console.
            if (complexType.AttributeUses.Count > 0)
            {
                IDictionaryEnumerator enumerator =
                    complexType.AttributeUses.GetEnumerator();

                while (enumerator.MoveNext())
                {
                    XmlSchemaAttribute attribute =
                        (XmlSchemaAttribute)enumerator.Value;

                    string attrDataType = attribute.AttributeSchemaType.TypeCode.ToString();

                    string attrName = string.Format(prefix + "(Attr:: {0}({1}))", attribute.Name, attrDataType);

                    Console.WriteLine(attrName);
                }
            }

            // Get the sequence particle of the complex type.
            XmlSchemaSequence sequence = complexType.ContentTypeParticle as XmlSchemaSequence;

            // Iterate over each XmlSchemaElement in the Items collection.
            foreach (XmlSchemaElement childElement in sequence.Items)
            {
                RecursiveElementAnalyser(prefix + " ", childElement);
            }
        }
    }

    static void Main(string[] args)
    {
        XmlSchemaSet schemas = new XmlSchemaSet();
        schemas.Add("", XmlReader.Create(new StringReader(File.ReadAllText("Schema.xsd"))));
        schemas.Compile();
        AnalyseSchema(schemas);
        Console.ReadLine();
    }

Output:

![x]({{BASE_PATH}}/assets/md-images/2016-03-06/xsd.png "XSD Tree from Code")

You should see the possible XML elements, attributes and their datatypes, but you have access to all specified schema information from the XSD that you want.

## XML Namespaces

XML namespaces are powerful, but can also be pretty complicated for everyone who needs to parse your XML. I guess you could put some evil XML namespaces inside the XSD and things will break with my code. 
Just be aware of this issue if you are dealing with namespaces.

## Visual Studio Tooling

I discovered that Visual Studio ships with a pretty nice XSD editor. But you don't need to craft the XSD by hand,there are many tools out there that can generate XSDs based on existing XML documents.

![x]({{BASE_PATH}}/assets/md-images/2016-03-06/vs.png "Visual Studio XSD Tree")

## Sample XSD

I added the XSD Sample from the [MSDN](https://msdn.microsoft.com/en-us/library/bb675181.aspx) in the demo project. If you found an issue, just let me know.

__[Full Sample Code on GitHub](https://github.com/Code-Inside/Samples/tree/master/2016/XsdParser)__
	
Hope this helps!
