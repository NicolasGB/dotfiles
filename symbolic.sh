#!/bin/bash

dotfiles_dir=~/dotfiles
config_dir=~/.config

create_symlink() {
    source_path="$dotfiles_dir/$1"
    target_path="$config_dir/$2"

    if [ -e "$target_path" ]; then
        echo "Symbolic link for $1 already exists."
    else
        ln -s "$source_path" "$target_path"
        echo "Symbolic link for $1 created."
    fi
}

remove_symlink() {
    target_path="$config_dir/$1"

    if [ -L "$target_path" ]; then
        rm "$target_path"
        echo "Symbolic link for $1 removed."
    else
        echo "No symbolic link found for $1."
    fi
}

case "$1" in
    "create")
        create_symlink nvim nvim
        create_symlink i3 i3
        create_symlink zellij zellij
        create_symlink polybar polybar
        create_symlink rofi rofi
        create_symlink picom picom
        create_symlink dunst dunst
        create_symlink mpd mpd
        create_symlink networkmanager-dmenu networkmanager-dmenu
        create_symlink nushell nushell
        echo "Setup completed!"
        ;;
    "remove")
        remove_symlink nvim
        remove_symlink i3
        remove_symlink zellij
        remove_symlink polybar
        remove_symlink rofi
        remove_symlink picom
        remove_symlink dunst
        remove_symlink mpd
        remove_symlink networkmanager-dmenu
        remove_symlink nushell
        echo "Removal completed!"
        ;;
    *)
        echo "Usage: $0 [create|remove]"
        exit 1
        ;;
esac

