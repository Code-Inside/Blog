---
layout: post
title: ".LESS – dynamic stylesheets for .NET Developer"
date: 2011-07-31 12:59
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
<p>.LESS was born in the world of Ruby and it helps to clear some failures of CSS. .LESS is similar with the original CSS Syntax but it has some nice additional functions like for example Variables (so you don’t have to write some values double or functions to, for example, add two distances. A complete overview with all the opportunities you will find <a href="http://lesscss.org/">here</a>. Let’s take a look on the Syntax:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:897b4afc-9b6c-477b-98ec-52c6dba5e88a" class="wlWriterEditableSmartContent"><pre name="code" class="c#">@color: #4D926F;

#header {
  color: @color;
}
h2 {
  color: @color;
}</pre></div>

<p>Of course the browsers only understand the usual CSS Syntax so .LESS needs to translate the Stylesheet. For this we have several solutions. </p>

<p><b>Transformation with Javascript</b></p>

<p><b></b></p>

<p>On <a href="http://lesscss.org">http://lesscss.org</a> you will find a Javascript-File which is able to do the transformation on the client in the browser. All you have to do is to reference the Javascript File and that’s it. Read more about this process <a href="http://lesscss.org/#-client-side-usage">here</a>.</p>

<p><b>Transformation during the Developing time into normal CSS</b></p>

<p><b></b></p>

<p>The steadiest solution to transform .LESS Style into usual CSS is to do the transformation before the Deployment or while developing. The advantage of this method is that a complete CSS will be created and you can continue processing it with the ordinary CSS - Toolstack. But it will be a disadvantage if you try to change it back into the .LESS form afterwards. It’s not impossible but it’s not really charming <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile21.png" /></p>

<p>For .NET developer I recommend the <a href="http://www.dotlesscss.org/">dotless Project</a>. The dotless Project is a porting of the original Ruby Project on .NET. In the <a href="https://github.com/dotless/dotless/downloads">Downloads</a> there is also a “Compiler” integrated which you can call on the CMD. But there is a “Watcher” too so it’s not possible to start the Compile Process manual. More about this you can read on <a href="https://github.com/dotless/dotless/wiki">Wiki</a>. </p>

<p><b>Transformation during the running time – with dotless</b></p>

<p>With this method the transformation will start while it’s running – you don’t have to create a CSS File by yourself. There are different ways but it’s always the dotless Project. </p>

<p>First we need to link the dotless into our webproject (for example on NuGet)</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb469.png" width="543" height="202" /></p>

<p>On this library we are able to start the transformation from the code. How this could look like you will see if you read this nice description (even if it’s a little bit old) Dynamic <a href="http://schotime.net/blog/index.php/2010/07/02/dynamic-dot-less-css-with-asp-net-mvc-2/">Dot Less CSS With Asp.net MVC 2</a>. </p>

<p><b>Transformation during the running time – with dotless and Combres</b></p>

<p>Combres is a nice library to send static Content (like JS or CSS files) to the client on a “better” way. Combres offers help with dotLess innately. Combres (including the MVC helper) is also a NuGet Package:</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb470.png" width="342" height="203" /></p>

<p>The usage of Combres after the installation is simple (and well described on the ReadMe Files). Combres is able to “manipulate” files before they will be delivered. Also integrated is a filter for DotLess (a view into the code you will find <a href="http://www.codeproject.com/KB/aspnet/combres2.aspx">here</a>). All you have to do is to put the DotLessCssFilter into the Combres.xml and the .LESS Css file as resource. </p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2b293b31-4219-4d7c-bbc0-99923c928829" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;combres xmlns='urn:combres'&gt;
  &lt;filters&gt;
    &lt;filter type="Combres.Filters.FixUrlsInCssFilter, Combres" /&gt;
    &lt;filter type="Combres.Filters.DotLessCssFilter, Combres" /&gt;
  &lt;/filters&gt;
  &lt;resourceSets url="~/combres.axd"
                defaultDuration="30"
                defaultVersion="auto"
                defaultDebugEnabled="false"
                defaultIgnorePipelineWhenDebug="true"
                localChangeMonitorInterval="30"
                remoteChangeMonitorInterval="60"
                &gt;
    &lt;resourceSet name="siteCss" type="css"&gt;
      &lt;resource path="~/content/Less.css" /&gt;
    &lt;/resourceSet&gt;
  &lt;/resourceSets&gt;
&lt;/combres&gt;</pre></div>

<p>In the Layout Master only the Combress HTML Helper will be used:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b83f1343-5bca-4bc3-90c6-376a45bbb500" class="wlWriterEditableSmartContent"><pre name="code" class="c#">@using Combres.Mvc;

&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
	...
    @Html.CombresLink("siteCss")
	...</pre></div>

<p>In the end, the result will look like this – doesn’t matter which method you have chosen. The only difference is the moment you choose for the transformation – even if in my opinion the Javascript method is adventurous <img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile21.png" /></p>















<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6d7f3ef8-1dbd-4880-bb85-a04152bfa9bb" class="wlWriterEditableSmartContent"><pre name="code" class="c#">// LESS

@color: #4D926F;

#header {
  color: @color;
}
h2 {
  color: @color;
}</pre></div>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ef63f6ca-5c7c-4b22-af5c-6624cf64ba7c" class="wlWriterEditableSmartContent"><pre name="code" class="c#">/* Compiled CSS */

#header {
  color: #4D926F;
}
h2 {
  color: #4D926F;
}</pre></div>
