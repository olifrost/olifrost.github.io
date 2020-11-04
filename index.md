---
layout: default
title: Oli Frost
videos: true
image: /blog/olifrost.jpg
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

{% include nextpage.html page1="Show me ads" link1="/work" page2="Show me films" link2="/reel" %}

---

# Show me everything

{% include featured-post.html %}

---
