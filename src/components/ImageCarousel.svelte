<script>
  import { onMount } from 'svelte';
  import { tick } from 'svelte';

  export let images = [];
  export let itemsPerSlide = 3;
  
  let emblaNode;
  let emblaApi;
  let canScrollPrev = false;
  let canScrollNext = true;
  let currentIndex = 0;
  let slidesInView = [];
  let mounted = false;
  let viewportWidth = 0;
  
  // Fixed options with more precise breakpoints to ensure 3 images at 992px
  const options = {
    loop: true,
    align: 'start',
    slidesToScroll: 1,
    // Remove breakpoints from options - we'll handle this with CSS flexbox instead
  };

  onMount(async () => {
    // Update viewport width on mount
    viewportWidth = window.innerWidth;
    
    // Add resize listener
    const handleResize = () => {
      viewportWidth = window.innerWidth;
    };
    window.addEventListener('resize', handleResize);
    
    // Correcting the import from embla-carousel
    const emblaCarousel = await import('embla-carousel');
    
    // Initialize the carousel - emblaCarousel.default is the correct way to access the function
    emblaApi = emblaCarousel.default(emblaNode, options);
    
    // Set up event listeners
    emblaApi.on('select', handleSelect);
    emblaApi.on('reInit', handleSelect);
    handleSelect();
    
    mounted = true;
    
    return () => {
      if (emblaApi) emblaApi.destroy();
      window.removeEventListener('resize', handleResize);
    };
  });
  
  function handleSelect() {
    canScrollPrev = emblaApi.canScrollPrev();
    canScrollNext = emblaApi.canScrollNext();
    currentIndex = emblaApi.selectedScrollSnap();
    slidesInView = emblaApi.slidesInView();
  }
  
  function scrollPrev() {
    if (emblaApi) emblaApi.scrollPrev();
  }
  
  function scrollNext() {
    if (emblaApi) emblaApi.scrollNext();
  }
  
  function scrollTo(index) {
    if (emblaApi) emblaApi.scrollTo(index);
  }

  // Function to determine how many slides are visible based on viewport width
  $: visibleSlides = viewportWidth < 640 ? 1 : viewportWidth < 768 ? 2 : itemsPerSlide;
</script>

<div class="carousel-container w-full not-prose">
  {#if images.length > 0}
    <!-- Carousel Container -->
    <div class="relative">
      <!-- Main Carousel -->
      <div class="overflow-hidden" bind:this={emblaNode}>
        <div class="flex">
          {#each images as image, i}
            <div 
              class="carousel-slide p-2" 
              style="flex: 0 0 {100/visibleSlides}%; min-width: 0;"
            >
              <img
                src={image.src}
                alt={image.alt || ''}
                class="w-full h-auto object-contain rounded-lg max-h-[60vh]"
                loading="lazy"
                decoding="async"
              />
            </div>
          {/each}
        </div>
      </div>
      
      <!-- Navigation Buttons with improved visibility -->
      {#if mounted && images.length > visibleSlides}
        <!-- Prev Button -->
        <button 
          class="absolute left-2 top-1/2 -translate-y-1/2 bg-white hover:bg-white/90 text-black p-3 rounded-full shadow-lg z-10 flex items-center justify-center disabled:opacity-30 disabled:cursor-not-allowed border border-gray-200"
          on:click={scrollPrev}
          disabled={!canScrollPrev}
          aria-label="Previous slide"
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="15 18 9 12 15 6"></polyline>
          </svg>
        </button>
        
        <!-- Next Button -->
        <button 
          class="absolute right-2 top-1/2 -translate-y-1/2 bg-white hover:bg-white/90 text-black p-3 rounded-full shadow-lg z-10 flex items-center justify-center disabled:opacity-30 disabled:cursor-not-allowed border border-gray-200"
          on:click={scrollNext}
          disabled={!canScrollNext}
          aria-label="Next slide"
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </button>
      {/if}
    </div>
    
    <!-- Pagination Dots with improved visibility -->
    {#if mounted && images.length > visibleSlides}
      <div class="flex justify-center mt-4 gap-3 py-2">
        {#each Array(Math.ceil(images.length / visibleSlides)) as _, i}
          <button
            class="w-2 h-2 rounded-full transition-colors duration-200 {currentIndex === i ? 'bg-black' : 'bg-gray-300'} hover:bg-gray-400"
            on:click={() => scrollTo(i)}
            aria-label={`Go to slide ${i + 1}`}
          ></button>
        {/each}
      </div>
    {/if}
    
  
  {:else}
    <p class="text-gray-500 italic">No images to display</p>
  {/if}
</div>

<style>
  /* Minimal required styles for Embla Carousel */
  :global(.embla) {
    position: relative;
    width: 100%;
  }
  
  /* Custom styles to complement Tailwind */
  .carousel-slide {
    transition: opacity 0.3s ease;
  }
  
  /* Small screens (up to 639px) - 1 slide */
  @media (max-width: 639px) {
    .carousel-slide {
      flex: 0 0 100%;
    }
  }
  
  /* Medium screens (640px - 767px) - 2 slides */
  @media (min-width: 640px) and (max-width: 767px) {
    .carousel-slide {
      flex: 0 0 50%;
    }
  }
  
  /* Large screens (768px and above) - 3 slides */
  @media (min-width: 768px) {
    .carousel-slide {
      flex: 0 0 33.333%;
    }
  }
</style>
