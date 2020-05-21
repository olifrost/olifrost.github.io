---
layout: page
images: true
title: Student Work
carousel-items: 3
---

You have time travelled back to 2013 to see the portfolio created at the Watford Ad Course with my old creative partner. It's mostly here for students who are currently doing that course, in an attempt to mislead them and cause financial and academic ruin.

{% assign portfolio = site.spec | sort: 'order' %}
{% for project in portfolio %}
<h2 class="post-title">{{ project.description}} – {{ project.title }}</h2>
<div>{{ project.content }}</div>
{% if forloop.last != true %}

<p></p>
{% endif %}
{% endfor %}

[<< Back to Work](/work)
