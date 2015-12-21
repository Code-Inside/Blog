---
layout: post
title: "“Http 400 Bad Request” beim Speichern in den Azure Blob Storage?"
date: 2012-10-08 23:51
author: Robert Muehsig
comments: true
categories: [Fix]
tags: [Azure, Blob, Fix]
language: de
---
{% include JB/setup %}
<p>Wer eine Exception “The remote server returned an error: (400) Bad Request.” beim Erstellen eines Blob Containers auf Azure bekommt, der wird höchst wahrscheinlich die <a href="http://msdn.microsoft.com/en-us/library/dd135715.aspx"><strong>Namenskonvention</strong></a> verletzen:</p> <p><em>A container name must be a valid DNS name, conforming to the following naming rules:</em>  <ol> <li><em>Container names must start with a letter or number, and can contain only letters, numbers, and the dash (-) character.</em>  <li><em>Every dash (-) character must be immediately preceded and followed by a letter or number; consecutive dashes are not permitted in container names.</em>  <li><em>All letters in a container name must be lowercase.</em>  <li><em>Container names must be from 3 through 63 characters long.</em></li></ol> <p><em></em>&nbsp;</p> <p>Kleiner Fehler, welcher einen doch leicht verunsichern kann ;)</p> <p>Einen sehr guten Guide zum Umgang mit dem BlobStorage findet man zudem <a href="https://www.windowsazure.com/en-us/develop/net/how-to-guides/blob-storage/">hier</a> mit gutem Beispielcode. Hier z.B. wie man eine Datei in den Blob Storage hochlädt:</p><pre>// Retrieve storage account from connection string
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
<p>Die obrige Exception würde bei der Zeile “container.CreateIfNotExist()” auftreten, wenn der Containername groß geschrieben wäre. Natürlich kam der entsprechende Tipp von <a href="http://stackoverflow.com/questions/2620521/blob-container-creation-exception">Stackoverflow</a>.</p>
