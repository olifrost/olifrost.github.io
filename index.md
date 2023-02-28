---
layout: default
title: Oli Frost
videos: true
carousel-items: 1
---

<style>

  h6 {
    text-align: center;
    font-size: 5rem;
  }

</style>

{% include opening %}

<div class="posts" markdown="0">
  {% assign projects = site.data.songs %}
  {% for item in projects | limit: 3 %}
        {% include project.html project=item %}
  {% endfor %}
</div>

---

###### Show me [more songs](/songs/)

---

# Past stuff

<div class="posts" markdown="0">
  {% assign projects = site.data.portfolio %}
  {% for item in projects %}
        {% include project.html project=item %}
  {% endfor %}
</div>


---

# Even more stuff

{% include featured-post.html %}

---

###### Show me [everything](/blog/)

---