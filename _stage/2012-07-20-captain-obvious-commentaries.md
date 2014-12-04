---
layout: post
title: "Captain Obvious commentaries"
date: 2012-07-20 12:22
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
&nbsp;

It was hard to write the code so we need to write good commentaries. Besides detailed commentaries are a characteristic for quality software right?

<strong>No.</strong>

To write a useful comment is a special art – but to comment on everything ends in something like this:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c4b6c305-92bf-497a-b74b-c31b5d5a0eef" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">  /// &lt;summary&gt;
    /// Home Controller
    /// &lt;/summary&gt;
    public class HomeController : Controller
    {
        /// &lt;summary&gt;
        /// Index Method
        /// &lt;/summary&gt;
        /// &lt;returns&gt;&lt;/returns&gt;
        public ActionResult Index()
        {
            ViewBag.Message = "Welcome to ASP.NET MVC!";

            return View();
        }

        /// &lt;summary&gt;
        /// Guess what?
        /// &lt;/summary&gt;
        /// &lt;returns&gt;&lt;/returns&gt;
        public ActionResult About()
        {
            return View();
        }
    }</pre>
</div>
The value of comments like this is almost zero – short of you tricked a special “Quality code Metric” or followed a rule. <a href="http://code-inside.de/blog/2010/11/18/howto-stylecop-settings-auf-mehrere-projekte-anwenden/">StyleCop</a> &amp; Co offer an easy way to create a rigid rule type.

<strong>Rules and “less is more”</strong>

<strong> </strong>

A “we comment on everything” rule makes no sense at all and seduces people to create “wrong” comments. Comments have to explain the code – why is there this and this element. That it’s the “HomeController” class I’m able to found out by myself and I also know what a constructor looks like. But why do you run these tests? What’s the technical background behind this Code?

If you write to many commentaries for your code your project members won’t be very motivated to read them. Resharper is able to run smart Refactorings – but the commentaries need to be handmade and if nobody does this (because there are too many of them) they are nothing more than dead weight.

<strong>My recommendations for commentaries:</strong>

- Why did you develop your code like this? The how is already in the code

- Rules seduce to useless comments and they need additional time during the development and especially in the code support

- You need to agree on one language in your team. German/English mixture isn’t that nice

- Always keep in mind: Is the comment an additional value for the code? If not than you don’t need the comment. Don’t mind. <strong>(Commentaries are not a must have!)</strong>

<strong>If comments get to long…</strong>

In this case you might ask yourself if your code is too complicated. Countless lines of explanation may show you that your method has to many tasks.

<strong>Other opinions about this subject</strong>

<a href="http://ayende.com/blog/1948/on-code-comments">Ayende Rahien</a> and Jeff Attwood <a href="http://www.codinghorror.com/blog/2008/07/coding-without-comments.html">blogged</a> about this (old subject) as well.

<strong>I’m interested in your opinion as well</strong>

<strong> </strong>

What do you think? Comment on everything? Am I just too lazy for all the writing? Do you have any code comment rules?
