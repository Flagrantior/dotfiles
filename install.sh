#!/bin/bash

cd $(dirname "$0")

pacman -Syu
pacman -S yay
yay -S base base-devel networkmanager neovim exa autojump ripgrep wayland xwayland sway waybar alacritty rofi-lbonn-wayland-git slurp wl-clipboard grim nemo xcursor-thedot nerd-fonts-hermit perl-image-exiftool

cp .bashrc ~/.bashrc
cp .bash_profile ~/.bash_profile

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#BlackArch
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sudo ./strap.sh
sudo pacman -Syu

echo -e "[Icon Theme]\nInherits=TheDOT-dark" | sudo tee /usr/share/icons/default/index.theme

mkdir ~/Projects

shopt -s globstar
shopt -s checkjobs
shopt -s extglob
shopt -s dotglob
shopt -s histverify


cp qutebrowser.desktop ~/.local/share/applications/qutebrowser.desktop
xdg-settings set default-web-browser qutebrowser.desktop

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:#00ffff,bg:#000000,hl:#ff00ff
 --color=fg+:#ffffff,bg+:#000000,hl+:#ff00ff
 --color=info:#afaf87,prompt:#00ff00,pointer:#ff00ff
 --color=marker:#ff0000,spinner:#ff0000,header:#ff00ff'
export PATH=/home/flagrantior/.config/scripts:$PATH

BROWSER=""; xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop
