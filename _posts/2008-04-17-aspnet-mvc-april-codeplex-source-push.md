---
layout: post
title: "ASP.NET MVC April CodePlex Source Push"
date: 2008-04-17 06:05
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [ASP.NET MVC, Codeplex, MVC]
---
Microsoft hat eine neue Version des MVC Frameworks auf Codeplex <a href="http://www.codeplex.com/aspnet/Release/ProjectReleases.aspx?ReleaseId=12640">released</a>.

Update: <a href="http://weblogs.asp.net/scottgu/archive/2008/04/16/asp-net-mvc-source-refresh-preview.aspx">Scott Guthrie hat nun einige Zeilen zu dem neuen "Release" geschrieben</a> - es ist nicht die MVC Preview 3, sondern eine "Preview" der "Preview" ;)

Wie bereits im Forum vom ASP.NET Team angekündigt, wurden die ActionFilter erweitert. Hier die Zusammenfassung von der <a href="http://www.codeplex.com/aspnet/Wiki/View.aspx?title=ReadMe">Codeplex Seite</a>:

<strong>MVC Changes Since Preview 2</strong>
<ul>
	<li>Action methods on Controllers now by default return an <em>ActionResult</em> instance, instead of void.
<ul>
	<li>This <em>ActionResult</em> object indicates the result from an action (a view to render, a URL to redirect to, another action/route to execute, etc).</li>
	<li>Each "result" is a type that inherits from <em>ActionResult</em>. To render a view, return a <em>RenderViewResult</em> instance.</li>
</ul>
</li>
	<li>The <em>RenderView()</em>, <em>RedirectToAction()</em>, and <em>Redirect()</em> helper methods on the <em>Controller</em> base class now return typed <em>ActionResult</em> objects (which you can further manipulate or return back from action methods).</li>
	<li>The <em>RenderView()</em> helper method can now be called without having to explicitly pass in the name of the view template you want to render.
<ul>
	<li>When you omit the template name the <em>RenderView()</em> method will by default use the name of the action method to determine the view template to render.</li>
	<li>So calling <em>RenderView()</em> with no parameters inside the <em>About()</em> action method is now the same as explicitly writing <em>RenderView('About')</em>.</li>
</ul>
</li>
	<li>Introduced a new <em>IActionFilter</em> interface for action filters. <em>ActionFilterAttribute</em> implements <em>IActionFilter</em>.</li>
	<li>Action Filters now have four methods they can implement representing four possible interception points.
<ul>
	<li><em>OnActionExecuting</em> which occurs just before the action method is called.</li>
	<li><em>OnActionExecuted</em> which occurs after the action method is called, but before the result is executed (aka before the view is rendered in common scenarios).</li>
	<li><em>OnResultExecuting</em> which occurs just before the result is executed (aka before the view is rendered in common scenarios).</li>
	<li><em>OnResultExecuted</em> which occurs after the result is executed (aka after the view is rendered in common scenarios).</li>
	<li>NOTE: The OnResult* methods will not be called if an exception is not handled during the invoking of the OnAction* methods or the action method itself.</li>
</ul>
</li>
	<li>Added a MapRoute extension method (extension on RouteCollection) for use in declaring MVC routes in a simpler fashion.</li>
</ul>
<strong>NOTE:</strong> It is pretty easy to update existing Controller classes built with Preview 2 to use this new pattern (just change void to ActionResult and add a return statement in front of any RenderView or RedirectToAction helper method calls).
<strong>Routing changes since Preview 2</strong>
<ul>
	<li>URLs may contain any literal (except for /) as a separator between URL parameters. For example, instead of {action}.{format} you can now have {action}-{format}. For more details on changes, see <a href="http://haacked.com/archive/2008/04/10/upcoming-changes-in-routing.aspx">this post</a>.</li>
	<li>Routing is ignored for files that exist on disk by default. This can be overriden by setting the <em>RouteTable.Routes.RouteExistingFiles</em> property to <em>true</em> (it is <em>false</em> by default).</li>
</ul>
Was das im Detail bedeutet und was man nun alles feines machen kann, werde ich mir mal in den nächsten Tagen anschauen :)
