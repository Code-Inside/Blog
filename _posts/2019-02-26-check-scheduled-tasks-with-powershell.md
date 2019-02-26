---
layout: post
title: "Check Scheduled Tasks with Powershell"
description: "Using Powershell to see the status and actions of a scheduled task in Windows."
date: 2019-02-26 23:45
author: Robert Muehsig
tags: [Windows, Powershell]
language: en
---

{% include JB/setup %}

# Task Scheduler via Powershell

Let's say we want to know the latest result of the "GoogleUpdateTaskMachineCore" task and the corresponding actions.

![x]({{BASE_PATH}}/assets/md-images/2019-02-26/taskscheduler.png "Task Scheduler")

All you have to do is this (in a Run-As-Administrator Powershell console) :

    Get-ScheduledTask | where TaskName -EQ 'GoogleUpdateTaskMachineCore' | Get-ScheduledTaskInfo
	
The result should look like this:

    LastRunTime        : 2/26/2019 6:41:41 AM
    LastTaskResult     : 0
    NextRunTime        : 2/27/2019 1:02:02 AM
    NumberOfMissedRuns : 0
    TaskName           : GoogleUpdateTaskMachineCore
    TaskPath           : \
    PSComputerName     :

Be aware that the "LastTaskResult" might be displayed as an integer. The full "result code list" [documentation](https://docs.microsoft.com/en-us/windows/desktop/taskschd/task-scheduler-error-and-success-constants) only lists the hex value, so you need to convert the number to hex.

Now, if you want to access the corresponding actions you need to work with the "actual" task like this:

    PS C:\WINDOWS\system32> $task = Get-ScheduledTask | where TaskName -EQ 'GoogleUpdateTaskMachineCore'
    PS C:\WINDOWS\system32> $task.Actions
    
    
    Id               :
    Arguments        : /c
    Execute          : C:\Program Files (x86)\Google\Update\GoogleUpdate.exe
    WorkingDirectory :
    PSComputerName   :

If you want to dig deeper, just checkout all the properties:

    PS C:\WINDOWS\system32> $task | Select *
    
    
    State                 : Ready
    Actions               : {MSFT_TaskExecAction}
    Author                :
    Date                  :
    Description           : Keeps your Google software up to date. If this task is disabled or stopped, your Google
                            software will not be kept up to date, meaning security vulnerabilities that may arise cannot
                            be fixed and features may not work. This task uninstalls itself when there is no Google
                            software using it.
    Documentation         :
    Principal             : MSFT_TaskPrincipal2
    SecurityDescriptor    :
    Settings              : MSFT_TaskSettings3
    Source                :
    TaskName              : GoogleUpdateTaskMachineCore
    TaskPath              : \
    Triggers              : {MSFT_TaskLogonTrigger, MSFT_TaskDailyTrigger}
    URI                   : \GoogleUpdateTaskMachineCore
    Version               : 1.3.33.23
    PSComputerName        :
    CimClass              : Root/Microsoft/Windows/TaskScheduler:MSFT_ScheduledTask
    CimInstanceProperties : {Actions, Author, Date, Description...}
    CimSystemProperties   : Microsoft.Management.Infrastructure.CimSystemProperties
	
If you have worked with Powershell in the past this blogpost should "easy", but it took me a while to see the result code and to check if the action was correct or not.

Hope this helps!
