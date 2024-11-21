---
layout: post
title: "Microsoft Defender Performance Analyzer"
description: "If you ever need to check, if Defender is slowing down your program..."
date: 2024-11-21 23:59
author: Robert Muehsig
tags: [Windows, Microsoft Defender, Performance]
language: en
---

{% include JB/setup %}

*This is more of a "Today-I-Learned" post and not a "full-blown How-To article." If something is completely wrong, please let me know - thanks!* 

A customer notified us that our product was slowing down their Microsoft Office installation at startup.
Everything on our side seemed fine, but sometimes Office took 10–15 seconds to start.

After some research, I stumbled upon this: [Performance analyzer for Microsoft Defender Antivirus](https://learn.microsoft.com/en-us/defender-endpoint/tune-performance-defender-antivirus).

# How to run the Performance Analyzer

The best part about this application is how easy it is to use (as long as you have a prompt with admin privileges). Simply run this PowerShell command:

    New-MpPerformanceRecording -RecordTo recording.etl

This will start the recording session. After that, launch the program you want to analyze (e.g., Microsoft Office). When you're done, press `Enter` to stop the recording.

The generated `recording.etl` file can be complex to read and understand. However, there's another command to extract the "Top X" scans, which makes the data way more readable.

Use this command to generate a CSV file containing the top 1,000 files scanned by Defender during that time:

    (Get-MpPerformanceReport -Path .\recording.etl -Topscans 1000).TopScans | Export-CSV -Path .\recording.csv -Encoding UTF8 -NoTypeInformation

Using this tool, we discovered that Microsoft Defender was scanning all our assemblies, which was causing Office to start so slowly.

Now you know: If you ever suspect that Microsoft Defender is slowing down your application, just check the logs.

__Note:__ After this discovery, the customer adjusted their Defender settings, and everything worked as expected.

Hope this helps!
