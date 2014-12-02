---
layout: post
title: "How to access an Azure Website with the local IIS Manager"
date: 2014-04-21 14:35
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
---
{% include JB/setup %}
<p><a href="http://blogs.msdn.com/b/windowsazure/archive/2014/02/28/remote-administration-of-windows-azure-websites-using-iis-manager.aspx">Since the end of February</a> it is possible to access an Azure Website with the IIS Manager. Although the Azure Management site offers some information there are more details visible at the IIS Manager.</p> 
<p>For the connection you will need an IIS Manager and the <a href="http://www.iis.net/downloads/microsoft/iis-manager">IIS Manager for Remote Administration Extension</a>. It’s also possible to connect with a free Azure website – it seems like there are no access restrictions.</p>
<p><b>The URL “myname.SCM.azurewebsites.net:443”</b></p> 
<p>After the installation of the Remote Administration Tool has been finished it is possible to add extra sites with the IIS Manager (via the context menu or file) and connect yourself to your site.</p> 
<p><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image" src="http://blog.codeinside.eu/wp-content/uploads/image_thumb1133.png" width="240" height="184"> </p>
<p>The URL is built after this scheme: <br>myazurewebsitename.SCM.azurewebites.net </p>
<p>If you named your website “HelloWorld” for example (HelloWorld.azurewebsites.net) you will find the administration site on Helloworld.SCM.azurewebsites.net:</p>
<p><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image" src="http://blog.codeinside.eu/wp-content/uploads/image_thumb1134.png" width="570" height="430"></p>
<p>In the next step you have to state the deployment credentials of the publication profile. If you didn’t change them you can also download them: </p>
<p><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image" src="http://blog.codeinside.eu/wp-content/uploads/image_thumb1135.png" width="570" height="297" /></p>
<p>The information is visible in the profile: </p>
<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image" src="http://blog.codeinside.eu/wp-content/uploads/image_thumb1136.png" width="570" height="195"/>
<p>That’s where you have to insert the information: </p>
<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image" src="http://blog.codeinside.eu/wp-content/uploads/image_thumb1137.png" width="570" height="430">
<p>And now we are connected:</p> 
<p><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image" src="http://blog.codeinside.eu/wp-content/uploads/image_thumb1138.png" width="570" height="306"></p> 
<p>Here you are able to have a look at several settings including some that are also accessible through the Azure Management Site: </p>
<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; padding-right: 0px" border="0" alt="image" src="http://blog.codeinside.eu/wp-content/uploads/image_thumb1139.png" width="240" height="156" />
<p>I wasn’t able to find out if (or when) it is possible to change the settings – I think it should be possible but there was no got example available. </p>
<a href="http://blogs.msdn.com/b/windowsazure/archive/2014/02/28/remote-administration-of-windows-azure-websites-using-iis-manager.aspx"><strong>More information’s are available on the Azure Blog.</strong></a>
