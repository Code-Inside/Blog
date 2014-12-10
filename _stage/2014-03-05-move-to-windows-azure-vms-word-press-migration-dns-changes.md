---
layout: post
title: "Move to Windows Azure – VMs, Word Press Migration, DNS changes"
date: 2014-03-05 01:37
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
Since mid January this blogs runs on a WordPress installation in an Azure VM. Because I always thought that the subject is quite complicated this blogpost offers a view behind the scenes.
<h3>Why this move?</h3>
So far this blog (both German and English Version) runs on a hoster somewhere in Germany. The main problem with this hoster was that they didn’t offer Windows Server 2012 R2 and that the contract is only annullable once a year. The annual termination was my mistake when we’ve first signed the contract. There was a monthly alternative but somehow I didn’t choose it. But anyway I wasn’t happy anymore since the communication only works via E-Mail or worse via Fax. Another reason for Azure: I own a MSDN Ultimate Licence including 150€ deposit at the moment. I’m sure I can work with that.
<h3>Windows Azure – a VM for Blogs</h3>
The migration to Azure had to be very fast and since I worked on the WordPress installation a lot over the past years I wasn’t so sure if the blog will run on Azure websites. Also there was this problem with the databases: the two MySQL databases are not really “small” and therefore I would have to pay more for the MySQL hoster as for the pure VM. That’s why I choose an Azure VM. Otherwise I would always recommend an Azure Website. <i>There is a <a href="http://wordpress.brandoo.pl/">WordPress alternative that runs with SQL azure</a> but I didn’t have a closer look on it.
</i> The creation of the VM was really simple and it only took me some minutes:
<img style="background-image: none; padding-top: 0px; padding-left: 0px; padding-right: 0px; border: 0px;" title="image" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1112.png" width="576" height="272" border="0" />
<h3>WordPress installation with the web platform installer</h3>
Like I mentioned before the blog runs on WordPress and I didn’t had any problems with IIS/Windows/PHP/MySQL (besides some WP Plugins don’t get along with windows).
The installation is easily done with the <a href="http://www.microsoft.com/web/downloads/platform.aspx">Web Platform installer</a>:

<img style="background-image: none; padding-top: 0px; padding-left: 0px; padding-right: 0px; border: 0px;" title="image" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1113.png" width="573" height="397" border="0" />
<h3>Data migration: wp-uploads / database</h3>
After the “pure” installation I’ve fetched my data from the old installation including the “wp-uploads” directory and the theme. My MySQL database was generated with a <a href="http://{{BASE_PATH}}/2011/06/12/mysql-datenbanken-sichern-ber-powershell/">Powershell Script</a> (I use this one as well for the Backup of the MySQL DBs). I’ve integrated the script later via the <a href="http://www.heidisql.com/">HeidiSQL</a> on the Azure VM. Just put the information in the suiting wp-config.php and it runs.
<h3>DNS migration: code-inside.de/blog on blog.condeinside.eu</h3>
With this migration I’ve tried to address the whole domain subject. Until now this blog used to run on “code-inside.de/blog”. For a while I’ve planned to go away from the “Subdirectory” and to an own “Subdomain”. I’ve already <a href="{{BASE_PATH}}/2013/04/16/subdomain-vs-subdirectory/">blogged about this here</a>. The aim was: Change to subdomains and to the new domain “codeinside.eu” (supporting the European spirit <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile55.png" />) The <a href="http://www.code-inside.de">www.code-inside.de</a> just links to the public IP of the Azure VM. “Blog.codeinside.eu”, “blogin.codeinside.eu”, “cdn.codeinside.eu” links via CName to codeinside.cloudapp.net – which in fact links to the Azure VM as well.

<span style="font-size: large;"><strong>The IIS includes the following structure:</strong></span>

<img style="background-image: none; padding-top: 0px; padding-left: 0px; margin: 0px 15px 15px 0px; padding-right: 0px; border: 0px;" title="image" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1114.png" width="175" height="153" align="left" border="0" />

- ci-blog answers the hostname “blog.codeinside.eu”
- ci-blogin answers the hostname “blogin.codeinside.eu”
- ci-cdn answers the hostname “cdn.codeinside.eu”
- redirects is my “catchall” application
<h3></h3>
<h3></h3>
<h3>The main redirect – operated via web.config</h3>
The aim of the redirection was to keep all the links alive:
<ul>
	<li>code-inside.de/blog has to link to blog.codeinside.eu</li>
	<li>code-inside.de/blog-in has to link to blogin.codeinside.eu</li>
	<li>code-inside.de/files has to link to cdn.codeinside.eu</li>
	<li>everything else has to link to the new main page “www.codeinside.eu”</li>
</ul>
The “redirects” App in IIS includes nothing but a web.config with the following content:
<pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;configuration&gt;
    &lt;system.webServer&gt;
        &lt;rewrite&gt;
            &lt;rules&gt;
                &lt;clear /&gt;
                &lt;rule name="code-inside.de blog-in" stopProcessing="true"&gt;
                    &lt;match url="blog\-in(.*)" /&gt;
                    &lt;conditions logicalGrouping="MatchAll" trackAllCaptures="false"&gt;
                        &lt;add input="{HTTP_HOST}" pattern="code-inside.de" /&gt;
                    &lt;/conditions&gt;
                    &lt;action type="Redirect" url="http://blogin.codeinside.eu{R:1}" redirectType="Permanent" /&gt;
                &lt;/rule&gt;
                &lt;rule name="code-inside.de blog" stopProcessing="true"&gt;
                    &lt;match url="blog(.*)" /&gt;
                    &lt;conditions logicalGrouping="MatchAll" trackAllCaptures="false"&gt;
                        &lt;add input="{HTTP_HOST}" pattern="code-inside.de" /&gt;
                    &lt;/conditions&gt;
                    &lt;action type="Redirect" url="http://blog.codeinside.eu{R:1}" redirectType="Permanent" /&gt;
                &lt;/rule&gt;
                &lt;rule name="code-inside.de files" stopProcessing="true"&gt;
                    &lt;match url="files(.*)" /&gt;
                    &lt;conditions logicalGrouping="MatchAll" trackAllCaptures="false"&gt;
                        &lt;add input="{HTTP_HOST}" pattern="code-inside.de" /&gt;
                    &lt;/conditions&gt;
                    &lt;action type="Redirect" url="http://cdn.codeinside.eu/files{R:1}" redirectType="Permanent" /&gt;
                &lt;/rule&gt;
                &lt;rule name="catch all" stopProcessing="true"&gt;
                    &lt;conditions logicalGrouping="MatchAll" trackAllCaptures="false" /&gt;
                    &lt;action type="Redirect" url="http://www.codeinside.eu" /&gt;
                &lt;/rule&gt;
            &lt;/rules&gt;
        &lt;/rewrite&gt;
    &lt;/system.webServer&gt;
&lt;/configuration&gt;</pre>
WordPress saves the “public” URL on different places – therefore I was forced to use HeidiSQL for some tasks (because I was constantly redirected to the old Admin Dashboard <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile55.png" />) or change the values in the configuration.
<h3>Adjust Feedburner configurations</h3>
The RSS Feed of this blog is still provided by Feedburner. With the DNS configurations I had to change these values as well.
<h3>Misson completed</h3>
So far I’m pretty happy with the results. If you recognize an error or if something isn’t working as good as it has worked in the old version please feel free to contact us in the comments below or on E-Mail/Twitter or anywhere else. An improvement from the traditional hoster is the dashboard:

<img style="background-image: none; padding-top: 0px; padding-left: 0px; padding-right: 0px; border: 0px;" title="image" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1115.png" width="578" height="206" border="0" />

Both blogs are currently running on a small (1 core, 1.75 GB memory) VM (two VMs would be too difficult because of the MySQL installation) and so far it looks really nice. I’m planning on giving you an update after a month to show you the costs of azure with this constellation and with the traffic on the blog. Questions? Go for it <img class="wlEmoticon wlEmoticon-smile" style="border-style: none;" alt="Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-smile17.png" />
