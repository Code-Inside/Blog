---
layout: post
title: "Improving Code"
description: "Recently I tried to simplify code I had written. As it tunred out, only I thought its simpler ;)"
date: 2018-08-03 09:00
author: Oliver Guhr
tags: [code, csharp, lambda,]
language: en
---
{% include JB/setup %}


# Improving code

## TL;DR;

**Things I learned: **

- long one-liners are hard to read and understand
- split up your code into small, easy to understand functions
- less "plumping" (read infrastructure code) is the better
- get [indentation](https://en.wikipedia.org/wiki/Indentation_style) right
- correct, concise, fast

**Why should I bother? **

Readable code is:

- easier to debug
- fast to fix
- easier to maintain

## The problem

Recently I wanted to implement an algorithm for a project we are doing. The goal was to create a so-called "Balanced Latin Square", we used it to prevent ordering effects in user studies. You can find a little bit of background [here](http://www.statisticshowto.com/latin-square-design/) and a nice description of the algorithm [here](http://rintintin.colorado.edu/~chathach/balancedlatinsquares.html).

It's fairly simple, although it is not obvious how it works, just by looking at the code. The function takes an integer as an argument and returns a Balanced Latin Square. For example, a "4" would return this matrix of numbers:

```
1 2 4 3 
2 3 1 4 
3 4 2 1 
4 1 3 2 
```

And there is a little twist if your number is odd, then you need to reverse every row and append them to your result. 

After I created the my implementation, I had an idea on how to simplify it. At least I thought its simpler ;) 

## First attempt -  Loops

Based on the description and a Python version of that algorithm, I created a classical (read "imperative") implementation.  

So this is the C# Code:

```c#
public List<List<String>> BalancedLatinSquares(int n)
{
    var result = new List<List<String>>() { };
    for (int i = 0; i < n; i++)
    {
        var row = new List<String>();
        for (int j = 0; j < n; j++)
        {
            var cell = ((j % 2 == 1 ? j / 2 + 1 : n - j / 2) + i) % n;
            cell++; // start counting from 1
            row.Add(cell.ToString());
        }
        result.Add(row);
    }
    if (n % 2 == 1)
    {
        var reversedResult = result.Select(x => x.AsQueryable().Reverse().ToList()).ToList();                
        result.AddRange(reversedResult);
    }
    return result;
}
```

I also wrote some simple unit tests to ensure this works. But in the end, I really didn't like this code.  It contains two nested loops and a lot of plumbing code.  There are four lines alone just to create the result object (list) and to add the values to it. Recently I looked into functional programming and since C# also has some functional inspired features, I tried to improve this code with some functional goodness :)

## Second attempt - Lambda Expressions

```c#
public List<List<String>> BalancedLatinSquares(int n)
{
    var result = Enumerable.Range(0, n)
        .Select(i =>
                Enumerable.Range(0, n).Select(j => ((((j % 2 == 1 ? j / 2 + 1 : n - j / 2) + i) % n)+1).ToString()).ToList()
            )
        .ToList();     
    
    if (n % 2 == 1)
    {
        var reversedResult = result.Select(x => x.AsQueryable().Reverse().ToList()).ToList();
        result.AddRange(reversedResult);
        return result;
}
```

This is the result of my attempt to use some functional features. And hey, it is much shorter, therefore it must be better, right? Well, [I posted a screenshot of both versions on Twitter](https://twitter.com/oliverguhr/status/1022395269026070528) and asked which one the people prefer. As it turned out, a lot of folks actually preferred the loop version. But why? Looking back at my code a saw two problems by looking at this line:

`Enumerable.Range(0, n).Select(j => ((((j % 2 == 1 ? j / 2 + 1 : n - j / 2) + i) % n)+1).ToString()).ToList()`

* I squeezed a lot of code in this one liner.  This makes it harder to read and therefore harder to understand.
* Another issue is, that I omitted descriptive variable names since they are not needed anymore. Oh and I removed the only comment I wrote since this comment would not fit in the one line of code :)

So, shorter is not always better.

## Third attempt - better Lambda Expressions 

The smart folks on Twitter had some great ideas about how to improve my code.

The first step was to get rid of the unholy one-liner. You can - and should - always split up your code into smaller, meaningful code blocks. I pulled out the *calculateCell* function and out of that I also extracted a *isEven* function. The nice thing is, that the function names also working as a kind of documentation about whats going on.

By returning IEnumerable instead of lists, I was able to remove some *.toList()* calls. Also, I was able to shorten the code to create the *reversedResult*. 

Another simple step to improve readability is to get line [indentation](https://en.wikipedia.org/wiki/Indentation_style) right. Personally, I don't care which indentation style people are using, as long as it's used consistently.

```c#
public static IEnumerable<IEnumerable<int>> GenerateBalancedLatinSquares(int n)
{
    bool isEven (int i) => i % 2 == 0;        
    int calculateCell(int j, int i) =>((isEven(j) ? n - j / 2 : j / 2 + 1) + i) % n + 1;
    
    var result = Enumerable
                    .Range(0, n)
                    .Select(row =>
                        Enumerable
                            .Range(0, n)
                            .Select(col =>calculateCell(col,row))
                    );     
    
    if (isEven(n) != false)
    {
        var reversedResult = result.Select(x => x.Reverse());                
        result = result.Concat(reversedResult);
    }        
    return result;conditional
}
```



I think there is room for further improvement. For the *calculateCell* function I am using this [?: conditional operator](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/conditional-operator), it allows you to write very compact code, on the other hand, it's also harder to read. If you would replace this with an *if* statement you would need more lines of code, but also have more space to add comments. Functional languages like Scala, F#, and Haskel providing this neat *match* expression that could help here. 

## Extra: How does this algorithm look in other languages:

**Python**

```python
def balanced_latin_squares(n):
    l = [[((j/2+1 if j%2 else n-j/2) + i) % n + 1 for j in range(n)] for i in range(n)]
    if n % 2:  # Repeat reversed for odd n
        l += [seq[::-1] for seq in l]
    return l
```

I took this sample from [Paul Grau.](https://gist.github.com/graup/70b09323bfa7182fe693eecb8e749896#file-balanced_latin_squares-py)

**Haskell**

<blockquote class="twitter-tweet" data-conversation="none" data-lang="de"><p lang="en" dir="ltr">Haskell: <a href="https://t.co/P5rFqvgvgA">pic.twitter.com/P5rFqvgvgA</a></p>&mdash; λx.x Carsten (@CarstenK_Dev) <a href="https://twitter.com/CarstenK_Dev/status/1022404328529829888?ref_src=twsrc%5Etfw">26. Juli 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Thank you [Carsten](https://twitter.com/CarstenK_Dev)
