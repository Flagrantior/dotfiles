#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export VISUAL=nvim
export EDITOR=nvim
export TERM=alacritty
export MOZ_WEBRENDER=1
export MOZ_ENABLE_WAYLAND=1

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	export XDG_CURRENT_DESKTOP=us
	export QT_QPA_PLATFORM=wayland
	export _JAVA_AWT_WM_NONREPARENTING=1
	exec sway --my-next-gpu-wont-be-nvidia
fi


source /home/flagrantior/.config/broot/launcher/bash/br
