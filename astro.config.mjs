// @ts-check
import { defineConfig } from 'astro/config';
import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';
import tailwindcss from "@tailwindcss/vite";
import svelte from '@astrojs/svelte';
import AutoImport from 'astro-auto-import';
import icon from 'astro-icon';
import astroBrokenLinksChecker from 'astro-broken-link-checker';
import { visualizer } from "rollup-plugin-visualizer";
import alpinejs from '@astrojs/alpinejs';
import umami from "@yeskunall/astro-umami";

// https://astro.build/config
export default defineConfig({
    site: 'https://olifro.st',
    // Add redirects configuration
    redirects: {
        '/stream': '/links',
        '/bio-builder': '/about',
        
        // Common misspellings or old URLs
        '/instagram': 'https://instagram.com/realolifrost',
        '/twitter': 'https://twitter.com/realolifrost',
        '/tiktok': 'https://tiktok.com/@olifrost',
        
        // Legacy redirects from jekyll site
        '/contact': '/links',
        '/posters': '/blog/climate-strike-posters',
        '/little-tips': '/blog/little-tips',   
        '/projects': '/blog',   
        '/ughconsumerism': '/blog/ughconsumerism',
        '/shop': '/about',    
        '/downloads': '/links',
        '/social': '/links',     
        '/bad-workflows': '/blog/bad-workflows',
        '/buymeacat': '/blog/buymeacat',
        '/fossilghouls': '/blog/fossilghouls',
        '/refer': '/blog/refer-a-friend',
        '/realistic-earth-emoji': '/blog/realistic-earth-emoji',
        '/recorda-boi': '/blog/recorda-boi',
        '/songs': '/tags/music',                      

        // Add 404 handling for paths that don't exist
        // This ensures a proper status code is returned while showing our custom 404 page
    },
    image: {
        responsiveStyles: true,
        layout: 'constrained',
  },
    // Ensure output directory is configured correctly
    outDir: './dist',
    // Configure experimental features properly
    integrations: [
        umami({ id: "ea01c721-04db-4c01-9a97-ae88acb7ea7e" }),
        AutoImport({
            imports: [
              // Import the YouTube component from your own components
              // Import astro-embed components
              '/src/components/YouTubeShort.astro',
              '/src/components/PosterGallery.astro',
              '/src/components/VideoCollection.astro',
              '/src/components/OptimizedYouTube.astro',
              { 'astro-embed': ['Tweet', 'Vimeo', 'YouTube',  'LinkPreview'] },
              // Import Astro's native Image component
              //{ 'astro:components': ['Image'] },
            ]
        }),
        mdx(),
        sitemap(),
        svelte({

        }),
        alpinejs(),
        astroBrokenLinksChecker({
            logFilePath: 'broken-links.log', // Optional: specify the log file path
            checkExternalLinks: false // Optional: check external links (currently, caching to disk is not supported, and it is slow )
          }),
        icon({
            include: {
                // Only include the specific SVGs that are actually used in the site
                'lucide': ['music'],
            },
            // Add this configuration to optimize icon loading
            svgoOptions: {
                multipass: true,
                plugins: [
                    {
                        name: 'preset-default',
                        params: {
                            overrides: {
                                // Disable plugins that might increase bundle size
                                removeViewBox: false,
                            },
                        },
                    },
                ],
            },
        }),
    ],
    vite: {
        plugins: [
            tailwindcss(),
            visualizer({
                emitFile: true,
                filename: "stats.html",
                open: true,
                gzipSize: true,
                brotliSize: true,
            })
        ],
        build: {
        },
        resolve: {
            alias: {
                '@assets': '/src/assets',
                '@components': '/src/components',
                '@layouts': '/src/layouts',
                '@posts': '/blog',
            }
        },
    },
});