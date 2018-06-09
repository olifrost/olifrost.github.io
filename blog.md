---
layout: default
title: Blog
---

  {% for post in site.posts %}


  <div class="post">

    <date>{{ post.date | date_to_long_string }}</date><br>

    <h1 class="post-title" style="margin-bottom: 0rem;"><a href="{{ post.url | prepend:site.baseurl }}">{{ post.title }}</a></h1>
    {% if post.description %}<p class="post-description">{{ post.description }}…</p>{% endif %}

  </div>
  {% endfor %}
