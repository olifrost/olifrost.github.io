---
layout: default
title: I'm sorting out global climate change
description: This is Oli Frost Refrosts The Planet
image: /blog/refrosttheplanet.jpg
videos: nRxJcj0qiQk
permalink: /refrost/
playbuttoncolour: "#B2E1ED"
playtrianglecolour: "rgba(0,0,0,1)"
---

{% include refrost-style %}

{% include youtube id="nRxJcj0qiQk" thumb="/blog/refrosttheplanet.jpg" %}

**Oli Frost Refrosts The Planet** is an online series that follows me, Oli Frost, and my plans to stop the earth defrosting.

<div class="posts" mardown="0">
{% assign refrost = site.refrost %}
{% for item in site.data.refrost %}
    {% include project.html project=item %}
{% endfor %}
</div>

---

Search Oli Frost on Instagram Stories to use the [#RefrostThePlanet GIFs](/gifs)

---

{% include about.html %}

---
