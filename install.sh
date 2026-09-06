#!/usr/bin/env bash

DOTFILES="$HOME/dotfiles"
CONFIG="$DOTFILES/.config"

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
    src="$CONFIG/$dir"
    dst="$HOME/.config/$dir"

    if [ ! -e "$src" ]; then
        echo "오류: 설정 소스가 없습니다: $src" >&2
        exit 1
    fi

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

if [ -e "$DOTFILES/.local/bin" ]; then
    ln -s "$DOTFILES/.local/bin" "$HOME/.local/bin"
else
    echo "오류: 실행 파일 소스가 없습니다: $DOTFILES/.local/bin" >&2
    exit 1
fi
