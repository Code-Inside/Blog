---
layout: post
title: "UrlEncode the Space Charater"
description: "Is it a '+' or '%20'?"
date: 2024-08-20 23:59
author: Robert Muehsig
tags: [UrlEncoding, TIL]
language: en
---

{% include JB/setup %}

*This is more of a "Today-I-Learned" post and not a "full-blown How-To article." If something is completely wrong, please let me know - thanks!* 

This might seem trivial, but last week I noticed that the [HttpUtility.UrlEncode(string)](https://learn.microsoft.com/en-us/dotnet/api/system.web.httputility.urlencode?view=net-8.0) encodes a space ` ` into `+`, whereas the JavaScript [encodeURI(string)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURI) method encodes a space as `%20`.
This brings up the question:

# Why?

It seems that in the early specifications, a space was encoded into a `+`, see this [Wikipedia](https://en.wikipedia.org/wiki/Percent-encoding) entry:

> When data that has been entered into HTML forms is submitted, the form field names and values are encoded and sent to the server in an HTTP request message using method GET or POST, or, historically, via email.[3] The encoding used by default is based on an early version of the general URI percent-encoding rules,[4] with a number of modifications such as newline normalization and replacing spaces with + instead of %20. The media type of data encoded this way is application/x-www-form-urlencoded, and it is currently defined in the HTML and XForms specifications. In addition, the CGI specification contains rules for how web servers decode data of this type and make it available to applications.

This convention has persisted to this day. For instance, when you search something on Google or Bing with a space in the query, the space is encoded as a `+`.

There seems to be some rules however, e.g. it is only "allowed" in the query string or as form parameters.

I found the [question & answers on StackOverflow](https://stackoverflow.com/questions/1634271/url-encoding-the-space-character-or-20) quite informative, and [this answer](https://stackoverflow.com/a/72833702) summarizes it well enough for me:

```
| standard      | +   | %20 |
|---------------+-----+-----|
| URL           | no  | yes |
| query string  | yes | yes |
| form params   | yes | no  |
| mailto query  | no  | yes |
```

# What about .NET?

If you want to always encode spaces as `%20`, use the `UrlPathEncode` method, see [here](https://learn.microsoft.com/en-us/dotnet/api/system.web.httputility.urlencode?view=net-8.0).

> You can encode a URL using with the UrlEncode method or the UrlPathEncode method. However, the methods return different results. The UrlEncode method converts each space character to a plus character (+). The UrlPathEncode method converts each space character into the string "%20", which represents a space in hexadecimal notation. Use the UrlPathEncode method when you encode the path portion of a URL in order to guarantee a consistent decoded URL, regardless of which platform or browser performs the decoding.

Hope this helps!
