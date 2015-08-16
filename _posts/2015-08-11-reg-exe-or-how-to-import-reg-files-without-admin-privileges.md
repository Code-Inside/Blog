---
layout: post
title: "Reg.exe or how to import .reg files without admin privileges"
description: "Ever tried to import a registry key, but don't have admin privileges - reg.exe might help you."
date: 2015-08-11 23:30
author: robert.muehsig
tags: [Registry]
language: en
---
{% include JB/setup %}

The beloved Registry is still an important part of Windows, because of COM, protocol mappings, program registrations etc. - so, even in 2015 we might have to deal with it.

## Problem: Writing some Registry keys without admin privileges

Everytime I need to fiddle around in the Registry I use "RegEdit", but "RegEdit" needs admin privileges - because it can change everything (as far as I know).
The fun part is: Not all hives (the trees inside the registry-tree-structure) needs admin permissions. A typical user has the following permissions:

* Read on HKEY_CLASSES_ROOT (which is just a combinded view over the classes of HKEY_CURRENT_USER and HKEY_LOCAL_MACHINE)
* Read __and write__ on HKEY_CURRENT_USER
* Read on HKEY_LOCAL_MACHINE
* Read on HKEY_USERS
* Read on HKEY_CURRENT_CONFIG

So, if I want to write a key under the HKEY_CURRENT_USER with a normal user account it should be possible, but how?

## Solution 1: Via Code

Code something via the [Registry-APIs](https://msdn.microsoft.com/en-us/library/microsoft.win32.registry(v=vs.110).aspx) in .NET (or any other language...) and it should work, without messing around with admin stuff or turing off the UAC, which is really a stupid idea.

## Solution 2: Via reg.exe

Create a .reg file and try __reg.exe__. Syntax like:

    reg.exe import myregfile.reg

I discovered reg.exe and found it really handy, because it is very flexible and a .reg file can easily be written without much coding.

__[Reg.exe](https://technet.microsoft.com/en-us/library/cc732643.aspx)__ is shipped with Windows since... mh... like forever and should be safe to use.

## Solution 3: Combine the two other solutions

Of course you could invoke reg.exe also via code. This way you can still use any .reg file, but "embed" it inside your application.

    string path = "\"" + filepath + "\""; 
    using (var process = new Process())
    {
        try 
        { 
        process.StartInfo.FileName = "reg.exe"; 
        process.StartInfo.WindowStyle = ProcessWindowStyle.Hidden; 
        process.StartInfo.CreateNoWindow = true; 
        process.StartInfo.UseShellExecute = false; 
 
        string command = "import " + path; 
        process.StartInfo.Arguments = command; 
        process.Start(); 
 
        process.WaitForExit(); 
        }   
        catch (System.Exception) 
        { 
            // log...?
            proc.Dispose(); 
        }
    }    
    
    
Hope this helps!
