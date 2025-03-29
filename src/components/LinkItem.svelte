<script lang="ts">
  import { slide } from 'svelte/transition';
  import { onMount } from 'svelte';
  
  export let title: string;
  export let url: string | undefined = undefined;
  export let icon: string | undefined = undefined;
  export let color = "bg-blue-600";
  export let textColor = "text-white";
  export let isExpandable = false;
  export let children: any[] = [];

  let isExpanded = false;
  let IconComponent: any;

  onMount(async () => {
    if (icon) {
      const module = await import('astro-icon/components');
      IconComponent = module.Icon;
    }
  });

  function toggleExpand() {
    if (isExpandable) {
      isExpanded = !isExpanded;
    } else if (url) {
      window.open(url, '_blank');
    }
  }
</script>

<div class="w-full">
  <div
    on:click={toggleExpand}
    class="w-full flex items-center justify-between p-6 rounded-sm mb-2 transition-all hover:-translate-y-1 hover:shadow-lg font-bold cursor-pointer {color} {textColor}"
  >
    <div class="flex items-center justify-center gap-3 flex-1">
      {#if icon && IconComponent}
        <span class="w-6 h-6">
          <svelte:component this={IconComponent} name={icon} />
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
        <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
      </svg>
    {:else if url}
      <svg 
        xmlns="http://www.w3.org/2000/svg" 
        class="w-4 h-4" 
        viewBox="0 0 20 20" 
        fill="currentColor"
      >
        <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd" />
      </svg>
    {/if}
  </div>

  {#if isExpandable && isExpanded}
    <div class="pl-4 space-y-2 mb-4" transition:slide={{ duration: 200 }}>
      {#each children as child}
        <div
          class="flex items-center justify-between p-4 rounded-sm transition-all hover:-translate-y-1 hover:shadow-lg font-bold cursor-pointer {child.colour || color} {textColor}"
          on:click={() => window.open(child.url, '_blank')}
        >
          <div class="flex items-center gap-3">
            {#if child.icon && IconComponent}
              <span class="w-6 h-6">
                <svelte:component this={IconComponent} name={child.icon} />
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
            <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd" />
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
</style>