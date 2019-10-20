---
layout: default
title: Oli Frost
videos: true
image: /blog/shook-1.jpg
---
<span><semibold>Latest Update</semibold> {% for post in site.posts limit:1 %}
<a href="{{ post.url }}">>> {{ post.title }} </a><br>{% endfor %}</span>

<div class="posts">

{% assign portfolio = site.portfolio | sort: 'order' %}

  {% for project in portfolio %}
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

# Work For Causes
<p></p>

{% assign causes = site.causes | sort: 'order' %}

  {% for project in causes %}
  <div class="project-section">
        {% if forloop.index < 2 %}
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


--------------

# Work For Brands

{% assign brands = site.brands | sort: 'order' %}
{% for project in brands limit: 4 %}
<div class="project-section">
          {% if project.video != nil %}
          <div class="youtube-player" data-id="{{ project.video }}" data-thumb="{{ project.image }}"></div>
          {% else %}
          <img src="{{ project.image | relative_url }}">
          {% endif %}
          <a href="{{ project.link }}"><span class="title">>> {{ project.title }}</span></a>
          <p> {{ project.description }}<br>
          </p>
    </div>
{% endfor %}

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
