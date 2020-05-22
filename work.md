---
layout: default
title: Oli Frost
videos: true
---

Creative at **AMV BBDO** (2015-2020)  
Creative Circle **Best New Creative** (2017)  
Previous experience **Droga5, BBH, Mother** (2014)   
Studied at [**Watford Ad Course**](/student) (2013)  


<div class="posts" markdown="0">
{% assign portfolio = site.portfolio %}

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

<div class="posts" markdown="0">
{% assign brands = site.brands %}
{% for project in brands %}
      {% include project.html project=project %}
{% endfor %}
</div>

<div class="posts" markdown="0">
{% assign causes = site.causes %}
{% for project in causes %}
{% if forloop.index > 1 %}
      {% include project.html project=project %}
{% endif %}
{% endfor %}
</div>


---

Further Live Work: *Snickers (Activation), Bombay Sapphire (Out Of Home), Sainsbury's Food Waste (TV & Print), BT (Social & Out of Home), Bodyform (TV & Print), Maltesers (Online Film), Galaxy (Online Film), The National Lottery (TV), Sainsbury's Tu (TV & Print), Mercedes-Benz (TV), IKEA (Radio & Print), Hiscox (Radio), & Chupa-Chups (Activation)*.

---


[>> Skip Ads](/)
