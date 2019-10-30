---
title: Global Climate Strike
description: Find your local climate strike and posters to promote it.
style: custom
layout: links
---

<ul>
{% for item in site.data.globalstrike.docs %}
<li style="background-color: #{{item.colour}}; border-color: #{{item.colour}};">
  <a href="{{ item.url }}" alt="{{ item.title }}">
    {{ item.title }}</a>
</li>
{% endfor %}
</ul>
