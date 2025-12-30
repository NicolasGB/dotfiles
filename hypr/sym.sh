#!/bin/bash

dotfiles_dir=~/dotfiles/hypr
config_dir=~/.config/hypr

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
        create_symlink conf/custom.conf conf/custom.conf
        create_symlink conf/windowrules/custom.conf conf/windowrules/custom.conf
        create_symlink conf/keybindings/custom.conf conf/keybindings/custom.conf
        create_symlink conf/keybindings/custom2.conf conf/keybindings/custom2.conf
        create_symlink conf/layouts/custom.conf conf/layouts/custom.conf
        create_symlink scripts/screen-record.sh scripts/screen-record.sh
        echo "Setup completed!"
        ;;
    "remove")
        remove_symlink conf/custom.conf 
        remove_symlink conf/windowrules/custom.conf 
        remove_symlink conf/keybindings/custom.conf 
        remove_symlink conf/layouts/custom.conf 
        remove_symlink scripts/screen-record.sh
        echo "Removal completed!"
        ;;
    *)
        echo "Usage: $0 [create|remove]"
        exit 1
        ;;
esac


