---
layout: default
title: Oli Frost
videos: true
---
{% include custom-style primary="#bababa" text="white" background="#2e2e2e" hover="#8d8e93" %}


Here's a few more films I made. Mostly produced by me at home, but occasionally with other directors.

When I was 14 years old, I won 5th place in the Music & Dance category of a prestigious World of Warcraft movie contest. The rest is history.

Most recently, I have been performing at stand-up events and attending the Free Association.

<div class="posts" markdown="0">
{% assign projects = site.data.reel %}
{% for item in projects %}
    {% include project.html project=item %}
{% endfor %}
</div>

---

{% include nextpage.html page1="Show me everything" link1="/blog" page2="Show me ads" link2="/work" %}

---

# Further Reading

{% include featured-post.html %}

---
