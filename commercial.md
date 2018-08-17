---
layout: default
title: Oli Frost
videos: true
image: /blog/shook-1.jpg
---
# Work For Brands

{% assign brands = site.brands | sort: 'order' %}
{% for project in brands %}
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
