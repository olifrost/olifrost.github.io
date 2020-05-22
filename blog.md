---
layout: default
title: Blog
---

## Top posts

{% include featured-post.html %}

## All posts

{% for post in site.posts %}

{% if post.featured %}
{% else %}
  <div class="post">
    {% include post-title.html post=post %}
  </div>
{% endif %}
{% endfor %}
