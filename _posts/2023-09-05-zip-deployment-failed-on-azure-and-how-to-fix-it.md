---
layout: post
title: "Zip deployment failed on Azure"
description: "How to fix a nasty ZipDeploy problem"
date: 2023-09-05 23:55
author: Robert Muehsig
tags: [Azure, AppService, ZipDeploy]
language: en
---

{% include JB/setup %}

# The Problem

We are using [Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/) for our application (which runs great BTW) and deploy it automatically via [ZipDeploy](https://learn.microsoft.com/en-us/azure/app-service/deploy-zip). 
This basic setup was running smoth, but we noticed that at some point the deployment failed with these error messages:

```
2023-08-24T20:48:56.1057054Z Deployment endpoint responded with status code 202
2023-08-24T20:49:15.6984407Z Configuring default logging for the app, if not already enabled
2023-08-24T20:49:18.8106651Z Zip deployment failed. {'id': 'temp-b574d768', 'status': 3, 'status_text': '', 'author_email': 'N/A', 'author': 'N/A', 'deployer': 'ZipDeploy', 'message': 'Deploying from pushed zip file', 'progress': '', 'received_time': '2023-08-24T20:48:55.8916655Z', 'start_time': '2023-08-24T20:48:55.8916655Z', 'end_time': '2023-08-24T20:49:15.3291017Z', 'last_success_end_time': None, 'complete': True, 'active': False, 'is_temp': True, 'is_readonly': False, 'url': 'https://[...].scm.azurewebsites.net/api/deployments/latest', 'log_url': 'https://[...].scm.azurewebsites.net/api/deployments/latest/log', 'site_name': '[...]', 'provisioningState': 'Failed'}. Please run the command az webapp log deployment show
2023-08-24T20:49:18.8114319Z                            -n [...] -g production
```

or this one (depending on how we invoked the deployment script):

```
Getting scm site credentials for zip deployment
Starting zip deployment. This operation can take a while to complete ...
Deployment endpoint responded with status code 500
An error occured during deployment. Status Code: 500, Details: {"Message":"An error has occurred.","ExceptionMessage":"There is not enough space on the disk.\r\n","ExceptionType":"System.IO.IOException","StackTrace":" 
```

# "There is not enough space on the disk"?

The message `There is not enough space on the disk` was a good hint, but according to the File system storage everything should be fine with only 8% used.

Be aware - this is important: We have multiple apps on the same App Service plan!

![x]({{BASE_PATH}}/assets/md-images/2023-09-05/file-system-storage.png "File System Storage")

# Kudu to the rescure

Next step was to check the behind the scene environment via the "Advanced Tools" Kudu and there it is:

![x]({{BASE_PATH}}/assets/md-images/2023-09-05/kudu.png "Kudu local Storage")

There are two different storages attached to the app service:

- `c:\home` is the "File System Storage" that you can see in the Azure Portal and is quite large. App files are located here.
- `c:\local` is a __much__ smaller storage with ~21GB and if the space is used, then ZipDeploy will fail.

# Who is using this space?

`c:\local` stores "mostly" temporarily items, e.g.:

```
Directory of C:\local

08/31/2023  06:40 AM    <DIR>          .
08/31/2023  06:40 AM    <DIR>          ..
07/13/2023  04:29 PM    <DIR>          AppData
07/13/2023  04:29 PM    <DIR>          ASP Compiled Templates
08/31/2023  06:40 AM    <DIR>          Config
07/13/2023  04:29 PM    <DIR>          DomainValidationTokens
07/13/2023  04:29 PM    <DIR>          DynamicCache
07/13/2023  04:29 PM    <DIR>          FrameworkJit
07/13/2023  04:29 PM    <DIR>          IIS Temporary Compressed Files
07/13/2023  04:29 PM    <DIR>          LocalAppData
07/13/2023  04:29 PM    <DIR>          ProgramData
09/05/2023  08:36 PM    <DIR>          Temp
08/31/2023  06:40 AM    <DIR>          Temporary ASP.NET Files
07/18/2023  04:06 AM    <DIR>          UserProfile
08/19/2023  06:34 AM    <SYMLINKD>     VirtualDirectory0 [\\...\]
               0 File(s)              0 bytes
              15 Dir(s)  13,334,384,640 bytes free
```

The "biggest" item here was in our case under `c:\local\Temp\zipdeploy`:

```
 Directory of C:\local\Temp\zipdeploy

08/29/2023  04:52 AM    <DIR>          .
08/29/2023  04:52 AM    <DIR>          ..
08/29/2023  04:52 AM    <DIR>          extracted
08/29/2023  04:52 AM       774,591,927 jiire5i5.zip
```

This folder stores our `ZipDeploy` package, which is quite large with ~800MB. The folder also contains the extracted files - remember: We only have 21GB on this storage, but even if this zip file and the extracted files are ~3GB, there is still plenty of room, right?

# Shared resources

Well... it turns out, that __each App Service__ on a __App Service plan__ is using this storage and if you have multiple App Services on the same plan, than those 21GB might melt away. 

The "bad" part is, that the space is shared, but each App Services has it's own `c:\local` folder (which makes sense). To free up memory we had to clean up this folder on each App Service like that:

```
rmdir c:\local\Temp\zipdeploy /s /q
```

# TL;DR 

If you have problems with ZipDeploy and the error message tells you, that there is not enough space, check out the `c:\local` space (and of course `c:\home` as well) and delete unused files. Sometimes a reboot might help as well (to clean up temp-files), but AFAIK those ZipDeploy files will survive that.

