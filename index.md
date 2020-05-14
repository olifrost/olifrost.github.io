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

{% assign portfolio = site.portfolio | sort: 'order' %}

  {% for project in portfolio limit: 6 %}
        <div class="project-section">
        {% if project.video != nil %}
        <div class="youtube-player" data-id="{{ project.video }}" data-thumb="{{ project.image }}"></div>
        {% else %}
        <img src="{{ project.image | relative_url }}">
        {% endif %}
        <a href="{{ project.link }}"><span class="title">>> {{ project.title }}</span></a>
        <p> {{ project.description }}<br>
        {% if project.partner != nil %}<span class="partner">Made with {{ project.partner }}</span>{% endif %}
        {% for press in project.press %}
        <a href="{{ press.article_link }}" class="press">{{ press.name }}{% if forloop.last == false %},{% else %}.{% endif %}</a>
        {% endfor %}
        </p>

  </div>
  {% endfor %}
</div>

---

# Work For Causes & Brands
<p></p>

{% assign causes = site.causes | sort: 'order' %}

  {% for project in causes limit: 2 %}
  <div class="project-section">
        {% if forloop.index < 3 %}
        <img src="{{ project.image | relative_url }}">
        {% endif %}
        <a href="{{ project.link }}"><span class="title">>> {{ project.title }}</span></a>
        <p> {{ project.description }}<br>
        {% for press in project.press %}
        <a href="{{ press.article_link }}" class="press">{{ press.name }}{% if forloop.last == false %},{% else %}.{% endif %}</a>
        {% endfor %}
        </p>

  </div>
  {% endfor %}


{% assign brands = site.brands | sort: 'order' %}
{% for project in brands limit: 2 %}
<div class="project-section">
          {% if project.video != nil %}
          <div class="youtube-player" data-id="{{ project.video }}" data-thumb="{{ project.image }}"></div>
          {% else %}
          <img src="{{ project.image | relative_url }}">
          {% endif %}
          {% if project.link %}
          <a href="{{ project.link }}"><span class="title">>> {{ project.title }}</span></a>
          {% else %}
          <span class="title">>> {{ project.title }}</span>
          {% endif %}
          <p> {{ project.description }}<br>
          </p>
    </div>
{% endfor %}

{% assign causes = site.causes | sort: 'order' %}

  {% for project in causes %}
  {% if forloop.index == 3 %}
  <div class="project-section">

        {% if project.video != nil %}
        <div class="youtube-player" data-id="{{ project.video }}" data-thumb="{{ project.image }}"></div>
        {% else %}
        <img src="{{ project.image | relative_url }}">
        {% endif %}

        <a href="{{ project.link }}"><span class="title">>> {{ project.title }}</span></a>
        <p> {{ project.description }}<br>
        {% for press in project.press %}
        <a href="{{ press.article_link }}" class="press">{{ press.name }}{% if forloop.last == false %},{% else %}.{% endif %}</a>
        {% endfor %}
        </p>

  </div>
{% endif %}  
{% endfor %}

**[>> See More](/work)**

---

# Further Reading
{% for post in site.posts %}

{% if post.featured %}
  <div class="post">


    <h1 class="post-title" style="margin-bottom: 0rem;"><a href="{{ post.url }}">{{ post.title }}</a></h1>
    {% if post.description %}<p class="post-description">{{ post.description }}…</p>{% endif %}

  </div>
  {% endif %}
{% endfor %}
---------------
