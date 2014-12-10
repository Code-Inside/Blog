---
layout: post
title: "Prototype for Google + similar Feedback-Module with Html2Canvas-Screenshots with Javascript"
date: 2011-08-08 11:45
author: antje.kilian
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}
<a href="{{BASE_PATH}}/assets/wp-images-en/image1302-397x194.png"></a>

<a href="{{BASE_PATH}}/assets/wp-images-en/image1302-397x194.png"> </a>

<a href="{{BASE_PATH}}/assets/wp-images-en/image1302-397x194.png"></a>

<a href="{{BASE_PATH}}/assets/wp-images-en/image1302-397x194.png"> </a>

A main problem for every Developer is that you can’t see what the user will see. The developer from Google integrated a useful tool where you are able to mark a part of the Side and send it to Google as a screenshot. Both developer and user will have a maximum plus of Usability.

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb485.png" border="0" alt="image" width="509" height="343" />

Today I found a Javascript-Framework which is able to pack the HTML in a Canvas. The name is <a href="http://html2canvas.hertzen.com/">Html2Canvas</a> and it is still experimental and has several limitations but at least it works with many sides. Here is the <a href="http://html2canvas.hertzen.com/screenshots.html">testconsole</a>:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb486.png" border="0" alt="image" width="408" height="275" />

Little downer: of course it’s not a real Screenshot but a picture of the DOM. More you can read <a href="http://html2canvas.hertzen.com/">on the developer side</a>. And of course Html2Canvas only works it the browser supports the Canvas element.

But because of I didn’t work with the Canvas Element so far I would like to test the Google + Feedback-Modul Scenario.

<strong>Transform the Canvas into an Image and post it to the server </strong>

<strong> </strong>

So I adapted the Demoside a little and integrated a ASP.NET MVC application and added a Upload-Button (and adapted the script a little bit and appointed Canvas with an ID).

<a href="{{BASE_PATH}}/assets/wp-images-en/image1305.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image1305" src="{{BASE_PATH}}/assets/wp-images-en/image1305_thumb.png" border="0" alt="image1305" width="548" height="196" /></a>

The HTML Canvas Object has a Javascript-method to change it into base64 picture (the deciding tip is form <a href="http://stackoverflow.com/questions/1590965/uploading-canvas-image-data-to-the-server">this side</a>). With AJAX the base64 image will be send to the Controller. With the Url.Action Parameter I force that the whole URL will be render because the Javascript of Html2Canvas destroys the Location of the side.
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2f4f7130-3ac7-4907-b182-92d15868d9d4" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">  function upload() {
                var canvas = $("#CanvasTest").get(0).toDataURL('image/jpeg');

                $.post('@Url.Action("Upload", "Home", null, "http")',
                    {
                        img: canvas
                    });
            }</pre>
</div>
Because it’s not the regular fileupload running here and because of this I can’t use the <a href="http://code-inside.de/blog-in/2011/02/23/howto-fileupload-with-asp-net-mvc/">HttpPostedFileBase</a> I need to drag and save the image manual.
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f94a6feb-a744-4d94-92c2-d126cc9b5b88" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#"> public ActionResult Upload()
        {
            string fullString = this.Request.Form["img"];
            var base64 = fullString.Substring(fullString.IndexOf(",") + 1);
            byte[] b;
            b = Convert.FromBase64String(base64);

            MemoryStream ms = new System.IO.MemoryStream(b);

            Image img = System.Drawing.Image.FromStream(ms);

            img.Save(Path.Combine(
              AppDomain.CurrentDomain.BaseDirectory, Guid.NewGuid().ToString() + ".jpg"), System.Drawing.Imaging.ImageFormat.Jpeg);

            return RedirectToAction("Index");
        }</pre>
</div>
The result is nice:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb488.png" border="0" alt="image" width="244" height="129" />

In fact my sides are not rendered quite good but almost <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile22.png" alt="Zwinkerndes Smiley" />

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb489.png" border="0" alt="image" width="420" height="332" />

The images will be saved in the directory of the application.

<strong>Things we have learned:</strong>

<strong> </strong>

- Html2Canvas is an interesting project<strong> </strong>

- It’s easy to post a canvas to the server<strong> </strong>

- I’ve learned something new about <a href="http://forums.asp.net/p/1679283/4524525.aspx/1?Re+Convert+base64+to+image+">base64 coded images</a>

There are a lot of <a href="http://www.youtube.com/watch?v=wbSoSCStodA">things you can do with canvas</a> so it becomes more similar with Google+.

Like I’ve already mentioned in the title: It’s just a Prototype <img class="wlEmoticon wlEmoticon-winkingsmile" style="border-style: none;" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile22.png" alt="Zwinkerndes Smiley" />
