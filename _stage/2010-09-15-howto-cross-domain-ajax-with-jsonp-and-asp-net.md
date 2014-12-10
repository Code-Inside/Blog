---
layout: post
title: "HowTo: Cross Domain Ajax with JSONP and ASP.NET"
date: 2010-09-15 20:30
author: oliver.guhr
comments: true
categories: [HowTo]
tags: []
language: en
---
{% include JB/setup %}
<a href="{{BASE_PATH}}/assets/wp-images-de/image_thumb66.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; margin-left: 0px; border-left-width: 0px; margin-right: 0px" title="ajax" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb66.png" border="0" alt="ajax" hspace="12" width="147" height="154" align="left" /></a>

Actually it isn´t possible to send Ajax Requests to addresses which are reachable at the same domain like the site where the script is executed.The reason for this is the <a href="http://de.wikipedia.org/wiki/Same_Origin_Policy" target="_blank">Same Origin Policy</a> in JavaScript. There it is given, that the port, the protocol and the domain have to be equal to start requests. This is save but unfortunately not practical.

<!--more-->

<strong>But there is a Trick. Right?</strong>

Yes! There are a lot of different possibilities to avoid the problem. Enter "Cross Domain Ajax" into the searching engine and you will have a wide pool of solutions. I almost spend half a day to take a look on all the different websites. For example it is possible to use a Proxy or Flash/Silverlight and so on. For me the best solution was JSONP.
<h4></h4>
<h4><strong>What´s JSOPN? </strong></h4>
<p align="left"><a href="http://en.wikipedia.org/wiki/JSON#JSONP" target="_blank">JSOPN is the short form ofÂ  "žJSON with padding".</a></p>

The Idea behind it is as simple as clever. It works by using a security hole of the implementation of the Same Origin Policy of the Browser. It isn´t possible to start requests to other domains but you are allowed to include JavaScript Files from other Domains and while doing this you can easily import your own files. The disadvantage is that it is only possible to send data via GET and not via POST. Who plans to send more data, has to use another trick otherwise you need to compress your data. JQuery makes the implementation at this point easy as usual and help us with the adequate methods:
<h3>And this is how it looks like:</h3>
<h6></h6>
<h6><em>At the Client:</em></h6>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c9755566-ec79-4566-a686-fcbaca4a0466" class="wlWriterSmartContent" style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px">
<div class="dp-highlighter">
<div class="bar">
<div class="tools"><a onclick="dp.sh.Toolbar.Command('ViewSource',this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command('CopyToClipboard',this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command('PrintSource',this);return false;" href="about:blank#">print</a></div>
</div>
<ol class="dp-c">
	<li class="alt"><span><span>$.ajax({ </span></span></li>
	<li><span> dataType: </span><span class="string">'jsonp'</span><span>, </span></li>
	<li class="alt"><span> jsonp: </span><span class="string">'jsonp_callback'</span><span>, </span></li>
	<li><span> url: </span><span class="string">'http://localhost:56761/TestService.ashx'</span><span>, </span></li>
	<li class="alt"><span> success: </span><span class="keyword">function</span><span> (j) { </span></li>
	<li><span> alert(j.response); </span></li>
	<li class="alt"><span> }, </span></li>
	<li><span> }); </span></li>
</ol>
</div>
<pre class="js" style="display: none">      $.ajax({
                dataType: 'jsonp',
                jsonp: 'jsonp_callback',
                url: 'http://localhost:56761/TestService.ashx',
                success: function (j) {
                    alert(j.response);
                },
            });</pre>
</div>
The only difference to the usual jQuery Request is the line: "žjsonp: "˜jsonp_callback´". This line includes the GET name of the parameter where jQuery transmit the name of the Callback function to the server.

jQuery works like this:
<ol>
	<li>A &lt;script&gt; tag is created which points to the chosen address. In the process a random number is transmitted as a parameter (that´s the name of the calback function).</li>
	<li>The server produces a JavaScript file for response, which opens a function with the random number and pass it as a JSON file.</li>
	<li>The browser integrates the script and accomplishes the whole thing. jQuery now submits us the file to the "success" Event.</li>
</ol>
<h6><em>And at the Server:</em></h6>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:35344d39-ea21-4560-8561-838b22133041" class="wlWriterSmartContent" style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px">
<div class="dp-highlighter">
<div class="bar">
<div class="tools"><a onclick="dp.sh.Toolbar.Command('ViewSource',this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command('CopyToClipboard',this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command('PrintSource',this);return false;" href="about:blank#">print</a></div>
</div>
<ol class="dp-c">
	<li class="alt"><span><span class="keyword">string</span><span> response = context.Request.Params[</span><span class="string">"jsonp_callback"</span><span>]; </span></span></li>
	<li><span> response += </span><span class="string">"({\"response\":\""</span><span> + context.Session[</span><span class="string">"RequestCounter"</span><span>]Â  + </span><span class="string">" requests startet\"});"</span><span>; </span></li>
	<li class="alt"><span>context.Response.Write(response); </span></li>
</ol>
</div>
<pre class="c#" style="display: none">string response = context.Request.Params["jsonp_callback"];
       response += "({\"response\":\"" + context.Session["RequestCounter"]  + " requests startet\"});";
context.Response.Write(response);</pre>
</div>
<a href="{{BASE_PATH}}/assets/wp-images-de/image_thumb67.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; margin-left: 0px; border-left-width: 0px; margin-right: 0px" title="clip_image002" src="file:///Z:/Users/Oliver%20Guhr/AppData/Local/Temp/WindowsLiveWriter783867672/supfiles2E0B85/clip_image002_thumb2.jpg" border="0" alt="{{BASE_PATH}}/assets/wp-images-de/image_thumb67.png" hspace="12" width="223" height="317" align="left" /></a>

For this example I used a Generic Handler (.ashx). But you could also use a WCF service. The example consists of two projects. A clientproject "CrossDomainAjax" and a serviceproject "SourceDomain". To start the demo press with the right mousebutton on the name of the <strong>Project -&gt; debug -&gt; Start new instance</strong>

Both projects should be started now. After this you should see a javascipt alert with an "1" in your browser window. With this example I also tried to find out if it´s possible to access the session of the server, and it works. After every rebuild of the page the value increase by one.

I know it´s not a really exiting example but I hope you are able to forgive me about this.

<a href="http://code-inside.de/files/democode/crossdomainajax/CrossDomainAjax.zip" target="_blank">Here you can find the demo code.</a> Have Fun :)
