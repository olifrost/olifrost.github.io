---
layout: default
title: Oli Frost
videos: true
carousel-items: 1
---

## Press Mentions

In no order, here's a list of publications or organisations that have written about my work. Some older links may need updating or be offline.

<p>
{% for project_press in site.data.press-mentions %}
  {% for press in project_press[1] %}
    {% if press.article_link != nil %}
      <a href="{{ press.article_link }}" class="">{{ press.name }}{% unless forloop.last and forloop.parentloop.last %},{% endunless %}</a>
    {% else %}
      <span class="">{{ press.name }}{% unless forloop.last and forloop.parentloop.last %},{% endunless %}</span>
    {% endif %}
    {% unless forloop.last and forloop.parentloop.last %} {% endunless %}
  {% endfor %}
{% endfor %}



</p>