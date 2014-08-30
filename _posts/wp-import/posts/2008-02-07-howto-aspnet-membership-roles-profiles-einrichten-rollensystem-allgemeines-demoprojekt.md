---
layout: post
title: "HowTo: ASP.NET Membership, Roles & Profiles - Einrichten, Rollensystem, Allgemeines & Demoprojekt"
date: 2008-02-07 22:00
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET, ASP.NET MVC, Cardspace, HowTo, Membership, MySQL, OpenID, Security]
---
{% include JB/setup %}
Jetzt werde ich sicherlich über ein etwas älteres Thema schreiben. Allerdings hatte ich erst jetzt damit zutun und da ich doch einige Anfangsschwierigkeiten hatte, werde ich hier nach und nach Informationen zum Membership System von ASP.NET niederschreiben. Ziel soll es sein auch CardSpace oder OpenID mit einzubinden - mal sehn wann dies geschehen wird.

Dies ist der "Einstiegsteil" in das Thema, fangen wir daher nun an:

<strong>Membership? Was ist das? </strong>

Das ASP.NET Membership System wurde mit ASP.NET 2.0 eingeführt und stellt eine einheitliche API zum <a href="http://msdn2.microsoft.com/en-us/library/yh26yfzy.aspx">Benutzer</a>-, <a href="http://msdn2.microsoft.com/en-us/library/ms998314.aspx">Rollen</a>-, <a href="http://msdn.microsoft.com/msdnmag/issues/05/10/CuttingEdge/">Profilmanagement</a> sowie Authentifierung bereit. Zudem gibt es noch einige UI Controls in ASP.NET.

Das ganze Membership System ist zudem erweiterbar - dazu gibt es ein <a href="http://msdn2.microsoft.com/en-us/library/aa479031.aspx">Providermodell</a>.

<strong>Wie funktioniert das ganze?</strong>

Von Microsoft direkt gibt es ein Provider für Active Directory und für den SQL Server (desweiteren kann man noch in der web.config feste Nutzer einrichten). Der SQL Provider ist für Internetanwendungen geeignet, dabei wird von ASP.NET eine solche DB erzeugt:

<a href="{{BASE_PATH}}/assets/wp-images/image251.png"><img src="{{BASE_PATH}}/assets/wp-images/image-thumb230.png" style="border: 0px none " alt="image" border="0" height="244" width="241" /></a>

Es gibt auch bereits Provider für alles mögliche - z.B. auch für <a href="http://www.codeproject.com/KB/database/mysqlmembershipprovider.aspx">MySQL</a>. Natürlich kann man auch seinen <a href="http://msdn2.microsoft.com/en-us/library/f1kyba5e.aspx">eigenen Membership Provider schreiben</a>. Schauen wir uns erstmal Schritt für Schritt an, was man tun muss, um eine solche Datenbank zu bekommen.

<strong>Schritt 1: Web Site anlegen &amp; ASP.NET Configuration starten</strong>

Ich empfehle eine "Web Site", weil es in Zusammenhang mit dem Profil System und "Web Projects" zu <a href="{{BASE_PATH}}/2008/01/23/howto-aspnet-profile-system-mit-web-projects-nutzen-visual-studio-20052008/">Problemen kommen kann</a>. Visual Studio sollte zudem möglichst unter dem Admin Konto ausgeführt werden - bei mir hat es ansonsten immer mal geklemmt.

Sobald man solch ein Web Site angelegt hat, gibt es im Menü den Punkt "Website", dort einfach auf "ASP.NET Configuration" gehen:

<a href="{{BASE_PATH}}/assets/wp-images/image252.png"><img src="{{BASE_PATH}}/assets/wp-images/image-thumb231.png" style="border: 0px none " alt="image" border="0" height="244" width="228" /></a>

Danach öffnet sich eine Website mit mehreren Reitern - der interessanteste Teil dürfte sicherlich "Sicherheit" sein:

<a href="{{BASE_PATH}}/assets/wp-images/image253.png"><img src="{{BASE_PATH}}/assets/wp-images/image-thumb232.png" style="border: 0px none " alt="image" border="0" height="118" width="378" /></a>

Unter "Authentifierzungstyp auswählen" kann man zwischen den SQL Provider und den AD Provider wechseln. Wenn man das erste mal den Punkt "Aus dem Internet" (also den SQL Provider) gewählt hat, dann wird die obrige Datenbank erstellt.
<u>Hinweis:</u> Das <a href="http://msdn2.microsoft.com/de-de/library/ms229862(VS.80).aspx">aspnet_regsql Tool</a> erlaubt dies auch auf Basis der Kommandozeile.

Recht komfortabel kann man hier zudem Nutzer und Rollen einrichten und Zugriffsregeln setzen. Die Zugriffsregeln werden dabei jeweils in der web.config <a href="http://msdn2.microsoft.com/en-us/library/8d82143t(VS.71).aspx">abgespeichert</a>.

Wichtig ist, dass die Nutzer nach dem Anlegen aktiviert sind:

<a href="{{BASE_PATH}}/assets/wp-images/image254.png"><img src="{{BASE_PATH}}/assets/wp-images/image-thumb233.png" style="border: 0px none " alt="image" border="0" height="98" width="540" /></a>

Rollen lassen sich ebenso managen.

<u>Hinweis:</u> Der Reiter "Anbieter" wird bei einem Custom Membership Provider interessant.

<strong>Schritt 2: ASP.NET Login Controls verwenden</strong>

Man kann den gesamten Authentifierungsprozess &amp; das restliche Management über die <a href="http://msdn2.microsoft.com/en-us/library/2d449f1x.aspx">Membership Klassen</a> abbilden, allerdings hat Microsoft eine handvoll nützliche Controls bereits definiert:

<a href="{{BASE_PATH}}/assets/wp-images/image255.png"><img src="{{BASE_PATH}}/assets/wp-images/image-thumb234.png" style="border: 0px none " alt="image" border="0" height="186" width="183" /></a>

Wenn man nichts verstellt hat, kann man das <a href="http://msdn2.microsoft.com/en-us/library/system.web.ui.webcontrols.login.aspx">Login Control</a> auf eine ASPX Seite ziehen und sich (nachdem Nutzer eingerichtet wurden) auch gleich anmelden. Einen Überblick über die einzelnen Controls gibt es <a href="http://msdn2.microsoft.com/en-us/library/ms178329.aspx">hier</a>.

Die meisten Controls können angepasst werden, z.B. das <a href="http://www.aspnetzone.de/blogs/peterbucher/archive/2007/07/11/login-control-aussehen-und-output-per-template-anpassen.aspx">Login Control</a>, aber <a href="http://msdn2.microsoft.com/de-de/library/ms178339(VS.80).aspx">auch andere</a>.

<strong>Schritt 3: Grundgerüst erstellen</strong>

Ich mache mal eine Beispielhafte Implementation, welche ich am Ende auch zum Downloaden anbiete.

Das Grundgerüst sieht so aus

<a href="{{BASE_PATH}}/assets/wp-images/image256.png"><img src="{{BASE_PATH}}/assets/wp-images/image-thumb235.png" style="border: 0px none " alt="image" border="0" height="244" width="134" /></a>

Es wurden 3 Nutzer eingerichtet und 3 Rollen - Benutzer, Redakteur und Administrator.

In dem Ordner "Redakteur" kommen nur Redakteure - in den Ordner "Admin" kommen nur Administrator - die Benutzer und anonyme kommen nur auf die "Default.aspx" im Root Verzeichnis - dies wurde über die ASP.NET Configuration vorgenommen.

<strong>Schritt 4: MasterPage einrichten</strong>

Auf jeder Seite wollen wir bei anonymen Nutzern einen "Anmelden" Button anzeigen oder bei bereits angemeldeten einen "Abmelden" Button - daher kommt dies in die MasterPage.
Zudem wollen wir jeden Nutzer "Willkommen" sagen und spezielle Links je nach Rolle ihm zur Verfügung stellen:

<a href="{{BASE_PATH}}/assets/wp-images/image257.png"><img src="{{BASE_PATH}}/assets/wp-images/image-thumb236.png" style="border: 0px none " alt="image" border="0" height="156" width="594" /></a>

Das "<a href="http://msdn2.microsoft.com/en-us/library/system.web.ui.webcontrols.loginstatus.aspx">LoginStatus</a>" Control übernimmt den Login/Logout Part. Das "<a href="http://msdn2.microsoft.com/en-us/library/system.web.ui.webcontrols.loginview.aspx">LoginView</a>" Control bietet die Möglichkeit je nach Anmeldestatus informationen bereitzustellen:

<a href="{{BASE_PATH}}/assets/wp-images/image258.png"><img src="{{BASE_PATH}}/assets/wp-images/image-thumb237.png" style="border: 0px none " alt="image" border="0" height="173" width="515" /></a>

Mithilfe des "<a href="http://msdn2.microsoft.com/en-us/library/system.web.ui.webcontrols.loginname.aspx">LoginName</a>" Control bekommen wir den Usernamen des momentan angemeldeten Nutzers raus.

<strong>Schritt 5: Login Page einrichten</strong>

Die Login.aspx ist Standardmäßig die Login Seite (ist in der web.config gespeichert) und muss natürlich ebenfalls noch mit einem Control gefüllt werden - das "<a href="http://msdn2.microsoft.com/en-us/library/system.web.ui.webcontrols.login.aspx">Login</a>" Control. Wenn man mit den normalen Aussehen leben kann, muss man hier auch nichts mehr machen. Falls man allerdings das design etwas stärker ändern möchte, muss man wie <a href="http://www.aspnetzone.de/blogs/peterbucher/archive/2007/07/11/login-control-aussehen-und-output-per-template-anpassen.aspx">hier</a> beschrieben z.B. ein Template anlegen.

<a href="{{BASE_PATH}}/assets/wp-images/image259.png"><img src="{{BASE_PATH}}/assets/wp-images/image-thumb238.png" style="border: 0px none " alt="image" border="0" height="122" width="518" /></a>

Die Codebehinde sieht dann so aus:

<a href="{{BASE_PATH}}/assets/wp-images/image260.png"><img src="{{BASE_PATH}}/assets/wp-images/image-thumb239.png" style="border: 0px none " alt="image" border="0" height="137" width="511" /></a>

Das wars eigentlich bereits. Wenn man diese Template Variante wählt, muss man dann natürlich um die ganze Funktionalität abzudecken, auch wie hier beschrieben die Elemente mit <a href="http://msdn2.microsoft.com/de-de/library/system.web.ui.ieditabletextcontrol(VS.80).aspx">implementieren</a>.

Sehr praktisch ist es auch, wenn ein nicht angemeldeter Nutzer z.B. die Adminseite besuchen möchte, wir automatisch auf die Login.aspx verlinkt, allerdings wird als Parameter die Zieladresse mitgegeben, sodass nach einem erfolgreichen Login man automatisch auf der "richtigen" Seite befindet:

<a href="{{BASE_PATH}}/assets/wp-images/image261.png"><img src="{{BASE_PATH}}/assets/wp-images/image-thumb240.png" style="border: 0px none " alt="image" border="0" height="29" width="499" /></a>

Dafür ist diese Methode verantwortlich: <a href="http://msdn2.microsoft.com/en-us/library/ka5ffkce.aspx">FormsAuthentication.RedirectFromLoginPage</a>.

<strong>Die technische Seite</strong>

Der angemeldete Nutzer ist in der Klassenhierarchie z.B. bei jeder <a href="http://msdn2.microsoft.com/en-us/library/system.web.ui.page.aspx">Page</a> oder <a href="http://msdn2.microsoft.com/en-us/library/system.web.httpcontext(vs.71).aspx">HttpContext</a> unter "User" zu finden:

<a href="{{BASE_PATH}}/assets/wp-images/image262.png"><img src="{{BASE_PATH}}/assets/wp-images/image-thumb241.png" style="border: 0px none " alt="image" border="0" height="111" width="463" /></a>

Andere Teile finden sich auch in dem <a href="http://msdn2.microsoft.com/de-de/library/system.web.sessionstate.httpsessionstate.aspx">HttpSessionState</a>:

<a href="{{BASE_PATH}}/assets/wp-images/image263.png"><img src="{{BASE_PATH}}/assets/wp-images/image-thumb242.png" style="border: 0px none " alt="image" border="0" height="238" width="555" /></a>

<strong>Eine Sache zu den Controls</strong>

Die Login Controls renden oft nicht das, was man als normaler Webdesigner erwartet - dafür gibt es entweder den <a href="http://www.asp.net/cssadapters/">CSS Friendly Adapter</a> oder man muss eigene Controls entwickeln, welche auf das Membership System aufsetzen.

<strong>Grundsatzfrage: Sollte ich das Membership verwenden oder was selber implementieren?</strong>

Das ist so eine nette Frage - wenn man sich in das System eingefunden hat, sieht man viele positive Sachen. Die Controls sind natürlich etwas garstig, aber auch das bekommt man in den Griff.

Wenn man selber eine Art Membership System realisiert, dann kann dies später zu einem Problem werden, da das Membership System ansich wie oben zu sehen ist, einiges im Hintergrund macht. Wozu selber so ein System dann realisieren? Dann lieber ein <a href="http://msdn2.microsoft.com/en-us/library/f1kyba5e.aspx">Custom Provider erstellen</a> - dies wäre mein Rat zu dem Thema.

<strong>Weiterführende Links &amp; Informationen</strong>

<a href="http://weblogs.asp.net/scottgu/archive/2006/02/24/ASP.NET-2.0-Membership_2C00_-Roles_2C00_-Forms-Authentication_2C00_-and-Security-Resources-.aspx">Scott Guthrie</a> hat einige tolle Links zusammengefasst. Ein sehr gutes, 9 teiliges Tutorial gibt es zudem auch <a href="http://aspnet.4guysfromrolla.com/articles/120705-1.aspx">hier</a>. Mein persönliches Lieblingsthema ASP.NET MVC kann man zudem ebenfalls mit dem Membership System (und den Controls) verheiraten: <a href="http://weblogs.asp.net/fredriknormen/archive/2008/02/07/asp-net-mvc-framework-using-forms-authentication.aspx">ASP.Net MVC Framework - Using Forms Authentication</a>. Hier gibt es auch noch ein <a href="http://msdn2.microsoft.com/en-us/library/ms998347.aspx">HowTo direkt auf der MSDN</a>.

Es gibt auch direkt ein <a href="http://www.amazon.de/gp/product/0764596985?ie=UTF8&amp;tag=meinkleinerbl-21&amp;linkCode=as2&amp;camp=1638&amp;creative=6742&amp;creativeASIN=0764596985">Buch</a> was sich nur mit diesem Thema auseinandersetzt.

<strong>Download des Demoprojekts</strong>

Um das Demoprojekt auszuführen braucht ihr VS 2008 und in der web.config muss der Connection String noch angepasst werden. In der ReadMe.txt stehen die eingetragenen Nutzer samt Passwörter. Viel Spaß wünsch ich euch.

<strong>[ <a href="{{BASE_PATH}}/assets/files/democode/membershipsimple/membership.zip">Download Democode</a> ]</strong>
