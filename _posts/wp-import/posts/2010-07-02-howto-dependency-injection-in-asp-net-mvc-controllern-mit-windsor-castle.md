---
layout: post
title: "HowTo: Dependency Injection in ASP.NET MVC Controllern mit Windsor Castle"
date: 2010-07-02 00:21
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, Castle Windsor, DI, HowTo, IoC]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image993.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb177.png" width="192" height="150" /></a>Um einem MVC Controller seine Abhängigkeiten (z.B. Repositories, Services etc.) über ein DI-Framework, wie z.B. <a href="http://www.castleproject.org/container/">Windsor Castle</a>, reinzugeben muss man ein klein wenig am MVC Workflow rumschrauben. Glücklicherweise erlaubt das MVC Framework die Überschreibung der ControllerFactory.</p>  <p><strong>Für die Testbarkeit - das Szenario</strong></p>  <p>Wir haben den simplen HomeController:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a2504d90-70b3-41f3-8142-10ab02df7869" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    [HandleError]
    public class HomeController : Controller
    {
        private IFooService _fooService;

        public HomeController(IFooService fooService)
        {
            this._fooService = fooService;
        }

        public ActionResult Index()
        {
            ViewData["Message"] = "Welcome to ASP.NET MVC!" + this._fooService.Bar();

            return View();
        }

        public ActionResult About()
        {
            return View();
        }
    }</pre></div>

<p>Dieser nimmt im Konstruktor eine Implementation von IFooService entgegen. Der FooService wird in der Index Methode gebraucht. In einer realen Anwendung könnte dies z.B. ein Repository sein. </p>

<p>Der FooService:</p>

<p>
  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:61b4648c-619b-4949-bf5c-8ebb14e43a63" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    public interface IFooService
    {
        string Bar();
    }

    public class DummyFooService : IFooService
    {
        public string Bar()
        {
            return "DummyFooBar";
        }
    }</pre></div>
</p>

<p>Durch den Einsatz des Interfaces könnten wir dies z.B. in einem UnitTest mocken. </p>
<strong></strong>

<p><strong>Knackpunkt: Die Objekterzeugung</strong></p>

<p>In einer normalen Anwendung könnte man, wie z.B. <a href="{{BASE_PATH}}/2010/06/27/howto-alle-implementationen-vom-interface-x-ber-castle-windsor-per-di-auflsen/">in diesem Post</a> erklärt, recht einfach über den IoC Container die Implementation reingeben. Allerdings wird ein Objekt zum HomeController vom MVC Framework erzeugt - dies übernimmt die <a href="http://msdn.microsoft.com/en-us/library/system.web.mvc.defaultcontrollerfactory.aspx">DefaultControllerFactory</a>.</p>

<p>Zum Glück kann man auch eine eigene ControllerFactory schreiben. So würde es im Grunde aussehen:</p>

<p>
  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:89a4ad22-9ec1-4579-9844-6dded75da5d6" class="wlWriterEditableSmartContent"><pre name="code" class="c#">// nur für Demozwecke. Im richtigen Beispiel nutze ich MvcContrib
public class ControllerFactory : IControllerFactory
{
    public IController CreateController(RequestContext context, Type controllerType)
    {
        return IoC.Resolve&lt;IController&gt;(controllerType.Name);
    }
}</pre></div>
</p>

<p>Es gibt im MVC Framework momentan noch ein paar Ecken wo man nur über Umwege die Objekterzeugung steuern kann. Bei ActionFiltern wird es z.B. etwas kniffliger (<a href="http://www.lostechies.com/blogs/jimmy_bogard/archive/2010/05/03/dependency-injection-in-asp-net-mvc-filters.aspx">geht aber wohl auch</a> - vielleicht ein anderer Blogpost). Dies soll aber mit <a href="http://aspnet.codeplex.com/wikipage?title=Road%20Map&amp;ProjectName=aspnet">MVC3 besser werden</a> :)</p>

<p><strong>MvcContrib</strong> </p>

<p>Ich nutze dafür aus dem <a href="http://mvccontrib.codeplex.com/">MvcContrib</a> Projekt die WindsorControllerFactory, benötigt werden aus den vielen DLLs lediglich zwei:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image994.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb178.png" width="244" height="194" /></a>&#160;</p>

<p><strong>Der Einstiegspunkt - Global.asax</strong></p>

<p>In die Global.asax habe ich einfach noch eine "Bootstrapper” Methode eingebaut:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c8554a38-99d5-49d4-8b4f-e5bb8e1cadf2" class="wlWriterEditableSmartContent"><pre name="code" class="c#">        protected void Application_Start()
        {
            Bootstrapper();

            AreaRegistration.RegisterAllAreas();
            RegisterRoutes(RouteTable.Routes);
        }

        private void Bootstrapper()
        {
            IWindsorContainer container = new WindsorContainer();
            // IFooService with DummyFooService
            container.Register(AllTypes.Pick().FromAssembly(typeof(MvcApplication).Assembly)
                    .WithService.FirstInterface());
            // Controller
            container.RegisterControllers(typeof(HomeController).Assembly);

            // Set the controller factory
            ControllerBuilder.Current.SetControllerFactory(new WindsorControllerFactory(container));
        }</pre></div>

<p>Durch das nutzen der "WindsorControllerFactory” müssen auch alle Controller registriert werden. Dies geschieht in Zeile 16. In Zeile 19 wird dann die ControllerFactory gesetzt.</p>

<p>Fertig. Die richtige Implementation landet beim Aufruf des HomeControllers auch dort wo sie hin soll.</p>

<p><strong>Für andere IoC Container</strong></p>

<p>Phil Haack hat z.B. <a href="http://haacked.com/archive/2007/12/07/tdd-and-dependency-injection-with-asp.net-mvc.aspx">ein Post</a> mit StructureMap gemacht. In <a href="http://www.pnpguidance.net/Post/SetDefaultControllerFactoryIControllerFactoryASPNETMVCFramework.aspx">diesem Post</a> wird es mit Spring.NET gemacht.</p>

<p><strong>Wenn es komplexer wird</strong></p>

<p>In <a href="http://blog.coreycoogan.com/2009/11/06/castle-windsor-tutorial-in-asp-net-mvc/">diesem Post von Corey Coogan</a> ist ein komplexeres Beispiel erläutert. Jedenfalls hat mir der Blogpost recht viel gebracht und mein Blogpost soll es nur (etwas simpler) wiedergeben.</p>

<p><a href="{{BASE_PATH}}/assets/files/democode/mvccontrollerinjection/mvccontrollerinjection.zip"><strong>[ Download Democode ]</strong></a></p>
