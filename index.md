---
layout: default
title: Oli Frost
videos: true
carousel-items: 1
---

<style>

  h6 {
    text-align: center;
    font-size: 4rem;
  }

  a {
    white-space: nowrap;
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

# Other climate projects

<div class="posts" markdown="0">
  {% assign projects = site.data.refrost %}
  {% for item in projects | limit: 3 %}
        {% include project.html project=item %}
  {% endfor %}
</div>

---

###### Show me [more climate projects](/refrost/)


---

# Past stuff

<div class="posts" markdown="0">
  {% assign projects = site.data.portfolio %}
  {% for item in projects | limit: 3 %}
        {% include project.html project=item %}
  {% endfor %}
</div>


---

###### Show me [more past stuff](/archive/)

---