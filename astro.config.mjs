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

// https://astro.build/config
export default defineConfig({
    site: 'https://olifro.st',
    // Add redirects configuration
    redirects: {
        '/stream': '/links',
        
        // Common misspellings or old URLs
        '/instagram': 'https://instagram.com/realolifrost',
        '/twitter': 'https://twitter.com/realolifrost',
        '/tiktok': 'https://tiktok.com/@olifrost',
        
        // Legacy redirects from jekyll site
        '/projects': '/',
        '/contact': '/links',
        '/posters': '/blog/climate-strike-posters',
        '/little-tips': '/blog/little-tips',   

        // Add 404 handling for paths that don't exist
        // This ensures a proper status code is returned while showing our custom 404 page
        '/404': {
            status: 404,
            destination: '/404'
        }
    },
    integrations: [
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
        svelte(),
        astroBrokenLinksChecker({
            logFilePath: 'broken-links.log', // Optional: specify the log file path
            checkExternalLinks: false // Optional: check external links (currently, caching to disk is not supported, and it is slow )
          }),
        icon({
            include: {
                // Only include the specific SVGs that are actually used in the site
                'lucide': ['music', 'globe', 'heart', 'coffee', 'gamepad-2', 'messages-square', 'video', 'mail'],
                'simple-icons': ['youtube', 'instagram', 'tiktok'],
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
            rollupOptions: {
                output: {
                    manualChunks: {
                        // Create separate chunk for icon packages to improve caching
                        'icons': [/astro-icon/, /@iconify-json/],
                        // Split large components into separate chunks
                        'svelte-components': [/\.svelte$/],
                    }
                }
            },
            // Increase warning limit while optimizing
            chunkSizeWarningLimit: 1000,
        },
        resolve: {
            alias: {
                '@assets': '/src/assets',
                '@components': '/src/components',
                '@layouts': '/src/layouts',
                '@posts': '/blog',
            }
        }
    },
});