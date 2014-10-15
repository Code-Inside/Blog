---
layout: post
title: "OpenRA: Open Source Command & Conquer written in C#"
description: "If you ever wanted to take a closer look at a Game Engine OpenRA is a pretty awesome example and brings back old memories."
date: 2014-10-15 21:25
author: robert.muehsig
tags: [OpenRA, Games, C#]
---
{% include JB/setup %}

If you are familiar with Dune 2 or the Command & Conquer Serie you will definitely love [OpenRA](http://www.openra.net/). 

## Project Description

![x]({{BASE_PATH}}/assets/md-images/2014-10-15/startscreen.png "OpenRA Startscreen")

From the [_project site_](http://www.openra.net/):

> OpenRA is a Libre/Free Real Time Strategy project that recreates the classic Command & Conquer titles.
>
> We include recreations of C&C (Tiberian Dawn), C&C: Red Alert, and Dune 2000. These are not intended to be perfect copies, but instead combine the classic gameplay of the originals with modern improvements such as unit veterancy and the fog of war.
> 
> OpenRA's primary focus is cross-platform multiplayer between Windows, OS X, and Linux; however, we include a number of single-player missions, and also support skirmish games against AI bots.

## Completely written in C# and on GitHub
I always wanted to take a deeper look at Games, but most Games are written in C/C++ or other crazy languages. OpenRA on the other hand is written in C# and is on [GitHub](https://github.com/OpenRA/OpenRA/) - so Yeah! 

![x]({{BASE_PATH}}/assets/md-images/2014-10-15/vs.png "Visual Studio Solution of OpenRA")

## Game Features
The Game consists of the whole Engine, including AI, Multiplayer, Scripting (interesting for Maps) and so on and the three different Mods:
* Tiberum Dawn (Command & Conquer 1)
* Red Alert (Command & Conquer 2)
* Dune 2000

A Tiberum Sun Mod (the 3rd C&C) is currently under development. All games have been updated with ["modern" RTS game elements](https://github.com/OpenRA/OpenRA/wiki/FAQ#this-is-not-true-to-the-original) - I definitely had great fun playing some rounds.

## Coding Experience
The GitHub repo has a bunch of batch files and the Visual Studio Solution in it. Sometimes it can be a bit challenging to start and debug the game within Visual Studio, but make sure all dependencies are copied (via make dependencies) or try to switch branches. The best part is that the team is very active and is available [via GitHub or in IRC](http://www.openra.net/community/). 
All you need to do is:
	make all
	OpenRA.Game.exe
	
Or run it in Visual Studio.
	
More information can be found [here](https://github.com/OpenRA/OpenRA/wiki/Compiling)

This should build the solution and will start the game.

## Platform neutral
You can also compile the Game with Xamarin or Mono Develop under OS X or Linux and you don't need any expensive Visual Studio licence - the "Express"-Version should work, too.

## The "Game-loop"
For me the biggest difference between a real Game and a "normal" business application is the Game loop - which is kinda crazy, because it's a big while-loop. This loop is in charge for rendering and the logic. You can found the OpenRA Game loop in the _Game.cs_.

## Interesting Stuff
If you look deeper at the code you will see some very cool stuff:
* OpenGL Rendering
* LUA Scripting
* Modding via YAML
* AI Stuff (also configured via YAML)
* Working with the different assets from C&C & co.

## Take a look
As I already said - if you are interested in Game Development, this could be a good start. There is also a special [GitHub label for easy tasks](https://github.com/OpenRA/OpenRA/labels/Easy) if you want to contribute. You can also just enjoy this great game. I'm always open for a quick OpenRA match. 

![x]({{BASE_PATH}}/assets/md-images/2014-10-15/game.png "Tiberum Dawn")

Happy Coding... or playing.