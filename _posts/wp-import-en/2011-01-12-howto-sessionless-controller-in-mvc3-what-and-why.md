---
layout: post
title: "HowTo: Sessionless Controller in MVC3 – what & and why?"
date: 2011-01-12 14:57
author: CI Team
comments: true
categories: [HowTo]
tags: [MVC3, Sessionless Controller]
language: en
---
{% include JB/setup %}
<p>&#160;</p>  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb316.png" width="184" height="96" />At the moment I play with <a href="http://www.microsoft.com/downloads/en/details.aspx?FamilyID=a920ccee-1397-4feb-824a-2dfefee47d54">MVC3 RC</a>. A new feature which is the introduction of a <a href="http://www.lostechies.com/blogs/dahlbyk/archive/2010/12/06/renderaction-with-asp-net-mvc-3-sessionless-controllers.aspx?utm_source=feedburner&amp;utm_medium=feed&amp;utm_campaign=Feed:+LosTechies+(LosTechies)&amp;utm_content=Google+International">SessionState Behavior</a> to, for example, make a controller state-, and sessionless. Unfortunately there wasn´t a really advertising.</p>  <p>How it works, what to keep in mind and why you should use it? Go on reading <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile8.png" /></p>  <!--more-->  <p><b>Sessionless? My demo application</b></p>  <p><b></b></p>  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb317.png" width="234" height="339" />My demo application consists of two controllers. One of them is "sessionless". Also we have to views for the assignment. Beside the MVC App is an "Empty Website" (except the routing, which is usually leading to the SessionController).</p>  <p>   <br />    <br />    <br />    <br /></p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:61f0a4b9-6475-45c7-8c46-51fa5d5287f7" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    [ControllerSessionState(SessionStateBehavior.Default)]
    public class SessionController : Controller
    {
        //
        // GET: /Session/

        public ActionResult Index()
        {
            Thread.Sleep(1000);
            ViewModel.Session = this.ControllerContext.HttpContext.Session.SessionID;
            return View(ViewModel);
        }

    }</pre></div>

<p>We are interested in the ControllerSessionState Attribute (Beware: I´ve heard that this will be renamed in the final so you need to look for it again <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile8.png" />)</p>

<p>Through the attribute controller-state you are able to access the Sessionstates:</p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb318.png" width="340" height="193" /></p>

<p>If you want to turn it off totally than choose "disable". Afterwards the session will be "zero". </p>

<p><b>What things should I keep in mind?</b></p>

<p><b></b></p>

<p>On the first few: You can´t access the Session. That means, for example, for recognizing the user you use the FormsAuth Cookie and so on. As soon if you try to write something into the "TempData" <a href="http://www.dotnetcurry.com/ShowArticle.aspx?ID=609&amp;AspxAutoDetectCookieSupport=1">you are going to receive an Exception</a> "The SessionStateTempDataProvider class requires session state to be enabled". If you try to move a file from controller A to controller B you need a cookie. But there is a CookieStateTempDataProvider used to be in the new MVC Futures. </p>

<p><b></b></p>

<p><b>Why should I use this?</b></p>

<p><b></b></p>

<p>Nice question. I found a nice declaration in a <a href="http://stackoverflow.com/questions/4139428/what-are-some-scenarios-of-having-a-session-less-controller-in-asp-net-mv3">Stackoverflow</a> Post:</p>

<p><i></i></p>

<p><i>The release notes cover this more (you can download them from the download link above). Session state is designed so that only one request from a particular user/session occurs at a time. So if you have a page that has multiple AJAX callbacks happening at once they will be processed in serial fashion on the server. Going session-less means that they would execute in parallel.</i></p>

<p>Here is another declaration: <a href="http://weblogs.asp.net/imranbaloch/archive/2010/07/10/concurrent-requests-in-asp-net-mvc.aspx">Concurrent Requests in ASP.NET MVC</a></p>

<p><b></b></p>

<p><b>Is there a consequence for the performance? </b></p>

<p><b></b></p>

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb319.png" width="244" height="105" />I´ve done some experiments with Visual Studio 2010 Test Tools and I tried to run a WebPerformances Test in the controller without the Thread.Sleep with 1000 iterations on sessionless and on the "normal" controller. </p>

<p><u>Beware: I´ve never tested something with WebTest Tools from Visual Studio 2010 Test Tools. Because of this it´s possible that my results are wrong. </u></p>

<p>The test runs on my Macbook in a VM. The WebApp is hosted in IIS7 - because of this the results aren´t significant for any performance stories of an IIS. </p>

<p>Results for 1000 repeats (open the site a 1000 times) and NO Thread.Sleep:</p>

<p>Try SessionLess (time in sec.) Session (time in sec.)</p>

<p>1&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 5,70&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 6,17</p>

<p>2&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 5,15&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 6,21</p>

<p>3&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 5,28&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 5,15</p>

<p>4&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 5,16&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 6,74</p>

<p>5&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 5,13&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 5,54</p>

<p>6&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 6,68&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 5,50</p>

<p>7&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 5,12&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 5,17</p>

<p>8&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 5,30&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 5,66</p>

<p>9&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 6,28&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 5,30</p>

<p>10&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 4,98&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 5,27</p>

<p>On both sites there are some bolters but all in all we can see, that the Sessionless Controller is a bit faster. </p>

<p>I´ve done another test ( a so called "LoadTest") with equal results. By the way: Really interesting tool, I´m sure it´s worth to take a look on it later on. But enough for now. </p>

<p><b>Result</b></p>

<p><b></b></p>

<p>In view of "big" web applications and scalability this could be an interesting subject for you. But if we talk about a usually site I´m sure you can live without this. To put something into a session is sometimes very comfortable and nice for some applications like for example wizard. That´s what I think about but maybe I´m wrong <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile8.png" /></p>

<p><a href="{{BASE_PATH}}/assets/files/democode/mvcsessionless/mvcsessionless.zip">[Download Sample]</a> (Beware: Maybe you will need a higher version of Visual Studio to run the Test project) </p>
