---
layout: post
title: "ASP.NET MVC: Using a ActionFilter for logging"
date: 2008-04-17 21:07
author: Robert Muehsig
comments: true
categories: [Uncategorized]
tags: [ActionFilters, ASP.NET MVC, log4net, logging]
language: en
---
{% include JB/setup %}
<p>The &quot;pre-&quot; preview 3 of the MVC Framework (<a href="{{BASE_PATH}}/2008/04/17/aspnet-mvc-april-codeplex-source-push/">see here for more information</a>) introduced new features for the ActionFilter.</p>
<p>The &quot;FilterExecutingContext&quot; (using in the OnActionExecuted method) and &quot;FilterExecutedContext&quot; (using in the OnActionExecuting method) are now called &quot;ActionEx...Context&quot;.</p>
<p>This is the complete method list from an ActionFilter in this pre-preview:</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a8515567-54a8-4a50-93fe-626175cf3f8e" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
<pre name="code" class="c#">        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            ActionExecutingContext contect = filterContext;
            string test = contect.ActionMethod.ToString();
        }

        public override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            ActionExecutedContext context = filterContext;
            string test = context.ActionMethod.ToString();
        }

        public override void OnResultExecuting(ResultExecutingContext filterContext)
        {
            ResultExecutingContext context = filterContext;
            string test = context.ToString();
        }


        public override void OnResultExecuted(ResultExecutedContext filterContext)
        {
            ResultExecutedContext context = filterContext;
            string test = context.ToString();
        }
</pre>
</div>


<p>A great new feature: You have access to the viewdata form the...</p>

<ul>
  <li>ResultExecutedContext</li>

  <li>ResultExecutingContext</li>

  <li>ActionExecutedContext Yeah!</li>
</ul>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image12.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="259" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image-thumb12.png" width="523" border="0" /></a>&#160;</p>

<p>With this feature we can now build a very smart logger: Get all ViewData typ information recursive and save this by using <a href="http://logging.apache.org/log4net/">Log4Net</a>.</p>

<p>I use this &quot;<a href="http://www.codeguru.com/csharp/csharp/cs_syntax/reflection/article.php/c5885/">DumpObject Code</a>&quot; and <a href="http://www.codeproject.com/KB/aspnet/log4net.aspx?df=100&amp;forumid=323468&amp;exp=0&amp;select=1580054">configure Log4Net like this guy</a>.</p>

<p>The &quot;simple log FilterAction&quot;:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5b0b7acf-4108-4220-b61f-f2e14ac8eb9f" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
<pre name="code" class="c#">namespace Mvc2.Filters
{
    public class LogAttribute : ActionFilterAttribute
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(LogAttribute).Name);

        public override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            ActionExecutedContext context = filterContext;
            
            StringBuilder logMessage = new StringBuilder();
            logMessage.AppendLine(context.ActionMethod.Name);
            
            if(context.Result.GetType() == typeof(RenderViewResult))
            {
                RenderViewResult viewResult = context.Result as RenderViewResult;
                logMessage.AppendLine("ActionResult: RenderViewResult");
                logMessage.AppendLine();
                logMessage.AppendLine(Dumper.DumpObject(viewResult.ViewData, 5));
            }
            logMessage.AppendLine();
            log.Info(logMessage.ToString());
        }

    }
}
</pre>
</div>


<p>And now just add the attribute above the Controller:</p>

<p>
  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0a74a792-ef0b-4252-a6db-b510a98a35c9" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
<pre name="code" class="c#">[Log]
public class EntryController : Controller
{...}
</pre>
</div>

</p>

<p>The result in the log.txt:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:157f822e-b64b-4c41-b81a-b134f7cf4f7f" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px">
<pre name="code" class="c#">2008-04-17 20:41:02,204 [10] INFO  LogAttribute [(null)] - List
ActionResult: RenderViewResult

[ObjectToDump] AS Mvc2.Views.Entry.ListViewData = Mvc2.Views.Entry.ListViewData
+&lt;EntryList&gt;k__BackingField AS Mvc2.Helpers.PagedList`1[[Mvc2.Models.DataObjects.Entry, Mvc2, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null]] = Mvc2.Helpers.PagedList`1[Mvc2.Models.DataObjects.Entry]
|+&lt;TotalPages&gt;k__BackingField AS System.Int32 = 2
|+&lt;TotalCount&gt;k__BackingField AS System.Int32 = 17
|+&lt;PageIndex&gt;k__BackingField AS System.Int32 = 1
|+&lt;PageSize&gt;k__BackingField AS System.Int32 = 10
+(System.Collections.Generic.List`1[[Mvc2.Models.DataObjects.Entry, Mvc2, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null]])
|+_items AS Mvc2.Models.DataObjects.Entry[] = Mvc2.Models.DataObjects.Entry[]
||+[0] AS Mvc2.Models.DataObjects.Entry = Mvc2.Models.DataObjects.Entry
|||+_Id AS System.Guid = 797c70f0-f571-4969-80e8-d4a085445b6d
|||+_Title AS System.String = test
|||+_Url AS System.String = test
|||+_UserId AS System.Guid = cf2e5ccc-bd32-405d-bd54-eda112ebe06c
|||+_Link AS System.String = http...
|||+_Description AS System.String = tealkjdlsakj
|||+_CategoryId AS System.Guid = 7bd8028e-02c1-45f4-a0a6-403f5bf0ff0c
|||+_Date AS System.DateTime = 17.04.2008 15:48:53
|||+_EntryTags AS System.Data.Linq.EntitySet`1[[Mvc2.Models.DataObjects.EntryTag, Mvc2, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null]] = System.Data.Linq.EntitySet`1[Mvc2.Models.DataObjects.EntryTag]
|||+_Category AS System.Data.Linq.EntityRef`1[[Mvc2.Models.DataObjects.Category, Mvc2, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null]] = System.Data.Linq.EntityRef`1[Mvc2.Models.DataObjects.Category]
|||+PropertyChanging AS System.ComponentModel.PropertyChangingEventHandler = System.ComponentModel.PropertyChangingEventHandler
|||+(System.MulticastDelegate)
|||+(System.Delegate)
||+[1] AS Mvc2.Models.DataObjects.Entry = Mvc2.Models.DataObjects.Entry
|||+_Id AS System.Guid = 8e1554c1-47fa-4db5-af41-91c3fcf92fb3
|||+_Title AS System.String = EntryTitle
|||+_Url AS System.String = EntryTitle_13
|||+_UserId AS System.Guid = cf2e5ccc-bd32-405d-bd54-eda112ebe06c
|||+_Link AS System.String = http://.../
|||+_Description AS System.String = Blabla
|||+_CategoryId AS System.Guid = 16d09b0a-2157-43b7-a881-b536e90f7fbf
...
</pre>
</div>


<p>This is not the perfect solution - but it should show the &quot;power&quot; of the new ActionFilters.</p>

<p>I will try to create a better (and more readable) version in the next days - with the RouteData/submitted parameters and so on :)</p>
