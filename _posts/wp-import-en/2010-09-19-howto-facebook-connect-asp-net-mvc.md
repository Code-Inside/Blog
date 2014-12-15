---
layout: post
title: "HowTo: Facebook Connect & ASP.NET MVC"
date: 2010-09-19 14:52
author: CI Team
comments: true
categories: [Uncategorized]
tags: [ASP.NET MVC, Facebook, Facebook Connect, HowTo]
language: en
---
{% include JB/setup %}
<p>Because if you spend a lot of time into building something stunning and you want other people in public to see this than it´s much easier for them to login with their already created Facebook login files than to register again on your site and remember another keyword.</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image891.png"><img style="border-right-width: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb76.png" width="187" height="41" /></a></p>

<p><b>You convinced me. What do I need?</b></p>

<ul>   <li>your own Facebook account</li>    <li>an API key (look at the registration)</li>    <li>in best case a library which will do most of the serious work</li>    <li>10 minutes of time</li> </ul>  <ul></ul>  <p><b>First step: get a Facebook account</b></p>
<p>Just register yourself <a href="http://www.facebook.com" target="_blank">here</a>.</p>  

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image892.png"><img style="border-right-width: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb77.png" width="244" height="187" /></a></p>
<p>Not as hard as you thought, hum? ;)</p>

<p><b>Second step: register for the Facebook Connect / Facebook Development Account</b></p>

<p>At the <a href="http://developers.facebook.com/?ref=pf" target="_blank">bottom of the Facebook page</a> you will found a link named "developer". Here you need to create an application. Than you need to enter a name and a URL.</p>  

<p><strong><u>Important for development: Localhost</u></strong></p>

<p>The API keys of Facebook are mapped on a URL. In conclusion you need to fix the port in visual studio according to the web server (In my example it is 55555) or you use the IIS.</p>

<p>Especially with localhost there is another thing to beware if you want it to work:</p>  

<p>Ignore the second step. I´m going to talk about this later. </p> 

<p>Here are the two most<strong> important API keys:</strong></p> 

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image896.png"><img style="border-right-width: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb81.png" width="489" height="105" /></a></p>
<p>Now you are able to see your application on the "<a href="http://www.facebook.com/developers/apps.php" target="_blank">Developer dashboard</a>". </p>
<p>That´s exactly where we have to go now. Here you will find all your former created applications. During the registration for the Connect service Facebook creates a "Base Domain" for you. That´s very useful if you are planning to use many different domains but it will not work with local host. So we need to edit the application:</p>  

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image897.png"><img style="border-right-width: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb82.png" width="480" height="375" /></a></p>  

<p>Please delete the base domain in the connect tab.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image898.png"><img style="border-right-width: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb83.png" width="588" height="194" /></a></p> 

<p>Now we are ready for developing. By the way, the fight with the base domain costs me 4 entire nights ;) </p>  

<p><b>Step 3: create an ASP.NET MVC Project</b></p>  

<p>Create a new ASP.NET MVC Project...</p>
<p><b>Step 4: Facebook Developer Toolkit </b></p>

<p>The <a href="http://www.codeplex.com/FacebookToolkit">Facebook Developer Toolkit</a> is a .NET OpenSource wrapper around the REST APIs from Facebook. Microsoft <a href="http://msdn.microsoft.com/en-us/windows/ee388574.aspx">supports this.</a> Unfortunately there are several other .NET APIs but for now this is the easiest way. </p> 

<p>We need the <a href="http://facebooktoolkit.codeplex.com/Release/ProjectReleases.aspx?ReleaseId=35534#DownloadId=91366">SDK Binaries</a> . </p>
<p>Now our project should look like this:</p> 

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image899.png"><img style="border-right-width: 0px; margin: 0px 10px 0px 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb84.png" width="213" height="244" /></a></p>  

<p>Of course we need to reference the 3 Facebook .DLLs. </p>

<p><b>Step 5: Facebook API Key + Facebook API Secret in .config</b></p>  

<p>I add both the keys to the web.config.</p> 

<pre class="c#" name="code">
&lt;appSettings&gt;
    &lt;add key=&quot;Facebook_API_Key&quot; value=&quot;462ab423fdc4d27XXXXXXX6a085af&quot; /&gt;
    &lt;add key=&quot;Facebook_API_Secret&quot; value=&quot;641ca675f280XXXXXXXXded099&quot;/&gt;
  &lt;/appSettings&gt;
</pre>


<p><b>Step 6: prepare the Masterpage</b></p>

<p>Now you have to include a Facebook Javascript into the Masterpage. After that you open the "init" Function with the API key and I refer to an "xdReceiver" file which will play an important role later. </p>


<pre class="c#" name="code">
&lt;script src=&quot;http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php/de_DE&quot; type=&quot;text/javascript&quot;&gt;&lt;/script&gt;
    &lt;script type=&quot;text/javascript&quot;&gt;FB.init(&quot;&lt;%this.Writer.Write(ConfigurationManager.AppSettings[&quot;Facebook_API_Key&quot;]); %&gt;&quot;,&quot;XdReceiver&quot;);&lt;/script&gt;
</pre>

<p><b>Step 7: include the Facebook Login Button into the Home/Index View</b></p>


<p>The People of Facebook created their own <a href="http://wiki.developers.facebook.com/index.php/FBML">Markup (FBML)</a> for Buttons, Pictures and so on. For example the Login Button looks like this:</p>


<pre class="c#" name="code">
&lt;p&gt;
        &lt;fb:login-button v=&quot;2&quot; size=&quot;medium&quot; onlogin=&quot;window.location.reload(true);&quot;&gt;Mit Facebook anmelden&lt;/fb:login-button&gt;
    &lt;/p&gt;
</pre>

<p>To keep the HTML valid you have to integrate the XML Namespace as well</p>

<pre class="c#" name="code">
&lt;html xmlns=&quot;http://www.w3.org/1999/xhtml&quot; xmlns:fb=&quot;http://www.facebook.com/2008/fbml&quot;&gt;
</pre>

<p><b>Step 8: the XdReceiver file</b></p>

<p>That´s the file facebook already offer to us during the registration. With this file you are aloud to connect <a href="http://wiki.developers.facebook.com/index.php/Cross_Domain_Communication_Channel">via AJAX to Facebook</a>.</p>

<pre class="c#" name="code">
&lt;%@ Page Language=&quot;C#&quot; Inherits=&quot;System.Web.Mvc.ViewPage&quot; %&gt;
&lt;!DOCTYPE html PUBLIC &quot;-//W3C//DTD XHTML 1.0 Strict//EN&quot; &quot;http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd&quot;&gt;
&lt;html xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;
    &lt;body&gt;
        &lt;script src=&quot;http://static.ak.connect.facebook.com/js/api_lib/v0.4/XdCommReceiver.js&quot; type=&quot;text/javascript&quot;&gt;&lt;/script&gt;
    &lt;/body&gt;
&lt;/html&gt;
</pre>

<p>I stored this xdReceiver file into the home folder and I also created an xdReceiver action to render the view.</p>

<p>Additionally I created a "Facebook" route into Global.asx. If a User registered successfully via facebook on your homepage he will automatically send up to "Domain/xdReceiver" via DEFAULT</p>

<pre class="c#" name="code">
routes.MapRoute(&quot;Facebook&quot;,
                            &quot;XdReceiver&quot;,
                            new {controller = &quot;Home&quot;, action = &quot;XdReceiver&quot;});
</pre>

<p><b>Step 9: the Homecontroler </b></p>

<p>The last step is to control if the user is signed in successfully ore not. </p>


<pre class="c#" name="code">
public ActionResult Index()
        {
            ConnectSession session = new ConnectSession(ConfigurationManager.AppSettings[&quot;Facebook_API_Key&quot;], ConfigurationManager.AppSettings[&quot;Facebook_API_Secret&quot;]);
            if(session.IsConnected())
            {
                Api facebook = new Api(session);

                ViewData[&quot;Message&quot;] = &quot;Hello, &quot; + facebook.Users.GetInfo().name;
            }
            else
            {
                ViewData[&quot;Message&quot;] = &quot;Login with Facebook!&quot;;
            }

            return View();
        }
</pre>

<p>If the user is already signed in with facebook his username will be shown. Otherwise the "Log in with facebook" sign will appear. </p>

<p><strong>Result:</strong></p>

<p>start Login...</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image900.png"><img style="border-right-width: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb85.png" width="389" height="166" /></a></p>

<p>*click*</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image901.png"><img style="border-right-width: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb86.png" width="432" height="255" /></a></p>

<p>*connect*</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image902.png"><img style="border-right-width: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb87.png" width="244" height="127" /></a></p>

<p>All in all it doesn´t take a lot of your time and the developer of facebook did a great job with their API. (excluded the base domain ... if you enter this, local host won´t work) </p>

<p><strong>More Links:</strong></p>

<ul>
  <li><a href="http://wiki.developers.facebook.com/index.php/Facebook_Connect_Tutorial1">Facebook Connect Tutorial1 von Facebook</a> </li>

  <li><a href="http://www.beefycode.com/post/Facebook-Connect-Action-Filter-for-ASPNET-MVC.aspx">Facebook Connect Action Filter for ASP.NET MVC</a> </li>

  <li><a href="http://www.rjygraham.com/archive/2009/11/22/using-facebook-connect-with-aspnet-mvc-and-the-facebook-developer-toolkit-3.aspx">Using Facebook Connect with ASP.NET MVC and the Facebook Developer Toolkit 3</a> </li>
</ul>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvcfacebookconnect/mvcfacebookconnect.zip">[Download Source Code]</a></strong></p>
