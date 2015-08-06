---
layout: post
title: "HowTo: Write to Azure Blob Storage"
description: "How to save a simple text file in Azure Blob Storage. As you might already know: It's easy."
date: 2015-08-06 21:15
author: robert.muehsig
tags: [Azure]
language: en
---
{% include JB/setup %}

Sometimes I just want to write blogposts to memorize it better even if the stuff is actually quiet old. So... and now I present you:

## How To write a simple text to Azure Storage

All you need is the __[Microsoft.WindowsAzure.Storage](https://www.nuget.org/packages/WindowsAzure.Storage/)__ NuGet Package (well... there is also a [REST API available](https://msdn.microsoft.com/en-us/library/azure/dd179355.aspx), but in the .NET land, this is much easier).

    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(ConfigurationManager.ConnectionStrings["storage"].ConnectionString);

    // Create the blob client.
    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();

    // Retrieve a reference to a container.
    CloudBlobContainer container = blobClient.GetContainerReference("mycontainer");

    // Create the container if it doesn't already exist.
    container.CreateIfNotExists();

	// Make it public - because sharing is good, right?
    container.SetPermissions(
        new BlobContainerPermissions
        {
            PublicAccess =
        BlobContainerPublicAccessType.Blob
    });

    CloudBlockBlob blockBlob = container.GetBlockBlobReference("myblob");

    var foobar = "helloworld";

    blockBlob.UploadText(foobar);
	
Besides "UploadText" there a bunch of other methods available to save a stream or bytes etc..

The "CloudStorageAccount.Parse" needs a well formed [WindowsAzure Storage ConnectionString](https://www.connectionstrings.com/windows-azure/).

That's all. If you want to learn more: [Azure Documentation](https://azure.microsoft.com/en-us/documentation/articles/storage-dotnet-how-to-use-blobs/)

Hope this helps!
