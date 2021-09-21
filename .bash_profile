#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export VISUAL=nvim
export EDITOR=nvim
export TERM=alacritty
export MOZ_WEBRENDER=1
export XDG_CURRENT_DESKTOP=us
export PAGER=less
export MANPAGER=less
export QT_QPA_PLATFORM=wayland
export _JAVA_AWT_WM_NONREPARENTING=1

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec sway --my-next-gpu-wont-be-nvidia
fi

