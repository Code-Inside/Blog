---
layout: post
title: "HowTo: Cookies mit ASP.NET MVC erstellen & entfernen"
date: 2009-06-10 02:19
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: []
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image759.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="125" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb737.png" width="135" align="left" border="0" /></a><a href="http://de.wikipedia.org/wiki/HTTP-Cookie">Cookies</a> sind ein toller Weg um Daten auf dem Client zu speichern. Das k&#246;nnen Anmeldeinformationen sein oder andere Daten, die man auf dem Client abspeichern m&#246;chte. Wer das <a href="{{BASE_PATH}}/2008/02/07/howto-aspnet-membership-roles-profiles-einrichten-rollensystem-allgemeines-demoprojekt/">ASP.NET Membership System</a> nutzt wird oftmals auch die &quot;Angemeldet bleiben&quot; Funktionalit&#228;t benutzen. In diesem HowTo geht es um das pure Erstellen eines Cookies und wie man diesen auch wieder los wird.</p> 
<!--more-->
  <p><strong>Aufbau</strong></p>  <p>Als Demogrundlage nutze ich das <a href="http://asp.net/mvc">ASP.NET MVC Framework</a>. So sieht die Testseite aus wenn ein Cookie gefunden wurde:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image760.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="111" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb738.png" width="268" border="0" /></a>&#160;</p>  <p>Ich habe auch die Zeit mit ausgegeben, wann der Cookie erstellt wurde (ja, ich blogge 3 Uhr morgens ;) ).</p>  <p>Wenn kein Cookie gefunden wird sieht es so aus:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image761.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="96" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb739.png" width="244" border="0" /></a> </p>  <p>Die Ausgabe erfolgt auf der Index.aspx &#252;ber den <strong>HomeController:</strong></p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:bc44e6f4-cf74-46b8-8a2b-31c45033c38c" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public ActionResult Index()
        {
            ViewData["Message"] = "Welcome to ASP.NET MVC!";
            string cookie = "There is no cookie!";
            if(this.ControllerContext.HttpContext.Request.Cookies.AllKeys.Contains("Cookie"))
            {
                cookie = "Yeah - Cookie: " + this.ControllerContext.HttpContext.Request.Cookies["Cookie"].Value;
            }
            ViewData["Cookie"] = cookie;
            return View();
        }</pre></div>

<p>Hier wird festgestellt ob es so ein Cookie gibt und wenn ja wird dieser ausgegeben.</p>

<p>Die beiden Links f&#252;hren zum <strong>CookieController</strong>:</p>

<p>
  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:7a7d7cd9-0e7b-4b56-8b53-7f6ae48dd55d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public class CookieController : Controller
    {

        public ActionResult Create()
        {
            HttpCookie cookie = new HttpCookie("Cookie");
            cookie.Value = "Hello Cookie! CreatedOn: " + DateTime.Now.ToShortTimeString();

            this.ControllerContext.HttpContext.Response.Cookies.Add(cookie);
            return RedirectToAction("Index", "Home");
        }

        public ActionResult Remove()
        {
            if (this.ControllerContext.HttpContext.Request.Cookies.AllKeys.Contains("Cookie"))
            {
                HttpCookie cookie = this.ControllerContext.HttpContext.Request.Cookies["Cookie"];
                cookie.Expires = DateTime.Now.AddDays(-1);
                this.ControllerContext.HttpContext.Response.Cookies.Add(cookie);
            }
            return RedirectToAction("Index", "Home");
        }

    }</pre></div>
</p>

<p>Die Create Methode erzeugt sehr schlicht ein Cookie und packt diesen in die Response und leitet dann wieder zum Index View um.</p>

<p>Die Remove Methode pr&#252;ft ebenfalls ob das Cookie da ist und wenn ja, wird dieses gel&#246;scht.</p>

<p><strong>Wichtig beim Cookies l&#246;schen:</strong></p>

<p>Diese Variante den Cookie zu l&#246;schen schl&#228;gt fehl:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:74b4ed9e-53fc-44d7-a7f7-9f0be9a6bbd0" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">this.ControllerContext.HttpContext.Response.Cookies.Clear();</pre></div>

<p>Der Cookie muss (wie im CookieController zu sehen) wieder in die Response zur&#252;ck und das <a href="http://msdn.microsoft.com/en-us/library/system.web.httpcookie.expires.aspx">Ablaufdatum</a> muss gesetzt werden. Ich setze es einfach auf gestern, sodass der Browser das Cookie sofort verwirft.

  <br />Da ich da eine kleine Weile rumgeflucht habe, wollte ich es einfach mal niederschreiben&#160; ;)</p>

<p><a href="{{BASE_PATH}}/assets/files/democode/cookies/cookies.zip"><strong>[ Download Demosource ]</strong></a></p>
