---
layout: page
title: Most Recent Blog Posts
title-image: /assets/icons/logo_260x260.png
---
{% include JB/setup %}

<div>
  {% assign englishPosts = site.posts | where: "language", "en" %}
  {% for post in englishPosts limit:20 %}
	<div class="row">
		<div class="col-md-12">
			<a href="{{ BASE_PATH }}{{ post.url }}"><h2>{{ post.title }}</h2></a>
			<p>{{ post.description }}</p>
			<p><i>Posted on {{ post.date | date_to_string }} by {{ post.author }}</i></p>
			<hr>
		</div>
	</div>
  {% endfor %}
</div>
