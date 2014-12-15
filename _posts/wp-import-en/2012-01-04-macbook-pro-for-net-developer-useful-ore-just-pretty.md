---
layout: post
title: "MacBook Pro for .NET Developer – useful or just pretty?"
date: 2012-01-04 11:00
author: CI Team
comments: true
categories: [Uncategorized]
tags: [MacBook Pro; Apple]
language: en
---
{% include JB/setup %}
&nbsp;

I own a MacBook Pro (from 2010) for about a year now and because I’ve used to think about this Question since I have it, I’m going to blog about my experience now.

<strong>My Notebook Configurations MacBook Pro April 2010</strong>

- 2,66 Intel Core i7

- 8GB RAM

- 15’’ Glossy Display

- Intel X-25M 168GB SSD

<strong>The Hardware: It’s a dream – at least with little disadvantages </strong>



What to write about Apple Hardware: The Quality is amazing. There are worlds between this and all the plastic notebooks I’ve seen so far. Also the Touchpad and the clever usage of Multitouch in the Desktop World are brilliant. The Display is great and the Colors are very strong. I wasn’t even disturbed by the “Glossy” but maybe it’s because I didn’t use it in the sun .. Come on… I’m a Developer <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile31.png" alt="Zwinkerndes Smiley" />

For a Developer the keyboard is very important and here is <strong>the problem</strong>…

a) It’s a Notebook keyboard where some keys are left anyway

b) It’s a keyboard from Apple where even more keys are left or allocated with something else

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb605.png" border="0" alt="image" width="589" height="406" />

In compare with my PC keyboard (not that beautiful but that what they usually look like):

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb606.png" border="0" alt="image" width="600" height="287" />

Either my keyboard scheme was totally wrong configured or I’m a noob. I couldn’t find the keys “~” and “\”, which are sometimes very useful for developers. Also “[“”]” and “{“”}” where missing for a long time even if I found them with closed eyes on my normal keyboard and why the @ is on a completely other key is a mystery.

At last if you plan to use the numerous Goodis of Resharper you will need some Specialists (POS1 / ENDE,…) which you wouldn’t find on the MacBook Keyboard.

An advantage is that the keyboard glows in the dark and that writing on her is very comfortable. Programming is very difficult but you can learn to life with it (Quite recently I didn’t use a second keyboard <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile31.png" alt="Zwinkerndes Smiley" /> )

<span style="text-decoration: underline;"> </span>

<span style="text-decoration: underline;">Summary about the hardware:</span>

It’s possible to work with the keyboard and the mouse but it’s more effective to use another one. At the moment I use this one. There is nothing negative left to say about the hardware.

<strong>About the Software: Mac OSX or Windows? Why not both?</strong>



I don’t care if it’s Mac OSX or Windows 7. Both have their strengths and weaknesses. But at last I have to use Windows for Visual Studio and co.

<span style="text-decoration: underline;"> </span>

<span style="text-decoration: underline;"><a href="{{BASE_PATH}}/assets/wp-images-en/image1429.png"><img style="background-image: none; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; padding-top: 0px; border: 0px;" title="image1429" src="{{BASE_PATH}}/assets/wp-images-en/image1429_thumb.png" border="0" alt="image1429" width="96" height="108" align="left" /></a>What I use Mac OSX for: </span>Most of all for Browsing in the Web. It’s more comfortable to use the great Touchpad then a Mouse or the Touchpad of a Windows Notebook. Even Mail-App and iCal is okay for the usual user. The Mail-App works and I don’t have problems with the synchronization so far.

<a href="http://www.applesheet.com/download-mac-os-x-10-7-1-lion-update-direct-link/34039/">(Picturesource)</a>

Summary:

- Webbrowsing for fun

- Mail

<span style="text-decoration: underline;"> </span>

<span style="text-decoration: underline;"><a href="{{BASE_PATH}}/assets/wp-images-en/image1430.png"><img style="background-image: none; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; padding-top: 0px; border: 0px;" title="image1430" src="{{BASE_PATH}}/assets/wp-images-en/image1430_thumb.png" border="0" alt="image1430" width="101" height="82" align="left" /></a>What I use Windows 7 for: </span>For developing with Visual Studio and for serious office stuff. To say the true I didn’t like Office for Mac &amp; co. Office 2010 is enough for me. Even if it has some faults but nothing is perfect <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile31.png" alt="Zwinkerndes Smiley" />. Gaming of course makes only sense on Windows.

Summary:

- Developing with .NET / Visual Studio 2010

- Office

- Gaming

<strong>Connecting both worlds with Bootcamp &amp; VMWare Fusion – without disadvantages </strong>



Since the change to Intel-processors MacBooks are at least “only” PC’s. Of course it’s possible to install Windows 7 nativ – Apple calls this Bootcamp and serves the fitting drivers. With Bootcamp Windows runs native like on every other PC and uses the whole power. But for example the Touchpad doesn’t work in the same way like with Mac OSX.

Bootcamp “splits” the hard disk in an OSX and in a Windows partition. But think twice about this step because the hard disk is only 160GB – not much space if you are used to think in Terabyte.

<a href="{{BASE_PATH}}/assets/wp-images-en/image1431.png"><img style="background-image: none; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; padding-top: 0px; border: 0px;" title="image1431" src="{{BASE_PATH}}/assets/wp-images-en/image1431_thumb.png" border="0" alt="image1431" width="65" height="68" align="left" /></a>VMWare Fusion has a very useful feature: It’s possible to boot the Bootcamp partition in a VM. The advantage is that you are now able to use MacOSX and Windows at the same time. The performance doesn’t thank you for that but simple strategy games, Office or Visual Studio will work.

Combined with VMWare Fusion it’s able to connect both worlds in a classy way and if you need more Power than you use Bootcamp. Only Windows hates the changes of the Hardwaresettings and asks for a reactivation of the Licencekey.

&nbsp;
<div id="scid:5737277B-5D6D-4f48-ABFC-DD9C333F4C5D:408e7628-c704-4006-bc56-95ec0f60e9bb" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<div><object width="434" height="244"><param name="movie" value="http://www.youtube.com/v/uFAWg6XZ0ic?hl=en&amp;hd=1" /><embed type="application/x-shockwave-flash" width="434" height="244" src="http://www.youtube.com/v/uFAWg6XZ0ic?hl=en&amp;hd=1"></embed></object></div>
</div>
That’s what the Windows Capacity index looks like (because of this is the MacBook from 2010 the newest Generation will look a little bit better)

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb610.png" border="0" alt="image" width="537" height="181" />

<strong>Take a look beyond your own nose (at least for iOS Devs)!</strong>



To take a look beyond your nose to try Mac OSX could be a reason for the buy as well (it was for me too). If you want to develop native for iOS Tools you need a MacBook Pro.

If you like it you can try mono as well but I didn’t even think about this – if .NET works on Windows and I build WebApps why this pain?

But it’s possible.

I don’t regret the buy but now I need a battle machine to play battlefield (but this would be the dead for every Windows Notebook at least <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile31.png" alt="Zwinkerndes Smiley" />).

<strong>Result: Is a MacBook Pro the right choice for a .NET Developer?</strong>



If you need a high class Notebook with Performance but also mobile: Yes, I recommend it to you. But for a longer work and for programming you need a windows keyboard.

If you are only mobile from time to time the better choice is a usual pc and for to go a <a href="http://blog.thomasbandt.de/39/2371/de/blog/macbook-air-late-2010-kurzes-review.html">MachBook Air</a>. Today it would have been the better choice for me.

If you don’t want to make any type of compromises than you should buy the MacBook Pro – it will never be a bad buy. Or you wait for a look on the Ultrabooks.



<strong>Last question – Gaming?</strong>

From time to time you need a little alternation. On the 2010 Macbook Battlefield 3 runs on the “minimal” settings at last for 3 hours. After that the machine gets hot and turns into the sleep mode. Nice for working but I need something with more power <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile31.png" alt="Zwinkerndes Smiley" />. But keep in mind, that battlefield is a very ambitious game. Older games run without problems.

If you are interested now: Im sure you will find something on Apple or Amazon.
