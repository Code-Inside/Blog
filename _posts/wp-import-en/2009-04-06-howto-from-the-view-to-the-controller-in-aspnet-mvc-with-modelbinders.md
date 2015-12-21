---
layout: post
title: "HowTo: From the view to the controller in ASP.NET MVC with ModelBinders"
date: 2009-04-06 21:03
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, HowTo, ModelBinders]
language: en
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb411.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; border-right-width: 0px" height="117" alt="image_thumb4" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb4-thumb3.png" width="153" align="left" border="0" /></a>With ASP.NET MVC the developer has now full control about the HTML rendering and how the form data will be transmitted to the server. But how can you get the form values on the server side? There are better ways in MVC to do that than Request.Form[&quot;...&quot;].</p> 



<p><strong>Intro</strong>     <br />If you are new to ASP.NET MVC, I recommend you to read <a href="{{BASE_PATH}}/2008/11/26/howto-first-steps-with-aspnet-mvc/">this post</a> or look at <a href="http://asp.net/mvc">asp.net/mvc</a>. </p>
<p><strong>&quot;Bindings&quot;</strong>     <br />In this HowTo you can learn how to access the form data in a more elegant way than Request.Form[&quot;...&quot;]. </p>
<p><strong>Structure</strong></p>
<p><strong></strong>    <br /><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb810.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; border-right-width: 0px" height="279" alt="image_thumb8" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb8-thumb1.png" width="152" align="left" border="0" /></a></p>
<p>We have a &quot;BindingController&quot; and in the Model folder a &quot;Person&quot; class and 3 views:</p>
<p>- &quot;CreatePerson&quot; (form to create a person)    <br />- &quot;Result&quot; of the action     <br />- &quot;Index&quot; is the overview page</p>  
  
  
  

<p>Person Class:</p>  
  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0b1e181d-3966-498f-aefd-8712a0c8d7e5" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">   <div class="dp-highlighter">     <div class="bar">       <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>     </div>      <ol class="dp-c">       <li class="alt"><span><span class="keyword">public</span><span>&#160;</span><span class="keyword">class</span><span> Person&#160;&#160; </span></span></li>        <li class=""><span>{&#160;&#160; </span></li>        <li class="alt"><span>&#160;&#160;&#160; </span><span class="keyword">public</span><span> Guid Id { </span><span class="keyword">get</span><span>; </span><span class="keyword">set</span><span>; }&#160;&#160; </span></span></li>        <li class=""><span>&#160;&#160;&#160; </span><span class="keyword">public</span><span>&#160;</span><span class="keyword">string</span><span> Prename { </span><span class="keyword">get</span><span>; </span><span class="keyword">set</span><span>; }&#160;&#160; </span></span></li>        <li class="alt"><span>&#160;&#160;&#160; </span><span class="keyword">public</span><span>&#160;</span><span class="keyword">string</span><span> Surname { </span><span class="keyword">get</span><span>; </span><span class="keyword">set</span><span>; }&#160;&#160; </span></span></li>        <li class=""><span>&#160;&#160;&#160; </span><span class="keyword">public</span><span>&#160;</span><span class="keyword">int</span><span> Age { </span><span class="keyword">get</span><span>; </span><span class="keyword">set</span><span>; }&#160;&#160; </span></span></li>        <li class="alt"><span>}&#160; </span></li>     </ol>   </div>    <pre class="c#" style="display: none" name="code">    public class Person
    {
        public Guid Id { get; set; }
        public string Prename { get; set; }
        public string Surname { get; set; }
        public int Age { get; set; }
    }</pre>
</div>




<p>Form in CreatePerson.aspx:</p>




<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e3f6bc9b-67a4-4dd1-acb6-2e470a6a230c" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span>&lt;% </span><span class="keyword">using</span><span> (Html.BeginForm()) { %&gt;&#160;&#160; </span></span></li>

      <li class=""><span>&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160; &lt;fieldset&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;legend&gt;Fields&lt;/legend&gt;&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;p&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;label </span><span class="keyword">for</span><span>=</span><span class="string">&quot;Id&quot;</span><span>&gt;Id:&lt;/label&gt;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;%= Html.TextBox(</span><span class="string">&quot;Id&quot;</span><span>) %&gt;&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;%= Html.ValidationMessage(</span><span class="string">&quot;Id&quot;</span><span>, </span><span class="string">&quot;*&quot;</span><span>) %&gt;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;/p&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;p&gt;&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;label </span><span class="keyword">for</span><span>=</span><span class="string">&quot;Prename&quot;</span><span>&gt;Prename:&lt;/label&gt;&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;%= Html.TextBox(</span><span class="string">&quot;Prename&quot;</span><span>) %&gt;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;%= Html.ValidationMessage(</span><span class="string">&quot;Prename&quot;</span><span>, </span><span class="string">&quot;*&quot;</span><span>) %&gt;&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;/p&gt;&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;p&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;label </span><span class="keyword">for</span><span>=</span><span class="string">&quot;Surname&quot;</span><span>&gt;Surname:&lt;/label&gt;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;%= Html.TextBox(</span><span class="string">&quot;Surname&quot;</span><span>) %&gt;&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;%= Html.ValidationMessage(</span><span class="string">&quot;Surname&quot;</span><span>, </span><span class="string">&quot;*&quot;</span><span>) %&gt;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;/p&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;p&gt;&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;label </span><span class="keyword">for</span><span>=</span><span class="string">&quot;Age&quot;</span><span>&gt;Age:&lt;/label&gt;&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;%= Html.TextBox(</span><span class="string">&quot;Age&quot;</span><span>) %&gt;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;%= Html.ValidationMessage(</span><span class="string">&quot;Age&quot;</span><span>, </span><span class="string">&quot;*&quot;</span><span>) %&gt;&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;/p&gt;&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;p&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;input type=</span><span class="string">&quot;submit&quot;</span><span> value=</span><span class="string">&quot;Create&quot;</span><span> /&gt;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;/p&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160; &lt;/fieldset&gt;&#160;&#160; </span></li>

      <li class="alt"><span>&#160; </span></li>

      <li class=""><span>&lt;% } %&gt;&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">    &lt;% using (Html.BeginForm()) { %&gt;

        &lt;fieldset&gt;
            &lt;legend&gt;Fields&lt;/legend&gt;
            &lt;p&gt;
                &lt;label for=&quot;Id&quot;&gt;Id:&lt;/label&gt;
                &lt;%= Html.TextBox(&quot;Id&quot;) %&gt;
                &lt;%= Html.ValidationMessage(&quot;Id&quot;, &quot;*&quot;) %&gt;
            &lt;/p&gt;
            &lt;p&gt;
                &lt;label for=&quot;Prename&quot;&gt;Prename:&lt;/label&gt;
                &lt;%= Html.TextBox(&quot;Prename&quot;) %&gt;
                &lt;%= Html.ValidationMessage(&quot;Prename&quot;, &quot;*&quot;) %&gt;
            &lt;/p&gt;
            &lt;p&gt;
                &lt;label for=&quot;Surname&quot;&gt;Surname:&lt;/label&gt;
                &lt;%= Html.TextBox(&quot;Surname&quot;) %&gt;
                &lt;%= Html.ValidationMessage(&quot;Surname&quot;, &quot;*&quot;) %&gt;
            &lt;/p&gt;
            &lt;p&gt;
                &lt;label for=&quot;Age&quot;&gt;Age:&lt;/label&gt;
                &lt;%= Html.TextBox(&quot;Age&quot;) %&gt;
                &lt;%= Html.ValidationMessage(&quot;Age&quot;, &quot;*&quot;) %&gt;
            &lt;/p&gt;
            &lt;p&gt;
                &lt;input type=&quot;submit&quot; value=&quot;Create&quot; /&gt;
            &lt;/p&gt;
        &lt;/fieldset&gt;

    &lt;% } %&gt;</pre>
</div>




<p><strong>Binding: 1. Option - FormCollection:</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:541bb5b8-17eb-49f7-b8ca-5c964f2a38db" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span>[AcceptVerbs(HttpVerbs.Post)]&#160;&#160; </span></span></li>

      <li class=""><span></span><span class="keyword">public</span><span> ActionResult FormCollection(FormCollection collection)&#160;&#160; </span></span></li>

      <li class="alt"><span>{&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160; Person person = </span><span class="keyword">new</span><span> Person();&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160; person.Prename = collection[</span><span class="string">&quot;Prename&quot;</span><span>];&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160; person.Surname = collection[</span><span class="string">&quot;Surname&quot;</span><span>];&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160; person.Age = </span><span class="keyword">int</span><span>.Parse(collection[</span><span class="string">&quot;Age&quot;</span><span>]);&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160; </span><span class="keyword">return</span><span> View(</span><span class="string">&quot;Result&quot;</span><span>, person);&#160;&#160; </span></span></li>

      <li class="alt"><span>}&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult FormCollection(FormCollection collection)
        {
            Person person = new Person();
            person.Prename = collection[&quot;Prename&quot;];
            person.Surname = collection[&quot;Surname&quot;];
            person.Age = int.Parse(collection[&quot;Age&quot;]);
            return View(&quot;Result&quot;, person);
        }</pre>
</div>

<p>This option is the simplest possible way to access the form data, but not very elegant and hard to test, because you need to know which keys are in the FormCollection. </p>

<p><strong>Binding: 2. Option- Parameter Matching:</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1e8d4262-2c08-41b7-828c-545d1e61a4ed" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span>[AcceptVerbs(HttpVerbs.Post)]&#160;&#160; </span></span></li>

      <li class=""><span></span><span class="keyword">public</span><span> ActionResult ParameterMatching(</span><span class="keyword">string</span><span> Prename, </span><span class="keyword">string</span><span> Surname, </span><span class="keyword">int</span><span> Age)&#160;&#160; </span></span></li>

      <li class="alt"><span>{&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160; Person person = </span><span class="keyword">new</span><span> Person();&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160; person.Prename = Prename;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160; person.Surname = Surname;&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160; person.Age = Age;&#160;&#160; </span></li>

      <li class=""><span>&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160; </span><span class="keyword">return</span><span> View(</span><span class="string">&quot;Result&quot;</span><span>, person);&#160;&#160; </span></span></li>

      <li class=""><span>}&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ParameterMatching(string Prename, string Surname, int Age)
        {
            Person person = new Person();
            person.Prename = Prename;
            person.Surname = Surname;
            person.Age = Age;

            return View(&quot;Result&quot;, person);
        }</pre>
</div>

<p>This option is very handy. The HTTP form values will be mapped to the parameters if the type and name are the same as the transmitted form value. This option is easy to test, but you have to map the parameters to your model manually.</p>

<p><strong>Binding: 3. Option - Default Binding:</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:7f829ed2-ca11-4995-8d10-f6cd19ae10a2" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span>[AcceptVerbs(HttpVerbs.Post)]&#160;&#160; </span></span></li>

      <li class=""><span></span><span class="keyword">public</span><span> ActionResult DefaultBinding(Person person)&#160;&#160; </span></span></li>

      <li class="alt"><span>{&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160; </span><span class="keyword">return</span><span> View(</span><span class="string">&quot;Result&quot;</span><span>, person);&#160;&#160; </span></span></li>

      <li class="alt"><span>}&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult DefaultBinding(Person person)
        {
            return View(&quot;Result&quot;, person);
        }</pre>
</div>

<p>Now we use our own model as parameter type. The default model binder, which is included in the ASP.NET MVC, will map the incomming HTTP form values to the properties of our person, if type and name match.</p>

<p><strong>Binding: 3. Option with addon - Default Binding with Include:</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:fad75f19-afaf-4cce-a86f-b3002463b407" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span>[AcceptVerbs(HttpVerbs.Post)]&#160;&#160; </span></span></li>

      <li class=""><span></span><span class="keyword">public</span><span> ActionResult DefaultBindingWithInclude([Bind(Include=</span><span class="string">&quot;Prename&quot;</span><span>)] Person person)&#160;&#160; </span></span></li>

      <li class="alt"><span>{&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160; </span><span class="keyword">return</span><span> View(</span><span class="string">&quot;Result&quot;</span><span>, person);&#160;&#160; </span></span></li>

      <li class="alt"><span>}&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult DefaultBindingWithInclude([Bind(Include=&quot;Prename&quot;)] Person person)
        {
            return View(&quot;Result&quot;, person);
        }</pre>
</div>

<p><a href="http://www.codethinked.com/post/2009/01/08/ASPNET-MVC-Think-Before-You-Bind.aspx">You should think bevor you bind</a> - to secure your applicaiton you can specify which properties will be mapped to the properties of the parameters.</p>

<p><strong>Binding: 3. Option with addon - Default Binding with Exclude:</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f464b65d-eba8-4ca5-b00e-c6549044295e" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span>[AcceptVerbs(HttpVerbs.Post)]&#160;&#160; </span></span></li>

      <li class=""><span></span><span class="keyword">public</span><span> ActionResult DefaultBindingWithExclude([Bind(Exclude = </span><span class="string">&quot;Prename&quot;</span><span>)] Person person)&#160;&#160; </span></span></li>

      <li class="alt"><span>{&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160; </span><span class="keyword">return</span><span> View(</span><span class="string">&quot;Result&quot;</span><span>, person);&#160;&#160; </span></span></li>

      <li class="alt"><span>}&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult DefaultBindingWithExclude([Bind(Exclude = &quot;Prename&quot;)] Person person)
        {
            return View(&quot;Result&quot;, person);
        }</pre>
</div>

<p>The same functionality, but this time reversed. </p>

<p><strong>Binding: 3. Option with addon - Default Binding with Prefix:</strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb113.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="53" alt="image_thumb11" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb11-thumb.png" width="407" border="0" /></a></p>

<p>If you put a prefix in your Html Input controls (because you have multiple &quot;name&quot; fields), than you can specify a prefix.</p>

<p>All these options can be used together and you can map more than one parameter.</p>

<p><strong>Binding: 4. Option - IModelBinder</strong></p>

<p>If the values are getting more complex or you want your own mapping logic than you can use the IModelBinder interface. One example is <a href="http://www.hanselman.com/blog/ASPNETMVCBetaReleasedCoolnessEnsues.aspx">Fileupload</a> or to get the <a href="http://www.hanselman.com/blog/IPrincipalUserModelBinderInASPNETMVCForEasierTesting.aspx">session user</a>.</p>

<p>Now you just need to implement the IModelBinder interface:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:73f40b10-a763-4707-8b7a-60fcbd9226b8" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span class="keyword">public</span><span>&#160;</span><span class="keyword">class</span><span> PersonModelBinder : IModelBinder&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160; {&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><span class="keyword">public</span><span>&#160;</span><span class="keyword">object</span><span> BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; {&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><span class="keyword">if</span><span> (controllerContext == </span><span class="keyword">null</span><span>) {&#160;&#160;&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><span class="keyword">throw</span><span>&#160;</span><span class="keyword">new</span><span> ArgumentNullException(</span><span class="string">&quot;controllerContext&quot;</span><span>);&#160;&#160;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; }&#160;&#160;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><span class="keyword">if</span><span> (bindingContext == </span><span class="keyword">null</span><span>) {&#160;&#160;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><span class="keyword">throw</span><span>&#160;</span><span class="keyword">new</span><span> ArgumentNullException(</span><span class="string">&quot;bindingContext&quot;</span><span>);&#160;&#160;&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; }&#160;&#160; </span></li>

      <li class="alt"><span>&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; NameValueCollection collection = controllerContext.RequestContext.HttpContext.Request.Form;&#160;&#160; </span></li>

      <li class="alt"><span>&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; Person returnValue = </span><span class="keyword">new</span><span> Person();&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; returnValue.Id = Guid.NewGuid();&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; returnValue.Prename = </span><span class="string">&quot;Modelbinder: &quot;</span><span> + collection[</span><span class="string">&quot;Prename&quot;</span><span>];&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; returnValue.Surname = </span><span class="string">&quot;Modelbinder: &quot;</span><span> + collection[</span><span class="string">&quot;Surname&quot;</span><span>];&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><span class="keyword">int</span><span> age = 0;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><span class="keyword">int</span><span>.TryParse(collection[</span><span class="string">&quot;Age&quot;</span><span>], </span><span class="keyword">out</span><span> age);&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; returnValue.Age = age;&#160;&#160; </span></li>

      <li class="alt"><span>&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><span class="keyword">return</span><span> returnValue;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; }&#160;&#160; </span></li>

      <li class=""><span>&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160; }&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">public class PersonModelBinder : IModelBinder
    {
        public object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
         if (controllerContext == null) {  
             throw new ArgumentNullException(&quot;controllerContext&quot;);  
         }  
         if (bindingContext == null) {  
             throw new ArgumentNullException(&quot;bindingContext&quot;);  
         }

            NameValueCollection collection = controllerContext.RequestContext.HttpContext.Request.Form;

            Person returnValue = new Person();
            returnValue.Id = Guid.NewGuid();
            returnValue.Prename = &quot;Modelbinder: &quot; + collection[&quot;Prename&quot;];
            returnValue.Surname = &quot;Modelbinder: &quot; + collection[&quot;Surname&quot;];
            int age = 0;
            int.TryParse(collection[&quot;Age&quot;], out age);
            returnValue.Age = age;

            return returnValue;
        }

    }</pre>
</div>

<p>You get full access to the form values or other controller properties or route value.</p>

<p>You can register your Modelbinder global in the Global.ascx:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ec540371-fa11-4087-965e-dcf98a12bb33" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span class="keyword">protected</span><span>&#160;</span><span class="keyword">void</span><span> Application_Start()&#160;&#160; </span></span></li>

      <li class=""><span>{&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160; RegisterRoutes(RouteTable.Routes);&#160;&#160;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160; ModelBinders.Binders[</span><span class="keyword">typeof</span><span>(Person)] = </span><span class="keyword">new</span><span> PersonModelBinder(); </span><span class="comment">// Important! </span><span>&#160; </span></span></li>

      <li class="alt"><span>}&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">        protected void Application_Start()
        {
            RegisterRoutes(RouteTable.Routes);  
            ModelBinders.Binders[typeof(Person)] = new PersonModelBinder(); // Important!
        }</pre>
</div>

<p>Everytime you have a parameter of type &quot;Person&quot; the &quot;PersonModelBinder&quot; will try to map the values to this object.</p>

<p>Or you can specify it per ActionMethod:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d3cc88dd-8128-4121-a197-5f8541b409ae" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span>[AcceptVerbs(HttpVerbs.Post)]&#160;&#160; </span></span></li>

      <li class=""><span></span><span class="keyword">public</span><span> ActionResult PersonModelBinder([ModelBinder(</span><span class="keyword">typeof</span><span>(PersonModelBinder))] Person person)&#160;&#160; </span></span></li>

      <li class="alt"><span>{&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160; </span><span class="keyword">return</span><span> View(</span><span class="string">&quot;Result&quot;</span><span>, person);&#160;&#160; </span></span></li>

      <li class="alt"><span>}&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult PersonModelBinder([ModelBinder(typeof(PersonModelBinder))] Person person)
        {
            return View(&quot;Result&quot;, person);
        }</pre>
</div>

<p><strong>Lists/Array Binding:</strong></p>

<p>You can even &quot;bind&quot; arrays / lists. Read <a href="http://www.hanselman.com/blog/ASPNETWireFormatForModelBindingToArraysListsCollectionsDictionaries.aspx">Scott Hanselmans post</a> for more information.</p>

<p><strong>Screens:</strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb121.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="176" alt="image_thumb12" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb12-thumb.png" width="244" border="0" /></a></p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb142.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="244" alt="image_thumb14" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb14-thumb1.png" width="212" border="0" /></a></p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb152.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="244" alt="image_thumb15" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb15-thumb1.png" width="243" border="0" /></a></p>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvcbinding/mvcbinding.zip">[Download Source Code]</a></strong></p>
