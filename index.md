---
layout: default
title: Oli Frost
videos: true
image: /blog/olifrost.jpg
carousel-items: 1
---

<div markdown="1">

{% include bio %}

My work has been featured everywhere from UK Parliament to Britain's Got Talent, BBC to Fox News, in art shows, and on bins.

<span><semibold>Most recently,</semibold> {% for post in site.posts limit:1 %}
<a href="{{ post.url }}"> {{ post.title }} </a><br>{% endfor %}</span>

</div>

<div class="posts" markdown="0">
  {% assign projects = site.data.portfolio %}
  {% for item in projects limit: 6 %}
        {% include project.html project=item %}
  {% endfor %}
</div>

---

# Work For Causes & Brands

<div class="posts" markdown="0">
  {% assign causes = site.causes %}

  {% for project in causes %}
  {% if forloop.index < 3 %}
        {% include project.html project=project %}
  {% endif %}  
  {% endfor %}
</div>

<div class="posts" markdown="0">
  {% assign brands = site.brands %}
  {% for project in brands limit: 2 %}
        {% include project.html project=project %}
  {% endfor %}
</div>


<div class="posts" markdown="0">

  {% for project in causes %}
  {% if forloop.index == 3 %}
        {% include project.html project=project %}
  {% endif %}  
  {% endfor %}
</div>

**[>> See More](/work)**

---

# Further Reading

{% include featured-post.html %}

---
