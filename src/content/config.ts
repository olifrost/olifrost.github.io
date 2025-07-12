import { z, defineCollection } from 'astro:content';

const blogCollection = defineCollection({
  schema: z.object({
    title: z.string(),
    description: z.string().optional(),
    date: z.date(),
    image: z.string(),
    video: z.string().optional(),
    press: z.array(
      z.object({
        name: z.string(),
        article_link: z.string().optional(),
      })
    ).optional(),
    projectType: z.string().optional(),
    homepageCategory: z.string().optional(),
    homepageOrder: z.number().optional(),
    tags: z.array(z.string()).optional(),
  })
});

export const collections = {
  'blog': blogCollection,
};
``