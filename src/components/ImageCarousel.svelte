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

<style>
  .carousel-container {
    width: 100%;
    margin: 0 auto;
  }
  
  .carousel-item {
    padding: 0.5rem;
    height: auto;
    box-sizing: border-box;
  }

  /* Remove the aspect-wrapper entirely */

  :global(.sc-carousel__carousel-container) {
    margin: 0 -0.5rem;
  }

  :global(.sc-carousel__content-container) {
    height: auto !important;
  }
  
  /* Fix spacing around dots */
  :global(.sc-carousel__dots) {
    margin-top: 0.5rem !important;
  }
</style>