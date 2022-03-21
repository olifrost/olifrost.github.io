---
layout: site
title: I made Halloween scary again
header: Fossil Ghouls
description: Fossil Ghouls is a range of printable, plastic-free masks for ages 3 and up.
tagline: Printable, plastic-free masks
image: /posters/fossilghouls/fossilghouls-cover.jpg
permalink: /fossilghouls
carousel-items: 3
images: true
---

{% include custom-style primary="#eb6123" text="" background="" hover="#8d8e93" %}

<style>

body {
    background-color: #141414;
    /*background-image: linear-gradient(#121922, #0C3E5C);*/

}
p, h1, h2, h3, h4, small, header, footer, input[type='email'] {
  color: #FEFEFE;

}

hr {
  border-color: gray;
}

input[type='submit'], .button {
  background-color: #eb6123;
  border-color: #c4511b
}

input[type='email'] {
border: .1rem solid #FEFEFE;
color: #FEFEFE;
}



 a, .navigation a {
   color: #eb6123
 }

  a:hover, .navigation a:hover {
       color: #8d8e93;
  }

 .icon svg path {
   fill: #eb6123;
 }

 svg path {
   fill: #eb6123;
 }

 .owl-dot span {
   background-color: #eb6123;
 }

 .downloads p {
   text-align: center;
   max-width: 40rem;
   padding-top: 1rem;
   margin: auto;
   font-size: 140%;
 }


</style>

<div class="hero">


  <div class="row first-xs between-sm ">
    <div class="col-xs-12">
      <h1 class="headline">{{ page.header }}</h1>
      <p class="center"> {{ page.tagline }}</p>


    </div>

  </div>

    <div class="row first-xs between-sm video">
      <div class="col-xs-12">
          {% include poster-gallery.html path="posters/fossilghouls/social" %}
      </div>
    </div>

    <div class="row first-xs between-sm buttons downloads">
        <div class="col-xs-12">

            <a href="https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/olifrost/olifrost.github.io/tree/master/posters/fossilghouls" class="button"><i class="fas fa-ghost"></i> Download</a>

            <p markdown="1">You can print and share these if you'll give a tag and follow [@olifro.st](https://olifro.st/links) in return</p>
      </div>
    </div>


</div>

<hr>

<p>
</p>
<div class="row first-xs between-sm">
    <div class="col-xs-12 col-sm-4" markdown="1">


### <i class="fas fa-sticky-note"></i>  Plastic-Free
Unless you print them on plastic.


  </div>

  <div class="col-xs-12 col-sm-4" markdown="1">

### <i class="fas fa-ghost"></i>  Very Scary
Scarier than plastic straws.

  </div>

  <div class="col-xs-12 col-sm-4" markdown="1">

### <i class="fas fa-oil-can"></i>  Good Party Chat

Based on 20 companies [behind more than a third of emissions](https://www.theguardian.com/environment/2019/oct/09/revealed-20-firms-third-carbon-emissions).

  </div>

</div>

---

{% include poster-gallery.html path="halloween" %}

---

## Terms and Conditions

<span class="terms">You can use this non-commercially with attribution [@olifro.st](https://olifro.st/links). If you get a toffee apple I want half. If you make friends [I want them](/refer). You must make one small child cry.  </span>

---

## More #RefrostThePlanet

[Oli Frost Refrosts The Planet](/refrost) is an online series that follows me, Oli Frost, and my plans to stop the earth defrosting.

{% include poster-gallery.html path="posters/refrosttheplanet" %}

---

{% include about.html %}

---
