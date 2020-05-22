---
layout: page
images: true
title: Student Work
carousel-items: 3
---

You have time travelled back to 2013 to see the portfolio created at the Watford Ad Course with my old creative partner. It's mostly here for students who are currently doing that course, in an attempt to mislead them and cause financial and academic ruin.

{% assign projects = site.data.spec %}
{% for item in projects %}
  <h2 class="post-title">{{ item.description}} – {{ item.title }}</h2>
  <div>
  <div class="owl-carousel owl-theme" data-items="{{ item.carousel-items }}">
  {% for image in item.images %}
  <img class="owl-lazy" data-src="{{ site.baseurl}}/blog/{{ image.name }}" alt="{{ image.alt }}">
{% endfor %}
</div>
</div>
{% if forloop.last != true %}

<p></p>
{% endif %}
{% endfor %}


<h2 class="post-title">Creative Unblocker</h2>

[>> Visit Site](https://olifro.st/creativeunblocker). Featured on [Design Taxi](http://designtaxi.com/interstitial.html?v=1&advertiser=External&return_url=http%3A%2F%2Fdesigntaxi.com%2Fnews%2F388116%2FCreative-Unblocker-Generates-Fun-Random-Problems-To-Unstick-Your-Brain%2F)

<a href="https://olifro.st/creativeunblocker"><img alt="unblocker" src="/blog/creativeunblocker.jpg"></a>

[<< Back to Work](/work)
