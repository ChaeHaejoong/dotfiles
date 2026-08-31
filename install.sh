#!/usr/bin/env bash

DOTFILES="$HOME/dotfiles"

configDirs=(
    assets
    fcitx
    fcitx5
    fish
    hypr
    kitty
    nvim
    waybar
)

for dir in "${configDirs[@]}"; do
    src="$DOTFILES/$dir"
    dst="$HOME/.config/$dir"

    if [ -e "$dst" ] || [ -L "$dst" ]; then
        read -r -p "$dst 이미 있는데 덮어쓸래? [y/n] " answer

        if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
            rm -rf "$dst"
            ln -s "$src" "$dst"
        else
            echo "$dst 건너뜀"
        fi
    else
        ln -s "$src" "$dst"
    fi
done

ln -s "$DOTFILES/.local/bin" "$HOME/.local/bin"
