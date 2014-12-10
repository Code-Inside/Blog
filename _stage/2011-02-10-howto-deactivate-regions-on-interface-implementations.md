---
layout: post
title: "HowTo: deactivate #regions on Interface implementations"
date: 2011-02-10 11:47
author: antje.kilian
comments: true
categories: [HowTo]
tags: [regions]
language: en
---
{% include JB/setup %}
<p><b></b></p>  <p>&#160;</p>  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 10px 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="http://code-inside.de/blog/wp-content/uploads/image_thumb350.png" width="244" height="119" />As you already know I´m an adversary of #regions in the source code. If you don´t use the resharper instead of the Visual Studio helpers you will get a "˜region tag around the interface implementations. But, of course, there is a way to turn this off...</p>  <p>&#160;</p>  <!--more-->  <p><b>Scenario:</b></p>  <p>I have a IFoo interface and I want to write a suitable implementation. Visual Studio already shows me, that some actions are possible: </p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f285da67-eacc-4575-bf05-a27314b57a18" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    public interface IFoo
    {
        void Run();
        void Stop();
    }

    public class FooImplementation : IFoo
    {
		...
    }</pre></div>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image121.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb30.png" width="240" height="112" /></a></p>

<p>If you click:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image122.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb31.png" width="240" height="87" /></a></p>

<p>Cool... but you will be disappointed if you see that some #regions are in the code now:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:59a19218-2a6a-4131-99d9-dfa281c24a4d" class="wlWriterEditableSmartContent"><pre name="code" class="c#">view plaincopy to clipboardprint
public class FooImplementation : IFoo   
    {  
        #region IFoo Members   
  
        public void Run()   
        {   
            throw new NotImplementedException();   
        }   
  
        public void Stop()   
        {   
            throw new NotImplementedException();   
        }  
 
        #endregion   
    }  

public class FooImplementation : IFoo
    {
        #region IFoo Members

        public void Run()
        {
            throw new NotImplementedException();
        }

        public void Stop()
        {
            throw new NotImplementedException();
        }

        #endregion
    }</pre></div>

<p><u>So, how to deactivate this:</u></p>

<p><u></u></p>

<p><b>Tools -&gt; Option -&gt; Text Editor -&gt; C# -&gt; Advanced: </b></p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image123.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb32.png" width="507" height="294" /></a></p>

<p>&#160;</p>

<p>Deactivate this Checkbox and then it works without "#region..." <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-smile" alt="Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-smile2.png" /></p>

<p>Resharper it self´s won´t do this stuff but maybe sometimes you accidently click on the assistance of Visual Studio.</p>
