<script>
  import { fade, scale } from 'svelte/transition';
  import { onMount, onDestroy } from 'svelte';
  
  // Props
  let { videoId = '', isOpen = false, onClose = () => {} } = $props();

  // State
  let fadeTimeout;
  let iframeSrc = $state('');
  let eventListener = $state(null);
  
  // When the modal opens, load the YouTube iframe
  $effect(() => {
    if (isOpen && videoId) {
      // Set timeout to allow fade transition to start before loading the iframe
      clearTimeout(fadeTimeout);
      fadeTimeout = setTimeout(() => {
        iframeSrc = `https://www.youtube.com/embed/${videoId}?autoplay=1&rel=0&modestbranding=1`;
      }, 100);
    } else {
      iframeSrc = '';
    }
  });
  
  // Handle escape key to close modal
  function handleKeydown(event) {
    if (event.key === 'Escape' && isOpen) {
      closeModal();
    }
  }
  
  // Handle click outside the modal content to close
  function handleBackdropClick(event) {
    if (event.target === event.currentTarget) {
      closeModal();
    }
  }

  // Function to set up event listeners for modal updates
  function setupEventListener() {
    const container = document.getElementById('youtube-modal-container');
    if (!container) return null;
    
    const listener = (event) => {
      const detail = event.detail;
      if (detail) {
        videoId = detail.videoId || '';
        isOpen = !!detail.isOpen;
        
        // If the modal is closing, clean up iframe
        if (!isOpen) {
          iframeSrc = '';
        }
      }
    };
    
    container.addEventListener('update-youtube-modal', listener);
    return listener;
  }

  // Clean up function for event listeners
  function cleanupEventListener() {
    if (eventListener) {
      const container = document.getElementById('youtube-modal-container');
      if (container) {
        container.removeEventListener('update-youtube-modal', eventListener);
      }
    }
  }

  onMount(() => {
    eventListener = setupEventListener();
    
    // Clean up on component destruction
    return () => {
      cleanupEventListener();
      clearTimeout(fadeTimeout);
    };
  });
  
  // Listen for Astro view transitions
  onMount(() => {
    const handlePageLoad = () => {
      eventListener = setupEventListener();
    };
    
    const handleBeforeSwap = () => {
      // Clean up before page navigation
      cleanupEventListener();
      if (isOpen) {
        isOpen = false;
        iframeSrc = '';
        document.body.classList.remove('modal-open');
      }
    };
    
    document.addEventListener('astro:page-load', handlePageLoad);
    document.addEventListener('astro:before-swap', handleBeforeSwap);
    
    return () => {
      document.removeEventListener('astro:page-load', handlePageLoad);
      document.removeEventListener('astro:before-swap', handleBeforeSwap);
    };
  });

  function closeModal() {
    // Check if the global controller exists in a type-safe way
    const controller = window.YouTubeModalController;
    if (controller && typeof controller.close === 'function') {
      controller.close();
    } else {
      isOpen = false;
      iframeSrc = '';
      document.body.classList.remove('modal-open');
    }
  }
</script>

<svelte:window onkeydown={handleKeydown} />

{#if isOpen}
  <div 
    class="fixed inset-0 z-50 bg-black/80 flex items-center justify-center p-4 md:p-8"
    role="dialog"
    aria-modal="true"
    aria-labelledby="modal-title"
    onclick={handleBackdropClick}
    onkeydown={(e) => e.key === 'Enter' && handleBackdropClick(e)}
    tabindex="0"
    transition:fade={{ duration: 200 }}
  >
    <div 
      class="relative max-w-5xl w-full max-h-[80vh] aspect-video bg-black rounded-lg shadow-2xl"
      transition:scale={{ start: 0.95, duration: 200, easing: t => 1 - Math.pow(1 - t, 3) }}
    >
      <!-- Close button -->
      <button 
        type="button"
        aria-label="Close video"
        class="absolute -top-10 right-0 w-8 h-8 flex items-center justify-center bg-white rounded-full text-black"
        onclick={closeModal}
      >
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" 
             class="w-5 h-5" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <line x1="18" y1="6" x2="6" y2="18"></line>
          <line x1="6" y1="6" x2="18" y2="18"></line>
        </svg>
      </button>
      
      <!-- Hidden title for accessibility -->
      <h2 id="modal-title" class="sr-only">YouTube Video</h2>
      
      <!-- YouTube iframe or loading placeholder -->
      {#if iframeSrc}
        <iframe 
          class="w-full h-full rounded-lg"
          src={iframeSrc}
          title="YouTube video player"
          frameborder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          allowfullscreen
        ></iframe>
      {:else}
        <div class="absolute inset-0 flex items-center justify-center">
          <div class="w-12 h-12 border-4 border-blue-200 border-t-blue-600 rounded-full animate-spin"></div>
        </div>
      {/if}
    </div>
  </div>
{/if}

<style>
  /* Prevent scrolling when modal is open */
  :global(body.modal-open) {
    overflow: hidden;
  }
</style>