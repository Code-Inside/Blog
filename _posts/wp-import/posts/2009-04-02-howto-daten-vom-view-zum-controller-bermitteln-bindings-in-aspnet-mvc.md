---
layout: post
title: "HowTo: Daten vom View zum Controller übermitteln / Modelbinders in ASP.NET MVC"
date: 2009-04-02 22:15
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, HowTo, MVC]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image700.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="113" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb678.png" width="149" align="left" border="0" /></a>Mit ASP.NET MVC ist der Entwickler v&#246;llig in Kontrolle &#252;ber das HTML Markup und wohin die Daten gesendet werden. Die Daten werden &#252;ber eine HTML Form an den Server gesendet - aber wie kann der Controller Daten entgegen nehmen? Das Framework bringt einige M&#246;glichkeiten mit, um nicht immer &#252;ber Request.Forms[...] an seine Daten ranzukommen.</p> 
<!--more-->
  <p><strong>Einstieg</strong>    <br />Das gorbe ASP.NET MVC Konzept (und wie die Kommunikation unter den verschiedenen Teilen funktioniert) habe ich breits in diesem <a href="{{BASE_PATH}}/2008/10/14/howto-aspnet-mvc-erstellen-erster-einstieg/">Post</a> aufgef&#252;hrt.</p>  <p><strong>&quot;Bindings&quot;</strong>    <br />In diesem HowTo geht es darum, wie HTML Form Daten auf dem Server ankommen und welche M&#246;glichkeiten es gibt.</p>  <p><strong>Aufbau</strong></p>  <p><strong></strong>    <br /><a href="{{BASE_PATH}}/assets/wp-images/image701.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="317" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb679.png" width="171" align="left" border="0" /></a> </p>  <p>Wir haben einen &quot;BindingController&quot;, sowie im Model unsere &quot;Person&quot; Klasse und dazu 3 Views:</p>  <p>- &quot;CreatePerson&quot; (Form f&#252;r das Erstellen einer Person)   <br />- &quot;Ergebnis&quot; der Aktion    <br />- &quot;Index&quot; ist nur die &#220;bersichtsseite</p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  <p>Person Class:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0b1e181d-3966-498f-aefd-8712a0c8d7e5" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public class Person
    {
        public Guid Id { get; set; }
        public string Prename { get; set; }
        public string Surname { get; set; }
        public int Age { get; set; }
    }</pre></div>

<p>Form in der CreatePerson.aspx:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e3f6bc9b-67a4-4dd1-acb6-2e470a6a230c" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;% using (Html.BeginForm()) {
	%&gt;

        &lt;fieldset&gt;
            &lt;legend&gt;Fields&lt;/legend&gt;
            &lt;p&gt;
                &lt;label for="Id"&gt;Id:&lt;/label&gt;
                &lt;%= Html.TextBox("Id") %&gt;
                &lt;%= Html.ValidationMessage("Id", "*") %&gt;
            &lt;/p&gt;
            &lt;p&gt;
                &lt;label for="Prename"&gt;Prename:&lt;/label&gt;
                &lt;%= Html.TextBox("Prename") %&gt;
                &lt;%= Html.ValidationMessage("Prename", "*") %&gt;
            &lt;/p&gt;
            &lt;p&gt;
                &lt;label for="Surname"&gt;Surname:&lt;/label&gt;
                &lt;%= Html.TextBox("Surname") %&gt;
                &lt;%= Html.ValidationMessage("Surname", "*") %&gt;
            &lt;/p&gt;
            &lt;p&gt;
                &lt;label for="Age"&gt;Age:&lt;/label&gt;
                &lt;%= Html.TextBox("Age") %&gt;
                &lt;%= Html.ValidationMessage("Age", "*") %&gt;
            &lt;/p&gt;
            &lt;p&gt;
                &lt;input type="submit" value="Create" /&gt;
            &lt;/p&gt;
        &lt;/fieldset&gt;

    &lt;% } %&gt;</pre></div>

<p><strong>Binding: 1. Variante - FormCollection:</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:541bb5b8-17eb-49f7-b8ca-5c964f2a38db" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult FormCollection(FormCollection collection)
        {
            Person person = new Person();
            person.Prename = collection["Prename"];
            person.Surname = collection["Surname"];
            person.Age = int.Parse(collection["Age"]);
            return View("Result", person);
        }</pre></div>

<p>In diesem Fall greifen wir auf die Collection zu und haben &#252;ber Key/Value Zugang zu den &#252;bermittelten Werten. Hier muss man seine Daten manuell rausziehen.</p>

<p><strong>Binding: 2. Variante - Parameter Matching:</strong></p>

<p>
  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1e8d4262-2c08-41b7-828c-545d1e61a4ed" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ParameterMatching(string Prename, string Surname, int Age)
        {
            Person person = new Person();
            person.Prename = Prename;
            person.Surname = Surname;
            person.Age = Age;

            return View("Result", person);
        }</pre></div>
</p>

<p>Bei dieser Variante wird versucht die &#252;bermittelten Werte anhand des Namens und des Types auf die Parameter zu mappen.</p>

<p><strong>Binding: 3. Variante - Default Binding:</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:7f829ed2-ca11-4995-8d10-f6cd19ae10a2" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult DefaultBinding(Person person)
        {
            return View("Result", person);
        }</pre></div>

<p>Bei dieser Variante wird der Default Modelbinder im ASP.NET MVC Framework genommen. Dieser versucht ebenfalls anhand des Namens und des Types dies auf diesen Typ zu mappen.</p>

<p><strong>Binding: 3. Variante mit Addon - Default Binding mit Include:</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:fad75f19-afaf-4cce-a86f-b3002463b407" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult DefaultBindingWithInclude([Bind(Include="Prename")] Person person)
        {
            return View("Result", person);
        }</pre></div>

<p>Da <a href="http://www.codethinked.com/post/2009/01/08/ASPNET-MVC-Think-Before-You-Bind.aspx">es gef&#228;hrlich sein kann</a> einfach blind die Http Form Values auf ein Objekt zu mappen, kann man auch nur bestimmte Felder &#252;ber &quot;Include&quot; ausw&#228;hlen.</p>

<p><strong>Binding: 3. Variante mit Addon - Default Binding mit Exclude:</strong></p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f464b65d-eba8-4ca5-b00e-c6549044295e" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult DefaultBindingWithExclude([Bind(Exclude = "Prename")] Person person)
        {
            return View("Result", person);
        }</pre></div>

<p>Die selbe Funktionalit&#228;t geht auch umgedreht.</p>

<p><strong>Binding: 3. Variante mit Addon - Default Binding mit Prefix:</strong></p>
<a href="{{BASE_PATH}}/assets/wp-images/image702.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="55" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb680.png" width="455" border="0" /></a> 

<p>Wenn man die Html Input Felder mit einem Prefix versehen hat, dann kann man dies hier mit angeben. Das ist dann sinnvoll, wenn in einer Form verschiedene Daten eingegeben werden sollen, allerdings die Namen sich gleichen.</p>

<p>Diese Optionen kann man auch beliebig mixen.</p>

<p><strong>Binding: 4. Version - IModelBinder</strong></p>

<p>Wenn man doch eine etwas komplexeres Beispiel hat, wo das Default Binding versagt, kann man auch seine eigenen ModelBinder schreiben. Ein Beispiel ist z.B. <a href="http://www.hanselman.com/blog/ASPNETMVCBetaReleasedCoolnessEnsues.aspx">Fileupload</a> oder das das Binden an den <a href="http://www.hanselman.com/blog/IPrincipalUserModelBinderInASPNETMVCForEasierTesting.aspx">aktuellen User</a>.</p>

<p>Dazu muss man in einer Klasse das IModelBinder Interface implementieren:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:73f40b10-a763-4707-8b7a-60fcbd9226b8" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public class PersonModelBinder : IModelBinder
    {
        public object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
         if (controllerContext == null) {  
             throw new ArgumentNullException("controllerContext");  
         }  
         if (bindingContext == null) {  
             throw new ArgumentNullException("bindingContext");  
         }

            NameValueCollection collection = controllerContext.RequestContext.HttpContext.Request.Form;

            Person returnValue = new Person();
            returnValue.Id = Guid.NewGuid();
            returnValue.Prename = "Modelbinder: " + collection["Prename"];
            returnValue.Surname = "Modelbinder: " + collection["Surname"];
            int age = 0;
            int.TryParse(collection["Age"], out age);
            returnValue.Age = age;

            return returnValue;
        }

    }</pre></div>

<p>Hierbei hat man kompletten Zugriff auf die Formvalues und kann diese entsprechend auf sein Objekt mappen.</p>

<p>Dieser Modelbinder kann entweder Global in der Global.asax hinzugef&#252;gt werden:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ec540371-fa11-4087-965e-dcf98a12bb33" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        protected void Application_Start()
        {
            RegisterRoutes(RouteTable.Routes);  
            ModelBinders.Binders[typeof(Person)] = new PersonModelBinder(); // Important!
        }</pre></div>

<p> Oder man macht es pro ActionMethod:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d3cc88dd-8128-4121-a197-5f8541b409ae" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult PersonModelBinder([ModelBinder(typeof(PersonModelBinder))] Person person)
        {
            return View("Result", person);
        }</pre></div>

<p><strong>Lists/Array Binding:</strong></p>

<p>Es ist auch m&#246;glich dass man eine komplette &quot;Collection&quot; zum Controller sendet und dieser versteht das am Ende auch als List&lt;Person&gt;. Das Beispiel ist sehr gut in <a href="http://www.hanselman.com/blog/ASPNETWireFormatForModelBindingToArraysListsCollectionsDictionaries.aspx">Scott Hanselmans Post</a> erkl&#228;rt.</p>

<p><strong>Screens:</strong></p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image703.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="175" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb681.png" width="244" border="0" /></a> </p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image704.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="286" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb682.png" width="248" border="0" /></a> </p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image705.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb683.png" width="243" border="0" /></a> </p>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvcbinding/mvcbinding.zip">[Download Source Code]</a></strong></p>
