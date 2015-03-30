---
layout: post
title: "JSON.NET deserialize to abstract class or interface"
description: "If you are using JSON.NET with interfaces or abstract classes and try to deserialize it you might know the lovely 'Type is an interface or abstract class and cannot be instantiated.'-exception. Let's try to fix this..."
date: 2015-03-30 23:30
author: robert.muehsig
tags: [JSON, JSON.NET]
language: en
---
{% include JB/setup %}

Ok, this is my scenario: We have a common base class and two or more implementations of it and we want to serialize a __List<Base>__ to JSON and deserialize it - pretty straightforward I would say. The NuGet Package of choice for JSON is (of course) JSON.NET.

## Base Class & Implementations

    public abstract class BaseFoo
    {
        public string FooBarBuzz { get; set; }
    }

    public class AFoo : BaseFoo
    {
        public string A { get; set; }
    }

    public class BFoo : BaseFoo
    {
        public string B { get; set; }
    }

When we deserilize it we need somehow a "marker"-property and I use the "FooBarBuzz" property from the BaseFoo-class as my marker. If it contains "A", then it is implementation "AFoo" and "B" for "BFoo".	
	
## Serialize

The serialization part works as expected:

    AFoo a = new AFoo();
    a.FooBarBuzz = "A";
    a.A = "Hello World";

    BFoo b = new BFoo();
    b.FooBarBuzz = "B";
    b.B = "Hello World";

    List<BaseFoo> allFoos = new List<BaseFoo>();
    allFoos.Add(a);
    allFoos.Add(b);

    var result = JsonConvert.SerializeObject(allFoos);

Resulting Json:

![x]({{BASE_PATH}}/assets/md-images/2015-03-30/json.png "Resulting JSON")

## Deserialize and boom...

If we continue now and just use the typical code we get a nice exception:

    var test = JsonConvert.DeserializeObject<List<BaseFoo>>(result);
	
__Exception:__

_Additional information: Could not create an instance of type ConsoleApplication6.BaseFoo. Type is an interface or abstract class and cannot be instantiated. Path '[0].A', line 1, position 6._

## Introducing a simple JsonConverter

The exception is pretty clear, because JSON.NET has no knowledge about our convention. The way to go is to write a __JsonConverter__. I found a couple of implementations on StackOverflow, but [this one](http://stackoverflow.com/questions/22537233/json-net-how-to-deserialize-interface-property-based-on-parent-holder-object/22539730#22539730) seems to be the easiest and best option.	

    public class FooConverter : JsonConverter
    {
        public override bool CanConvert(Type objectType)
        {
            return (objectType == typeof(BaseFoo));
        }

        public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
        {
            JObject jo = JObject.Load(reader);
            if (jo["FooBarBuzz"].Value<string>() == "A")
                return jo.ToObject<AFoo>(serializer);

            if (jo["FooBarBuzz"].Value<string>() == "B")
                return jo.ToObject<BFoo>(serializer);

            return null;
        }

        public override bool CanWrite
        {
            get { return false; }
        }

        public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
        {
            throw new NotImplementedException();
        }
    }

When we read the JSON we look for our "FooBarBuzz"-property and serialize it to the correct implementation.

## Let's use our new JsonConverter

Just create a new instance of the Converter and apply it to the DeserializeObject method and you are done. 

    JsonConverter[] converters = { new FooConverter()};
    var test = JsonConvert.DeserializeObject<List<BaseFoo>>(result, new JsonSerializerSettings() { Converters = converters });

Easy, right?
	
The full sample can be viewed on [GitHub](https://github.com/Code-Inside/Samples/tree/master/2015/JsonConvertIssuesWithBaseClasses)