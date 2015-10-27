---
layout: post
title: "XML deserialize to abstract class, interface or base class"
description: "Playing around with the .NET XmlSerializer and deserialize a given XML to a abstract class, interface or a base class."
date: 2015-10-25 22:00
author: robert.muehsig
tags: [XML]
language: en
---
{% include JB/setup %}

Let's assume we have the following XML structure:

    <?xml version="1.0" encoding="utf-8" ?>
    <Root>
      <Node>
        <Label Id="Label1">Betreff</Label>
        <TextBox Id="TextBox1" MultiLines="3" />
      </Node>
      <Node>
        <Label Id="Label2">Betreff 123132</Label>
        <TextBox Id="TextBox2" />
        <Button Id="Button1" Label="Hello World" Action="Foobar" />
      </Node>
    </Root>

Under <Root> we have n-<Node>-elements and each <Node> element has a couple of specialized elements. The elements share a common attribute, in this case "Id", so we could say that we need a "Base"-Element. 

## Code: Deserialize the elements & co.

The first step: We need to deserialize the <Root> and it's <Node> children. 

    public class Root
    {
        [XmlElement(ElementName = "Node")]
        public List<Node> Nodes { get; set; }
    }
	
Next - and this is the __main part of this blogpost__ - we need to describe the <Node> element and that it contains a list of "baseelements".

    public class Node
    {
        [XmlElement(typeof(LabelElement), ElementName = "Label")]
        [XmlElement(typeof(TextBoxElement), ElementName = "TextBox")]
        [XmlElement(typeof(ButtonElement), ElementName = "Button")]
        public List<BaseElement> Elements { get; set; }
    }
	
As you can see, we need to "register" each specialized known element. The default XmlSerializer will read all XmlElement Attributes and will do the main work.

The last part: The base class and the specialized classes for each element.

    public abstract class BaseElement
    {
        [XmlAttribute(AttributeName = "Id")]
        public string Id { get; set; }
    }
	
    public class ButtonElement : BaseElement
    {
        [XmlAttribute(AttributeName = "Label")]
        public string Label { get; set; }

        [XmlAttribute(AttributeName = "Action")]
        public string Action { get; set; }
    }
	
    public class LabelElement : BaseElement
    {
        [XmlText]
        public string Content { get; set; }
    }
	
    public class TextBoxElement : BaseElement
    {
        [XmlAttribute(AttributeName = "MultiLines")]
        public int MultiLines { get; set; }
    }

## Interfaces, base classes etc.

It doesn't matter if you choose a interface, base class or a abstract base class. The built-in XmlSerializer is flexible, but as far as I know you will need to "register" the implementation elements on the base element. So there is no "convention" or any magic in place.

## Using the code

Using the XmlSerializer is simple:

    FileStream readFileStream = new FileStream(@"test.xml", FileMode.Open, FileAccess.Read, FileShare.Read);

    XmlSerializer serializer = new XmlSerializer(typeof(Root));
    var test = serializer.Deserialize(readFileStream);

![x]({{BASE_PATH}}/assets/md-images/2015-10-25/result.PNG "Xml Deserializer")
		
## Serializing

If you want to serialize objects to XML with this code the XmlSerializer should be well prepared and no code changes should be needed. It just works ;)
	
Hope this helps!

The code is also available on __[GitHub](https://github.com/Code-Inside/Samples/tree/master/2015/XmlBaseClassDeserializer)__.
