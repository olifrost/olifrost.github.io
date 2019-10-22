---
layout: default
title: I'm sorting out global climate change
description: This is Oli Frost Refrosts The Planet
image: /img/refroststheplanet-small.jpg
videos: nRxJcj0qiQk
permalink: /refrost/
carousel-items: 3
images: true
---

{% include refrost-style %}

<div class="youtube-player" data-id="{{ page.videos }}" data-thumb="{{ page.image }}"></div>

**Oli Frost Refrosts The Planet** is an online series that follows me, Oli Frost, and my plans to stop the earth defrosting.

<div>
{% assign portfolio = site.refrost | sort: 'order' %}

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

Search Oli Frost on Instagram Stories to use the [#RefrostThePlanet GIFs](/gifs)

---

{% include about.html %}

---
