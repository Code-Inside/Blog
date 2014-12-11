---
layout: post
title: "Fix: the value ‚x‘ is not valid for Foo in ASP.NET MVC"
date: 2012-01-23 12:12
author: CI Team
comments: true
categories: [Fix]
tags: [value; ASP.NET MVC]
language: en
---
{% include JB/setup %}
&nbsp;

<strong> </strong>

To get files into the MVC Controller <a href="{{BASE_PATH}}/2009/04/02/howto-daten-vom-view-zum-controller-bermitteln-bindings-in-aspnet-mvc/">Modelbinding</a> from MVC is a clever method.

But in fact it is a little bit complicated to set the error message if the connection failed.

<strong>Example: </strong>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:39e2d23e-7a67-4843-a117-686ee11866e7" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">public class RegisterModel
    {
		...

        [Required]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "Email address")]
        public string Email { get; set; }

        [Required]
        [Display(Name = "Age")]
        public int Age { get; set; }

		...
    }</pre>
</div>
<strong> </strong>

This is the default model for the registration in the ASP.NET MVC project draft. I’ve added a Property “Age” from the Typ “int”. This have to be mentioned in the View as well:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:40299041-887f-4cd8-bbf2-84f8e307c5b4" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#"> ...
			&lt;div class="editor-label"&gt;
                @Html.LabelFor(m =&gt; m.Age)
            &lt;/div&gt;
            &lt;div class="editor-field"&gt;
                @Html.TextBoxFor(m =&gt; m.Age)
                @Html.ValidationMessageFor(m =&gt; m.Age)
            &lt;/div&gt;
			...</pre>
</div>
<strong>Problem: What happens if the user enters letters instead of numbers? </strong>

<strong> </strong>

Everything is alright as long as <strong>the ClientValidation is on</strong>:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb615.png" border="0" alt="image" width="464" height="173" />

If it’s off you will receive this error message:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb616.png" border="0" alt="image" width="426" height="101" />

The error message “The vaule ‘Test’ is not valid for Age.” Will be written directly into the ModelState:

<a href="{{BASE_PATH}}/assets/wp-images-en/image1439.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image1439" src="{{BASE_PATH}}/assets/wp-images-en/image1439_thumb.png" border="0" alt="image1439" width="459" height="308" /></a>

Unfortunately it’s not that easy to <a href="http://forums.asp.net/t/1512140.aspx/1/10">change this message</a> – all kinds of languages will be ignored. That doesn’t look nice on a German side.

<strong>Fix: create a resource file </strong>

You need to create a Resource file at the App_GlobalResources and add a “PropertyValuenvalid” with the proper text:

<img style="background-image: none; padding-left: 0px; padding-right: 0px; padding-top: 0px; border: 0px;" title="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb618.png" border="0" alt="image" width="503" height="162" />

Link the Resource file to the Global.asax:
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d0183f0e-56d0-475a-b1dc-3b06efb5e778" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;">
<pre class="c#">	protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            DefaultModelBinder.ResourceClassKey = "Errors"; &lt;-- lookup in Errors.resx

            RegisterGlobalFilters(GlobalFilters.Filters);
            RegisterRoutes(RouteTable.Routes);
        }</pre>
</div>
<strong>Result:</strong>

<a href="{{BASE_PATH}}/assets/wp-images-en/image14411.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image1441" src="{{BASE_PATH}}/assets/wp-images-en/image1441_thumb1.png" border="0" alt="image1441" width="424" height="124" /></a>

<strong> </strong>

<strong>Background: </strong>

It’s not possible to run every kind of validation logic because the Framework isn’t able to attach the Property. Interestingly the reaction of the Framework is different if you try to allocate a higher number to the Int. In this case the ModelState receives an Exception you are able to catch. Also a validation could grip. I only have this problem in connection with String-entries.
