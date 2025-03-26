<script lang="ts">
  import LinkItem from './LinkItem.svelte';
  import { links, streamingLinks } from '../data/links';
</script>

<div class="min-h-screen flex items-center">
  <div class="max-w-2xl mx-auto px-4 py-8 w-full">
    <h1 class="text-3xl font-bold mb-4 text-center">Oli Frost</h1>
    
    <nav class="space-y-2 w-full">
      {#each links.docs as link}
        <LinkItem 
          title={link.title}
          url={link.url}
          icon={link.icon}
          color={link.colour}
          isExpandable={link.isExpandable}
          children={link.children}
        />
      {/each}
    </nav>
  </div>
</div>