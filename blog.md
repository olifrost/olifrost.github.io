---
layout: default
title: Blog
---

## Top posts

{% for post in site.posts %}

{% if post.featured %}
  <div class="post">


    <h1 class="post-title" style="margin-bottom: 0rem;"><a href="{{ post.url }}">{{ post.title }}</a></h1>
    {% if post.description %}<p class="post-description">{{ post.description }}…</p>{% endif %}

  </div>
  {% endif %}
{% endfor %}

## All posts

{% for post in site.posts %}

{% if post.featured %}
{% else %}

  <div class="post">



    <h1 class="post-title" style="margin-bottom: 0rem;"><a href="{{ post.url }}">{{ post.title }}</a></h1>
    {% if post.description %}<p class="post-description">{{ post.description }}…</p>{% endif %}


  </div>
  {% endif %}
{% endfor %}
