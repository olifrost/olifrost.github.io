import { glob } from 'astro/loaders';
import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
	loader: glob({ base: './src/content/', pattern: '**/*.{md,mdx,astro}' }),
	schema: ({ image }) => z.object({
		title: z.string(),
		description: z.string(),
		date: z.coerce.date(),
		updatedDate: z.coerce.date().optional(),
		image: image(),
		video: z.string().optional(),
		press: z.array(
			z.object({
				name: z.string(),
				article_link: z.string().optional()
			})
		).optional(),
		// Organization fields
		tags: z.array(z.string()).optional(),
		homepageCategory: z.enum(['songs', 'climate', 'archive']).optional(),
		homepageOrder: z.number().optional(),
		 // Project type for layout selection
		projectType: z.enum(['default', 'standalone', 'product', 'music']).optional(),
		// Publishing status
		draft: z.boolean().optional(),
	}),
});



export const collections = { blog };
