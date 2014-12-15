---
layout: post
title: "HowTo: First steps with ASP.NET MVC"
date: 2008-11-26 00:57
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC]
language: en
---
{% include JB/setup %}
<p>In <a href="{{BASE_PATH}}/2008/11/25/howto-basics-of-aspnet-mvc-or-why-mvc/">my last post</a> I wrote about why you should take a look at ASP.NET MVC. With this blogpost I want to go a little bit deeper into the MVC universe.</p>
<p><strong><u>The project template        <br /></u></strong>After the installation of <a href="http://www.asp.net/mvc/">ASP.NET MVC</a> (currently beta) you will find a new project template in Visual Studio:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb110.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="267" alt="image_thumb1" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb1-thumb.png" width="414" border="0" /></a></p>
<p>Right after you click ok you get another dialog:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb51.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="282" alt="image_thumb5" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb5-thumb.png" width="419" border="0" /></a></p>
<p>ASP.NET MVC is very testable and ask you if you want to create a unit test project. I recommend you to do that (or create your own unit test project) - unit tests are a great way to produce high quality.    <br />The default test framework is MSTest, other frameworks will be added later (hopefully :) ).</p>
<p><strong><u>Project structure:        <br /></u></strong>Now you should see a solution like this (i added another project to this solution, but you don&#180;t need to care about it):</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb71.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="357" alt="image_thumb7" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb7-thumb.png" width="191" border="0" /></a></p>
<p>The &quot;ReadYou.WebApp&quot; shows the typical ASP.NET MVC folder structure:</p>  <ul>   <li>Controller: Logic </li>    <li>Models: Business data / application model </li>    <li>Views: simple ASPX / ASCX / masterpage (or other) views </li> </ul>
<p><strong><u>Views, Controller &amp; Models in detail        <br /></u></strong>The project template include 2 controller and 3 view folders:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb92.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="244" alt="image_thumb9" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb9-thumb1.png" width="217" border="0" /></a></p>  <ul>   <li>The &quot;<strong>Shared</strong>&quot; folder contains all viewelements that could be used by other views, like the masterpage or some common controls. </li>    <li>Each controller has it&#180;s own view folder (&quot;<strong>Account</strong>Controller&quot; - &quot;<strong>Account</strong>&quot; / &quot;<strong>Home</strong>Controller&quot; - &quot;<strong>Home</strong>&quot;) </li>    <li>This &quot;path&quot;-configuration can be modified by using the diverent interfaces, hier are 2 good examples &quot;<a href="http://blog.codeville.net/2008/07/30/partitioning-an-aspnet-mvc-application-into-separate-areas/">Partitioning an ASP.NET MVC application into separate &quot;Areas&quot;</a>&quot; and <a href="http://blog.wekeroad.com/blog/my-mvc-starter-template/">Rob Conerys version</a>. </li>    <li>The &quot;<strong>model</strong>&quot; folder contains only the application data classes (normal CRL classes) </li> </ul>
<p><strong><u>A short look on the default website:</u>       <br /></strong>The default MVC website is great to get a first look how MVC is working. There is masterpage, a simple membershipsystem and some simple form stuff (the login and register page) :</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb141.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="149" alt="image_thumb14" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb14-thumb.png" width="362" border="0" /></a></p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb131.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="192" alt="image_thumb13" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb13-thumb.png" width="357" border="0" /></a></p>
<p><strong><u>The request Flow:        <br /></u></strong><a href="http://www.codethinked.com/author/Justin%20Etheredge.aspx">Justin Etheredge</a> create a great overview of the request flow and where the extensibility points are: <a href="http://www.codethinked.com/post/2008/09/27/ASPNET-MVC-Request-Flow.aspx">ASP.NET MVC Request Flow </a></p>
<p><strong><u>Communication between the controller and the view: </u></strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb311.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="126" alt="image_thumb31" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb31-thumb.png" width="452" border="0" /></a></p>
<p>You can use the &quot;ViewData&quot;-dictionary to send data from the controller (the request will be routed to an action method of a controller) :</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:74cd4e71-443f-4b20-afdb-3b53f3c81731" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">   <div class="dp-highlighter">     <div class="bar">       <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>     </div>      <ol class="dp-c">       <li class="alt"><span><span class="keyword">public</span><span> ActionResult Index()&#160;&#160; </span></span></li>        <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; {&#160;&#160; </span></li>        <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; ViewData[</span><span class="string">&quot;Title&quot;</span><span>] = </span><span class="string">&quot;Home Page&quot;</span><span>;&#160;&#160; </span></span></li>        <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; ViewData[</span><span class="string">&quot;Message&quot;</span><span>] = </span><span class="string">&quot;Welcome to ASP.NET MVC!&quot;</span><span>;&#160;&#160; </span></span></li>        <li class="alt"><span>&#160; </span></li>        <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><span class="keyword">return</span><span> View();&#160;&#160; </span></span></li>        <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; }&#160; </span></li>     </ol>   </div>    <pre class="c#" style="display: none" name="code">public ActionResult Index()
        {
            ViewData[&quot;Title&quot;] = &quot;Home Page&quot;;
            ViewData[&quot;Message&quot;] = &quot;Welcome to ASP.NET MVC!&quot;;

            return View();
        }</pre>
</div>

<p>The data in the dictionary&#160; will be send to a view called &quot;<strong>Index</strong>&quot; in the &quot;<strong>Home</strong>&quot; folder, because the action method is a method of the &quot;<strong>Home</strong>Controller&quot;. You can specify a view in the &quot;View(YOURVIEW)&quot; method, but if you just use the &quot;View()&quot; method the MVC framework will route the data to a view namend like the action method itself e.g. &quot;<strong>Index</strong>&quot;. 

  <br />

  <br />Source code of the &quot;Index.aspx&quot; <em>(~/Views/Home/</em>):</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:11ac1b28-7c0c-448e-b6ec-4308d1624787" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span>&lt;%@ Page Language=</span><span class="string">&quot;C#&quot;</span><span> MasterPageFile=</span><span class="string">&quot;~/Views/Shared/Site.Master&quot;</span><span> AutoEventWireup=</span><span class="string">&quot;true&quot;</span><span> CodeBehind=</span><span class="string">&quot;Index.aspx.cs&quot;</span><span> Inherits=</span><span class="string">&quot;ReadYou.WebApp.Views.Home.Index&quot;</span><span> %&gt;&#160;&#160; </span></span></li>

      <li class=""><span>&#160; </span></li>

      <li class="alt"><span>&lt;asp:Content ID=</span><span class="string">&quot;indexContent&quot;</span><span> ContentPlaceHolderID=</span><span class="string">&quot;MainContent&quot;</span><span> runat=</span><span class="string">&quot;server&quot;</span><span>&gt;&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160; &lt;h2&gt;&lt;%= Html.Encode(ViewData[</span><span class="string">&quot;Message&quot;</span><span>]) %&gt;&lt;/h2&gt;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160; &lt;p&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; To learn more about ASP.NET MVC visit &lt;a href=</span><span class="string">&quot;http://asp.net/mvc&quot;</span><span> title=</span><span class="string">&quot;ASP.NET MVC Website&quot;</span><span>&gt;http://asp.net/mvc&lt;/a&gt;.&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160; &lt;/p&gt;&#160;&#160; </span></li>

      <li class=""><span>&lt;/asp:Content&gt;&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">&lt;%@ Page Language=&quot;C#&quot; MasterPageFile=&quot;~/Views/Shared/Site.Master&quot; AutoEventWireup=&quot;true&quot; CodeBehind=&quot;Index.aspx.cs&quot; Inherits=&quot;ReadYou.WebApp.Views.Home.Index&quot; %&gt;

&lt;asp:Content ID=&quot;indexContent&quot; ContentPlaceHolderID=&quot;MainContent&quot; runat=&quot;server&quot;&gt;
    &lt;h2&gt;&lt;%= Html.Encode(ViewData[&quot;Message&quot;]) %&gt;&lt;/h2&gt;
    &lt;p&gt;
        To learn more about ASP.NET MVC visit &lt;a href=&quot;http://asp.net/mvc&quot; title=&quot;ASP.NET MVC Website&quot;&gt;http://asp.net/mvc&lt;/a&gt;.
    &lt;/p&gt;
&lt;/asp:Content&gt;</pre>
</div>

<p>The data in the &quot;ViewData&quot;-dictionary are rendered though the inline code. There is no code behinde file, it&#180;s similar to PHP/JSP or classic ASP. 
  <br />As you can see: ASP.NET MVC is still MVC. You can still use the masterpage files and the content placeholder and use the &quot;ViewData&quot; in the masterpage:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:77bf3548-3ca7-43ba-9bb5-69c8ba4b70bf" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span>...&#160;&#160; </span></span></li>

      <li class=""><span>&lt;head runat=</span><span class="string">&quot;server&quot;</span><span>&gt;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160; &lt;meta http-equiv=</span><span class="string">&quot;Content-Type&quot;</span><span> content=</span><span class="string">&quot;text/html; charset=iso-8859-1&quot;</span><span> /&gt;&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160; &lt;title&gt;&lt;%= Html.Encode(ViewData[</span><span class="string">&quot;Title&quot;</span><span>]) %&gt;&lt;/title&gt;&#160;&#160; </span></span></li>

      <li class="alt"><span>&lt;/head&gt;&#160;&#160; </span></li>

      <li class=""><span>...&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">...
&lt;head runat=&quot;server&quot;&gt;
    &lt;meta http-equiv=&quot;Content-Type&quot; content=&quot;text/html; charset=iso-8859-1&quot; /&gt;
    &lt;title&gt;&lt;%= Html.Encode(ViewData[&quot;Title&quot;]) %&gt;&lt;/title&gt;
&lt;/head&gt;
...</pre>
</div>

<p><strong>Strongly typed ViewData: 
    <br /></strong>The dictionary isn&#180;t very great in bigger applications, but you can use a strongly typed ViewData class to send data from the controller to the view. If you take a look at the code behinde file of the viewpage, than you see a partial class which is inherited from ViewPage:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b0d4c0a1-26fd-409c-956d-d70dc9b3f4a8" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span class="keyword">namespace</span><span> ReadYou.WebApp.Views.Home&#160;&#160; </span></span></li>

      <li class=""><span>{&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160; </span><span class="keyword">public</span><span> partial </span><span class="keyword">class</span><span> Index : ViewPage&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160; {&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160; }&#160;&#160; </span></li>

      <li class=""><span>}&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">namespace ReadYou.WebApp.Views.Home
{
    public partial class Index : ViewPage
    {
    }
}</pre>
</div>

<p>You can pass in your own &quot;ViewData&quot; class to the ViewPage&lt;T&gt;:</p>

<p>Index.aspx.cs:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:16d2c25a-102f-4351-a04a-71d7fccc2062" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span class="keyword">namespace</span><span> ReadYou.WebApp.Views.Home&#160;&#160; </span></span></li>

      <li class=""><span>{&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160; </span><span class="keyword">public</span><span>&#160;</span><span class="keyword">class</span><span> IndexViewData&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160; {&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><span class="keyword">public</span><span>&#160;</span><span class="keyword">string</span><span> Text { </span><span class="keyword">get</span><span>; </span><span class="keyword">set</span><span>; }&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160; }&#160;&#160; </span></li>

      <li class="alt"><span>&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160; </span><span class="keyword">public</span><span> partial </span><span class="keyword">class</span><span> Index : ViewPage&lt;IndexViewData&gt;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160; {&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160; }&#160;&#160; </span></li>

      <li class="alt"><span>}&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">namespace ReadYou.WebApp.Views.Home
{
    public class IndexViewData
    {
        public string Text { get; set; }
    }

    public partial class Index : ViewPage&lt;IndexViewData&gt;
    {
    }
}</pre>
</div>

<p>Index.aspx:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:74ea2dce-f8d0-480b-868f-6e42a64c4877" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span>&lt;%@ Page Language=</span><span class="string">&quot;C#&quot;</span><span> MasterPageFile=</span><span class="string">&quot;~/Views/Shared/Site.Master&quot;</span><span> AutoEventWireup=</span><span class="string">&quot;true&quot;</span><span> CodeBehind=</span><span class="string">&quot;Index.aspx.cs&quot;</span><span> Inherits=</span><span class="string">&quot;ReadYou.WebApp.Views.Home.Index&quot;</span><span> %&gt;&#160;&#160; </span></span></li>

      <li class=""><span>&#160; </span></li>

      <li class="alt"><span>&lt;asp:Content ID=</span><span class="string">&quot;indexContent&quot;</span><span> ContentPlaceHolderID=</span><span class="string">&quot;MainContent&quot;</span><span> runat=</span><span class="string">&quot;server&quot;</span><span>&gt;&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160; &lt;h2&gt;&lt;%= Html.Encode(ViewData.Model.Text) %&gt;&lt;/h2&gt;&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160; &lt;p&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; To learn more about ASP.NET MVC visit &lt;a href=</span><span class="string">&quot;http://asp.net/mvc&quot;</span><span> title=</span><span class="string">&quot;ASP.NET MVC Website&quot;</span><span>&gt;http://asp.net/mvc&lt;/a&gt;.&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160; &lt;/p&gt;&#160;&#160; </span></li>

      <li class=""><span>&lt;/asp:Content&gt;&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">&lt;%@ Page Language=&quot;C#&quot; MasterPageFile=&quot;~/Views/Shared/Site.Master&quot; AutoEventWireup=&quot;true&quot; CodeBehind=&quot;Index.aspx.cs&quot; Inherits=&quot;ReadYou.WebApp.Views.Home.Index&quot; %&gt;

&lt;asp:Content ID=&quot;indexContent&quot; ContentPlaceHolderID=&quot;MainContent&quot; runat=&quot;server&quot;&gt;
    &lt;h2&gt;&lt;%= Html.Encode(ViewData.Model.Text) %&gt;&lt;/h2&gt;
    &lt;p&gt;
        To learn more about ASP.NET MVC visit &lt;a href=&quot;http://asp.net/mvc&quot; title=&quot;ASP.NET MVC Website&quot;&gt;http://asp.net/mvc&lt;/a&gt;.
    &lt;/p&gt;
&lt;/asp:Content&gt;</pre>
</div>

<p>HomeController.cs:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5ce3331c-2195-46e8-a8ad-7f8ce787701c" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span class="keyword">public</span><span> ActionResult Index()&#160;&#160; </span></span></li>

      <li class=""><span>{&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160; ViewData[</span><span class="string">&quot;Title&quot;</span><span>] = </span><span class="string">&quot;Home Page&quot;</span><span>;&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160; IndexViewData data = </span><span class="keyword">new</span><span> IndexViewData();&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160; data.Text = </span><span class="string">&quot;Hi strongly typed viewdatat&quot;</span><span>;&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160; ViewData.Model = data;&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160; </span><span class="keyword">return</span><span> View();&#160;&#160; </span></span></li>

      <li class=""><span>}&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">        public ActionResult Index()
        {
            ViewData[&quot;Title&quot;] = &quot;Home Page&quot;;
            IndexViewData data = new IndexViewData();
            data.Text = &quot;Hi strongly typed viewdatat&quot;;
            ViewData.Model = data;
            return View();
        }</pre>
</div>

<p>The benefit of this approach is, that you get a more robust application and have a &quot;contract&quot; between the view and the controller. 
  <br /><u>Warning:</u> The &quot;ViewData[&quot;Title&quot;]&quot; is still in use, because the masterpage needs this data. In the MVC universe the controller is responsible to send all data to the view (there are some ideas how you can create an get an independent control). </p>

<p>You finde more information in this great blogpost of Scott Guthrie (it&#180;s an older one, but the concepts are still in use): 
  <br /><a href="http://weblogs.asp.net/scottgu/archive/2007/12/06/asp-net-mvc-framework-part-3-passing-viewdata-from-controllers-to-views.aspx">ASP.NET MVC Framework (Part 3): Passing ViewData from Controllers to Views</a></p>

<p><strong><u>Communication between the view and the controller</u></strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb301.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="147" alt="image_thumb30" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb30-thumb.png" width="443" border="0" /></a>&#160;</p>

<p>The view talks to the controler via normal HTML links or forms (GET/POST data). 
  <br />The template included some examples:</p>

<p><strong>Option 1: Via GET or the &quot;ActionLink&quot; 
    <br /></strong>If you want to go to the register page, you just click on this link:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image-thumb281.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="132" alt="image_thumb28" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb28-thumb.png" width="454" border="0" /></a></p>

<p>You just use the HTML &quot;ActionLink&quot; helper:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d5c1306b-70b8-4cb0-a9b3-62c5f8d9a11d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span>&lt;p&gt;&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; Please enter your username and password below. If you don't have an account,&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; please &lt;%= Html.ActionLink(</span><span class="string">&quot;register&quot;</span><span>, </span><span class="string">&quot;Register&quot;</span><span>) %&gt;.&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160; &lt;/p&gt;&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">&lt;p&gt;
        Please enter your username and password below. If you don't have an account,
        please &lt;%= Html.ActionLink(&quot;register&quot;, &quot;Register&quot;) %&gt;.
    &lt;/p&gt;</pre>
</div>

<p>The request will be routed to the &quot;Register&quot; action method on the &quot;AccountController&quot;, because this view is inside the &quot;Account&quot;-folder and the second ActionLink parameter contains the name of the specific action method.</p>

<p><strong>Option 2: Via POST</strong></p>

<p>The login mask (username / password) use a standard HTML form:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4b1cf111-4e8a-4e15-a96b-854da3911470" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span>&lt;form method=</span><span class="string">&quot;post&quot;</span><span> action=</span><span class="string">&quot;&lt;%= Html.AttributeEncode(Url.Action(&quot;</span><span>Login</span><span class="string">&quot;)) %&gt;&quot;</span><span>&gt;&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160; &lt;div&gt;&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;table&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;tr&gt;&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;td&gt;Username:&lt;/td&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;td&gt;&lt;%= Html.TextBox(</span><span class="string">&quot;username&quot;</span><span>) %&gt;&lt;/td&gt;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;/tr&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;tr&gt;&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;td&gt;Password:&lt;/td&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;td&gt;&lt;%= Html.Password(</span><span class="string">&quot;password&quot;</span><span>) %&gt;&lt;/td&gt;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;/tr&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;tr&gt;&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;td&gt;&lt;/td&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;td&gt;&lt;input type=</span><span class="string">&quot;checkbox&quot;</span><span> name=</span><span class="string">&quot;rememberMe&quot;</span><span> value=</span><span class="string">&quot;true&quot;</span><span> /&gt; Remember me?&lt;/td&gt;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;/tr&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;tr&gt;&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;td&gt;&lt;/td&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;td&gt;&lt;input type=</span><span class="string">&quot;submit&quot;</span><span> value=</span><span class="string">&quot;Login&quot;</span><span> /&gt;&lt;/td&gt;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;/tr&gt;&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; &lt;/table&gt;&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160; &lt;/div&gt;&#160;&#160; </span></li>

      <li class=""><span>&lt;/form&gt;&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">    &lt;form method=&quot;post&quot; action=&quot;&lt;%= Html.AttributeEncode(Url.Action(&quot;Login&quot;)) %&gt;&quot;&gt;
        &lt;div&gt;
            &lt;table&gt;
                &lt;tr&gt;
                    &lt;td&gt;Username:&lt;/td&gt;
                    &lt;td&gt;&lt;%= Html.TextBox(&quot;username&quot;) %&gt;&lt;/td&gt;
                &lt;/tr&gt;
                &lt;tr&gt;
                    &lt;td&gt;Password:&lt;/td&gt;
                    &lt;td&gt;&lt;%= Html.Password(&quot;password&quot;) %&gt;&lt;/td&gt;
                &lt;/tr&gt;
                &lt;tr&gt;
                    &lt;td&gt;&lt;/td&gt;
                    &lt;td&gt;&lt;input type=&quot;checkbox&quot; name=&quot;rememberMe&quot; value=&quot;true&quot; /&gt; Remember me?&lt;/td&gt;
                &lt;/tr&gt;
                &lt;tr&gt;
                    &lt;td&gt;&lt;/td&gt;
                    &lt;td&gt;&lt;input type=&quot;submit&quot; value=&quot;Login&quot; /&gt;&lt;/td&gt;
                &lt;/tr&gt;
            &lt;/table&gt;
        &lt;/div&gt;
    &lt;/form&gt;</pre>
</div>

<p>The Url.Action Helper create the action URL for the form. The form values will be submitted to the &quot;Login&quot; action method of the &quot;AccountController&quot;, beacuse this view is inside the &quot;Account&quot;-folder.</p>

<p>The source code of the &quot;Login&quot; action method:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b5520bfc-d749-4a9d-ac1c-79c68bee2348" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
  <div class="dp-highlighter">
    <div class="bar">
      <div class="tools"><a onclick="dp.sh.Toolbar.Command(&#39;ViewSource&#39;,this);return false;" href="about:blank#">view plain</a><a onclick="dp.sh.Toolbar.Command(&#39;CopyToClipboard&#39;,this);return false;" href="about:blank#">copy to clipboard</a><a onclick="dp.sh.Toolbar.Command(&#39;PrintSource&#39;,this);return false;" href="about:blank#">print</a><a onclick="dp.sh.Toolbar.Command(&#39;About&#39;,this);return false;" href="about:blank#">?</a></div>
    </div>

    <ol class="dp-c">
      <li class="alt"><span><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><span class="keyword">public</span><span> ActionResult Login(</span><span class="keyword">string</span><span> username, </span><span class="keyword">string</span><span> password, </span><span class="keyword">bool</span><span>? rememberMe)&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; {&#160;&#160; </span></li>

      <li class="alt"><span>&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; ViewData[</span><span class="string">&quot;Title&quot;</span><span>] = </span><span class="string">&quot;Login&quot;</span><span>;&#160;&#160; </span></span></li>

      <li class="alt"><span>&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><span class="comment">// Non-POST requests should just display the Login form&#160; </span><span>&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><span class="keyword">if</span><span> (Request.HttpMethod != </span><span class="string">&quot;POST&quot;</span><span>)&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; {&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><span class="keyword">return</span><span> View();&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; }&#160;&#160; </span></li>

      <li class="alt"><span>&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><span class="comment">// Basic parameter validation </span><span>&#160; </span></span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; List&lt;</span><span class="keyword">string</span><span>&gt; errors = </span><span class="keyword">new</span><span> List&lt;</span><span class="keyword">string</span><span>&gt;();&#160;&#160; </span></span></li>

      <li class=""><span>&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><span class="keyword">if</span><span> (String.IsNullOrEmpty(username))&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; {&#160;&#160; </span></li>

      <li class="alt"><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; errors.Add(</span><span class="string">&quot;You must specify a username.&quot;</span><span>);&#160;&#160; </span></span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; }&#160;&#160; </span></li>

      <li class="alt"><span>...&#160;&#160; </span></li>

      <li class=""><span>&#160;&#160;&#160;&#160;&#160;&#160;&#160; }&#160; </span></li>
    </ol>
  </div>

  <pre class="c#" style="display: none" name="code">        public ActionResult Login(string username, string password, bool? rememberMe)
        {

            ViewData[&quot;Title&quot;] = &quot;Login&quot;;

            // Non-POST requests should just display the Login form 
            if (Request.HttpMethod != &quot;POST&quot;)
            {
                return View();
            }

            // Basic parameter validation
            List&lt;string&gt; errors = new List&lt;string&gt;();

            if (String.IsNullOrEmpty(username))
            {
                errors.Add(&quot;You must specify a username.&quot;);
            }
...
        }</pre>
</div>

<p>The form values are automatically mapped to the method parameters. This mapping could be modified. <a href="http://weblogs.asp.net/stephenwalther/archive/2008/07/11/asp-net-mvc-tip-18-parameterize-the-http-context.aspx">Stephen Walther</a> wrote a nice blogpost about this. And there is a great screencast how the binding in ASP.NET MVC works on <a href="http://www.dimecasts.net/Casts/CastDetails/66">Dimecasts.net</a>.</p>

<p>Many helpers are overloaded and take strongly typed data - just try it out :)</p>

<p><strong><u>&quot;Best Practices&quot;, tips and information 
      <br /></u></strong>The MVC framework is currently a beta version, that&#180;s why you need to search at different blogs or websites to learn more about the framework. Here are my recommendations:</p>

<ul>
  <li><a href="http://weblogs.asp.net/stephenwalther/">Stephen Walthers Blog</a> </li>

  <li><a href="http://blog.wekeroad.com/mvc-storefront/">Rob Conerys MVC Storefront</a> </li>

  <li><a href="http://www.hanselman.com/blog/CategoryView.aspx?category=ASP.NET+MVC">Scott Hanselman</a> </li>

  <li><a href="http://weblogs.asp.net/scottgu/archive/tags/MVC/default.aspx">Scott Guthrie</a> </li>

  <li><a href="http://www.asp.net/mvc/default.aspx?wwwaspnetrdirset=1">ASP.NET MVC Seite</a> </li>

  <li><a href="http://forums.asp.net/1146.aspx">ASP.NET MVC Forum</a> </li>

  <li><a href="http://www.asp.net/learn/mvc-videos/">ASP.NET MVC Videos</a> </li>

  <li><a href="http://www.dotnetkicks.com/tags/MVC">DotNetKicks - MVC</a> </li>
</ul>

<p><strong><u>Feedback 
      <br /></u></strong>Feel free to comment this blogpost (and my english ;) )</p>
