---
layout: post
title: "Non-cryptographic hash functions for .NET"
description: "If you are using crypto-hash functions for non-crypto purposes you might want to take a look at faster and 'better' alternatives."
date: 2017-06-30 00:15
author: Robert Muehsig
tags: [Crypto, Hash]
language: en
---
{% include JB/setup %}

Creating hashs is quite common to check if content X has changed without looking at the whole content of X. 
Git for example uses SHA1-hashs for each commit. SHA1 itself is a pretty old cryptographic hash function, but in the case of Git there might have been better alternatives available, because the "to-be-hashed" content is not crypto relevant - it's just content marker. Well... in the case of Git the current standard is SHA1, which works, but a 'better' way would be to use non-cryptographic functions for non-crypto purposes.

## Why you should not use crypto-hashs for non-crypto

I discovered this topic via a Twitter-conversation and it started with this [Tweet](https://twitter.com/sfeldman/status/804984253985370112):

<blockquote class="twitter-tweet" data-lang="de"><p lang="en" dir="ltr">Bend Message Deduplication on <a href="https://twitter.com/hashtag/azure?src=hash">#azure</a> <a href="https://twitter.com/hashtag/servicebus?src=hash">#servicebus</a> to Your Will <a href="https://t.co/zjIQFjt2c9">https://t.co/zjIQFjt2c9</a></p>&mdash; Sean Feldman (@sfeldman) <a href="https://twitter.com/sfeldman/status/804984253985370112">3. Dezember 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

[Clemens Vasters](https://twitter.com/clemensv/status/805499766264172548) then came and pointed out why it would be better to use non-crypto hash functions:

<blockquote class="twitter-tweet" data-lang="de"><p lang="en" dir="ltr">Rationale: Any use of broken crypto hashes may trip up security review processes.</p>&mdash; Clemens Vasters 🇪🇺 (@clemensv) <a href="https://twitter.com/clemensv/status/805499766264172548">4. Dezember 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

The reason makes perfect sense for me - next step: What other choice are available?

## Non-cryptographic hash functions in .NET

If you are googleing around you will find many different hashing algorithm, like [Jenkins](https://en.wikipedia.org/wiki/Jenkins_hash_function) or [MurmurHash](https://en.wikipedia.org/wiki/MurmurHash). 

The good part is, that [Brandon Dahler](https://github.com/brandondahler) created .NET versions of the most well known algorithm and published them as NuGet packages.

The source and everything can be found on __[GitHub](https://github.com/brandondahler/Data.HashFunction/)__.

## Lessons learned

If you want to hash something and it is not crypto relevant, then it would be better to look at one of those Data.HashFunctions - some a pretty crazy fast.

I'm not sure which one is 'better' - if you have some opinions please let me know. Brandon created a small description of each algorithm on the __[Data.HashFunction documentation page](http://datahashfunction.azurewebsites.net/)__.

*(my blogging backlog is quite long, so I needed 6 month to write this down ;) )*
