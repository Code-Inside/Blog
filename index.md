---
layout: page
title: Welcome to our Blog
---
{% include JB/setup %}

<div>
  {% for post in site.posts %}
	<div class="row">
		<div class="col-xs-6">
			<a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a>
		</div>
		<div class="col-xs-6">
			<span class="pull-right">
			{{ post.date | date_to_string }}
			</span>
		</div>
	</div>
  {% endfor %}
</div>
