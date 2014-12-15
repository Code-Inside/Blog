---
layout: post
title: "Modelbinding with complex objects in ASP.NET MVC"
date: 2012-09-17 13:22
author: CI Team
comments: true
categories: [Uncategorized]
tags: []
language: en
---
{% include JB/setup %}

  
  <p><u><a href="{{BASE_PATH}}/assets/wp-images-en/image_thumb738-552x194.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image_thumb738-552x194" border="0" alt="image_thumb738-552x194" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb738-552x194_thumb.png" width="553" height="194" /></a></u></p>
<p><u></u></p>
<p><u>Basics:</u> The modelbinding in ASP.NET is “relatively” clever and you are able to bond almost everything. All you have to do is to understand how the binding works and you often found that out if you take a look via Fiddler and co. at what is transmitted as HTTP.</p>
<p><b>Object model </b></p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a3098236-fb7e-48f1-a274-839315bd3a8e" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public class Foobar
{
    public string Buzz { get; set; }

    public int Foo { get; set; }

    public List&lt;Foobar&gt; Children { get; set; }
}</pre></div>




<p>The model is very simple but it contains objects from the same type as a list. </p>

<p><b>Action method</b></p>




<p>We want to transmit those files to the computer (who doesn’t interact with them at all but it’s enough for the example):</p>



<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b837bc24-668a-4599-a5ff-859fca9004e7" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public ActionResult Test(string name, List&lt;Foobar&gt; foobars)
{
	return View("Index");
}
</pre></div>
I present you three different models of how to integrate complex objects into this method. 



<p><b>Model 1: easy form (Postback – no AJAX)</b></p>




<p>@using (Html.BeginForm(“Test”, “Home”, FormMethod.Post)) 
  <br />{ 

  <br />&#160;&#160;&#160; &lt;input type=”text” name=”Name” value=”Testvalue” /&gt; 

  <br />&#160;&#160;&#160; &lt;input type=”text” name=”Foobars[0].Buzz” value=”Testvalue” /&gt; 

  <br />&#160;&#160;&#160; &lt;input type=”text” name=”Foobars[0].Foo” value=”123123″ /&gt; 

  <br />&#160;&#160;&#160; &lt;input type=”text” name=”Foobars[1].Buzz” value=”Testvalue” /&gt; 

  <br />&#160;&#160;&#160; &lt;input type=”text” name=”Foobars[1].Foo” value=”123123″ /&gt; 

  <br />&#160;&#160;&#160; &lt;input type=”text” name=”Foobars[2].Buzz” value=”Testvalue” /&gt; 

  <br />&#160;&#160;&#160; &lt;input type=”text” name=”Foobars[2].Foo” value=”123123″ /&gt; 

  <br />&#160;&#160;&#160; &lt;input type=”text” name=”Foobars[3].Buzz” value=”Testvalue” /&gt; 

  <br />&#160;&#160;&#160; &lt;input type=”text” name=”Foobars[3].Foo” value=”123123″ /&gt; 

  <br />&#160;&#160;&#160; &lt;input type=”text” name=”Foobars[3].Children[0].Buzz” value=”KIND!” /&gt; 

  <br />&#160;&#160;&#160; &lt;input type=”text” name=”Foobars[3].Children[0].Foo” value=”123123″ /&gt; 

  <br />&#160;&#160;&#160; &lt;button&gt;Ok&lt;/button&gt; 

  <br />}</p>

<p>With the “[NUMBER]” of the field the MVC Binder will know that this is only a list. It’s possible to get this as interlaced as you like. It’s important at that point that the numbering is continuous. </p>

<p><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb736.png" width="477" height="333" /></p>

<p>If you take a look on what is transmitted you will recognize that it isn’t that complicated at all:</p>

<p><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb737.png" width="558" height="255" /></p>

<p><b>Model 2: send the form via jQuery with Ajax</b></p>




<p>That’s what the example looks like:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:94ccc44d-9b48-44c4-89f7-79dd13e154eb" class="wlWriterEditableSmartContent"><pre name="code" class="c#">$("#FormButton").click(function () {
    $.ajax({
        url: "@Url.Action("Test", "Home")",
        type: "POST",
        data: $("form").serializeArray()
    });

});</pre></div>

<p>I grab the Click-Event of one button and get all the information’s via “serializeArray()”. We are going to take another look at the transmission. It’s important that there are only form files as Content-Type not JSON:</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb738.png" width="552" height="314" /></p>

<p><b>Model 3: Files created with Javascript – transmit Javascript Arrays with AJAX </b></p>




<p>Model 1 and 2 rely on the existence of a form. If you prefer to build your files in Javascript only and if you don’t want to build a “Hidden”-Form you might prefer this model.</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:856496c8-dbfb-4c83-9aec-9883d3f44a6c" class="wlWriterEditableSmartContent"><pre name="code" class="c#">$("#ScriptButton").click(function () {

    var foobars = new Array();

    for (i = 0; i &lt; 10; i++) {
        foobars.push({ Buzz: "Test!", Foo: 12123, Children: { Buzz: "Child!", Foo: 123213} });
    }

    var requestData = { };
    requestData.Name = "Testadalsdk";
    requestData.Foobars = foobars;

    $.ajax({
        url: "@Url.Action("Test", "Home")",
        type: "POST",
        contentType: 'application/json;',
        dataType: 'json',
        data: JSON.stringify(requestData)
    });

});</pre></div>

<p>First we create an Array in Javascript:</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb739.png" width="528" height="244" /></p>

<p>Next we create a “requestData” and set our “Name”-Testproperty and connect the Array.</p>

<p>To transmit this to our controller we need to transform the files. The easiest way for this is the JSON-format. Newer browsers have a JSON support but to be sure I recommend you to use the JSON Helper from <a href="https://github.com/douglascrockford/JSON-js/blob/master/json2.js">Douglas Crockford “json2.js</a>” (it’s also available on NuGet). </p>

<p>With this script you will receive the method “<a href="https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/JSON/stringify">JSON.stringify(</a>)” (the link leeds to the Mozialle Developer Center – the same thing is in the MSDN) which transforms an object into JSON.</p>

<p>Therefore we set the following properties in the AJAX request so our controller will be able to understand what he receives:</p>

<p><b>contentType: ‘application/json;’,</b></p>

<p><b>dataType: ‘json’,</b></p>

<p>That’s what is going to be transmitted:</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb740.png" width="525" height="352" /></p>

<p>Because of the content-type: application/json the MVC framework uses the JSON modelbinder automatically and the information’s will be transmitted to the controller.</p>

<p><b>Result</b></p>

<p>You are able to do almost everything with the MVC Modelbinding if you keep in mind some basic rules. Also a look onto what is transmitted via HTTP will help you a lot with the Debugging. </p>

<p>The whole demo application is available <a href="https://github.com/Code-Inside/Samples/tree/master/2012/MvcModelbinding">here</a> – but there is also code included from another Blogpost. </p>
