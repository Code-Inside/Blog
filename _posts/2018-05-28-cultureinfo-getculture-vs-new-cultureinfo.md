---
layout: post
title: "CultureInfo.GetCulture() vs. new CultureInfo() - what's the difference?"
description: "Last month I was fighting a nasty localization problem with number group separators. If you are dealing with localizations you should know the different behavior of GetCulture() vs new CultureInfo()."
date: 2018-05-28 23:45
author: Robert Muehsig
tags: [.NET, localization]
language: en
---
{% include JB/setup %}

# The problem

The problem started with a simple code:

    double.TryParse("1'000", NumberStyles.Any, culture, out _)

Be aware that the given culture was "DE-CH" and the Swiss use the ' for the separator for numbers. 

Unfortunately the Swiss authorities has abandoned the ' for currencies, but it is widly used in the industrie and such a number should be parsed or displayed.

Now Microsoft steps in and they use a very similar char in the "DE-CH" region setting:

* The backed in char to separate numbers: ' (CharCode: 8217)
* The obvious choice would be: ' (CharCode: 39)

__The result of this configuration hell:__

If you don't change the region settings in Windows you can't parse doubles with this fancy group separator. 

__Stranger things:__

My work machine is running the EN-US version of Windows and my tests where failing because of this madness, but it was even stranger: Some other tests (quite similar to what I did) were OK on our company DE-CH machines.

# But... why?

After some crazy time I discovered that our company DE-CH machines (and the machines from our customer) were using the "sane" group separator, but my code still didn't work as expected.

# Root cause

The root problem (besides the stupid char choice) was this: I used the "wrong" method to get the "DE-CH" culture in my code. 

Let's try out this demo code:

```csharp
class Program
    {
        static void Main(string[] args)
        {
            var culture = new CultureInfo("de-CH");

            Console.WriteLine("de-CH Group Separator");
            Console.WriteLine(
                $"{culture.NumberFormat.CurrencyGroupSeparator} - CharCode: {(int) char.Parse(culture.NumberFormat.CurrencyGroupSeparator)}");
            Console.WriteLine(
                $"{culture.NumberFormat.NumberGroupSeparator} - CharCode: {(int) char.Parse(culture.NumberFormat.NumberGroupSeparator)}");

            var cultureFromFramework = CultureInfo.GetCultureInfo("de-CH");

            Console.WriteLine("de-CH Group Separator from Framework");
            Console.WriteLine(
                $"{cultureFromFramework.NumberFormat.CurrencyGroupSeparator} - CharCode: {(int)char.Parse(cultureFromFramework.NumberFormat.CurrencyGroupSeparator)}");
            Console.WriteLine(
                $"{cultureFromFramework.NumberFormat.NumberGroupSeparator} - CharCode: {(int)char.Parse(cultureFromFramework.NumberFormat.NumberGroupSeparator)}");
        }
    }
```

The result should be something like this: 

```
de-CH Group Separator
' - CharCode: 8217
' - CharCode: 8217
de-CH Group Separator from Framework
' - CharCode: 8217
' - CharCode: 8217
```

Now change the region setting for de-CH and see what happens:

![x]({{BASE_PATH}}/assets/md-images/2018-05-28/regionsettings.png "Changed region settings")

```
de-CH Group Separator
' - CharCode: 8217
X - CharCode: 88
de-CH Group Separator from Framework
' - CharCode: 8217
' - CharCode: 8217
```

Only the CultureInfo from the first instance got the change!

# Modified vs. read-only

The problem can be summerized with: [RTFM](https://msdn.microsoft.com/en-us/library/system.globalization.cultureinfo.getcultureinfo(v=vs.110).aspx)!

From the MSDN for GetCultureInfo: *Retrieves a cached, read-only instance of a culture.*

The ["new CultureInfo" constructor](https://msdn.microsoft.com/en-us/library/205h6kwc(v=vs.110).aspx) will pick up the changed settings from Windows.

# TL;DR:

* CultureInfo.GetCultureInfo will return a "backed in" culture, which might be very fast, but doesn't respect user changes.
* If you need to use the modified values from windows: Use the normal CultureInfo constructor.

Hope this helps!
