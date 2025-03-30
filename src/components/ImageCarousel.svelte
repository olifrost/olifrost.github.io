<script>
  import { onMount } from 'svelte';
  import Carousel from 'svelte-carousel';

  export let images = [];
  export let itemsPerSlide = 3;

  let carouselComponent;

  const responsive = [
    {
      breakpoint: 0,
      itemsToShow: 1,
      itemsToScroll: 1,
    },
    {
      breakpoint: 640,
      itemsToShow: Math.min(2, itemsPerSlide),
      itemsToScroll: 1,
    },
    {
      breakpoint: 1024,
      itemsToShow: Math.min(3, itemsPerSlide),
      itemsToScroll: 1,
    }
  ];
</script>

<div class="carousel-container">
  {#if typeof window !== 'undefined'}
    <Carousel
      bind:this={carouselComponent}
      particlesToShow={1}
      {responsive}
      autoplay={false}
      autoplayDuration={5000}
      pauseOnFocus={true}
    >
      {#each images as image}
        <div class="carousel-item">
          <img
            src={image.src}
            alt={image.alt || ''}
            class="w-full h-auto object-contain rounded-lg"
            loading="lazy"
            decoding="async"
          />
        </div>
      {/each}
    </Carousel>
  {/if}
</div>
