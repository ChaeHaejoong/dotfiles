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

if [ -e "$dst" ] || [ -L "$dst" ]; then
    read -r -p "니 컴퓨터에 이미 설정 있는데 덮어쓸래 말래 [y/n]" answer

    if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
        for dir in "${configDirs[@]}"; do
            src="$DOTFILES/$dir"
            dst="$HOME/.config/$dir"

            rm -rf "$dst"
            ln -s "$src" "$dst"
        done

        ln -s "$DOTFILES/.local/bin" "$HOME/.local/bin"
    else
        echo "설정 다운하지 않고 종료"
        exit 0
    fi

fi
