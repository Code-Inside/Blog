---
layout: post
title: "Create or update files via the GitHub API"
description: "Let's explore Octokit.NET and changing some files in your GitHub Repo."
date: 2017-01-02 23:45
author: Robert Muehsig
tags: [GitHub, Octokit]
language: en
---
{% include JB/setup %}

This blogpost covers a pretty basic GitHub topic: Creating and updating content on GitHub. Of course, there are many ways to do it - e.g. you could do the full Git-ceremony and it would work with all Git hosts, but in my case I just wanted to target the [__offical GitHub API__](https://developer.github.com/v3/).

## Prerequisite: A GitHub User, Repo and Token

To use this code you will need write access to a GitHub repository and you should have a valid [GitHub token](https://github.com/settings/tokens).

## Code

The most simple way to communicate with the [GitHub API](https://developer.github.com/v3/) is by using the [Octokit SDK](https://www.nuget.org/packages/Octokit/) (from GitHub). 

Description:
Inside the try-block we try to [get the target file](https://developer.github.com/v3/repos/contents/#get-contents), if it is already committed in the repo the API will return the last commit SHA.

With this SHA it is possible to [create a new commit to do the actual update](https://developer.github.com/v3/repos/contents/#update-a-file).

If the file was not found, [we create the file](https://developer.github.com/v3/repos/contents/#create-a-file). I'm not a huge fan of this try/catch block, but didn't found any other way to check if the file is comitted or not (please give me a hint if this is wrong ;))

    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    using Octokit;
    
    namespace CreateOrUpdateGitHubFile
    {
        class Program
        {
            static void Main(string[] args)
            {
                Task.Run(async () =>
                {
                    var ghClient = new GitHubClient(new ProductHeaderValue("Octokit-Test"));
                    ghClient.Credentials = new Credentials("ACCESS-TOKEN");
    
                    // github variables
                    var owner = "OWNER";
                    var repo = "REPO";
                    var branch = "BRANCH";
    
                    var targetFile = "_data/test.txt";
    
                    try
                    {
                        // try to get the file (and with the file the last commit sha)
                        var existingFile = await ghClient.Repository.Content.GetAllContentsByRef(owner, repo, targetFile, branch);
    
                        // update the file
                        var updateChangeSet = await ghClient.Repository.Content.UpdateFile(owner, repo, targetFile,
                           new UpdateFileRequest("API File update", "Hello Universe! " + DateTime.UtcNow, existingFile.First().Sha, branch));
                    }
                    catch (Octokit.NotFoundException)
                    {
                        // if file is not found, create it
                        var createChangeSet = await ghClient.Repository.Content.CreateFile(owner,repo, targetFile, new CreateFileRequest("API File creation", "Hello Universe! " + DateTime.UtcNow, branch));
                    }
    
                    
                    
                }).Wait();
            }
        }
    }


The demo code is also available on [__GitHub__](https://github.com/Code-Inside/Samples/tree/master/2017/CreateOrUpdateGitHubFile).

Hope this helps.