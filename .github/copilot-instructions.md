You are editing the portfolio site of renowned satirist Oli Frost, which documents a long list of very differnet projects over the years, and links out to his social medias

I'm in the middle of porting over an older implementation in jekyll, stored in /original

It is built with Astro (built on Vite), and the new Tailwind 4, and is capable of being extended with Svelte 5 for serious interactivity

Always use Tailwind for styling, if possible

We prefer a very modular design, with components /src/components, layouts in /src/layours

It consists of various projects, in mdx files, in src/content/year/project

Each contains things like a title, description, image, and maybe a link to a video and some press mentions

This collection is defined in content.config.ts
And global variables in consts.ts

Where serious interactivity is required we can build Svelte components

We are still deciding what implementation to use for icons, but will likely use a package for that

The site's colour scheme is black, blue and white
Its theme is light, minimal, and its simplicity is brutalistic, with a nod to the early web with its original internet blue defined in global.css