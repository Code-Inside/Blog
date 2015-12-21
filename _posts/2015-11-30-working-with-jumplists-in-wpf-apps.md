---
layout: post
title: "Working with JumpLists in WPF Apps"
description: "Even JumpLists are an old topic, I stumbled upon this topic and want to show how to create and work with JumpLists in a WPF app."
date: 2015-11-30 23:30
author: Robert Muehsig
tags: [WPF, Windows, JumpLists]
language: en
---
{% include JB/setup %}

## JumpLists?

JumpLists were introduced with Windows 7 and if it they are implemented right are pretty handy, because it can provide common functionality. 

A real world example:

![x]({{BASE_PATH}}/assets/md-images/2015-11-30/jumplistdemo.png "JumpList Demo")

## JumpLists with .NET

In pre .NET 4.0 times there was a Windows7API Code Pack available to access the JumpLists APIs of Windows and many older blogposts reference it, but since .NET 4.0 is out the JumpList APIs are part of the [PresentationFramework.dll](https://msdn.microsoft.com/en-us/library/system.windows.shell.jumpitem(v=vs.110).aspx). 
So, you don't need any other library - at least not for the stuff that I want to show you here.

## JumpLists & Windows Vista

A warning for everyone that still have to support Windows Vista: .NET 4.0 is supported on Windows Vista, but the JumpLists were introduced with Windows 7.
If you are trying to create a JumpList or touch the JumpList APIs your app will crash with a NotSupportedException. 

## Creating JumpLists via XAML

__Small warning: If you try this on Windows Vista, your app will just crash...__

JumpLists are registred per application and the easiest way to create a (static) JumpList is via XAML in the App.xaml:

    <Application x:Class="Jumplist_Sample.App"
                xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
                xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
                StartupUri="MainWindow.xaml">
        <Application.Resources>
            
        </Application.Resources>
        <JumpList.JumpList>
            <JumpList ShowRecentCategory="True"
                    ShowFrequentCategory="True"
                    
                    JumpItemsRejected="JumpList_JumpItemsRejected"
                    JumpItemsRemovedByUser="JumpList_JumpItemsRemovedByUser">
                
                <JumpTask Title="Notepad" 
                        Description="Open Notepad." 
                        ApplicationPath="C:\Windows\notepad.exe"
                        IconResourcePath="C:\Windows\notepad.exe"/>
                <JumpTask Title="Read Me" 
                        Description="Open readme.txt in Notepad." 
                        ApplicationPath="C:\Windows\notepad.exe"
                        IconResourcePath="C:\Windows\System32\imageres.dll"
                        IconResourceIndex="14"
                        WorkingDirectory="C:\Users\Public\Documents"
                        Arguments="readme.txt"/>
            </JumpList>
        </JumpList.JumpList>
    </Application>

## Creating JumpLists via Code

The "coding" JumpList API is a bit odd to use, but still easy to understand:

    var jt = new JumpTask
    {
        ApplicationPath = "C:\\Windows\\notepad.exe",
        Arguments = "readme.txt",
        Title = "Recent Entry for Notepad",
        CustomCategory = "Dummy"
    };
    
    JumpList.AddToRecentCategory(jt);
    
    
    
    var jt2 = new JumpTask
    {
        ApplicationPath = "C:\\Windows\\notepad.exe",
        Arguments = "readme.txt",
        Title = "Code Entry for Notepad",
        CustomCategory = "Dummy"
    };
    
    var currentJumplist = JumpList.GetJumpList(App.Current);
    currentJumplist.JumpItems.Add(jt2);
    currentJumplist.Apply();
    
The "Apply()" call is needed, otherwise the new JumpItem will not be added. As you can see, you can create new JumpList entries, add (and I think you could also remove items) from the default recent category.
Besides [JumpTasks](https://msdn.microsoft.com/en-us/library/system.windows.shell.jumptask(v=vs.110).aspx) there is [JumpPath](https://msdn.microsoft.com/en-us/library/system.windows.shell.jumppath(v=vs.110).aspx), which just contains a link.

In the XAML Part I also hooked up some events, so your application can get notified when a user pins something or removes something which you might want to handle. 

## Result

![x]({{BASE_PATH}}/assets/md-images/2015-11-30/jumplistresult.png "Result of Democode")
	
Oh... and of course: Windows 10 still supports JumpLists and there are rumors that even UWP apps will somehow support JumpLists.	
	
A good read was [this blogpost](http://elegantcode.com/2011/01/21/wpf-windows-7-taskbar-part-two-jump-lists/) (and it also contains information about other Windows 7 "Taskbar"-enhancements which are still valid for Windows 10). 

Hope this helps!

The code is also available on __[GitHub](https://github.com/Code-Inside/Samples/tree/master/2015/Jumplists)__.
