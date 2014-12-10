---
layout: post
title: "CodePlex is going to be updated"
date: 2012-04-14 09:36
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
&nbsp;

<a href="http://codeplex.com/">CodePlex</a> the Microsoft Open Source Project Hosting Plattform hasn’t changed that much in the last few years and for a few times I thought Microsoft stopped the whole developing process. But now I found out that there is still life in the project. Maybe it is because of the success of <a href="http://github.com/">GitHub</a> or because Microsofts latest intentions in the <a href="http://code-inside.de/blog/2012/03/29/der-asp-net-webstack-ist-open-source/">Open Source Direction</a>. Not so long ago Microsoft has chosen <a href="http://code-inside.de/blog/2011/12/12/windows-azure-sdk-fr-node-js-co-und-das-auf-github/">GitHub instead of CodePlex for publishing Azure SDK –</a> maybe that was the point where they decided to support their own platform again.

<strong>“The future of Codeplex is Bright”</strong>

Brian Harry who is Microsofts responsible person for the team Foundation Server and especially TFS Service on Azure posted a <a href="http://blogs.msdn.com/b/bharry/archive/2012/03/22/the-future-of-codeplex-is-bright.aspx">Blogpost with this headline</a>. Also in the Open Source <a href="http://www.hanselman.com/blog/ASPNETMVC4ASPNETWebAPIAndASPNETWebPagesV2RazorNowAllOpenSourceWithContributions.aspx">Announcement from Scott Hanselman</a> it was mentioned why the ASP.NET team decided to use CodePlex instead of GitHub:

Why not on GitHub?

The Visual Studio Team has <a href="http://blogs.msdn.com/b/bharry/archive/2012/03/22/the-future-of-codeplex-is-bright.aspx">big plans for CodePlex</a>, including adding Git support and modernizing the experience. Right now CodePlex supports TFS, Mercurial (Hg) and just added Git! As we’re a partner with the Visual Studio Team we think the right thing for us to do is to support their plans to make CodePlex a thriving place for open source software again. We push them hard and they’re releasing weekly now.

<strong>Git Support on CodePlex</strong>

CodePlex supports beside TFS and Mercurial <a href="http://blogs.msdn.com/b/codeplex/archive/2012/03/21/git-commit-m-codeplex-now-supports-git.aspx">also Git</a>. Though the integration into the Web-UI isn’t that extensive compared to GitHub but for what I have seen so far and from personal talks with Microsoft Corp. Developers I found out that Git isn’t a foreign word for them. For example the ASP.NET Team is using <a href="http://aspnetwebstack.codeplex.com/SourceControl/list/changesets">GitHub for developing ASP.NET Webstack</a> on Codeplex. I’m sure there will be some more futures soon.

<strong>TFS &amp; Git</strong>

<strong> </strong>

Of course this development is recognized by the TFS team as well – there are also some appearances for a <a href="http://en.wikipedia.org/wiki/Distributed_revision_control">DVSC</a>. There is also a comment by Brian Harry about the <a href="http://blogs.msdn.com/b/bharry/archive/2011/08/02/version-control-model-enhancements-in-tfs-11.aspx">Version Control Model</a> Enhancements in TFS1 1 about the DVCS Model:

I’m certain that about this time, I bunch of people are asking “but, did you implement DVCS”.  The answer is no, not yet.  You still can’t checkin while you are offline.  And you can’t do history or branch merges, etc.  Certain operations do still require you to be online.  You won’t get big long hangs – but rather nice error messages that tell you you need to be online.  DVCS is definitely in our future and this is a step in that direction but there’s another step yet to take.

<strong>New UI in the Look of Metro </strong>

<strong> </strong>

There are also some new Screenshots about <a href="http://blogs.msdn.com/b/codeplex/archive/2012/03/30/new-codeplex-ui-coming-soon.aspx">the Metro interface for CodePlex</a> shown:

<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb658.png" border="0" alt="image" width="493" height="375" /><a href="{{BASE_PATH}}/assets/wp-images-en/image1486.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image1486" src="{{BASE_PATH}}/assets/wp-images-en/image1486_thumb.png" border="0" alt="image1486" width="497" height="383" /></a>

<img title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb659.png" border="0" alt="image" width="493" height="380" />

More Screenshots <a href="http://blogs.msdn.com/b/codeplex/archive/2012/03/30/new-codeplex-ui-coming-soon.aspx">here</a>.

<strong>TFS Services &amp; CodePlex</strong>

<strong> </strong>

If you ask yourself how CodePlex and the announcement about TFS on Azure fits together: here is another <a href="http://blogs.msdn.com/b/bharry/archive/2012/03/22/the-future-of-codeplex-is-bright.aspx">comment from Brian Harry</a>:

And, as I alluded to earlier, we’ll be working to align CodePlex and Team Foundation Service into a single, scalable offering.  This work will be happening partially in parallel with the efforts to revitalize CodePlex and respond to community feedback.  It will also happen in stages rather than in one big milestone.  It will likely start by having newly created CodePlex projects hosted on the Team Foundation Service Azure infrastructure.  Then, over time, we’ll integrate the user experiences.  This isn’t a concrete plan, but rather a flavor of how we are thinking about it.alluded to earlier, we’ll be working to align CodePlex and Team Foundation Service into a single, scalable offering.  This work will be happening partially in parallel with the efforts to revitalize CodePlex and respond to community feedback.  It will also happen in stages rather than in one big milestone.  It will likely start by having newly created CodePlex projects hosted on the Team Foundation Service Azure infrastructure.  Then, over time, we’ll integrate the user experiences.  This isn’t a concrete plan, but rather a flavor of how we are thinking about it.

<strong>My commendation: Take a look on Git!</strong>

<strong> </strong>

From my point and according to the changes of the last view days I recommend every developer to take a look on Git or at least to think about the opportunities. Start a little Open Source Project – maybe on CodePlex and then give them your <a href="http://codeplex.codeplex.com/workitem/list/basic">Feedback</a>. Git is also interesting for .NET developer – <a href="http://code-inside.de/blog/2011/08/05/einstieg-in-git-fr-net-entwickler/">a little intro is here</a>. Maybe there will be a bigger Open Source mentality in the .NET environment. <img class="wlEmoticon wlEmoticon-smile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-smile14.png" alt="Smiley" />
