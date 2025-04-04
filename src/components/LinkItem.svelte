<script lang="ts">
  import { slide } from 'svelte/transition';
  
  export let title: string;
  export let url: string | undefined = undefined;
  export let icon: string | undefined = undefined;
  export let color = "bg-blue-600";
  export let textColor = "text-white";
  export let isExpandable = false;
  export let children: any[] = [];

  let isExpanded = false;

  // Define allowed icon types
  type IconType = 'arrow' | 'chevron';

  // Simple mapping of icon names to SVG paths with index signature
  const iconPaths: Record<string, string> = {
    arrow: "M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z",
    chevron: "M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z",
    // Add more icon paths as needed
  };

  function toggleExpand(event: MouseEvent | TouchEvent): void {
    // Prevent default behavior to ensure consistent handling across devices
    event.preventDefault();
    
    if (isExpandable) {
      isExpanded = !isExpanded;
    } else if (url) {
      window.open(url, '_blank');
    }
  }
  
  // Handle touch events separately for mobile Safari
  function handleTouch(event: TouchEvent): void {
    toggleExpand(event);
    // Prevent ghost clicks
    event.preventDefault();
  }
</script>

<div class="w-full">
  <div
    on:click={toggleExpand}
    on:touchstart={handleTouch}
    role="button"
    tabindex="0"
    class="linktree-item w-full flex items-center justify-between p-6 rounded-sm mb-2 transition-all hover:-translate-y-1 hover:shadow-lg font-bold cursor-pointer {color} {textColor}"
  >
    <div class="flex items-center justify-center gap-3 flex-1">
      {#if icon && iconPaths[icon]}
        <span class="w-6 h-6">
          <svg 
            xmlns="http://www.w3.org/2000/svg" 
            viewBox="0 0 20 20" 
            fill="currentColor"
            class="w-full h-full"
          >
            <path fill-rule="evenodd" d={iconPaths[icon]} clip-rule="evenodd" />
          </svg>
        </span>
      {/if}
      <span>{title}</span>
    </div>

    {#if isExpandable}
      <svg 
        xmlns="http://www.w3.org/2000/svg" 
        class="w-5 h-5 transition-transform {isExpanded ? 'rotate-180' : ''}" 
        viewBox="0 0 20 20"
        fill="currentColor"
      >
        <path fill-rule="evenodd" d={iconPaths.chevron} clip-rule="evenodd" />
      </svg>
    {:else if url}
      <svg 
        xmlns="http://www.w3.org/2000/svg" 
        class="w-4 h-4" 
        viewBox="0 0 20 20" 
        fill="currentColor"
      >
        <path fill-rule="evenodd" d={iconPaths.arrow} clip-rule="evenodd" />
      </svg>
    {/if}
  </div>

  {#if isExpandable && isExpanded}
    <div class="pl-4 space-y-2 mb-4" transition:slide={{ duration: 200 }}>
      {#each children as child}
        <div
          class="linktree-item flex items-center justify-between p-4 rounded-sm transition-all hover:-translate-y-1 hover:shadow-lg font-bold cursor-pointer {child.colour || color} {textColor}"
          on:click={(e) => {e.preventDefault(); window.open(child.url, '_blank');}}
          on:touchstart={(e) => {e.preventDefault(); window.open(child.url, '_blank');}}
          role="button"
          tabindex="0"
        >
          <div class="flex items-center gap-3">
            {#if child.icon && iconPaths[child.icon]}
              <span class="w-6 h-6">
                <svg 
                  xmlns="http://www.w3.org/2000/svg" 
                  viewBox="0 0 20 20" 
                  fill="currentColor"
                  class="w-full h-full"
                >
                  <path fill-rule="evenodd" d={iconPaths[child.icon]} clip-rule="evenodd" />
                </svg>
              </span>
            {/if}
            <span>{child.title}</span>
          </div>
          <svg 
            xmlns="http://www.w3.org/2000/svg" 
            class="w-4 h-4" 
            viewBox="0 0 20 20" 
            fill="currentColor"
          >
            <path fill-rule="evenodd" d={iconPaths.arrow} clip-rule="evenodd" />
          </svg>
        </div>
      {/each}
    </div>
  {/if}
</div>

<style>
  div {
    text-align: center;
  }
  
  /* Ensure proper pointer behavior on touch devices */
  .linktree-item {
    -webkit-tap-highlight-color: transparent;
    touch-action: manipulation;
  }
</style>