---
layout: post
title: "HowTo: #regions bei Interface Implementierungen deaktiveren"
date: 2011-01-23 21:12
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, region, Visual Studio]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1168.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb350.png" width="244" height="119" /></a> </p>  <p>Ich bin ein <a href="{{BASE_PATH}}/2010/09/08/region-failcode/">bekennender Gegner von #regions im Source Code</a>. Wenn man aber kein Resharper benutzt, sondern die von Visual Studio bekannten Helferlein, dann bekommt man bei Interface Implementierungen immer den #region Tag drumherum. Das kann man natürlich auch abstellen...</p>  <p><strong>Szenario:</strong></p>  <p>Ich hab ein IFoo Interface und möchte nun eine passende Implementation davon schreiben. Visual Studio zeigt mir mit dem Unterstrich bereits an, dass man irgendwelche Aktionen auslösen kann:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:94a77c08-6acc-42d4-a331-0ddacd3598a7" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    public interface IFoo
    {
        void Run();
        void Stop();
    }

    public class FooImplementation : IFoo
    {
		...
    }</pre></div>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1169.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb351.png" width="244" height="114" /></a> </p>

<p>Bei Klick:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1170.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb352.png" width="244" height="88" /></a> </p>

<p>Eigentlich toll... nachdem man nun dort drauf klickt, ärgert man sich erst einmal, weil #regions im Code sind:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a3284198-1452-4313-9ea9-1fa7397730f2" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public class FooImplementation : IFoo
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

<p><strong><u>Um das zu deaktiveren:</u></strong></p>

<p><strong>Tools -&gt; Option -&gt; Text Editor -&gt; C# -&gt; Advanced:</strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1171.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb353.png" width="478" height="276" /></a> </p>

<p>Diese Checkbox deaktivieren und dann klappts auch ohne "#region...” :)</p>

<p>Resharper selbst macht den Blödsinn nicht, aber ab und an klickt man vielleicht versehentlich auf die Unterstützung von Visual Studio.</p>
