---
layout: post
title: "HowTo: Logging with Log4Net"
date: 2010-10-06 19:37
author: CI Team
comments: true
categories: [HowTo]
tags: [.NET, log4net, logging. c#]
language: en
---
{% include JB/setup %}
<p><img border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb701.png" width="148" height="93" />As soon as the application works your customer will find the first bugs. In this case it is very important to find out what happened and to find the mistake. Because of this it is helpfully to include a logging while you are debugging. </p>
<p><a href="http://logging.apache.org/log4net/download.html">Log4Net</a> is a very classy library which fulfils you every desire and it takes just a few minutes of work.</p> 
  

<p><b>Log4Net</b></p>
<p>Log4Net is a quite practical .Net library which is created to make logging easier. There are several different types of "log steps" (debug, error, info,..) and loggings ("Appender"). So for example it´s possible to log into the Visual Studio Debug Window or in a file and so on. It´s also possible to configure it via XML so you are allowed to create log steps on the productivity system.</p>
<p>You can find a good introduction on the <a href="http://logging.apache.org/log4net/release/manual/introduction.html">homepage of Log4Net.</a> </p>
<p><b>Practical entrance </b></p>  

<p>To show you the whole problem on a very easy way I´m going to create a consol program and integrate Log4net DLL. <a href="http://logging.apache.org/log4net/download.html">Here</a> you will find the "log4net.dll"</p>  

<p>&#160;<img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb702.png" width="244" height="191" /></p>
<p>&#160;<b>Configuration of Log4Net</b></p>  <p align="left">The easiest way to configure Log4Net is to use App/Web.Config. Therefore we need to create an "App.config" file: </p>  
  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:62c5b207-e515-4818-82fb-9691775b938e" class="wlWriterEditableSmartContent"><pre name="code" class="xml">&lt;?xml version="1.0" encoding="utf-8" ?&gt;
&lt;configuration&gt;
  &lt;configSections&gt;
    &lt;section name="log4net" type="log4net.Config.Log4NetConfigurationSectionHandler, log4net"/&gt;
  &lt;/configSections&gt;
  &lt;log4net&gt;
    &lt;appender name="DebugAppender" type="log4net.Appender.DebugAppender" &gt;
      &lt;layout type="log4net.Layout.PatternLayout"&gt;
        &lt;conversionPattern value="%date [%thread] %-5level %logger [%property{NDC}] - %message%newline" /&gt;
      &lt;/layout&gt;
    &lt;/appender&gt;
    &lt;appender name="ConsoleAppender" type="log4net.Appender.ConsoleAppender"&gt;
      &lt;layout type="log4net.Layout.PatternLayout"&gt;
        &lt;conversionPattern value="%date [%thread] %-5level %logger [%property{NDC}] - %message%newline" /&gt;
      &lt;/layout&gt;
    &lt;/appender&gt;
    &lt;root&gt;
      &lt;level value="All" /&gt;
      &lt;appender-ref ref="DebugAppender" /&gt;
      &lt;appender-ref ref="ConsoleAppender" /&gt;
    &lt;/root&gt;
  &lt;/log4net&gt;
&lt;/configuration&gt;</pre></div>




<p>Explication:</p>

<p>We define us our own ConfigSections, so it´s possible to control everything central.</p>

<p>In this log4net-section we are going to use the different types of "Appender". Depending on the Appender there are several ways to log. For example the "ConsoleAppender" logs on the commando line and the "DebugAppender" on the Visual Studio Output Window. Other types of Appender you will find here: Config Examples.</p>

<p>In every Appender it´s possible to guideline the layout so you can adapt the Log Message. </p>

<p>In the last step we chose the level which should be logged - for our example everything, and we are going to use the two appenders.</p>

<p><b>"Logging Code" </b></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:40fbe398-29b7-4258-9310-4c0aa7000dc0" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    class Program
    {
        static void Main(string[] args)
        {
            log4net.Config.XmlConfigurator.Configure();
            ILog logger = LogManager.GetLogger(typeof (Program));

            logger.Debug("Hello World!");
            logger.Error("DÂ´oh!");

            Console.ReadLine();
        }
    }</pre></div>

<p>In Line 5 we dispose Log4Net to check the XML config and than we get our Logger. The Logger has a method for every "Log Level".</p>

<p><img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb703.png" width="221" height="209" /></p>

<p><b>Conclusion: </b></p>

<p>If I´m going to run the application now there is following Output on the console: <img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb704.png" width="487" height="60" /></p>

<p>And on the Output Window in Visual Studio: </p>

<p><img border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb705.png" width="509" height="92" /></p>

<p><b>Where exactly should I log? </b></p>

<p>I didn´t find any general rules but you should keep in mind that the sense of logging is to localise mistakes. So for example you could logout the parameter or "important calls from other services" and the output. With this it´s easier for you to get a feeling for the Code. </p>

<p>Especially with the "DebugAppender" it´s kind of funny if you press a button and you can see how the request walks to the levels and logg out the values. Nerd paradise. J</p>







<p><strong><a href="{{BASE_PATH}}/assets/files/democode/log4netintro/log4netintro.zip">[ Download Democode ]</a></strong></p>
