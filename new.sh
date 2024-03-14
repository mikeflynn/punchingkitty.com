#!/usr/bin/env bash

BANNER="
██████  ██    ██ ███    ██  ██████ ██   ██ ██ ███    ██  ██████
██   ██ ██    ██ ████   ██ ██      ██   ██ ██ ████   ██ ██
██████  ██    ██ ██ ██  ██ ██      ███████ ██ ██ ██  ██ ██   ███
██      ██    ██ ██  ██ ██ ██      ██   ██ ██ ██  ██ ██ ██    ██
██       ██████  ██   ████  ██████ ██   ██ ██ ██   ████  ██████


██   ██ ██ ████████ ████████ ██    ██
██  ██  ██    ██       ██     ██  ██
█████   ██    ██       ██      ████
██  ██  ██    ██       ██       ██
██   ██ ██    ██       ██       ██
                                    "
clear && echo -e "$BANNER"

TITLE=$(gum input --placeholder "What is the title for the new post?")

if [ -z "$TITLE" ]; then
  echo "No slug provided. Exiting..."
  exit 1
fi

# Make a slug out of the title
SLUG=$(echo "$TITLE" | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z)

CATEGORIES=$(gum choose --no-limit --header "What categories does this post belong to?" -- "crime" "sports" "happening" "media" "going-out" "capitalism-and-politics" "meta" "video" "best-of")

TAGS=$(gum input --placeholder "What tags does this post have? Separate with commas.")

gum confirm --default=0 "Create this new post?" || exit 1

FILENAME="content/post/$(date +%Y)-$(date +%m)-$(date +%d)-$SLUG.md"

# Make the new file in the right place
touch "$FILENAME"

# Add the frontmatter
echo "---
title: \"$TITLE\"
type: post
date: $(date +%Y-%m-%dT%H:%M:%S%z)
draft: true
url: /$(date +%Y)/$(date +%m)/$(date +%d)/$SLUG/
featured_image:
categories:
$(for category in $CATEGORIES; do echo "  - $category"; done)
tags:
$(for tag in $(echo "$TAGS" | tr ',' ' '); do echo "  - $tag"; done)
---" > "$FILENAME"

subl "$FILENAME" && open ./static/images/