---
layout: post
title: "Jint: Invoke Javascript from .NET"
description: "Combine the power of Javascript and C# with Jint."
date: 2019-06-30 23:45
author: Robert Muehsig
tags: [Jint, Javascript, .NET]
language: en
---

{% include JB/setup %}

If you ever dreamed to use Javascript in your .NET application there is a simple way: Use __[Jint](https://github.com/sebastienros/jint)__.

Jint implements the ECMA 5.1 spec and can be use from any .NET implementation (Xamarin, .NET Framework, .NET Core). Just use the [NuGet package](https://www.nuget.org/packages/Jint/) and has __no__ dependencies to other stuff - it's a single .dll and you are done!

## Why should integrate Javascript in my application?

In our product "OneOffixx" we use Javascript as a scripting language with some "OneOffixx" specific objects.

The pro arguments for Javascript:

* It's a well known language (even with all the brainfuck in it)
* You can sandbox it quite simple 
* With a library like Jint it is super simple to interate

I highly recommend to checkout the GitHub page, but here a some simple examples, which should show how to use it:

## Example 1: Simple start

After the NuGet action you can use the following code to see one of the most basic implementations:

    public static void SimpleStart()
    {
        var engine = new Jint.Engine();
        Console.WriteLine(engine.Execute("1 + 2 + 3 + 4").GetCompletionValue());
    }

We create a new "Engine" and execute some simple Javascript and returen the completion value - easy as that!

## Example 2: Use C# function from Javascript

Let's say we want to provide a scripting environment and the script can access some C# based functions. This "bridge" is created via the "Engine" object. We create a value, which points to our C# implementation.

    public static void DefinedDotNetApi()
    {
        var engine = new Jint.Engine();

        engine.SetValue("demoJSApi", new DemoJavascriptApi());

        var result = engine.Execute("demoJSApi.helloWorldFromDotNet('TestTest')").GetCompletionValue();

        Console.WriteLine(result);
    }

    public class DemoJavascriptApi
    {
        public string helloWorldFromDotNet(string name)

        {
            return $"Hello {name} - this is executed in {typeof(Program).FullName}";
        }
    }

## Example 3: Use Javascript from C#

Of course we also can do the other way around:

    public static void InvokeFunctionFromDotNet()
    {
        var engine = new Engine();

        var fromValue = engine.Execute("function jsAdd(a, b) { return a + b; }").GetValue("jsAdd");

        Console.WriteLine(fromValue.Invoke(5, 5));

        Console.WriteLine(engine.Invoke("jsAdd", 3, 3));
    }

## Example 4: Use a common Javascript library

Jint allows you to inject any Javascript code (be aware: There is no DOM, so only "libraries" can be used).

In this example we use [handlebars.js](https://handlebarsjs.com/):

    public static void Handlebars()
    {
        var engine = new Jint.Engine();

        engine.Execute(File.ReadAllText("handlebars-v4.0.11.js"));

        engine.SetValue("context", new
        {
            cats = new[]
            {
                new {name = "Feivel"},
                new {name = "Lilly"}
            }
        });

        engine.SetValue("source", "{{#each cats}} {{name}} says meow!!!\n{{/each}}");

        engine.Execute("var template = Handlebars.compile(source);");

        var result = engine.Execute("template(context)").GetCompletionValue();

        Console.WriteLine(result);
    }
	
## Example 5: REPL

If you are crazy enough, you can build a simple REPL like this (not sure if this would be a good idea for production, but it works!)

    public static void Repl()
    {
        var engine = new Jint.Engine();

        while (true)
        {
            Console.Write("> ");
            var statement = Console.ReadLine();
            var result = engine.Execute(statement).GetCompletionValue();
            Console.WriteLine(result);
        }
    }
	
## Jint: Javascript integration done right!

As you can see: Jint is quite powerfull and if you feel the need to integrate Javascript in your application, checkout Jint!

The sample code can be found [here ](https://github.com/Code-Inside/Samples/tree/master/2018/JintSample/JintPlayground).
	
Hope this helps!