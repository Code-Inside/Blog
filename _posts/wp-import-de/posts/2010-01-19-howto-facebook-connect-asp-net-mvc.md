---
layout: post
title: "HowTo: Facebook Connect & ASP.NET MVC"
date: 2010-01-19 01:19
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, Facebook, Facebook Connect, HowTo]
language: de
---
{% include JB/setup %}
<a href="{{BASE_PATH}}/assets/wp-images-de/image890.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="70" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb75.png" width="180" align="left" border="0"></a>  <p>Facebook bietet einen netten Dienst namens "<a href="http://developers.facebook.com/connect.php">Facebook Connect"</a> an. Damit können sich Facebook User sich mit ihren Facebook Login an deiner Seite anmelden - alles gesichert durch Facebook. Im Prinzip ähnelt es <a href="{{BASE_PATH}}/2010/01/04/howto-openid-authentifizierung-und-asp-net-mvc/">OpenID</a>, bietet allerdings neben der puren Authentifizierung auch noch mehr. Hier geht es aber erstmal nur um die Authentifizierung.</p><p><strong>Was bringt einem das?</strong></p> <p>Um nochmal kurz das "Warum" aufzugreifen: Wenn man etwas tolles gebaut hat, User sich aber erst dafür anmelden müssen (mit Email + Passwort) stellt das eine größere Hürde dar als einmal auf den Facebook Connect Button zu klicken. Vorausgesetzt natürlich die Leute haben ein Facebook Konto ;)</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image891.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="41" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb76.png" width="187" border="0"></a> </p> <p><strong>Was benötige ich?</strong></p> <ul> <li>Einen eigenen Facebook Login</li> <li>Einen API Schlüssel (siehe Registrierung)</li> <li>Am besten noch irgendeine Bibliothek die mir den schwereren REST Part abnimmt</li> <li>Etwa 10 Minuten Zeit bis der erste Erfolg sichtbar ist</li></ul> <p><strong>Schritt 1: Facebook Login besorgen</strong></p> <p>Einfach <a href="http://www.facebook.com/">da</a> registrieren.</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image892.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="187" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb77.png" width="244" border="0"></a> </p> <p><strong>So, dass war einfach ;)</strong></p> <p><strong>Schritt 2: Sich für Facebook Connect / Facebook Development anmelden</strong></p> <p>Ganz unten bei Facebook findest du die <a href="http://developers.facebook.com/?ref=pf">Entwickler Page</a>:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image893.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="64" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb78.png" width="173" border="0"></a> </p> <p>Dort erstellst du eine Anwendung:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image894.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="53" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb79.png" width="240" border="0"></a> </p> <p>Dort gibst du einen Namen und eine URL ein:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image895.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="220" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb80.png" width="451" border="0"></a> </p> <p><strong><u>Wichtig für die Entwicklung: Localhost</u></strong></p> <p>Die Facebook API Keys sind auf eine URL gemappt. D.h. man sollte den Port im Visual Studio entsprecht für den Webserver festsetzen (in meinem Beispiel 55555) oder <a href="{{BASE_PATH}}/2009/03/19/howto-iis7-als-development-server-im-visual-studio-2008-einrichten/">gleich den IIS nehmen</a>. Besonders mit Localhost gibt es dann gleich noch was zu beachten, ansonsten funktioniert es nämlich nicht.</p> <p>Den 2. Schritt ignorierst du - das kommt später zum Tragen.</p> <p>Hier sind nun die beiden <strong>wichtigen API Keys</strong>:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image896.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="105" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb81.png" width="489" border="0"></a> </p> <p>Die Anwendung siehst du jetzt auch in deinem "<a href="http://www.facebook.com/developers/apps.php">Entwickler Armaturenbrett</a>"</p> <p>Genau dahin müssen wir jetzt auch gehen. Dort findest du alle deine erstellten Anwendungen. Bei der Registrierung für den Facebook Connect Dienst legt Facebook auch automatisch eine "Base Domain" ein. Das ist nützlich wenn man in der Produktivumgebung mehere Domains benutzt, aber in der Entwicklung unter Localhost funktionier das nicht! Daher bearbeiten wir die Anwendung:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image897.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="375" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb82.png" width="480" border="0"></a></p> <p>Und löscht im Connect Tab die Base Domain:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image898.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="194" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb83.png" width="588" border="0"></a> </p> <p>Jetzt sind wir bereit zum Entwickeln....<br>Nebenbei erwähnt: Der Kampf mit der Base Domain dauerte bei mir ca. 4 Nächte ;)</p> <p><strong>Schritt 3: ASP.NET MVC Projekt anlegen</strong></p> <p>Wir legen ein frisches ASP.NET MVC Projekt an...</p> <p><strong>Schritt 4: Facebook Developer Toolkit</strong></p> <p>Das <a href="http://www.codeplex.com/FacebookToolkit">Facebook Developer Toolkit</a> ist ein .NET Open Source Wrapper um die REST APIs von Facebook. Microsoft selbst <a href="http://msdn.microsoft.com/en-us/windows/ee388574.aspx">supportet dies</a>. Es gibt vermutlich noch andere .NET APIs für Facebook, aber die ist erstmal die "nahliegendste".</p> <p>Die <a href="http://facebooktoolkit.codeplex.com/Release/ProjectReleases.aspx?ReleaseId=35534#DownloadId=91366">SDK Binaries</a> sind das was wir brauchen.</p> <p>So sollte jetzt unser Projekt aussehen:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image899.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb84.png" width="213" align="left" border="0"></a> </p> <p>&nbsp;</p> <p>&nbsp;</p> <p>Die 3 Facebook.dlls sollten natürlich noch referenziert werden.</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p><strong>Schritt 5: Facebook API Key + Facebook API Secret in der .config</strong></p> <p>Ich lege die beiden Keys in der Web.config ab:</p> <p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9ea6d147-5943-4d66-8258-3fae23203df5" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">  &lt;appSettings&gt;
    &lt;add key="Facebook_API_Key" value="462ab423fdc4d27XXXXXXX6a085af" /&gt;
    &lt;add key="Facebook_API_Secret" value="641ca675f280XXXXXXXXded099"/&gt;
  &lt;/appSettings&gt;</pre></div></p>
<p><strong>Schritt 6: Masterpage vorbereiten</strong></p>
<p>In der Masterpage wird ein Facebook Javascript eingebunden sowie die "init" Funktion mit dem Facebook API Key aufgerufen und ich verweise auf eine "XdReceiver" Datei die später noch eine wichtige Rolle spielt.</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:99e768c7-7d99-4f8e-9b14-6f54e7381868" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;script src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php/de_DE" type="text/javascript"&gt;&lt;/script&gt;
    &lt;script type="text/javascript"&gt;FB.init("&lt;%this.Writer.Write(ConfigurationManager.AppSettings["Facebook_API_Key"]); %&gt;","XdReceiver");&lt;/script&gt;
    </pre></div>
<p><strong>Schritt 7: Den "Facebook Login" Button auf dem Home/Index View einbauen</strong></p>
<p>Facebook hat sich ein eigenes <a href="http://wiki.developers.facebook.com/index.php/FBML">Markup (FBML)</a> für Buttons, Bilder etc. gebaut. Der Loginbutton ist z.B. so gemacht:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:3be7b66a-2c1e-426c-bb27-399ca51e415f" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;p&gt;
        &lt;fb:login-button v="2" size="medium" onlogin="window.location.reload(true);"&gt;Mit Facebook anmelden&lt;/fb:login-button&gt;
    &lt;/p&gt;</pre></div>
<p>Damit das HTML valide bleibt sollte man auch den XML Namespace im HTML (in der Masterpage) einbinden:</p>
<p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ee1b8a94-1130-40af-a558-59ada6bf608e" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml"&gt;</pre></div></p>
<p>Wem dieses Markup nicht zusagt, der kann auch <a href="http://wiki.developers.facebook.com/index.php/Facebook_Connect_Login_Buttons">normales HTML</a> nutzen.</p>
<p><strong>Schritt 8: Die XdReceiver Datei</strong></p>
<p>Diese Datei wollte uns Facebook bereits bei der Registrierung anbieten. Über diese Datei kann man <a href="http://wiki.developers.facebook.com/index.php/Cross_Domain_Communication_Channel">via AJAX auf Facebook</a> zugreifen.</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e9b5ed4e-462c-4c52-be1e-e95f5775e29d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;
&lt;html xmlns="http://www.w3.org/1999/xhtml"&gt;
    &lt;body&gt;
        &lt;script src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/XdCommReceiver.js" type="text/javascript"&gt;&lt;/script&gt;
    &lt;/body&gt;
&lt;/html&gt;</pre></div>
<p>Diese "XdReceiver" Datei habe ich mit in den "Home" Ordner gelegt und im HomeController habe ich auch eine "XdReceiver" Action angelegt um den View zu rendern.</p>
<p>Zusätzlich habe ich noch eine extra "Facebook" Route in der Global.asx angelegt. Wenn ein User sich auf deiner Seite via Facebook erfolgreich anmeldet, wird er per Default auf die "DOMAIN/XdReceicer" weitergeleitet. Daher habe ich noch diese Route hinzugefügt:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:549ea7e0-47da-43ce-946e-ea8e604f44b0" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            routes.MapRoute("Facebook",
                            "XdReceiver",
                            new {controller = "Home", action = "XdReceiver"});
</pre></div>
<p><strong>Schritt 9: Der Home Controller</strong></p>
<p>Der letzte Schritt ist im Homecontroller zu prüfen ob der User angemeldet ist oder nicht:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a7fdb126-c0d2-43b2-bb3f-a707718777bb" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public ActionResult Index()
        {
            ConnectSession session = new ConnectSession(ConfigurationManager.AppSettings["Facebook_API_Key"], ConfigurationManager.AppSettings["Facebook_API_Secret"]);
            if(session.IsConnected())
            {
                Api facebook = new Api(session);

                ViewData["Message"] = "Hello, " + facebook.Users.GetInfo().name;
            }
            else
            {
                ViewData["Message"] = "Login with Facebook!";
            }

            return View();
        }</pre></div>
<p>Wenn der User nun bereits bei Facebook angemeldet ist, wird der Name ausgelesen. Andernfalls wird ein "Login with Facebook!" dargestellt.</p>
<p><strong>Resultat:</strong></p>
<p>Nicht angemeldet:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image900.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="166" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb85.png" width="389" border="0"></a> </p>
<p>*klick*</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image901.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="255" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb86.png" width="432" border="0"></a> </p>
<p>*connect*</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image902.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="127" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb87.png" width="244" border="0"></a> </p>
<p>Alles in allem dauert es nicht lange und die Facebook Leute haben sich auch schon etwas bei ihrer API gedacht (bis auf die Base Domain... sobald man die einträgt funktioniert es nicht mehr mit localhost ;))</p>
<p><strong>Weitere Resourcen:</strong></p>
<ul>
<li><a href="http://wiki.developers.facebook.com/index.php/Facebook_Connect_Tutorial1">Facebook Connect Tutorial1 von Facebook</a></li>
<li><a href="http://www.beefycode.com/post/Facebook-Connect-Action-Filter-for-ASPNET-MVC.aspx">Facebook Connect Action Filter for ASP.NET MVC</a></li>
<li><a href="http://www.rjygraham.com/archive/2009/11/22/using-facebook-connect-with-aspnet-mvc-and-the-facebook-developer-toolkit-3.aspx">Using Facebook Connect with ASP.NET MVC and the Facebook Developer Toolkit 3</a></li></ul>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvcfacebookconnect/mvcfacebookconnect.zip">[Download Source Code]</a></strong></p>
