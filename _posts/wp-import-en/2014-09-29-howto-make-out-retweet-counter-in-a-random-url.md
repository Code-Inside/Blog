---
layout: post
title: "HowTo: make out Retweet-counter in a random URL"
date: 2014-09-29 21:17
author: CI Team
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
<p>&nbsp; <p>Twitter offers some interesting functions with the integration of the twitter button – every user can see how often the website has been retweeted and he can do the same with just one click. But of course the whole thing has his price: <p>- The integration of the Twitter JavaScript makes the whole data protection process difficult
<p>- You’ll need the Twitter JavaScript <p>- “background” processes are not able to access the “Tweet” numbers
<p><b></b>&nbsp; <p><b>Twitters rocky way across the official API</b> <p>It seems like a frequently asked question in the Twitter development board: How can I access the information in the Twitter button? Officially Twitter appreciates the usage of the streaming API. Here is an <a href="https://dev.twitter.com/discussions/5653">example</a>. But this API is only accessible with an authenticated Dev-Account. If you own many sites the numerous restrictions of Twitter might be a problem for you.
<p><b></b> <p><b></b>&nbsp; <p><b>The easy way using http://urls.api.twitter.com/1/urls/count.json?url=…</b> <p>Well it is not difficult to make out where the magic button gets his information’s from. Even if Twitter <a href="https://dev.twitter.com/discussions/5839">never tires to point out that this is not an official API</a> the usage is quite easy: <p>GET Request: <a href="http://urls.api.twitter.com/1/urls/count.json?url=http://{{BASE_PATH}}/2014/04/15/source-code-verffentlichen-aber-bitte-mit-lizenz/">http://urls.api.twitter.com/1/urls/count.json?url=http://{{BASE_PATH}}/2014/04/15/source-code-verffentlichen-aber-bitte-mit-lizenz/</a> <p>Result:</p> <div id="scid:9D7513F9-C04C-4721-824A-2B34F0212519:71b3a40b-e215-4f0c-8826-bbecfe5eaedf" class="wlWriterEditableSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre style=" width: 855px; height: 53px;background-color:White;overflow: auto;"><div><!--

Code highlighting produced by Actipro CodeHighlighter (freeware)
http://www.CodeHighlighter.com/

--><span style="color: #000000;">{</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">count</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">:</span><span style="color: #800080;">7</span><span style="color: #000000;">,</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">url</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">:</span><span style="color: #800000;">&quot;</span><span style="color: #800000;">http:\/\/blog.codeinside.eu\/2014\/04\/15\/source-code-verffentlichen-aber-bitte-mit-lizenz\/</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">}</span></div></pre><!-- Code inserted with Steve Dunn's Windows Live Writer Code Formatter Plugin.  http://dunnhq.com --></div>
<p>&nbsp; <p>Via Code:</p>
<div id="scid:9D7513F9-C04C-4721-824A-2B34F0212519:388cfaae-0894-46de-834c-066b436e3397" class="wlWriterEditableSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre style=" width: 867px; height: 222px;background-color:White;overflow: auto;"><div><!--

Code highlighting produced by Actipro CodeHighlighter (freeware)
http://www.CodeHighlighter.com/

--><span style="color: #0000FF;">class</span><span style="color: #000000;"> Program
   </span><span style="color: #800080;">2</span><span style="color: #000000;">:     {
   </span><span style="color: #800080;">3</span><span style="color: #000000;">:         </span><span style="color: #0000FF;">static</span><span style="color: #000000;"> </span><span style="color: #0000FF;">void</span><span style="color: #000000;"> Main(</span><span style="color: #0000FF;">string</span><span style="color: #000000;">[] args)
   </span><span style="color: #800080;">4</span><span style="color: #000000;">:         {
   </span><span style="color: #800080;">5</span><span style="color: #000000;">:             </span><span style="color: #0000FF;">string</span><span style="color: #000000;"> url </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #800000;">&quot;</span><span style="color: #800000;">http://urls.api.twitter.com/1/urls/count.json?url=http://{{BASE_PATH}}/2014/04/26/fix-excel-com-exception-code-2147467259-exception-from-hresult-0x80028018/#comments</span><span style="color: #800000;">&quot;</span><span style="color: #000000;">;
   </span><span style="color: #800080;">6</span><span style="color: #000000;">:  
   </span><span style="color: #800080;">7</span><span style="color: #000000;">:             </span><span style="color: #008000;">//</span><span style="color: #008000;"> Be carefull with this code - use async/await - </span><span style="color: #008000;">
</span><span style="color: #000000;">   </span><span style="color: #800080;">8</span><span style="color: #000000;">:             </span><span style="color: #008000;">//</span><span style="color: #008000;"> pure demo code inside a console application</span><span style="color: #008000;">
</span><span style="color: #000000;">   </span><span style="color: #800080;">9</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">10</span><span style="color: #000000;">:             var client </span><span style="color: #000000;">=</span><span style="color: #000000;"> </span><span style="color: #0000FF;">new</span><span style="color: #000000;"> HttpClient();
  </span><span style="color: #800080;">11</span><span style="color: #000000;">:             var result </span><span style="color: #000000;">=</span><span style="color: #000000;"> client.GetAsync(url).Result;
  </span><span style="color: #800080;">12</span><span style="color: #000000;">:  
  </span><span style="color: #800080;">13</span><span style="color: #000000;">:             Console.WriteLine(result.Content.ReadAsStringAsync().Result);
  </span><span style="color: #800080;">14</span><span style="color: #000000;">:             Console.ReadLine();
  </span><span style="color: #800080;">15</span><span style="color: #000000;">:         }
  </span><span style="color: #800080;">16</span><span style="color: #000000;">:     }</span></div></pre><!-- Code inserted with Steve Dunn's Windows Live Writer Code Formatter Plugin.  http://dunnhq.com --></div>
<p>&nbsp; <p>The code is also available on <a href="https://github.com/Code-Inside/Samples/tree/master/2014/RetweetCounter">GitHub</a>.
<p>P.S.: Golem is using a similar code. It seems like it is working for big projects as well.
