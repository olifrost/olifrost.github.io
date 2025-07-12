#!/bin/zsh
# A fun, colourful script to update the link tree for Oli Frost's portfolio

autoload -U colors && colors

# --- Configuration ---
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
PROJECT_ROOT=$(dirname "$SCRIPT_DIR")
LINKS_FILE="$PROJECT_ROOT/src/data/links.ts"

# --- Functions ---
function show_current_links() {
    print -P "%F{cyan}Current links in order:%f"
    grep -A 50 'docs: \[' "$LINKS_FILE" | grep -E 'title:' | head -10 | sed -E 's/.*title: "([^"]*)".*/ - \1/' | nl
}

function get_link_action() {
    print -P "%F{cyan}What would you like to do?%f"
    print -P "%F{yellow}1)%f Replace the second link (current project link)"
    print -P "%F{yellow}2)%f Add a new link after the first link"
    print -P "%F{yellow}3)%f Add a new link at the end"
    print -P "%F{yellow}4)%f Remove a link"
    print -P "%F{yellow}5)%f View current links and exit"
    print -P "%F{cyan}Choice (default: 1):%f"
    read action_choice
    if [[ -z "$action_choice" ]]; then
        action_choice="1"
    fi
}

function get_link_details() {
    print -P "%F{cyan}Link title:%f"
    read link_title
    
    print -P "%F{cyan}Link URL:%f"
    read link_url
    
    print -P "%F{cyan}Choose a color (default: bg-blue-600):%f"
    print -P "%F{yellow}1)%f bg-blue-600 (blue)"
    print -P "%F{yellow}2)%f bg-green-600 (green)"  
    print -P "%F{yellow}3)%f bg-red-600 (red)"
    print -P "%F{yellow}4)%f bg-purple-600 (purple)"
    print -P "%F{yellow}5)%f bg-pink-500 (pink)"
    print -P "%F{yellow}6)%f bg-orange-500 (orange)"
    print -P "%F{yellow}7)%f bg-indigo-600 (indigo)"
    print -P "%F{yellow}8)%f Custom color"
    read color_choice
    
    case $color_choice in
        1|"") link_color="bg-blue-600" ;;
        2) link_color="bg-green-600" ;;
        3) link_color="bg-red-600" ;;
        4) link_color="bg-purple-600" ;;
        5) link_color="bg-pink-500" ;;
        6) link_color="bg-orange-500" ;;
        7) link_color="bg-indigo-600" ;;
        8) 
            print -P "%F{cyan}Enter custom color (e.g., bg-teal-500):%f"
            read link_color
            ;;
        *) link_color="bg-blue-600" ;;
    esac
    
    print -P "%F{cyan}Choose an icon (default: lucide:globe):%f"
    print -P "%F{yellow}1)%f lucide:globe (website)"
    print -P "%F{yellow}2)%f lucide:music (music)"
    print -P "%F{yellow}3)%f lucide:video (video)"
    print -P "%F{yellow}4)%f lucide:gamepad-2 (game)"
    print -P "%F{yellow}5)%f lucide:heart (support)"
    print -P "%F{yellow}6)%f lucide:mail (email)"
    print -P "%F{yellow}7)%f lucide:external-link (external)"
    print -P "%F{yellow}8)%f Custom icon"
    read icon_choice
    
    case $icon_choice in
        1|"") link_icon="lucide:globe" ;;
        2) link_icon="lucide:music" ;;
        3) link_icon="lucide:video" ;;
        4) link_icon="lucide:gamepad-2" ;;
        5) link_icon="lucide:heart" ;;
        6) link_icon="lucide:mail" ;;
        7) link_icon="lucide:external-link" ;;
        8) 
            print -P "%F{cyan}Enter custom icon (e.g., lucide:star):%f"
            read link_icon
            ;;
        *) link_icon="lucide:globe" ;;
    esac
}

function replace_second_link() {
    get_link_details
    
    # Create the new link object
    new_link="    {
      title: \"$link_title\",
      url: \"$link_url\",
      colour: \"$link_color\",
      icon: \"$link_icon\"
    },"
    
    # Create a backup
    cp "$LINKS_FILE" "$LINKS_FILE.backup"
    
    # Find and replace the second link
    # This is a bit complex because we need to find the second occurrence
    awk '
        BEGIN { in_docs = 0; link_count = 0; in_second_link = 0; brace_count = 0 }
        /docs: \[/ { in_docs = 1; print; next }
        in_docs && /^    \{/ && !in_second_link { 
            link_count++
            if (link_count == 2) {
                in_second_link = 1
                brace_count = 1
                print "'"$new_link"'"
                next
            }
        }
        in_second_link {
            if (/\{/) brace_count++
            if (/\}/) brace_count--
            if (brace_count == 0) in_second_link = 0
            next
        }
        { print }
    ' "$LINKS_FILE.backup" > "$LINKS_FILE"
    
    print -P "%F{green}✅ Replaced second link with: $link_title%f"
}

function add_new_link() {
    local position="$1"
    get_link_details
    
    # Create the new link object
    new_link="    {
      title: \"$link_title\",
      url: \"$link_url\",
      colour: \"$link_color\",
      icon: \"$link_icon\"
    },"
    
    # Create a backup
    cp "$LINKS_FILE" "$LINKS_FILE.backup"
    
    if [[ "$position" == "after_first" ]]; then
        # Add after first link
        awk '
            BEGIN { in_docs = 0; link_count = 0; added = 0 }
            /docs: \[/ { in_docs = 1; print; next }
            in_docs && /^    \},/ && !added { 
                link_count++
                print
                if (link_count == 1) {
                    print "'"$new_link"'"
                    added = 1
                }
                next
            }
            { print }
        ' "$LINKS_FILE.backup" > "$LINKS_FILE"
        print -P "%F{green}✅ Added new link after first link: $link_title%f"
    else
        # Add at end (before closing bracket)
        awk '
            BEGIN { in_docs = 0 }
            /docs: \[/ { in_docs = 1 }
            in_docs && /^  \]/ { 
                print "'"$new_link"'"
                in_docs = 0
            }
            { print }
        ' "$LINKS_FILE.backup" > "$LINKS_FILE"
        print -P "%F{green}✅ Added new link at end: $link_title%f"
    fi
}

function remove_link() {
    show_current_links
    print -P "%F{cyan}Which link number would you like to remove?%f"
    read link_number
    
    if [[ ! "$link_number" =~ ^[0-9]+$ ]]; then
        print -P "%F{red}Invalid link number%f"
        return
    fi
    
    # Create a backup
    cp "$LINKS_FILE" "$LINKS_FILE.backup"
    
    # Remove the specified link
    awk -v target="$link_number" '
        BEGIN { in_docs = 0; link_count = 0; in_target_link = 0; brace_count = 0 }
        /docs: \[/ { in_docs = 1; print; next }
        in_docs && /^    \{/ && !in_target_link { 
            link_count++
            if (link_count == target) {
                in_target_link = 1
                brace_count = 1
                next
            }
        }
        in_target_link {
            if (/\{/) brace_count++
            if (/\}/) brace_count--
            if (brace_count == 0) in_target_link = 0
            next
        }
        { print }
    ' "$LINKS_FILE.backup" > "$LINKS_FILE"
    
    print -P "%F{green}✅ Removed link #$link_number%f"
}

# --- Main Script ---
print -P "%F{blue}Welcome to the %F{white}Oli Frost Link Tree Manager!%f"
echo

show_current_links
echo

get_link_action

case $action_choice in
    1)
        print -P "%F{cyan}Replacing the second link (current project link)...%f"
        replace_second_link
        ;;
    2)
        print -P "%F{cyan}Adding new link after the first link...%f"
        add_new_link "after_first"
        ;;
    3)
        print -P "%F{cyan}Adding new link at the end...%f"
        add_new_link "at_end"
        ;;
    4)
        print -P "%F{cyan}Removing a link...%f"
        remove_link
        ;;
    5)
        print -P "%F{green}Current links displayed above. Goodbye!%f"
        exit 0
        ;;
    *)
        print -P "%F{red}Invalid choice. Exiting.%f"
        exit 1
        ;;
esac

echo
print -P "%F{green}Link tree updated successfully!%f"
print -P "%F{cyan}Backup saved as: $LINKS_FILE.backup%f"
