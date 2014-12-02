---
layout: post
title: "How can I figure out if my ADFS 2.0 works?"
date: 2013-04-29 17:11
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
---
{% include JB/setup %}
&nbsp;

I was working with <a href="http://technet.microsoft.com/en-us/library/adfs2(v=ws.10).aspx">ADFS 2.0 (“Active Directory Federation Services”)</a> for a while when this simple question crossed my mind: How can I figure out if the connection between ADFS and AD “works”? Here is a simple test…

<strong> </strong>

<strong>What is ADFS?</strong>

If you need some “position of trusts” beneath the AD-boarders you choose an Active Directory Service in the world of Microsoft. They are communicating between the dispatcher (own company-AD) and receiver (another AD or a big “center” like for example <a href="http://en.wikipedia.org/wiki/Access_Control_Service">the Windows Azure Access Control Service</a>) and issues claims for the registered user. Maybe this isn’t 100% accurate and maybe my choice of words doesn’t fit 100% but that’s how I understand the system <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="http://code-inside.de/blog-in/wp-content/uploads/wlEmoticon-winkingsmile53.png" alt="Zwinkerndes Smiley" />

<strong> </strong>

<strong>So, how do I test the functionality of the ADFS?</strong>

The ADFS uses the IIS to host his own end points. There is also a simple Login-page that every user can use:

<strong><a href="https://%7badfs-fqdn%7d/adfs/ls/IdpInitiatedSignon.aspx">https://{ADFS-FQDN}/adfs/ls/IdpInitiatedSignon.aspx</a></strong>

Afterwards a simple „Login-Page“ appears – after one click on „login“ you should see something:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb983.png" border="0" alt="image" width="558" height="252" />

If this site appears without username/Password the login works over Kerberos – otherwise you should use NTLM.

If <strong>everything goes wrong</strong> (or the configuration database is “broken”) you will receive an error message like this:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb984.png" border="0" alt="image" width="550" height="225" />

<strong></strong>

<strong>What you can test with it</strong>

With that you just make sure that the configuration/connection between ADFS and your own AD “works” – not more – but it is possible that the problems appear already at this point. If the “opposite site” woks or not is another question.

<strong>I have an ADFS proxy running – what’s next?</strong>

Basically you test the “main” ADFS first and later you have a look from a different machine which is only looking at the Proxy to make sure the Login works. Afterwards it goes on until the “customer”.

In this blogpost you will find a better description (and I think that’s also where I found the advice): <a href="http://www.dagint.com/2011/10/how-to-test-if-adfs-is-functioning/">How to test if ADFS in functioning</a>

<strong>Troubleshooting</strong>

I had some problems with the ADFS which are not totally solved but I still found some links which might be helpful for someone:

<a href="http://social.technet.microsoft.com/wiki/contents/articles/1600.ad-fs-2-0-how-to-change-the-local-authentication-type.aspx">AD FS 2.0: How to Change the Local Authentication Type</a>

<a href="http://social.technet.microsoft.com/wiki/contents/articles/ad-fs-2-0-how-to-configure-the-spn-serviceprincipalname-for-the-service-account.aspx">AD FS 2.0: How to Configure the SPN (servicePrincipalName) for the Service Account</a>
