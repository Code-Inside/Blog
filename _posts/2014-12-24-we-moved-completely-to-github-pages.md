---
layout: post
title: "We moved completely to GitHub Pages - German & English Posts migrated!"
description: "After a long time with two different Wordpress installations we are finally on completely on GitHub Pages."
date: 2014-12-24 18:00
author: robert.muehsig
tags: [Wordpress, GitHub Pages, GitHub]
language: en
---
{% include JB/setup %}

The year 2014 was a big year for the German & English Code Inside Blog - as you might already know, because you are reading these lines, we are now finally completely on [GitHub Pages](https://github.com/Code-Inside/Blog/). 

But to summarize it, here are the main parts:

## Pre-2014 World
We started this Blog in German __2007__ with a simple Wordpress Installation. In __2008__ we begun to write Blogposts in English, but the main blog was still the German Blog. During the last years a good friend, Antje Killian, helped me and Oliver to translate the German articles and publish them on the English Blog. 

## March 2014 Custom VM to Azure VM
I always wanted to move the Blogs from our small Hoster to Azure, because I can spend there 115 Euro per month (MSDN Subscription, yeah!) and I wasn't very happy about the Hosting contract. So we __[moved to Azure](http://blog.codeinside.eu/2014/03/05/move-to-windows-azure-vms-word-press-migration-dns-changes/)__.

## September 2014 Wordpress to Jekyll Migration for the German Blog

Until September 2014 our main "blog" language was still German. I decided to Blog now only in English and we converted the German-Blogposts to Markdown and moved to GitHub.

These Blogposts cover the Wordpress to Jekyll Migration and the reasons for our language switch:

* [Wordpress to Jekyll Migration and Language switch](http://blog.codeinside.eu/2014/09/01/WordPress-To-Jekyll-Migration-And-Language-Switch/)
* [How we moved from Wordpress to Jekyll - on Windows](http://blog.codeinside.eu/2014/09/13/How-We-Moved-From-Wordpress-To-Jekyll-On-Windows/)

## December 2014 Wordpress to Jekyll Migration for the English Blog

The last weeks I converted the English Blogposts to Markdown, uploaded it to GitHub and did some enhancements to our Jekyll Installation. We now have a multi-language "Blog-Installation" on GitHub Pages.

We now have two archives, in __[English](http://blog.codeinside.eu/archive/)__ and __[German](http://blog.codeinside.eu/archive-de/)__. The feed will now only list English posts, but our goal is to keep English as the main language.

## All URLs should still be valid

I really hate it when content disappears, so I tried my best to keep all URLs working (= with a redirect to the new environment). In this [Blogpost](http://blog.codeinside.eu/2014/03/05/move-to-windows-azure-vms-word-press-migration-dns-changes/) I showed the web.config with the URL Rewrite rules. 
Now, this is the current URL-Rewrite Section on the (still running) Azure VM, that will redirect everything to this GitHub Pages installation:

    <?xml version="1.0" encoding="UTF-8"?>
    <configuration>
        <system.webServer>
            <rewrite>
                <rules>
                    <clear />
                    <rule name="code-inside.de blog-in" stopProcessing="true">
                        <match url="blog\-in(.*)" />
                        <conditions logicalGrouping="MatchAll" trackAllCaptures="false">
                            <add input="{HTTP_HOST}" pattern="code-inside.de" />
                        </conditions>
                        <action type="Redirect" url="http://blogin.codeinside.eu{R:1}" redirectType="Permanent" />
                    </rule>
                    <rule name="code-inside.de blog" stopProcessing="true">
                        <match url="blog(.*)" />
                        <conditions logicalGrouping="MatchAll" trackAllCaptures="false">
                            <add input="{HTTP_HOST}" pattern="code-inside.de" />
                        </conditions>
                        <action type="Redirect" url="http://blog.codeinside.eu{R:1}" redirectType="Permanent" />
                    </rule>
                    <rule name="code-inside.de files" stopProcessing="true">
                        <match url="files(.*)" />
                        <conditions logicalGrouping="MatchAll" trackAllCaptures="false">
                            <add input="{HTTP_HOST}" pattern="code-inside.de" />
                        </conditions>
                        <action type="Redirect" url="http://cdn.codeinside.eu/files{R:1}" redirectType="Permanent" />
                    </rule>
    				<rule name="blogin.codeinside.eu to GitHub" stopProcessing="true">
    				    <match url="(.*)" />
                        <conditions logicalGrouping="MatchAll" trackAllCaptures="false">
                            <add input="{HTTP_HOST}" pattern="blogin.codeinside.eu" />
                        </conditions>
                        <action type="Redirect" url="http://blog.codeinside.eu/{R:1}" redirectType="Permanent" />
                    </rule>
                    <rule name="catch all" stopProcessing="true">
                        <conditions logicalGrouping="MatchAll" trackAllCaptures="false" />
                        <action type="Redirect" url="http://www.codeinside.eu" />
                    </rule>
                </rules>
            </rewrite>
        </system.webServer>
    </configuration>

__If you found any issues, please let us [know](https://github.com/Code-Inside/Blog/issues)__

Hope this helps and happy Christmas!