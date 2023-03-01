---
layout: list
title: Comedy songs about climate change
description: Here's all my novelty songs about the climate crisis
image: /blog/vampireconspiracy.jpg
permalink: /songs/
videos: true
images: true
---

# Songs

<div class="posts" markdown="0">
{% assign projects = site.data.songs %}
{% for item in projects %}
    <h2>{{ item.category }}</h2>
    {% include project.html project=item %}
{% endfor %}
</div>

---

# Short songs

<div markdown="0">
{% for post in site.posts %}
  {% if post.shortsong %}
    {% include post-title.html post=post %}
  {% endif %}
{% endfor %}
</div>

