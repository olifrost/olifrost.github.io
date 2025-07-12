def extract_title_from_content(content):
    """Extract title from the markdown content"""
    # Look for the first # heading
    lines = content.split('\n')
    for line in lines:
        if line.startswith('# '):
            return line[2:].strip()
    return ""
#!/usr/bin/env python3
"""
Press Article Cleaner for Oli Frost's Portfolio

This script:
1. Renames files to clean lowercase slugs
2. Removes all markdown images ![...](...) 
3. Cleans up frontmatter
4. Handles excerpt blocks consistently

Usage:
  python scripts/clean-press.py
  
Processes all .md files in src/content/press/
"""

import os
import re
import glob
from pathlib import Path
def escape_yaml_double_quotes(text):
    """Escape double quotes for YAML double-quoted strings"""
    return text.replace('"', '\"')

def slugify(text):
    """Convert text to a clean URL slug"""
    # Remove file extension
    text = re.sub(r'\.(md|markdown)$', '', text, flags=re.IGNORECASE)
    # Convert to lowercase
    text = text.lower()
    # Replace spaces and special chars with hyphens
    text = re.sub(r'[^\w\s-]', '', text)
    text = re.sub(r'[-\s]+', '-', text)
    # Remove leading/trailing hyphens
    text = text.strip('-')
    return text

def remove_images(content):
    """Remove all markdown images from content"""
    # Remove markdown images: ![alt text](path)
    content = re.sub(r'!\[([^\]]*)\]\([^)]+\)', '', content)
    # Remove standalone image references
    content = re.sub(r'^\s*\[Image:.*\]\s*$', '', content, flags=re.MULTILINE)
    # Clean up multiple empty lines
    content = re.sub(r'\n{3,}', '\n\n', content)
    return content

def clean_excerpt_section(content):
    """Remove or clean the excerpt section"""
    # Remove the '> ## Excerpt' section entirely
    content = re.sub(r'> ## Excerpt\s*\n> [^\n]+\s*\n\n---\s*\n', '', content)
    # Also handle variations
    content = re.sub(r'>\s*##\s*Excerpt[^\n]*\n>[^\n]*\n*---\s*\n', '', content)
    return content

def clean_frontmatter(content):
    """Clean and standardize frontmatter, safely quoting titles"""
    lines = content.split('\n')
    
    if len(lines) < 3 or lines[0] != '---':
        # No frontmatter, add basic one
        title = extract_title_from_content(content)
        safe_title = escape_yaml_double_quotes(title or 'Article Title')
        return f"""---\ntitle: \"{safe_title}\"\nsource: \"\"\nauthor: \"\"\ndate: 2024-01-01\n---\n\n{content}"""
    
    # Find end of frontmatter
    end_idx = None
    for i, line in enumerate(lines[1:], 1):
        if line.strip() == '---':
            end_idx = i
            break
    
    if end_idx is None:
        return content
    
    frontmatter_lines = lines[1:end_idx]
    body_lines = lines[end_idx+1:]
    body_content = '\n'.join(body_lines)
    
    # Extract title from content if not in frontmatter
    title = extract_title_from_content(body_content)
    
    # Parse existing frontmatter
    fm_data = {}
    for line in frontmatter_lines:
        if ':' in line:
            key, value = line.split(':', 1)
            fm_data[key.strip()] = value.strip()
    
    # Add or fix title
    if title:
        safe_title = escape_yaml_double_quotes(title)
        fm_data['title'] = f'"{safe_title}"'
    
    # Clean frontmatter
    cleaned_fm = []
    for key, value in fm_data.items():
        # Skip empty tags
        if key == 'tags' and (value == '[]' or not value.strip()):
            continue
        
        # Fix various nested tag formats
        if key == 'tags':
            # Handle nested arrays like [["Internal"]] -> ["Internal"]  
            if '[["' in value and '"]]' in value:
                value = value.replace('[[', '[').replace(']]', ']')
            # Handle other malformed tags - just remove them for simplicity
            elif 'tags: [' not in f"{key}: {value}" or value.count('[') != value.count(']'):
                continue  # Skip malformed tags
        
        cleaned_fm.append(f"{key}: {value}")
    
    # Reconstruct
    result = '---\n' + '\n'.join(cleaned_fm) + '\n---\n' + body_content
    return result
    return result

def process_file(filepath):
    """Process a single markdown file"""
    print(f"Processing: {filepath.name}")
    
    # Read file
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"  Error reading file: {e}")
        return
    
    # Clean content
    content = remove_images(content)
    content = clean_excerpt_section(content)
    content = clean_frontmatter(content)
    
    # Generate new filename
    new_name = slugify(filepath.stem) + '.md'
    new_path = filepath.parent / new_name
    
    # Avoid overwriting if name hasn't changed
    if filepath.name == new_name:
        # Just update content
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"  ✓ Cleaned content")
    else:
        # Rename and update
        with open(new_path, 'w', encoding='utf-8') as f:
            f.write(content)
        os.remove(filepath)
        print(f"  ✓ Renamed: {filepath.name} → {new_name}")

def main():
    """Main function"""
    press_dir = Path(__file__).parent.parent / 'src' / 'content' / 'press'
    
    if not press_dir.exists():
        print(f"Press directory not found: {press_dir}")
        return
    
    # Find all markdown files
    md_files = list(press_dir.glob('*.md')) + list(press_dir.glob('*.markdown'))
    
    if not md_files:
        print("No markdown files found in press directory")
        return
    
    print(f"Found {len(md_files)} files to process\n")
    
    for filepath in md_files:
        process_file(filepath)
    
    print(f"\n✓ Processed {len(md_files)} files")
    print("Press articles are ready!")

if __name__ == '__main__':
    main()
