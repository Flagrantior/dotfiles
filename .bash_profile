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
# export XDG_CURRENT_DESKTOP=us
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
export QT_QPA_PLATFORM="wayland;xcb"
export QT_QPA_PLATFORMTHEME="qt6ct"

# GPU optimization?
export MESA_GL_VERSION_OVERRIDE=4.5
export MESA_GLSL_VERSION_OVERRIDE=450
export MESA_LOADER_DRIVER_OVERRIDE=radeonsi
export RADV_DEBUG=llvm
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json


if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	#exec sway --my-next-gpu-wont-be-nvidia
	#exec sway
	exec Hyprland
fi

export PATH=~/.local/bin/:~/.cargo/bin:$PATH
export LD_LIBRARY_PATH=/home/flagrantior/.local/lib/arch-mojo:$LD_LIBRARY_PATH

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[ -f /home/flagrantior/.dart-cli-completion/bash-config.bash ] && . /home/flagrantior/.dart-cli-completion/bash-config.bash || true
## [/Completion]

