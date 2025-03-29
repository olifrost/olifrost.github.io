<script lang="ts">
  import LinkItem from './LinkItem.svelte';
  import { links, streamingLinks } from '../data/links';
</script>

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