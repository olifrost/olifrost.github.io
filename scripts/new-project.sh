#!/bin/zsh
# A fun, colourful script to create a new MDX project file for Oli Frost's portfolio
export PATH="/opt/homebrew/bin:$PATH"

autoload -U colors && colors

# --- Configuration ---
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
PROJECT_ROOT=$(dirname "$SCRIPT_DIR")
CONTENT_DIR="$PROJECT_ROOT/src/content"
ASSETS_DIR="@assets" # Astro alias for src/assets

# --- Functions ---
function select_tag() {
    # Find all unique tags from all mdx files
    local all_tags=($(grep -hE "^tags:" "$CONTENT_DIR"/**/*.mdx(N) 2>/dev/null | sed -E "s/tags: \[(.*)\]/\1/" | tr -d "'" | tr ',' '\n' | sort -u | grep -v '^[[:space:]]*$'))
    
    if [[ ${#all_tags[@]} -eq 0 ]]; then
        selected_tag=$(gum input --placeholder "Enter a new tag (or leave blank)")
        return
    fi

    # Add "New tag..." option and use gum for tag selection
    local tag_options=("${all_tags[@]}" "New tag...")
    selected_tag=$(printf "%s\n" "${tag_options[@]}" | gum choose --header "Choose a tag:")
    
    if [[ "$selected_tag" == "New tag..." ]]; then
        selected_tag=$(gum input --placeholder "Enter new tag (or leave blank)")
    fi
}

function validate_date() {
    local date_input="$1"
    if [[ $date_input =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        return 0
    else
        return 1
    fi
}

function extract_instagram_id() {
    local url="$1"
    # Extract from URLs like https://www.instagram.com/reel/DLXxE-XPO0w/
    echo "$url" | sed -E 's#.*/(reel|p)/([^/]+).*#\2#'
}

function extract_youtube_id() {
    local input="$1"
    if [[ $input =~ "youtu.be/" ]]; then
        echo "$input" | sed -E 's#.*youtu.be/([a-zA-Z0-9_-]+).*#\1#'
    elif [[ $input =~ "youtube.com/watch" ]]; then
        echo "$input" | sed -E 's#.*v=([a-zA-Z0-9_-]+).*#\1#'
    elif [[ $input =~ "youtube.com/shorts/" ]]; then
        echo "$input" | sed -E 's#.*shorts/([a-zA-Z0-9_-]+).*#\1#'
    else
        echo "$input"
    fi
}

function create_website_template() {
    local url="$1"
    cat <<EOF
$frontmatter

<LinkPreview id="$url" />
EOF
}

function create_instagram_template() {
    local url="$1"
    local title="$2"
    cat <<EOF
$frontmatter
import InstagramEmbed from "@components/InstagramEmbed.astro";

<InstagramEmbed postUrl="$url" title="$title" />
EOF
}

function create_youtube_video_template() {
    # No content, just frontmatter with video property
    echo "$frontmatter"
}

function create_youtube_short_template() {
    local video_id="$1"
    cat <<EOF
$frontmatter

<YouTubeShort id="$video_id" />
EOF
}

function create_song_template() {
    cat <<EOF
$frontmatter

[Stream](https://olifro.st/links) or [buy this track](https://olifrost.bandcamp.com) anywhere you like, if you like 

## Lyrics
Write your lyrics here...
EOF
}

function create_basic_template() {
    cat <<EOF
$frontmatter

Write your project content here.
EOF
}

function create_image_template() {
    cat <<EOF
$frontmatter

![]($image)
EOF
}

function create_postergallery_template() {
    local gallery_path="$1"
    cat <<EOF
$frontmatter

<PosterGallery path="$gallery_path" />
EOF
}

# --- Main Script ---
gum style --foreground 212 --border-foreground 212 --border double --align center --width 50 --margin "1 2" --padding "2 4" "Welcome to the Oli Frost Project Creator!"

# Get today's date
today=$(date +%Y-%m-%d)

# Choose post type template
post_type=$(gum choose --header "What kind of post is this?" \
    "website" \
    "instagram video" \
    "youtube video" \
    "youtube short" \
    "song video" \
    "basic" \
    "image" \
    "postergallery")

# Get project name
project_name=$(gum input --placeholder "What's the project called?")
if [[ -z "$project_name" ]]; then
    echo "Project name is required!"
    exit 1
fi

slug=$(echo "$project_name" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g' | sed -E 's/^-+|-+$//g')

# Get description based on post type
case "$post_type" in
    "website")
        description=$(gum input --placeholder "How should we describe it?")
        ;;
    "instagram video")
        echo "Getting Instagram post details..."
        instagram_url=$(gum input --placeholder "Instagram post URL")
        if [[ -z "$instagram_url" ]]; then
            echo "Instagram URL is required!"
            exit 1
        fi
        # Try to get title from Instagram (simplified - user can edit)
        description=$(gum input --placeholder "Description (will use as title for embed)" --value "$project_name")
        ;;
    "youtube video"|"youtube short"|"song video"|"basic"|"image"|"postergallery")
        description=$(gum input --placeholder "How should we describe it?")
        ;;
esac

# Get release date
date=$(gum input --placeholder "When was it released? (YYYY-MM-DD)" --value "$today")
while ! validate_date "$date"; do
    echo "Invalid date format. Please use YYYY-MM-DD"
    date=$(gum input --placeholder "When was it released? (YYYY-MM-DD)" --value "$today")
done

# Set default tag based on post type and allow override
case "$post_type" in
    "song video")
        default_tag="music"
        ;;
    "basic"|"image"|"postergallery")
        default_tag="other"
        ;;
    *)
        default_tag="climate"
        ;;
esac

# Ask for tag with default
confirm_tag=$(gum confirm --default=true "Use default tag: $default_tag?" && echo "yes" || echo "no")
if [[ "$confirm_tag" == "yes" ]]; then
    selected_tag="$default_tag"
else
    select_tag
fi

# Get image

# Prompt for source image file to copy
copy_image=$(gum confirm "Would you like to copy an image file from your computer?" && echo "yes" || echo "no")
if [[ "$copy_image" == "yes" ]]; then
    src_image_path=$(gum input --placeholder "Enter the path to your image file (e.g. ~/Downloads/image.jpg)")
    # Get year from date
    year=$(echo "$date" | cut -d'-' -f1)
    dest_dir="$PROJECT_ROOT/src/assets/$year"
    mkdir -p "$dest_dir"
    dest_image_path="$dest_dir/$slug.jpg"
    cp "$src_image_path" "$dest_image_path"
    image="@assets/$year/$slug.jpg"
    gum style --foreground 212 "✅ Copied image to $dest_image_path"
else
    image=$(gum input --placeholder "Image file (leave blank for default)" --value "$ASSETS_DIR/blog/$slug.jpg")
    if [[ -z "$image" ]]; then
        # Get year from date
        year=$(echo "$date" | cut -d'-' -f1)
        image="$ASSETS_DIR/$year/$slug.jpg"
    fi
fi

# Handle post-type specific inputs
video_id=""
url=""
press_info=""
gallery_path=""

case "$post_type" in
    "website")
        url=$(gum input --placeholder "Website URL")
        if [[ -z "$url" ]]; then
            echo "Website URL is required!"
            exit 1
        fi
        ;;
    "instagram video")
        # Already got instagram_url above
        ;;
    "youtube video"|"song video")
        video_input=$(gum input --placeholder "YouTube video link or ID")
        if [[ -n "$video_input" ]]; then
            video_id=$(extract_youtube_id "$video_input")
        fi
        
        if [[ "$post_type" == "song video" ]]; then
            add_press=$(gum confirm "Add press mentions?" && echo "yes" || echo "no")
            if [[ "$add_press" == "yes" ]]; then
                press_info=$(gum write --placeholder "Enter press mentions (one per line, format: 'Name' or 'Name|URL')")
            fi
        fi
        ;;
    "youtube short")
        video_input=$(gum input --placeholder "YouTube Short link or ID")
        if [[ -z "$video_input" ]]; then
            echo "YouTube Short link is required!"
            exit 1
        fi
        video_id=$(extract_youtube_id "$video_input")
        ;;
    "postergallery")
        gallery_path=$(gum input --placeholder "Gallery path (e.g., @assets/2024/project-gallery)" --value "@assets/blog/$slug-gallery")
        ;;
    "basic"|"image")
        # No additional inputs needed
        ;;
esac

# Create MDX file in blog directory
dir="$CONTENT_DIR/blog"
mkdir -p "$dir"
file="$dir/$slug.mdx"

# Build frontmatter
frontmatter="---"
frontmatter="$frontmatter
title: $project_name"
frontmatter="$frontmatter
description: $description"
frontmatter="$frontmatter
image: \"$image\""
frontmatter="$frontmatter
date: $date"

if [[ -n "$selected_tag" ]]; then
    frontmatter="$frontmatter
tags: ['$selected_tag']"
else
    frontmatter="$frontmatter
tags: []"
fi

if [[ -n "$video_id" ]]; then
    frontmatter="$frontmatter
video: $video_id"
fi

# Add press info if provided
if [[ -n "$press_info" ]]; then
    frontmatter="$frontmatter
press:"
    while IFS= read -r line; do
        if [[ -n "$line" ]]; then
            if [[ "$line" == *"|"* ]]; then
                name=$(echo "$line" | cut -d'|' -f1)
                url=$(echo "$line" | cut -d'|' -f2)
                frontmatter="$frontmatter
  - name: \"$name\"
    article_link: '$url'"
            else
                frontmatter="$frontmatter
  - name: \"$line\""
            fi
        fi
    done <<< "$press_info"
fi

frontmatter="$frontmatter
---"

# Generate content based on template
case "$post_type" in
    "website")
        content=$(create_website_template "$url")
        ;;
    "instagram video")
        content=$(create_instagram_template "$instagram_url" "$description")
        ;;
    "youtube video")
        content=$(create_youtube_video_template)
        ;;
    "youtube short")
        content=$(create_youtube_short_template "$video_id")
        ;;
    "song video")
        content=$(create_song_template)
        ;;
    "basic")
        content=$(create_basic_template)
        ;;
    "image")
        content=$(create_image_template)
        ;;
    "postergallery")
        content=$(create_postergallery_template "$gallery_path")
        ;;
esac

echo "$content" > "$file"

gum style --foreground 212 "✅ Created $file!"
echo ""
gum style --foreground 246 "Next steps:"
echo "• Add image to public/blog/$slug.jpg"
if [[ "$post_type" == "song video" ]]; then
    echo "• Write lyrics in the file"
fi
if [[ "$post_type" == "postergallery" ]]; then
    echo "• Add images to the gallery folder: ${gallery_path//@assets/public}"
fi
echo "• Edit and refine the content as needed"
