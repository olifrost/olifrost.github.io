---
layout: post
title: I incorporated myself
description: The Oli Frost you know and love is now a service
image: /blog/lockdownlemons.jpg
permalink: /ltd
videos: true
images: true
---

Imaginatively named, Oli Frost Ltd.

I think of and make things for you that are similar to the things I make.

Most recently, I have been working for Greenpeace UK as a presenter for their [social channels](https://www.tiktok.com/@greenpeaceuk/video/7112887411226529029?is_copy_url=1&is_from_webapp=v1&lang=en).

<div class="posts" markdown="0">
{% assign projects = site.data.ltd%}
{% for item in projects %}
    <h2>{{ item.category }}</h2>
    {% include project.html project=item %}
{% endfor %}
</div>

---

# Further Reading

{% include featured-post.html %}

---
