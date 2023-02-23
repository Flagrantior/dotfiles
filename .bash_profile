#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

#export WAYLAND_DISPLAY=wayland-0
export VISUAL=nvim
export EDITOR=nvim
export TERM=alacritty
export MOZ_WEBRENDER=1
export MOZ_ENABLE_WAYLAND=1
export XDG_CURRENT_DESKTOP=us
export PAGER=less
export MANPAGER=less
#export GDK_BACKEND=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export CLUTTER_BACKEND=wayland
export QT_QPA_PLATFORM=wayland
#export SDL_VIDEODRIVER=wayland
export ELM_DISPLAY=wl
export ECORE_EVAS_ENGINE=wayland_egl
#export QT_WAYLAND_FORCE_DPI=physical
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	#exec sway --my-next-gpu-wont-be-nvidia
	exec sway
fi

export PATH=~/.local/bin/:~/.cargo/bin:$PATH
