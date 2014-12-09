---
layout: post
title: "HowTo: HttpContext, HttpRequest & HttpResponse in MVC Controllern testen & mocken"
date: 2011-01-04 00:10
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, HowTo, MVC, TDD, Unit Test]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1147.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb329.png" width="162" height="114" /></a> </p>  <p>Eines der top Gründe für ASP.NET MVC ist die gute Testbarkeit. Doch wie testet man eigentlich? Insbesondere wenn man mit HttpContext, HttpRequest und HttpResponse rumbastelt? Hier ein kleiner Leitfaden...</p>  <p><strong>HttpContext</strong></p>  <p>Als kleines Vorwort: HttpContext.Current ist böse. Weil nicht testbar (jedenfalls würde ich das jetzt mal eiskalt behaupten ohne irgendwelches seltsamen Tools zu benutzen). Doch im HttpContext stecken recht viele interessante Dinge. Jegliche Information über den Browser bekommt man über das Request Objekt. <a href="{{BASE_PATH}}/2009/06/10/howto-cookies-mit-aspnet-mvc-erstellen-entfernen/">Cookies erstellt man</a>, indem man sie in die Response schreibt. Wenn man solche Sachen in seiner Applikationslogik verwendet hat man folgende Möglichkeiten:</p>  <ul>   <li>Gar nicht erst sowas testen (ungünstige Idee)</li>    <li>Einen Binder benutzen und die Werte als Parameter mit reingeben</li>    <ul>     <li>Allerdings greift dann spätestens der Binder auf den HttpContext zu... </li>   </ul>    <li>Oder wir mocken das ganze.</li> </ul>  <p><strong>Szenario</strong></p>  <p>Folgendes Szenario: Ich geh auf die Home/Index Seite und möchte den Browser UserAgent auslesen und gleichzeitig ein Cookie erstellen. Das ganze will ich mit Unit Tests testen.</p>  <p>Als Testframework nutze ich <a href="http://www.nunit.org/">NUnit</a> und als Mocking Framework <a href="http://code.google.com/p/moq/">Moq</a>. Andere Frameworks können das aber auch.</p>  <p>Durch unser Szenario haben wir folgende Fälle:</p>  <p><em>Wenn die HomeController Index Methode aufgerufen wird...</em></p> <em>   <ul>     <li>dann wird der Useragent ausgelesen</li>      <li>dann wird ein Cookie erstellt</li>   </ul>    <p>     <br /></p> </em>  <p>Wer Fragen zum Style von den Unit Tests hat, dem empfehle ich <a href="http://blog.thomasbandt.de/39/2326/de/blog/tdd-bdd-status-quo.html">Thomas Bandts TDD Post</a>.</p>  <p><strong>Der Testcode</strong></p>  <p>Erstmal der gesamte Testcode - unten folgt im Detail die Erklärung:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4e2ea4d7-dc4d-4fe5-a201-00c52b2bd2f2" class="wlWriterEditableSmartContent"><pre name="code" class="c#">   [TestFixture]
    public class When_HomeController_Index_is_called
    {
        protected HomeController Sut;
        protected Mock&lt;HttpContextBase&gt; _httpContextBaseMock;
        protected Mock&lt;HttpRequestBase&gt; _httpRequestBaseMock;
        protected Mock&lt;HttpResponseBase&gt; _httpRepsonseBaseMock;
        protected HttpCookieCollection _cookieCollection;
        protected string _expectedUserAgentInViewBagMessage;
        protected HttpCookie _expectedCookie;

        protected ViewResult _result;

        [TestFixtureSetUp]
        public void Arrange()
        {
            _expectedUserAgentInViewBagMessage = "HelloTDDInMVC";
            _expectedCookie = new HttpCookie("HelloTDDInCookie");

            // Request expectations
            this._httpRequestBaseMock = new Mock&lt;HttpRequestBase&gt;();
            this._httpRequestBaseMock.Setup(x =&gt; x.UserAgent).Returns(this._expectedUserAgentInViewBagMessage);

            // Response expectations
            _cookieCollection = new HttpCookieCollection();
            this._httpRepsonseBaseMock = new Mock&lt;HttpResponseBase&gt;();
            this._httpRepsonseBaseMock.Setup(x =&gt; x.Cookies).Returns(_cookieCollection);


            // HttpContext expectations
            this._httpContextBaseMock = new Mock&lt;HttpContextBase&gt;();
            this._httpContextBaseMock.Setup(x =&gt; x.Request).Returns(this._httpRequestBaseMock.Object);
            this._httpContextBaseMock.Setup(x =&gt; x.Response).Returns(this._httpRepsonseBaseMock.Object);

            // Arrang Sut
            this.Sut = new HomeController();
            this.Sut.ControllerContext = new ControllerContext();
            this.Sut.ControllerContext.HttpContext = this._httpContextBaseMock.Object;
        }

        public void Act()
        {
            this._result = (ViewResult)this.Sut.Index();
        }

        [Test]
        public void Then_the_Request_UserAgent_should_be_read()
        {
            Act();
            Assert.AreEqual(this._expectedUserAgentInViewBagMessage, this._result.ViewBag.Message);
        }

        [Test]
        public void Then_a_Cookie_should_be_added_to_the_Response()
        {
            Act();
            Assert.AreSame(this._expectedCookie.Value, this._cookieCollection[this._expectedCookie.Name].Value);
        }
    }</pre></div>

<p>Um nicht auf HttpContext.Current zuzugreifen gibt es im ControllerContext ein Property namens HttpContext. Diesen können wir in einem Unit Test auch selber setzen. Dies wird auf Zeile 38 gemacht. In den Zeilen drüber erstlelle ich mir mein Context/Request/Response Mock und setze zudem noch meinen UserAgentden ich erwarte und mein HttpCookie, welches ich hinterher in der Response haben möchte. </p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:7455e9d3-defc-4e3d-9aad-15d54d0774cb" class="wlWriterEditableSmartContent"><pre name="code" class="c">            _expectedUserAgentInViewBagMessage = "HelloTDDInMVC";
            _expectedCookie = new HttpCookie("HelloTDDInCookie");</pre></div>

<p>Da es sich bei Context/Response/Request nur um Mocks handelt muss man diese genau sagen, was passieren soll.</p>

<p>In Zeile 21/22 sage ich, dass es ein HttpRequestBase (HttpRequest ist nicht mockbar, daher wurden die "...Base” Klassen eingeführt) mock gibt, welches beim Zugreifen auf den UserAgent meinen eigenen UserAgent aus Zeile 17 zurückliefert. </p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9aec234a-70cc-41e1-bd4e-b7dd121e4121" class="wlWriterEditableSmartContent"><pre name="code" class="c">            this._httpRequestBaseMock = new Mock&lt;HttpRequestBase&gt;();
            this._httpRequestBaseMock.Setup(x =&gt; x.UserAgent).Returns(this._expectedUserAgentInViewBagMessage);
</pre></div>

<p>Im Response (Zeile 25-27) sage ich, dass wenn auf Cookies zugegriffen wird, soll die _cookieCollection zurückgegeben werden. Diese ist aber hier leer und enthält in diesem Schritt noch nicht mein erwartetes Cookie von Zeile 18.</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6bec6736-831d-4668-9593-0c9cc522b9da" class="wlWriterEditableSmartContent"><pre name="code" class="c">            _cookieCollection = new HttpCookieCollection();
            this._httpRepsonseBaseMock = new Mock&lt;HttpResponseBase&gt;();
            this._httpRepsonseBaseMock.Setup(x =&gt; x.Cookies).Returns(_cookieCollection);</pre></div>

<p>Nun füge ich dies noch zu dem HttpContext hinzu:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:21fbf0f5-451b-4a4e-810e-77bd53116e82" class="wlWriterEditableSmartContent"><pre name="code" class="c#">            this._httpContextBaseMock = new Mock&lt;HttpContextBase&gt;();
            this._httpContextBaseMock.Setup(x =&gt; x.Request).Returns(this._httpRequestBaseMock.Object);
            this._httpContextBaseMock.Setup(x =&gt; x.Response).Returns(this._httpRepsonseBaseMock.Object);
</pre></div>

<p>Mein Sut (System Under Test) ist der HomeController.</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a887bf3d-abe8-40c5-8c49-5016d69942d1" class="wlWriterEditableSmartContent"><pre name="code" class="c#"> this.Sut = new HomeController();
            this.Sut.ControllerContext = new ControllerContext();
            this.Sut.ControllerContext.HttpContext = this._httpContextBaseMock.Object;</pre></div>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p>Damit habe ich meine Erwartungen/Arranges gemacht.</p>

<p><strong>Nun zu den eigentlichen Tests</strong></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e2af00c0-69e7-44b1-8778-1d0eba8b1069" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public void Act()
        {
            this._result = (ViewResult)this.Sut.Index();
        }

        [Test]
        public void Then_the_Request_UserAgent_should_be_read()
        {
            Act();
            Assert.AreEqual(this._expectedUserAgentInViewBagMessage, this._result.ViewBag.Message);
        }

        [Test]
        public void Then_a_Cookie_should_be_added_to_the_Response()
        {
            Act();
            Assert.AreSame(this._expectedCookie.Value, this._cookieCollection[this._expectedCookie.Name].Value);
        }</pre></div>

<p>Bei "Act” ruf ich die Index Methode auf und speichere das Result dessen in einem Property. In der ersten Testmethode schau ich nun, ob in der ViewBag nun auch der UserAgent gesetzt ist. </p>

<p>In der zweiten Testmethode prüfe ich, ob nun in der _cookieCollection, welche am Anfan leer war, nun auch mein Cookie zu finden ist.</p>

<p><strong>Damit haben wir auch die drei As kennengelernt: Arrange / Act / Assert.</strong></p>

<p>Die Implementierung dessen fand auch ganz nach TDD Art "Red/Green/Refactor” statt und das ist am Ende die fertige Methode:</p>

<p>&#160;</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b83c70c4-d80f-4605-985f-255934083ab2" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public ActionResult Index()
        {
            ViewBag.Message = this.ControllerContext.HttpContext.Request.UserAgent;
            HttpCookie cookie = new HttpCookie("HelloTDDInCookie");
            this.Response.Cookies.Add(cookie);
            return View();
        }</pre></div>

<p>Im Browser klappt das natürlich auch:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1148.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb330.png" width="651" height="236" /></a> </p>

<p>Prinzipiell ist also das test und mocken mit HttpContext &amp; co. nicht schwer. Es gibt natürlich diverse Feinheiten, aber dies würde ich für einen anderen Post aufbewahren.</p>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvccontrollerhttpcontexttests/mvccontrollerhttpcontexttests.zip">[Download Democode]</a></strong></p>
