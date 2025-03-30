<script>
  import { onMount } from 'svelte';
  import { tick } from 'svelte';
  import EmblaCarousel from 'embla-carousel';

  // Enhanced props for better customization
  export let images = [];
  export let itemsPerSlide = 3; // Default desktop value
  export let itemsPerSlideTablet = 2; // Default tablet value
  export let itemsPerSlideMobile = 1; // Default mobile value
  export let loop = true; // Allow toggling loop behavior
  export let showControls = true; // Allow hiding controls
  export let showPagination = true; // Allow hiding pagination
  export let autoplay = false; // Optional autoplay
  export let autoplayInterval = 5000; // Autoplay interval in ms
  
  let emblaNode;
  let emblaApi;
  let canScrollPrev = false;
  let canScrollNext = true;
  let currentIndex = 0;
  let slidesInView = [];
  let mounted = false;
  let viewportWidth = 0;
  let autoplayTimer;
  
  const options = {
    loop,
    align: 'start',
    slidesToScroll: 1,
  };

  onMount(() => {
    // Update viewport width on mount
    viewportWidth = window.innerWidth;
    
    // Add resize listener
    const handleResize = () => {
      viewportWidth = window.innerWidth;
    };
    window.addEventListener('resize', handleResize);
    
    // Initialize Embla
    emblaApi = EmblaCarousel(emblaNode, options);
    
    // Set up event listeners
    emblaApi.on('select', handleSelect);
    emblaApi.on('reInit', handleSelect);
    handleSelect();
    
    // Setup autoplay if enabled
    if (autoplay) {
      startAutoplay();
    }
    
    mounted = true;
    
    return () => {
      if (emblaApi) emblaApi.destroy();
      window.removeEventListener('resize', handleResize);
      if (autoplayTimer) clearInterval(autoplayTimer);
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
    if (autoplay) resetAutoplay();
  }
  
  function scrollNext() {
    if (emblaApi) emblaApi.scrollNext();
    if (autoplay) resetAutoplay();
  }
  
  function scrollTo(index) {
    if (emblaApi) emblaApi.scrollTo(index);
    if (autoplay) resetAutoplay();
  }
  
  function startAutoplay() {
    autoplayTimer = setInterval(() => {
      if (emblaApi) {
        if (!emblaApi.canScrollNext() && !loop) {
          emblaApi.scrollTo(0);
        } else {
          emblaApi.scrollNext();
        }
      }
    }, autoplayInterval);
  }
  
  function resetAutoplay() {
    if (autoplayTimer) clearInterval(autoplayTimer);
    if (autoplay) startAutoplay();
  }

  // Responsive slides calculation based on viewport width
  $: visibleSlides = viewportWidth < 640 ? itemsPerSlideMobile : 
                     viewportWidth < 768 ? itemsPerSlideTablet : 
                     itemsPerSlide;
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
      {#if mounted && showControls && images.length > visibleSlides}
        <!-- Prev Button -->
        <button 
          class="absolute left-2 top-1/2 -translate-y-1/2 bg-white hover:bg-white/90 text-black p-3 rounded-full shadow-lg z-10 flex items-center justify-center disabled:opacity-30 disabled:cursor-not-allowed border border-gray-200"
          on:click={scrollPrev}
          disabled={!canScrollPrev && !loop}
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
          disabled={!canScrollNext && !loop}
          aria-label="Next slide"
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </button>
      {/if}
    </div>
    
    <!-- Pagination Dots with improved visibility -->
    {#if mounted && showPagination && images.length > visibleSlides}
      <div class="flex justify-center mt-4 gap-3 py-2">
        {#each Array(Math.ceil(images.length / visibleSlides)) as _, i}
          <button
            class="w-3 h-3 rounded-full transition-colors duration-200 {currentIndex === i ? 'bg-black' : 'bg-gray-300'} hover:bg-gray-400"
            on:click={() => scrollTo(i)}
            aria-label={`Go to slide ${i + 1}`}
          ></button>
        {/each}
      </div>
    {/if}
    
    <!-- Debug info in development mode -->
    {#if import.meta.env.DEV}
      <div class="text-xs text-gray-400 text-center mt-2">
        Viewport: {viewportWidth}px | Slides: {visibleSlides} | Mode: {viewportWidth < 640 ? 'mobile' : viewportWidth < 768 ? 'tablet' : 'desktop'}
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
</style>
