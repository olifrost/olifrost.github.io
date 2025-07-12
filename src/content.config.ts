import { defineCollection, z } from 'astro:content';

// Define the blog collection schema
const blogCollection = defineCollection({
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
	})
});

// Press collection for articles about projects
const pressCollection = defineCollection({
	schema: z.object({
		title: z.string().optional(),
		created: z.string().optional(),
		tags: z.array(z.string()).optional(),
		source: z.string().optional(),
		author: z.string().optional().nullable(),
	}),
});

export const collections = {
	blog: blogCollection,
	press: pressCollection,
};
