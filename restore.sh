#!/bin/bash
cd ~/hyprdots
for file in *; do
  target="$HOME/.config/$file"
  [ -e "$target" ] && echo "Skipping $file: already exists." && continue
  ln -s "$(pwd)/$file" "$target"
done

