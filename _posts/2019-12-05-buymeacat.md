---
layout: site
title: If you like my work, you can buy me a cat
description: It's only £17,000
header: Buy Me A Cat
tagline: Support my work. It's only £17,000.
permalink: /buymeacat
carousel-items: 3
images: true
image: /blog/cat.jpg
thumb: /blog/cat.jpg
paypallink: https://ko-fi.com/olifrost
coffeelink: https://ko-fi.com/olifrost
---

<div class="hero">


  <div class="row first-xs between-sm ">
    <div class="col-xs-12">
      <h1 class="headline">{{ page.header }}</h1>
      <p class="center"> {{ page.tagline }}</p>
      <a href="{{ page.paypallink }}" class="button"><i class="fas fa-cat"></i> Buy Cat</a>
      <a href="{{ page.coffeelink }}" class="button button-clear"><i class="fas fa-leaf"></i> Buy Plant Instead</a>

    </div>

    <div class="col-xs-12">
      <p style="margin-top:2rem;">
      <img src="{{ page.thumb }}">
      </p>
    </div>

</div>

<div markdown="1">

<div class="row first-xs between-sm">
    <div class="col-xs-12 col-sm-4" markdown="1">


### <i class="fas fa-money-bill-alt"></i>  Cheap
It's only £17,000 for the lifetime cost so you can think of it as like buying me a few beers or coffees.


  </div>

  <div class="col-xs-12 col-sm-4" markdown="1">

### <i class="fas fa-paw"></i>  Small Pawprint
Ok cats do have a large carbon footprint but the happiness will likely prevent other reckless consumerism in my life.

  </div>

  <div class="col-xs-12 col-sm-4" markdown="1">

### <i class="fas fa-leaf"></i>  Plant-Based Alternative

Otherwise, please [buy me a plant]({{ page.coffeelink }}). I am currently shopping for small succulents, and Chinese money plants.

  </div>

</div>

---

{% include about.html %}

</div>
