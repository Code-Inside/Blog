---
layout: post
title: "Understanding stdin, stdout and stderr in .NET"
description: "A practical introduction for .NET developers to standard input, output, and error streams — with examples for the console, pipes, and redirection."
date: 2025-11-05 23:59
author: Robert Muehsig
tags: [Console, .NET, Windows]
language: en
---

{% include JB/setup %}

**Confession time:**  
It’s almost embarrassing to admit this — but after years of writing .NET code and using the terminal daily, I recently discovered that you can redirect the *error output* of a program using `2>`.  

So I decided to write this post — partly as a note to my future self, and partly for anyone else who’s ever thought:  
"Wait… why are there *two* output streams?"

# Overview

When you build console applications or CLI tools in .NET, sooner or later you’ll encounter these basic "input"/"output"-streams: 

- **stdin** — standard input (like keyboard, files, or pipes) or in C# `Console.In`, `Console.ReadLine()`  
- **stdout** — standard output or in C# `Console.Out`, `Console.WriteLine()` 

Besides the "standard output" there is a special output just for errors or warnings:

- **stderr** - Error or diagnostic messages or in C# `Console.Error`, `Console.Error.WriteLine()`

Having a dedicated error stream means your program can separate *data output* (for other programs or files) from *diagnostic messages* (for humans).

# A Simple Example

Let’s build a small C# program that reads from stdin, writes to stdout, and reports problems on stderr.

```csharp
using System;

class Program
{
    static void Main()
    {
        Console.WriteLine("== Start ==");

        string? line;
        int lineCount = 0;

        // Read from stdin
        while ((line = Console.ReadLine()) != null)
        {
            lineCount++;

            // Normal output
            Console.WriteLine($"[{lineCount}] {line}");

            // Print errors separately
            if (line.Contains("error", StringComparison.OrdinalIgnoreCase))
            {
                Console.Error.WriteLine($"Line {lineCount}: contains the word 'error'");
            }
        }

        Console.WriteLine("== End ==");
    }
}
```

When you run it and type some lines and include the word error, the output will look like this:

```
== Start ==
[1] Hello
[2] error found
Line 2: contains the word 'error'
[3] test
== End ==
```

# Why 2> means stderr

If you run the same app like this with the same input:

```
.\SampleConsoleApp.exe 2> err.txt
```

The `Line 2: contains the word 'error'` will be redirected into the `err.txt`.

# Input as file

Let's say you have a file that should be used as an input, then you could invoke the program like this:

```
.\SampleConsoleApp.exe < input.txt
```

# Input with pipes

You can also use the `|` operator to use this as input stream:

```
"error" | .\SampleConsoleApp.exe 2> err.txt
```

# Final thoughts

The standard streams are one of those Unix-era ideas that aged perfectly.
They make it easy to connect programs like Lego bricks — and .NET gives you full access to them.

Hope this helps!