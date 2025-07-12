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
        print -P "%F{cyan}No existing tags found. Enter a new tag (or leave blank):%f"
        read selected_tag
        return
    fi

    print -P "%F{cyan}Choose a tag or enter a new one (leave blank for none):%f"
    for i in {1..${#all_tags[@]}}; do
        print -P "%F{yellow}$i)%f ${all_tags[$i]}"
    done
    print -P "%F{yellow}0)%f Enter a new tag"
    read tag_choice

    if [[ -z "$tag_choice" ]]; then
        selected_tag=""
    elif [[ "$tag_choice" == "0" ]]; then
        print -P "%F{cyan}Enter new tag (or leave blank):%f"
        read selected_tag
    elif [[ "$tag_choice" =~ ^[0-9]+$ && $tag_choice -ge 1 && $tag_choice -le ${#all_tags[@]} ]]; then
        selected_tag="${all_tags[$tag_choice]}"
    else
        print -P "%F{red}Invalid choice, leaving tag blank%f"
        selected_tag=""
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


# --- Main Script ---
print -P "%F{blue}Welcome to the %F{white}Oli Frost Project Creator!%f"

# Get current year and today
year=$(date +%Y)
today=$(date +%Y-%m-%d)

# Ask for project name
print -P "%F{cyan}What's the project called?%f"
read project_name
slug=$(echo "$project_name" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g' | sed -E 's/^-+|-+$//g')

# Ask for description
print -P "%F{cyan}How should we describe it?%f"
read description

# Ask for release date with validation
while true; do
    print -P "%F{cyan}When was it released? (YYYY-MM-DD, default: $today)%f"
    read date
    if [[ -z "$date" ]]; then
        date="$today"
        break
    elif validate_date "$date"; then
        break
    else
        print -P "%F{red}Invalid date format. Please use YYYY-MM-DD%f"
    fi
done

# Ask for image (optional)
print -P "%F{cyan}Image file (leave blank to use $ASSETS_DIR/$year/$slug.jpg):%f"
read image
if [[ -z "$image" ]]; then
    image="$ASSETS_DIR/$year/$slug.jpg"
fi

# Ask for video link (optional)
print -P "%F{cyan}YouTube video link or ID (optional):%f"
read video_input

video_id=""
if [[ -n "$video_input" ]]; then
    if [[ $video_input =~ "youtu.be/" ]]; then
        video_id=$(echo $video_input | sed -E 's#.*youtu.be/([a-zA-Z0-9_-]+).*#\1#')
    elif [[ $video_input =~ "youtube.com/watch" ]]; then
        video_id=$(echo $video_input | sed -E 's#.*v=([a-zA-Z0-9_-]+).*#\1#')
    else
        video_id=$video_input
    fi
fi

# Select tag
select_tag

# Create MDX file
dir="$CONTENT_DIR/$year"
mkdir -p "$dir"
file="$dir/$slug.mdx"

# Build frontmatter
frontmatter="---
title: $project_name
description: $description
image: \"$image\"
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

frontmatter="$frontmatter
---"

cat > "$file" <<EOF
$frontmatter

Write your project content here.
EOF

print -P "%F{green}✅ Created $file!%f"
