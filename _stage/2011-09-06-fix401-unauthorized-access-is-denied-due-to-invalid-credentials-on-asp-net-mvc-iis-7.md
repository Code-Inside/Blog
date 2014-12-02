---
layout: post
title: "Fix:“401 – Unauthorized: Access is denied due to invalid credentials“ on ASP.NET MVC & IIS 7"
date: 2011-09-06 11:13
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
---
{% include JB/setup %}
<strong> </strong>

There are a lot of different reasons for this error message for example the IIS process has no access for the files or the password of the account where the application runs is wrong. All in all: it is a not very clear defined error message. <a href="http://www.uniquesoftware.de/Blog/de/post/2011/07/22/Access-denied-due-to-invalid-credentials-aber-nur-manchmal.aspx">Martin</a> has already written about a very interesting problem a short time ago (he found the Workaround <a href="http://blog.yeticode.co.uk/2011/03/iis7-iis-express-401-access-is-denied-due-to-invalid-credentials-issue/">here</a>). The symptoms of the error have been this:

- Error message “401 – Unauthorized: Access is denied due to invalid credentials” from a remote machine

- Nothing special in the IIS Logs

- The site was shown correctly by the Remote Desktop localhost

<strong><img style="background-image: none; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb504.png" border="0" alt="image" width="136" height="123" align="left" />What was wrong:</strong> If you turn the IIS Manager (IIS Manager -&gt; Error Pages -&gt; Edit Feature Settings) on Detailed Error the side works from outside as well without any kind of error messages. Mh?!

Beside the website was an ASP.NET MVC side but probably the problem would be the same with a regular ASP.NET. The page we want to see was the login page but that doesn’t work.

<strong>What about the detailed error settings? </strong>

You can change the settings at IIS Manager -&gt; Error Pages and Edit Feature Settings (on the right side). The following is set as Default:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb505.png" border="0" alt="image" width="402" height="344" />

These settings effect that the detail-information’s of an error will be shown to the user if he comes through the localhost. Everyone else will see an unspecific site. At this page you can read <a href="http://learn.iis.net/page.aspx/267/how-to-use-http-detailed-errors-in-iis-70/">more</a> about the process. Most important part:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb506.png" border="0" alt="image" width="544" height="281" />

Now we are going to talk about the symptom: the site was shown correctly by the Remote Desktop localhost

What I recognized much later was that the site was shown correctly on the server but it was redeemed with Http Status 401. The “Response Body” consists of the Login site and because of this I didn’t recognized it before.

Like you can see on the process above: If the errorMode is set on “detailed” the Response Body will be rendered as error message. In my case the response body was the login page.

<strong>Why was the Status Code 401?</strong>

The main problem was: a “RenderAction()” on the Layout/Masterpage which leaned on an action where authentication was necessary. That’s what provoked the 401 error and for result it puts the login page into the body. Beside I do not know why this didn’t end up in a circle because the login site also uses the Layout.

<strong>The solution:</strong>

<strong> </strong>

If you receive this kind of error message you have to check up if there is an RenderAction producing an error if there’s something wrong on your login page.

Other advice: Take a look on the Statuscodes of the site with Firebug or anything else.

This advice was from an answer on <a href="http://serverfault.com/questions/137073/401-unauthorized-on-server-2008-r2-iis-7-5">Stackoverflow</a> asked by a guy with the same problem.
