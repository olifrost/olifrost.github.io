---
layout: default
title: Oli Frost
videos: true
image: /posters/portraits/olifrost-0.greta.jpg
carousel-items: 1
---

{% include opening %}

<div class="posts" markdown="0">
  {% assign projects = site.data.portfolio %}
  {% for item in projects %}
        {% include project.html project=item %}
  {% endfor %}
</div>

---

# Show me everything

{% include featured-post.html %}

---
