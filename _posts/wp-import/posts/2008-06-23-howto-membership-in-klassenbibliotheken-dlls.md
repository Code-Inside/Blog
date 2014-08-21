---
layout: post
title: "HowTo: Membership in Klassenbibliotheken / DLLs"
date: 2008-06-23 22:09
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Membership, Security]
---
{% include JB/setup %}
<p>In diesem <a href="{{BASE_PATH}}/2008/02/07/howto-aspnet-membership-roles-profiles-einrichten-rollensystem-allgemeines-demoprojekt/">HowTo</a> habe ich das <a href="http://msdn.microsoft.com/en-us/library/yh26yfzy.aspx">ASP.NET Membership System</a> mal kurz vorstellt. Ich hab in einem Projekt nun das Membership System eingesetzt und auch seine großen Schattenseiten kennengelernt.</p> <p><strong>Der erste große Kritikpunkt:</strong><br>Da entwirft man eine <a href="http://de.wikipedia.org/wiki/Schichtenmodell">3-Tier Architektur</a> und am Ende hängt einer der wichtigsten Teile (das Usersystem) mit in der WebApp - das ist mehr als unschön.</p> <p><strong>Mein Wunsch:</strong> Das Usersystem soll mit im Backend verschwinden.<br>Eine grobe Skizze (wobei man den "Service" noch in andere Schichten unterteilen kann):</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image471.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="128" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb450.png" width="296" border="0"></a> <br>Die "App.Config" sollte den ConnectionString speichern und auch die Membership-Konfiguration übernehmen.<br>Ich sage hier bewusst "sollte", da ich es leider nicht ganz so perfekt hinbekommen hab.</p> <p>Allerdings erst mal Schritt für Schritt: Das Membership-System muss in eine DLL rein.</p> <p><strong>Grundsätzlicher Aufbau:</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image472.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="305" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb451.png" width="173" border="0"></a> </p> <ul> <li>"<strong>DllMembership.Lib"</strong> ist unser Service in dem wir unseren "MembershipService" haben.</li> <li>"<strong>DllMembership.Web</strong>" ist eine gewöhnliche ASP.NET Website.</li> <li>"<strong>DllMembership.Test</strong>" ist unser UnitTest-Projekt</li></ul> <p><strong>Schritt 1: Membership-System in der DLL Konfigurieren</strong></p> <p>Als erstes müssen wir in der App.Config folgende Konfiguration erstellen:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c3b766e2-1287-454f-a9e7-a5b06c121736" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-8" ?&gt;
&lt;configuration&gt;
  &lt;connectionStrings&gt;
    &lt;add name="ASPNETDBConnectionString" connectionString="Data Source=.\SQLEXPRESS;AttachDbFilename='C:\Users\rmu\Documents\Visual Studio 2008\Projects\Blogposts\DllMembership\DllMembership.Lib\DB\ASPNETDB.MDF';Integrated Security=True;User Instance=True"
     providerName="System.Data.SqlClient" /&gt;
  &lt;/connectionStrings&gt;
  &lt;system.web&gt;
    &lt;membership&gt;
      &lt;providers&gt;
        &lt;remove name="AspNetSqlMembershipProvider"/&gt;
        &lt;add name="AspNetSqlMembershipProvider"
             type="System.Web.Security.SqlMembershipProvider, System.Web, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
             connectionStringName="ASPNETDBConnectionString"
             enablePasswordRetrieval="false"
             enablePasswordReset="true"
             requiresQuestionAndAnswer="false"
             applicationName="/"
             requiresUniqueEmail="true"
             passwordFormat="Hashed"
             maxInvalidPasswordAttempts="12"
             minRequiredPasswordLength="1"
             minRequiredNonalphanumericCharacters="0"
             passwordAttemptWindow="10"
             passwordStrengthRegularExpression="" /&gt;
      &lt;/providers&gt;
    &lt;/membership&gt;
  &lt;/system.web&gt;
&lt;/configuration&gt;</pre></div>
<p>Die Data Source muss natürlich entsprechend des DB Speicherortes ausgewechselt werden.<br><strong><u>Wichtiger Hinweise:</u></strong> Ich verwende dieselbe DB wie aus dem <a href="{{BASE_PATH}}/2008/02/07/howto-aspnet-membership-roles-profiles-einrichten-rollensystem-allgemeines-demoprojekt/">anderen Blogpost</a>.<br><strong><u>Ganz wichtig:</u></strong> Damit die App.Config auch angenommen wird, müssen die Properties richtig gesetzt sein:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image473.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="162" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb452.png" width="244" border="0"></a> </p>
<p>Jetzt fügen wir noch die "System.Web" Referenz hinzu:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image474.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="206" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb453.png" width="244" border="0"></a> </p>
<p><strong>Schritt 2: Service schreiben</strong></p>
<p>Jetzt implementieren wir unseren sehr einfachen Service:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4913a48f-2849-4f35-8846-9b36bc6c79f5" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Security;

namespace DllMembership.Lib
{
    public class MembershipService
    {
        public IList&lt;User&gt; GetUsers()
        {  
            MembershipUserCollection col = Membership.GetAllUsers();
            List&lt;User&gt; returnList = new List&lt;User&gt;();
            foreach (MembershipUser user in col)
            {
                User u = new User();
                u.Name = user.UserName;
                u.Email = user.Email;
                returnList.Add(u);
            }
            return returnList;
        }

        public User Login(string username, string password)
        {
            User returnUser = new User();

            if (Membership.ValidateUser(username, password))
            {
                returnUser.IsLoggedIn = true;
                returnUser.Name = username;
                returnUser.Password = password;
                return returnUser;
            }
            else
            {
                returnUser.IsLoggedIn = false;
                return returnUser;
            }
        }

        public User GetUser(string username)
        {
            MembershipUser user = Membership.GetUser(username);
            User returnUser = new User();
            returnUser.Name = user.UserName;
            returnUser.Email = user.Email;
            return returnUser;
        }
    }
}
</pre></div>
<p>Dieser Service gibt ein "User" Objekt zurück (im Prinzip findet ein Mapping zwischen dem <a href="http://msdn.microsoft.com/en-us/library/system.web.security.membershipuser.aspx">MembershipUser</a> und unserem User statt) :</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e3475519-6cf0-499e-bf5f-99a193bfcea4" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DllMembership.Lib
{
    public class User
    {
        public bool IsLoggedIn { get; set; }
        public string Name { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
    }
}
</pre></div>
<p>Diese "User" Klasse fungiert ebenfalls als "Result" für unsere Service-Aufrufe. Klappt zum Beispiel die Login-Methode nicht, wird einfach die "IsLoggedIn" Property auf false gesetzt.</p>
<p><strong>Schritt 2.5: Unit Tests</strong></p>
<p>Ich habe 3 Unit-Test Methoden geschrieben, welche die grobe Funktionalität testen. Das klappt soweit.</p>
<p><strong>Schritt 3: Das Web-Projekt<br></strong>Damit unser Nutzer während einer Session auch eingeloggt bleibt, müssen wir noch die <a href="http://www.codeproject.com/KB/web-security/FormAuthenticnAuthorizn.aspx">Form-Authentication</a> aktivieren. <br>Hier müssen wir noch den Cookie "manuell" setzen. Dazu habe ich eine AppHelper mir erstellt:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0e0a6161-9dd2-4584-964f-d75ce79df578" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">namespace DllMembership.Web
{
    public static class AppUtil
    {
        public static User GetActiveUser()
        {
        if(HttpContext.Current.User.Identity.IsAuthenticated == false)
            {
                return new User() { IsLoggedIn = false };
            }
            else
            {
                MembershipService service = new MembershipService();
                User returnValue = service.GetUser(HttpContext.Current.User.Identity.Name);
                returnValue.IsLoggedIn = true;
                return returnValue;
            }
        }

        public static User Login(string username, string password)
        {
            MembershipService service = new MembershipService();
            User returnValue = service.Login(username, password);
            if (returnValue.IsLoggedIn)
            {
                FormsAuthentication.SetAuthCookie(returnValue.Name, true);
                returnValue.IsLoggedIn = true;
            }
            else
            {
                returnValue.IsLoggedIn = false;
            }

            return returnValue;
        }
    }
}
</pre></div>
<p>Hierbei gibt es zwei Methoden "GetActiveUser" und "Login".<br><strong>Zum "Login":</strong><br>Diese Methode übergibt die Parameter zum Service und wenn der Login erfolgreich war, wird dieser über ein Cookie über die Session hinweg authentifiziert.<br><strong>Die "GetActiveUser":</strong> <br>Diese Methode schaut einfach, ob der User im <a href="http://msdn.microsoft.com/en-us/library/system.web.httpcontext.user.aspx">HttpContext</a> <a href="http://msdn.microsoft.com/en-us/library/system.security.principal.iidentity.isauthenticated.aspx">authentifiziert ist</a>, wenn nicht, gibt es keinen angemeldeten Nutzer, ansonsten wird der aktuelle Nutzer geladen.</p>
<p><strong>Schritt 4: Ausgabe des Usernamen auf der Website</strong></p>
<p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:dfc6f519-8962-4a43-9d00-d90ced436b44" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            DllMembership.Lib.User returnUser = AppUtil.GetActiveUser();
            if (returnUser.IsLoggedIn == false)
            {
                this.UserName.Text = "unangemeldet";
            }
            else
            {
                this.UserName.Text = returnUser.Name;
            }</pre></div></p>
<p>Dadurch können wir leicht prüfen, ob jemand angemeldet ist, oder nicht.</p>
<p><strong>Das Problem dabei<br></strong>Leider geht die Lösung so wie ich sie hier gepostet habe, nicht ganz, denn man muss leider in der Web.Config die Membership Konfiguration und den ConnectionString noch extra angeben. <br>Das "Witzige" an der Geschichte: Die Unit-Tests laufen. Sobald dies aber auf der Webseite genutzt wird, überschreiben wohl die Web.Config Einstellungen die App.Config Einstellung - ihr könnt es gerne selber ausprobieren.<br>Ich finde das etwas unschön, aber verschmerzbar (bzw. fällt mir nix anderes ein).<br>Wenn jemand eine Lösung weiß, dann her damit :)</p>
<p><strong>Fazit<br></strong>Das ist nur ein "Prototyp", ich habe längst nicht alles fertig mir ausgedacht und würde vielleicht noch extra Properties einbauen und den Service umbasteln. Allerdings sollte dies der erste Schritt sein um zu zeigen, wie man das Membership dahin packt, wo es hingehört: In eine andere Schicht.</p>
<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/dllmembership/dllmembership.zip">[ Download Source Code ]</a></strong><br>* In den *.config muss der ConnectionString angepasst werden<br>** Anmeldedaten stehen in der ReadMe.txt in WebApp Ordner</p>
