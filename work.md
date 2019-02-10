---
layout: default
title: Oli Frost
videos: true
image: /blog/shook-1.jpg
---

Creative at **AMV BBDO**  
Previous experience **Droga5, BBH, Mother.**  
Creative Circle **Best Young Creative 2017**  
Click to **[ Skip Ads >>](/)**

<div class="posts">
{% assign portfolio = site.portfolio | sort: 'order' %}

  {% for project in portfolio limit: 1 %}
        <div class="project-section">
        {% if project.video != nil %}
        <div class="youtube-player" data-id="{{ project.video }}" data-thumb="{{ project.image }}"></div>
        {% else %}
        <img src="{{ project.image | relative_url }}">
        {% endif %}
        <a href="{{ project.link }}"><span class="title">>> Sanctus – Lifefaker.com</span></a>
        <p style="margin-bottom:2.5rem;"> {{ project.description }}<br>
        {% for press in project.press %}
        <a href="{{ press.article_link }}" class="press">{{ press.name }}{% if forloop.last == false %},{% else %}.{% endif %}</a>
        {% endfor %}
        </p>
  </div>
  {% endfor %}
</div>


{% assign causes = site.causes | sort: 'order' %}

  {% for project in causes limit: 1 %}
  <div class="project-section">
        <img src="{{ project.image | relative_url }}">

        <a href="{{ project.link }}"><span class="title">>> {{ project.title }}</span></a>
        <p> {{ project.description }}<br>
        {% for press in project.press %}
        <a href="{{ press.article_link }}" class="press">{{ press.name }}{% if forloop.last == false %},{% else %}.{% endif %}</a>
        {% endfor %}
        </p>

  </div>
{% endfor %}

<p></p>

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

{% assign causes = site.causes | sort: 'order' %}

  {% for project in causes %}
  {% if forloop.index > 1 %}
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


---

Further Live Work: *Snickers, Bombay Sapphire, Sainsbury's, BT, Bodyform, Pedigree, Maltesers, Galaxy, The National Lottery, Mercedes-Benz & Chupa-Chups*.

---

# Personal Work

<div class="posts">

{% assign portfolio = site.portfolio | sort: 'order' %}

  {% for project in portfolio %}
  {% if forloop.index > 1 %}
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
  {% endif %}
  {% endfor %}

  </div>
