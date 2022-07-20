---
layout: post
title: "How to run a Azure App Service WebJob with parameters"
description: "How to execute a WebJob with any parameters."
date: 2022-07-22 23:45
author: Robert Muehsig
tags: [Azure, AppService, WebJob]
language: en
---

{% include JB/setup %}

We are using __[WebJobs](https://docs.microsoft.com/en-us/azure/app-service/webjobs-create)__ in our Azure App Service deployment and they are pretty "easy" for the most part. Just register a WebJobs or deploy your `.exe/.bat/.ps1/...` under the `\site\wwwroot\app_data\Jobs\triggered` folder and it should execute as described in the `settings.job`.
 
![x]({{BASE_PATH}}/assets/md-images/2022-07-20/portal.png "Portal")

If you put any executable in this WebJob folder, it will be executed as planned.

__Problem: Parameters__

If you have a `my-job.exe`, then this will be invoked from the runtime. But what if you need to invoke it with a parameter like `my-job.exe -param "test"`?

__Solution: run.cmd__ 

The WebJob environment is "greedy" and will search for a `run.cmd` (or `run.exe`) and if this is found, it will be executed and it doesn't matter if you have any other `.exe` files there.
Stick to the `run.cmd` and use this to invoke your actual executable like this:

```
echo "Invoke my-job.exe with parameters - Start"

..\MyJob\my-job.exe -param "test"

echo "Invoke my-job.exe with parameters - Done"
```  

Be aware, that the path must "match". We use this `run.cmd`-approach in combination with the `is_in_place`-option (see [here](https://github.com/projectkudu/kudu/wiki/WebJobs#webjob-working-directory)) and are happy with the results). 

A more detailed explanation can be found [here](https://github.com/projectkudu/kudu/wiki/WebJobs). 

Hope this helps!