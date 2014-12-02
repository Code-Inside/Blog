---
layout: post
title: "„Http 400 Bad Request“ while saving into the Azure Blob Storage?"
date: 2012-10-25 10:23
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
---
{% include JB/setup %}
&nbsp;

If you receive the exception “the remote server returned an error: (400) Bad Request” while creating a Blob container with Azure you are most likely violate the <a href="http://msdn.microsoft.com/en-us/library/dd135715.aspx">name conventions</a>:

<em>A container name must be a valid DNS name, conforming to the following naming rules:</em>

1. <em>Container names must start with a letter or number, and can contain only letters, numbers, and the dash (-) character.</em>

2. <em>Every dash (-) character must be immediately preceded and followed by a letter or number; consecutive dashes are not permitted in container names.</em>

3. <em>All letters in a container name must be lowercase.</em>

4. <em>Container names must be from 3 through 63 characters long.</em>

Small error but it still has the potential to make me confused <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="http://code-inside.de/blog-in/wp-content/uploads/wlEmoticon-winkingsmile45.png" alt="Zwinkerndes Smiley" />

There is already a good guide about how to deal with the BlobStorage here with nice example code. For example how to upload a file into the Blob storage:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:35224f5e-9316-494f-acf3-822f73d2b928" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">// Retrieve storage account from connection string
CloudStorageAccount storageAccount = CloudStorageAccount.Parse(
    CloudConfigurationManager.GetSetting("StorageConnectionString"));

// Create the blob client
CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();

// Retrieve reference to a previously created container
CloudBlobContainer container = blobClient.GetContainerReference("mycontainer");

// Retrieve reference to a blob named "myblob"
CloudBlob blob = container.GetBlobReference("myblob");

// Create the container if it doesn't already exist
container.CreateIfNotExist();

// Create or overwrite the "myblob" blob with contents from a local file
using (var fileStream = System.IO.File.OpenRead(@"path\myfile"))
{
    blob.UploadFromStream(fileStream);
}</pre>
</div>
&nbsp;

The exception will appear on the line “container.CreatelNotExist()” if you wrote the container name in capital letters. Of course the hint was from <a href="http://stackoverflow.com/questions/2620521/blob-container-creation-exception">Stackoverflow</a>.
