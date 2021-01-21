#!/bin/bash

cd $(dirname "$0")

pacman -Syu
pacman -S yay
yay -S base base-devel networkmanager neovim exa autojump ripgrep wayland xwayland sway waybar alacritty rofi-lbonn-wayland-git slurp wl-clipboard grim nemo xcursor-thedot

cp .bashrc ~/.bashrc
cp .bash_profile ~/.bash_profile

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#BlackArch
curl -O https://blackarch.org/strap.sh
if [[ $(echo 9c15f5d3d6f3f8ad63a6927ba78ed54f1a52176b strap.sh | sha1sum -c) = "strap.sh: OK" ]]; then
	chmod +x strap.sh
	sudo ./strap.sh
	sudo pacman -Syu
fi

echo -e "[Icon Theme]\nInherits=TheDOT-dark" | sudo tee /usr/share/icons/default/index.theme

mkdir ~/Projects

shopt -s globstar
shopt -s checkjobs
shopt -s extglob
shopt -s dotglob
