---
layout: page
title: Home
title-image: /assets/icons/logo_260x260.png
---
{% include JB/setup %}

<div class="post-list">
  {% assign englishPosts = site.posts | where: "language", "en" %}
  {% for post in englishPosts limit:20 %}
	<a class="post-card" href="{{ BASE_PATH }}{{ post.url }}">
		<h2>{{ post.title }}</h2>
		{% if post.description %}<p>{{ post.description }}</p>{% endif %}
		<div class="post-meta">
			<span><i class="fa fa-calendar"></i> {{ post.date | date_to_string }}</span>
			<span><i class="fa fa-user"></i> {{ post.author }}</span>
		</div>
	</a>
  {% endfor %}
</div>

<div class="post-list-more">
	<a class="btn-ghost" href="{{ BASE_PATH }}/archive">All posts <i class="fa fa-arrow-right"></i></a>
</div>
