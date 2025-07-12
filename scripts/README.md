# Portfolio Scripts

This folder contains helpful automation scripts for managing Oli Frost's portfolio site.

## 🚀 new-project.sh

An interactive script to quickly create new MDX blog posts with pre-configured templates and smart defaults.

### Usage
```bash
./scripts/new-project.sh
```

### Features
- **8 Post Templates**: Website, Instagram video, YouTube video, YouTube Short, Song video, Basic, Image, and Poster Gallery
- **Smart Defaults**: Auto-selects appropriate tags (music for songs, climate for most others, other for basic posts)
- **Interactive UI**: Uses `gum` for beautiful dropdown menus and input fields
- **URL Parsing**: Automatically extracts video IDs from YouTube and Instagram URLs
- **Press Integration**: For songs, easily add press mentions with links
- **Template Content**: Generates appropriate MDX content and component imports

### Templates

| Template | Default Tag | Use Case | Components |
|----------|-------------|----------|------------|
| **website** | climate | Link previews | `<LinkPreview>` |
| **instagram video** | climate | Instagram embeds | `<InstagramEmbed>` |
| **youtube video** | climate | YouTube videos | Just `video:` frontmatter |
| **youtube short** | climate | YouTube Shorts | `<YouTubeShort>` |
| **song video** | music | Music releases | Streaming links + lyrics section |
| **basic** | other | General posts | Minimal template |
| **image** | other | Image-focused posts | Single image display |
| **postergallery** | other | Multiple images | `<PosterGallery>` |

### Requirements
- [gum](https://github.com/charmbracelet/gum) for interactive UI (`brew install gum`)

### Examples
The script will guide you through:
1. Selecting a post type
2. Entering project details (name, description, date)
3. Choosing/confirming tags  
4. Adding type-specific content (URLs, video IDs, etc.)
5. Optional press mentions for songs

All files are created in `src/content/blog/` with appropriate frontmatter and template content.

## Other Scripts

- **clean-press.py**: Python script for cleaning press data
- **update-links.sh**: Updates links across the site

---

💡 **Need a new template or feature?** Edit `new-project.sh` to add custom templates and workflows!
