## Packages

Autorandr\
Betterlockscreen\
Brightnessctl\
Rofi\
Polybar\
Networkmanager_dmenu\
Blueman\
Nitrogen\
Picom\
Playerctl\
Mpv\
snixembed\
Kwallet (pam kwallet)\
Wezterm\
PCManFM\
nmtui\
xclip\

-- Some usefull packages--

lsd\
bat\
fd\
ripgrep\
zoxide\
lazydocker\
lazygit\
starship\
sad\
fzf\
delta\
libratbag (mouse)\
piper (mouse)\
copyq\
network-manager-applet

sddm-sugar-candy

#### Specific paths

paru -> /etc/paru.conf
pacman -> /etc/pacman.conf

-- Useful commands --

#### Set keyboard layout

```sh
set keyboard layout definitive in X11:
    localectl --no-convert set-x11-keymap es,fr '' ''  caps:escape
```

#### Set lockscreen

```sh
betterlockscreen-u ~/polybar-themes/wallpapers/bg_17.jpg --fx dim,pixel
```

tips: From polybar clone and launch once the script comming from then then cp again over and icons are up

##### Symbolic links

```sh
ln -s  ~/dotfiles/nvim ~/.config/nvim
ln -s  ~/dotfiles/i3 ~/.config/i3
ln -s  ~/dotfiles/zellij ~/.config/zellij
ln -s  ~/dotfiles/polybar ~/.config/polybar
ln -s  ~/dotfiles/rofi ~/.config/rofi/
ln -s  ~/dotfiles/picom ~/.config/picom/
ln -s  ~/dotfiles/dunst ~/.config/dunst/
ln -s  ~/dotfiles/mpd/ ~/.config/mpd/
ln -s ~/dotfiles/networkmanager-dmenu/ ~/.config/networkmanager-dmenu/
```

##### Command for installing

-- Pacman

```sh
pacman -S $(cat package.list) --noconfirm
```

```sh
pacman -S $(cat package.list) --noconfirm --overwrite "*"
```

-- Paru

```sh
paru -S $(cat aur.list)
```
