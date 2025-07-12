/**
 * Generates a consistent URL for a blog post
 * @param id The content collection ID (e.g. 'project-name.mdx')
 * @returns A URL path for the blog post
 */
export function getBlogUrl(id: string): string {
  // Remove file extension (.mdx, .md, etc.)
  const cleanSlug = id.replace(/\.(mdx?|md)$/, '');
  return `/blog/${cleanSlug}`;
}