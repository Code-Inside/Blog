---
layout: post
title: "Pretty Print XML in .NET"
description: "Pretty printing an XML with correct indentation and line breakings - was a bit tricky and on the other hand really simple in .NET. I found many solutions, so here is mine."
date: 2016-02-28 20:00
author: Robert Muehsig
tags: [XML, .NET]
language: en
---
{% include JB/setup %}

## Pretty Print

The term "pretty print" describes that a document is more or less human readable formatted. So instead of this:

    
    <Foo><Bar><Buzz></Buzz></Bar></Foo>
    
  
You might want to get this:

    
    <Foo>
      <Bar>
        <Buzz></Buzz>
      </Bar>
    </Foo>
    
  
Many editors support this feature - but we want to do it in code. 

## Pretty Print XML with .NET

The code is really simple, because XDocument does the heavy lifting for us.

    
    var xDocument = XDocument.Parse(input);
    string formattedXml = xDocument.ToString();
    
    // Force XML Declaration if present
    if (xDocument.Declaration != null)
    {
      formattedXml = xDocument.Declaration + Environment.NewLine + formattedXml;
    }
    return formattedXml;
    

This should work in most cases - there might be some issues with comments or maybe special XML chars. If you have a better idea, please let me know.

Hope this helps!
