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
		items: sortedPosts.map((post) => ({
			title: post.data.title,
			pubDate: post.data.date,
			description: post.data.description,
			link: getBlogUrl(post.id),
		})),
	});
}
