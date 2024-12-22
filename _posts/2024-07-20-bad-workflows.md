---
layout: site
title: I made an app that makes you less productive
header: Escape the cult of productivity
tagline: Bad Workflows
description: Tools to make your Mac harder to use
image: /blog/bar.png
permalink: /bad-workflows
carousel-items: 3
images: true
---

{% include custom-style primary="#eb6123" text="" background="" hover="#8d8e93" %}

<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap');

body {
    background-color: #000000;
    font-family: "Inter", sans-serif;
    font-optical-sizing: auto;
   font-weight: 400;
    font-style: normal;


}
p, h2, h3, h4, small, header, footer, input[type='email'], img, button {
  color: #FEFEFE;
  animation: fadeIn 2s forwards; 
   animation-delay: 1s;
   opacity: 0;
}
h1 {
animation: fadeIn 2s forwards;
color: #FEFEFE;
}

h1 {
  font-weight: 500;
}
p {
  font-weight: 300;
  font-size: 2rem;
}
.tagline {
  font-weight: 600;
  letter-spacing: 10;
}
.description{
  font-weight: 600;
  max-width: 800px;
  font-size: 2rem;
  margin: auto;
}
#requirements {
  font-size: 1.5rem;
}

hr {
  border-color: gray;
}

.image-holder img {
  padding: 4rem;
  padding-bottom: 2rem;
}

/* Define the fade-in keyframes */
@keyframes fadeIn {
    from {
        opacity: 0; /* Start fully transparent */
    }
    to {
        opacity: 1; /* End fully opaque */
    }
} 

input[type='submit'], .button {
  background-color: #A358D7;
  border: #A358D7 1px solid;
}

input[type='email'] {
border: .1rem solid #FEFEFE;
color: #FEFEFE;
}



 a, .navigation a {
   color: #A358D7
 }

  a:hover, .navigation a:hover {
       color: #8d8e93;
  }

 .icon svg path {
   fill: #A358D7;
 }

 svg path {
   fill: #A358D7;
 }

 .owl-dot span {
   background-color: #A358D7;
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
            <p class="center tagline"> {{ page.tagline }}</p>
      <h1 class="headline">{{ page.header }}</h1>
    </div>
  </div>

  <div class="row first-xs between-sm video">
      <div class="col-xs-12 image-holder">
          <img src="/blog/badworkflows.png">
      </div>
      <div class="col-xs-12 center">
      <p class="center description">From forgetful reminders, to AutoMistake™, Bad Workflows is a collection of tools that make your Mac harder to use</p>
    </div>
    </div>

  <div class="row first-xs between-sm buttons downloads">
        <div class="col-xs-12">
      <a href="https://ko-fi.com/s/567c69f8ec" class="button"><i class="fas fa-arrow-down"></i> Download</a>
      <p markdown="1" id="requirements">Requires <a href="https://www.alfredapp.com">Alfred Powerpack</a>, Mac OS13+</p>
      </div>
    </div>
</div>

<hr>

<p>
</p>
<div class="row first-xs between-sm">
  <div class="col-xs-12 col-sm-4" markdown="1">

### <i class="fa-regular fa-copy"></i> Copy text, badly
Add a human touch to your Copy/Paste, with randomly generated errors.

  </div>

    <div class="col-xs-12 col-sm-4" markdown="1">
### <i class="fas fa-user-circle"></i> Shutdown progress
Opening apps like Zoom or Slack triggers an immediate system shutdown.
  </div>

  <div class="col-xs-12 col-sm-4" markdown="1">
### <i class="fas fa-stopwatch"></i> Focus, briefly
Set a focus timer that lasts seven seconds, before opening web games.
  </div>


</div>
<div class="row first-xs between-sm">


      <div class="col-xs-12 col-sm-4" markdown="1">
### <i class="fab fa-pagelines"></i> Touch grass
Take some time off to experience the outdoors. Display an image of grass you can touch.
  </div>

  <div class="col-xs-12 col-sm-4" markdown="1">
### <i class="fa-solid fa-folder"></i> Unorganise your files
Moves the selected file to a random location on your disk, making it harder to find.
  </div>

  <div class="col-xs-12 col-sm-4" markdown="1">
### <i class="fas fa-user-circle"></i> Human Stupidity™
Let me be your personal assistant. I'm both imprecise, and slow to reply.
  </div>
</div>
<div class="row first-xs between-sm">

  <div class="col-xs-12 col-sm-4" markdown="1">

### <i class="fas fa-check"></i> The worst to-do list
Tasks you enter are deleted, or replaced with aimless pondering, and stargazing activities.

  </div>

  <div class="col-xs-12 col-sm-4" markdown="1">
### <i class="fa-solid fa-keyboard"></i> AutoMistake™ 
Replace the selected text to add common typos, like swapping "because" for "becuase"
  </div>

  <div class="col-xs-12 col-sm-4" markdown="1">
### <i class="fas fa-keyboard"></i> Screaming space key
Make your space key play the famous Wilhelm scream, discouraging work.
  </div>
</div>

---

{% include about.html %}

---
