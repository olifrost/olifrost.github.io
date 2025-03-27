<!-- A Svelte component that adds subtle interactivity to the 404 page -->
<script>
  import { onMount } from 'svelte';
  
  // Messages that will randomly appear in the error box
  const messages = [
    "Have you tried looking in the mirror?",
    "This content was removed due to excessive truth-telling",
    "The page exists, but only conceptually",
    "404: Content monetization failed",
    "This URL has been donated to charity",
    "Page temporarily loaned to someone who needed it more",
    "Error_404: Reality not found",
    "This page is on strike for climate justice",
    "Content deleted by the internet's Marie Kondo",
    "This page has been recycled into something useful"
  ];
  
  let message = messages[messages.length - 4]; // Start with "Error_404: Reality not found"
  let intervalId;
  let isAnimating = false;
  
  function cycleMessage() {
    if (isAnimating) return;
    
    isAnimating = true;
    const currentIndex = messages.indexOf(message);
    const nextIndex = (currentIndex + 1) % messages.length;
    
    // Add a subtle fade out/in effect
    const element = document.querySelector('.message-text');
    if (element) {
      element.classList.add('opacity-0');
      
      setTimeout(() => {
        message = messages[nextIndex];
        setTimeout(() => {
          element.classList.remove('opacity-0');
          isAnimating = false;
        }, 50);
      }, 300);
    } else {
      message = messages[nextIndex];
      isAnimating = false;
    }
  }
  
  function startAutoCycle() {
    // Clear any existing interval
    if (intervalId) clearInterval(intervalId);
    
    // Set up a new interval to cycle messages
    intervalId = setInterval(() => {
      cycleMessage();
    }, 5000); // Change message every 5 seconds
  }
  
  // Handle interactions
  function handleInteraction() {
    cycleMessage();
    
    // Reset the auto-cycle timer when user interacts
    if (intervalId) clearInterval(intervalId);
    intervalId = setInterval(() => {
      cycleMessage();
    }, 5000);
  }
  
  onMount(() => {
    // Start auto-cycling when the component mounts
    startAutoCycle();
    
    // Clean up interval on unmount
    return () => {
      if (intervalId) clearInterval(intervalId);
    };
  });
</script>

<div 
  class="cursor-pointer select-none" 
  on:mouseenter={handleInteraction}
  on:click={handleInteraction}
  on:focus={handleInteraction}
  on:touchstart={handleInteraction}
  tabindex="0">
  <slot>
    <div class="border border-black p-6 mb-12 bg-white">
      <p class="message-text text-lg font-mono text-blue-600 transition-opacity duration-300">
        {message}
      </p>
      <p class="text-sm mt-2 font-mono">Tap here and I'll try again</p>
    </div>
  </slot>
</div>

<style>
  .opacity-0 {
    opacity: 0;
  }
  
  /* Ensure the component has a consistent height to prevent layout shifts */
  .message-text {
    min-height: 1.5em;
  }
</style>