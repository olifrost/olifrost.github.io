---
layout: post
title: Novelty songs about the climate crisis
description: Here's all my novelty songs about the climate crisis
image: /blog/vampireconspiracy.jpg
permalink: /songs
videos: true
images: true
---

<div class="posts" markdown="0">
{% assign projects = site.data.songs %}
{% for item in projects %}
    <h2>{{ item.category }}</h2>
    {% include project.html project=item %}
{% endfor %}
</div>

