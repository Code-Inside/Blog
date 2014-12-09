---
layout: post
title: "ASP.NET MVC - Paging implementieren"
date: 2008-04-01 19:31
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [ASP.NET MVC, Paging]
language: de
---
{% include JB/setup %}
<p>In meinem kleinen Testprojekt (was ich auch demn&#228;chst hier ver&#246;ffentlichen werde) baue ich eine Art <a href="http://dotnetkicks.com/">DotNetKicks</a> bzw. <a href="http://dotnetkicks.com/">Digg</a> Klon. Sowas gibts zwar schon und nennt sich &quot;<a href="http://www.codeplex.com/Kigg">Kigg</a>&quot;, aber ich hab damit noch etwas mehr vor und wollte mich einarbeiten :)</p>  <p>Momentaner Stand sieht (auf der Startseite) so aus:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image364.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="243" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb343.png" width="377" border="0" /></a> </p>  <p>&#196;hnlich wie bei den oben genannten Seite hab ich auch ein Paging implementiert:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image365.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="125" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb344.png" width="244" border="0" /></a> </p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image366.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="58" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb345.png" width="232" border="0" /></a> </p>  <p>Zuerst hab ich die L&#246;sung von <a href="http://blog.wekeroad.com/2007/12/10/aspnet-mvc-pagedlistt/">Rob Conery</a> gefunden.</p>  <p>Allerdings fing dort das z&#228;hlen bei 0 an - und eine Seite 0 hat mir nicht wirklich gefallen, daher hab ich diese Klasse etwas erweitert und noch eine TotalPages Property hinzugef&#252;gt:</p>  <pre style="width: 510px; overflow: auto;">    <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> PagedList&lt;T&gt; : List&lt;T&gt;
    {
        <span style="color: #0000ff">public</span> PagedList(IQueryable&lt;T&gt; source, <span style="color: #0000ff">int</span> index, <span style="color: #0000ff">int</span> pageSize)
        {
            <span style="color: #0000ff">this</span>.TotalCount = source.Count();
            <span style="color: #0000ff">this</span>.PageSize = pageSize;
            <span style="color: #0000ff">this</span>.PageIndex = index;
            <span style="color: #0000ff">this</span>.AddRange(source.Skip((index - 1) * pageSize).Take(pageSize).ToList());

            <span style="color: #0000ff">int</span> pageResult = 0;
            <span style="color: #0000ff">for</span> (<span style="color: #0000ff">int</span> counter = 1; pageResult &lt; <span style="color: #0000ff">this</span>.TotalCount; counter++)
            {
                pageResult = counter * <span style="color: #0000ff">this</span>.PageSize;
                <span style="color: #0000ff">this</span>.TotalPages = counter;
            }
        }

        <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> TotalPages
        {
            <span style="color: #0000ff">get</span>;
            <span style="color: #0000ff">set</span>;
        }

        <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> TotalCount
        {
            <span style="color: #0000ff">get</span>;
            <span style="color: #0000ff">set</span>;
        }

        <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> PageIndex
        {
            <span style="color: #0000ff">get</span>;
            <span style="color: #0000ff">set</span>;
        }

        <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> PageSize
        {
            <span style="color: #0000ff">get</span>;
            <span style="color: #0000ff">set</span>;
        }

        <span style="color: #0000ff">public</span> <span style="color: #0000ff">bool</span> HasPreviousPage
        {
            <span style="color: #0000ff">get</span>
            {
                <span style="color: #0000ff">return</span> (PageIndex &gt; 1);
            }
        }

        <span style="color: #0000ff">public</span> <span style="color: #0000ff">bool</span> HasNextPage
        {
            <span style="color: #0000ff">get</span>
            {
                <span style="color: #0000ff">return</span> (PageIndex * PageSize) &lt;= TotalCount;
            }
        }
    }

    <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">class</span> Pagination
    {
        <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> PagedList&lt;T&gt; ToPagedList&lt;T&gt;(<span style="color: #0000ff">this</span> IQueryable&lt;T&gt; source, <span style="color: #0000ff">int</span> index, <span style="color: #0000ff">int</span> pageSize)
        {
            <span style="color: #0000ff">return</span> <span style="color: #0000ff">new</span> PagedList&lt;T&gt;(source, index, pageSize);
        }

        <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> PagedList&lt;T&gt; ToPagedList&lt;T&gt;(<span style="color: #0000ff">this</span> IQueryable&lt;T&gt; source, <span style="color: #0000ff">int</span> index)
        {
            <span style="color: #0000ff">return</span> <span style="color: #0000ff">new</span> PagedList&lt;T&gt;(source, index, 10);
        }
    }</pre>

<p> F&#252;r das letztliche Design hab ich die CSS von <a href="http://woork.blogspot.com/2008/03/perfect-pagination-style-using-css.html">diesem Blogpost</a> hier genommen.</p>

<p>In meinem List View sieht das am Ende dann so aus (was mich etwas an meine PHP Zeiten erinnert) :</p>

<pre style="width: 510px; overflow: auto;">    <span style="color: #0000ff">&lt;</span><span style="color: #800000">ul</span> <span style="color: #ff0000">class</span>=<span style="color: #0000ff">&quot;pagination-clean&quot;</span><span style="color: #0000ff">&gt;</span>
            <span style="color: black; background-color: #ffff00">&lt;%</span> if (ViewData.EntryList.HasPreviousPage)
               { <span style="color: black; background-color: #ffff00">%&gt;</span>
                <span style="color: #0000ff">&lt;</span><span style="color: #800000">li</span> <span style="color: #ff0000">class</span>=<span style="color: #0000ff">&quot;previous&quot;</span><span style="color: #0000ff">&gt;</span><span style="color: black; background-color: #ffff00">&lt;%</span>=Html.ActionLink<span style="color: #0000ff">&lt;</span><span style="color: #800000">Mvc2.Controllers.EntryController</span><span style="color: #0000ff">&gt;</span>(c =&gt; c.List(ViewData.Category, ViewData.EntryList.PageIndex - 1), &quot;&#171; Previous&quot;)<span style="color: black; background-color: #ffff00">%&gt;</span><span style="color: #0000ff">&lt;/</span><span style="color: #800000">li</span><span style="color: #0000ff">&gt;</span>
            <span style="color: black; background-color: #ffff00">&lt;%</span> }
               else
               { <span style="color: black; background-color: #ffff00">%&gt;</span>
                <span style="color: #0000ff">&lt;</span><span style="color: #800000">li</span> <span style="color: #ff0000">class</span>=<span style="color: #0000ff">&quot;previous-off&quot;</span><span style="color: #0000ff">&gt;</span>&#171; Previous<span style="color: #0000ff">&lt;/</span><span style="color: #800000">li</span><span style="color: #0000ff">&gt;</span>
            <span style="color: black; background-color: #ffff00">&lt;%</span> } <span style="color: black; background-color: #ffff00">%&gt;</span>
            
            
            <span style="color: black; background-color: #ffff00">&lt;%</span>for (int page = 1; page <span style="color: #0000ff">&lt;</span>= ViewData.EntryList.TotalPages; page++)
              { 
                if (page == ViewData.EntryList.PageIndex)
                { %<span style="color: #0000ff">&gt;</span>
                <span style="color: #0000ff">&lt;</span><span style="color: #800000">li</span> <span style="color: #ff0000">class</span>=<span style="color: #0000ff">&quot;active&quot;</span><span style="color: #0000ff">&gt;</span><span style="color: black; background-color: #ffff00">&lt;%</span>=page.ToString()<span style="color: black; background-color: #ffff00">%&gt;</span><span style="color: #0000ff">&lt;/</span><span style="color: #800000">li</span><span style="color: #0000ff">&gt;</span>
               <span style="color: black; background-color: #ffff00">&lt;%</span>}
                
                else
                { <span style="color: black; background-color: #ffff00">%&gt;</span>
                    <span style="color: #0000ff">&lt;</span><span style="color: #800000">li</span><span style="color: #0000ff">&gt;</span><span style="color: black; background-color: #ffff00">&lt;%</span>=Html.ActionLink<span style="color: #0000ff">&lt;</span><span style="color: #800000">Mvc2.Controllers.EntryController</span><span style="color: #0000ff">&gt;</span>(c =&gt; c.List(ViewData.Category, page), page.ToString())<span style="color: black; background-color: #ffff00">%&gt;</span><span style="color: #0000ff">&lt;/</span><span style="color: #800000">li</span><span style="color: #0000ff">&gt;</span>
               <span style="color: black; background-color: #ffff00">&lt;%</span>}
              } 
              
              if (ViewData.EntryList.HasNextPage)
               { <span style="color: black; background-color: #ffff00">%&gt;</span>
                <span style="color: #0000ff">&lt;</span><span style="color: #800000">li</span> <span style="color: #ff0000">class</span>=<span style="color: #0000ff">&quot;next&quot;</span><span style="color: #0000ff">&gt;</span><span style="color: black; background-color: #ffff00">&lt;%</span>=Html.ActionLink<span style="color: #0000ff">&lt;</span><span style="color: #800000">Mvc2.Controllers.EntryController</span><span style="color: #0000ff">&gt;</span>(c =&gt; c.List(ViewData.Category, ViewData.EntryList.PageIndex + 1), &quot;Next &#187;&quot;)<span style="color: black; background-color: #ffff00">%&gt;</span><span style="color: #0000ff">&lt;/</span><span style="color: #800000">li</span><span style="color: #0000ff">&gt;</span>
            <span style="color: black; background-color: #ffff00">&lt;%</span> }
               else
               { <span style="color: black; background-color: #ffff00">%&gt;</span>
                <span style="color: #0000ff">&lt;</span><span style="color: #800000">li</span> <span style="color: #ff0000">class</span>=<span style="color: #0000ff">&quot;next-off&quot;</span><span style="color: #0000ff">&gt;</span>Next &#187;<span style="color: #0000ff">&lt;/</span><span style="color: #800000">li</span><span style="color: #0000ff">&gt;</span>
            <span style="color: black; background-color: #ffff00">&lt;%</span> } <span style="color: black; background-color: #ffff00">%&gt;</span>
        <span style="color: #0000ff">&lt;/</span><span style="color: #800000">ul</span><span style="color: #0000ff">&gt;</span> </pre>

<p></p>

<p>In ViewData.EntryList steckt am Ende nur die PageList. Meinem EntryContoller (bzw. dessen &quot;List&quot; Methode) &#252;bergeb ich die momentan angew&#228;hlte Kategorie und die Seite.</p>

<p>Resultat ist am Ende ein funktionierendes Paging, mit solchen URLs: <a title="http://localhost:56891/Entry/List/All/3" href="http://localhost:56891/Entry/List/All/3">http://localhost:56891/Entry/List/All/3</a> f&#252;r Seite 3 bei allen Kategorien. </p>

<p>Den kompletten Source Code werde ich sp&#228;ter noch nachreichen - zusammen mit dem gesamten MVC Testprojekt</p>
