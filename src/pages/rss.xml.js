import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';
import { SITE_TITLE, SITE_DESCRIPTION } from '../consts';
import { getBlogUrl } from '../utils/urls';

export async function GET(context) {
	const posts = await getCollection('blog');

	// Sort posts by date, most recent first
	const sortedPosts = posts.sort((a, b) =>
		new Date(b.data.date).getTime() - new Date(a.data.date).getTime()
	);

	return rss({
		title: SITE_TITLE,
		description: SITE_DESCRIPTION,
		site: context.site,
		stylesheet: '/rss/pretty-feed-v3.xsl',
		// Add xmlns for media content (images)
		xmlns: {
			media: 'http://search.yahoo.com/mrss/',
		},
		items: sortedPosts.map((post) => {
			const item = {
				title: post.data.title,
				pubDate: post.data.date,
				description: post.data.description,
				link: getBlogUrl(post.id),
			};

			// Add image if available
			if (post.data.image) {
				// Handle both string paths and ImageMetadata objects
				let imagePath;
				if (typeof post.data.image === 'string') {
					// Convert @assets/2025/image.jpg to /img/2025/image.jpg
					imagePath = post.data.image.replace('@assets/', '/img/');
				} else {
					// If it's an ImageMetadata object
					imagePath = post.data.image.src;
				}

				const imageUrl = new URL(imagePath, context.site).toString();
				const imageFormat = imagePath.endsWith('.png') ? 'png' : 'jpeg';

				item.customData = `<media:content
					type="image/${imageFormat}"
					medium="image"
					url="${imageUrl}" />`;
			}

			return item;
		}),
	});
}
