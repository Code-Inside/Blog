---
layout: post
title: "ASP.NET MVC - Pagination View User Control"
date: 2008-04-08 18:53
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [ASP.NET MVC]
---
<p>Bereits hier habe ich &#252;ber das <a href="http://code-inside.de/blog/2008/04/01/aspnet-mvc-paging-implementieren/">Paging</a> geschrieben - da dieses Feature eigentlich auf fast allen Seiten irgendwie benutzt wird, musste ich dies kapseln. </p>  <p>Beispiel daf&#252;r:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image373.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="119" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb352.png" width="353" border="0" /></a> </p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image374.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="340" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb353.png" width="339" border="0" /></a> </p>  <p>Vorteile wenn man das in einem Control b&#252;ndelt:</p>  <p>- Design ist gleich   <br />- &#196;nderungen k&#246;nnen zentral eingespielt werden</p>  <p>F&#252;r das Design k&#246;nnte man sich <a href="http://woork.blogspot.com/2008/03/perfect-pagination-style-using-css.html">hier</a> Inspiration holen.</p>  <p><strong><u>Dateistruktur</u></strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image375.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="79" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb354.png" width="242" border="0" /></a>&#160; </p>  <p>Es ist ein einfaches MVC View User Control.</p>  <p><strong><u>Code</u></strong></p>  <p>Pagination.ascx</p>  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ac53f895-2c91-4dd0-a0cf-4f84697589b4" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Pagination.ascx.cs" Inherits="Mvc2.Views.Shared.Pagination" %&gt;
&lt;ul class="pagination-clean"&gt;
    &lt;% if (ViewData.HasPreviousPage)
        { %&gt;
          &lt;li class="previous"&gt;&lt;a href="&lt;%=ViewData.PageActionLink.Replace("%7Bpage%7D", (ViewData.PageIndex - 1).ToString())%&gt;"&gt;Â« Previous&lt;/a&gt;&lt;/li&gt;
     &lt;% }
       else
        { %&gt;
          &lt;li class="previous-off"&gt;Â« Previous&lt;/li&gt;
     &lt;% } %&gt;
                  
     &lt;%for (int page = 1; page &lt;= ViewData.TotalPages; page++)
        { 
        if (page == ViewData.PageIndex)
            { %&gt;
              &lt;li class="active"&gt;&lt;%=page.ToString()%&gt;&lt;/li&gt;
         &lt;% }
        else
            { %&gt;
              &lt;li&gt;&lt;a href="&lt;%=ViewData.PageActionLink.Replace("%7Bpage%7D", page.ToString())%&gt;"&gt;&lt;%=page.ToString()%&gt;&lt;/a&gt;&lt;/li&gt;
         &lt;% }
        } 
              
       if (ViewData.HasNextPage)
            { %&gt;
              &lt;li class="next"&gt;&lt;a href="&lt;%=ViewData.PageActionLink.Replace("%7Bpage%7D", (ViewData.PageIndex + 1).ToString())%&gt;"&gt;Next Â»&lt;/a&gt;&lt;/li&gt;
         &lt;% }
       else
            { %&gt;
               &lt;li class="next-off"&gt;Next Â»&lt;/li&gt;
         &lt;% } %&gt;
&lt;/ul&gt; </pre></div>

<p>Pagination.ascx.cs</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d0cdee77-1bed-4a68-a58c-6417c5764d69" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Mvc2.Views.Shared
{
    public class PaginationViewData
    {
        public int PageIndex { get; set; }
        public int TotalPages { get; set; }
        public int PageSize { get; set; }
        public int TotalCount { get; set; }
        public string PageActionLink { get; set; }
        public bool HasPreviousPage
        {
            get
            {
                return (PageIndex &gt; 1);
            }
        }

        public bool HasNextPage
        {
            get
            {
                return (PageIndex * PageSize) &lt;= TotalCount;
            }
        }
    }

    public partial class Pagination : System.Web.Mvc.ViewUserControl&lt;PaginationViewData&gt;
    {
        public Pagination()
        {

        }
    }
}
</pre></div>

<p>Die PaginationViewData Klasse kapselt am Ende nur die Daten - streng typisierte ViewDatas.</p>

<p><strong><u>Anwendung - Helper &quot;PagedList&quot;</u></strong></p>

<p>Die Anwendung des Controls ist recht einfach gestaltet, insbesondere wenn man bereits diese &quot;PagedList&quot; Klasse als Typ in seinem ViewData benutzt:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:747bd65b-d4f4-419c-8b99-3398597fee78" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;

namespace Mvc2.Helpers
{
    public class PagedList&lt;T&gt; : List&lt;T&gt;
    {
        public PagedList(IQueryable&lt;T&gt; source, int index, int pageSize)
        {
            this.TotalCount = source.Count();
            this.PageSize = pageSize;
            this.PageIndex = index;
            this.AddRange(source.Skip((index - 1) * pageSize).Take(pageSize).ToList());

            int pageResult = 0;
            for (int counter = 1; pageResult &lt; this.TotalCount; counter++)
            {
                pageResult = counter * this.PageSize;
                this.TotalPages = counter;
            }
        }

        public int TotalPages
        {
            get;
            set;
        }

        public int TotalCount
        {
            get;
            set;
        }

        public int PageIndex
        {
            get;
            set;
        }

        public int PageSize
        {
            get;
            set;
        }

        public bool HasPreviousPage
        {
            get
            {
                return (PageIndex &gt; 1);
            }
        }

        public bool HasNextPage
        {
            get
            {
                return (PageIndex * PageSize) &lt;= TotalCount;
            }
        }
    }

    public static class Pagination
    {
        public static PagedList&lt;T&gt; ToPagedList&lt;T&gt;(this IQueryable&lt;T&gt; source, int index, int pageSize)
        {
            return new PagedList&lt;T&gt;(source, index, pageSize);
        }

        public static PagedList&lt;T&gt; ToPagedList&lt;T&gt;(this IQueryable&lt;T&gt; source, int index)
        {
            return new PagedList&lt;T&gt;(source, index, 10);
        }
    }
}
</pre></div>

<p>Das Original stammt von <a href="http://blog.wekeroad.com/2007/12/10/aspnet-mvc-pagedlistt/">Rob Conery</a> - ich habe daran nur ver&#228;ndert, dass zuerst die &quot;Seite 1&quot; zu sehen ist - weil eine &quot;Seite 0&quot; w&#252;rde am Ende die Nutzer nur verwirren.</p>

<p><strong><u>Anwendung - Im View</u></strong></p>

<p>In unserem View (in dem das Control dargestellt werden soll) bauen wir das &#252;ber den Html.RenderUserControl recht simpel ein:</p>

<p>
  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c4cdc69f-778a-48d0-9094-bbd26e6e6054" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    &lt;%=Html.RenderUserControl("~/Views/Shared/Pagination.ascx", new Mvc2.Views.Shared.PaginationViewData()
      {
          PageIndex = ViewData.EntryList.PageIndex,
          TotalPages = ViewData.EntryList.TotalPages,
          PageActionLink = Url.Action("List","Entry", new { category = ViewData.Category, page = "{page}"}),
          TotalCount = ViewData.EntryList.TotalCount,
          PageSize = ViewData.EntryList.PageSize
      }, null)%&gt;</pre></div>
</p>

<p>Hier &#252;bergeben wir jetzt die &quot;Zustandsdaten&quot; von unserem View dem Control. Ein wichtiger Punkt ist der &quot;PageActionLink&quot;. Dieser Link ruft am Ende wieder den Controller auf - z.B. den Link &quot;/Management/Tag/2&quot; w&#252;rde meinen <strong>&quot;Management&quot;-Controller</strong> aufrufen und dort die <strong>&quot;Tag&quot;-Action</strong> mit der entsprechenden Seitenanzahl. Da diese Anzeige mit &quot;1&quot;, &quot;2&quot;, &quot;3&quot;...</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image376.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="33" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb355.png" width="217" border="0" /></a> </p>

<p>...dynamisch erstellt wird, dient der {page} Parameter hier als Template. Was sp&#228;ter durch die einzelnen Seiten ersetzt wird:</p>

<p>
  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:33d6efe7-5ffc-4189-a145-73061fd7a7b6" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;li&gt;&lt;a href="&lt;%=ViewData.PageActionLink.Replace("%7Bpage%7D", page.ToString())%&gt;"&gt;&lt;%=page.ToString()%&gt;&lt;/a&gt;&lt;/li&gt;</pre></div>
</p>

<p>&quot;%7B&quot; steht dabei f&#252;r { und &quot;%7D&quot; f&#252;r } - der URL Helper maskiert diese Zeichen so.
  <br />Einfach in den Quellcode des Controls schauen - dann ergibt es einen Sinn ;)</p>

<p>Ich werde mein Beispiel demn&#228;chst mal in einer Beta ver&#246;ffentlichen - dann kann man das ganze auch in Aktion sehen. Ansonsten sind alle wesentlichen Klassen in diesem Post aufgef&#252;hrt :)</p>
