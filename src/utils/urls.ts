/**
 * Generates a consistent URL for a blog post
 * @param id The full content collection ID (e.g. '2022/project-name')
 * @returns A URL path for the blog post
 */
export function getBlogUrl(id: string): string {
  // Extract just the filename without year directory
  const slug = id.split('/').pop() || id;
  return `/blog/${slug}`;
}