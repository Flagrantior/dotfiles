# ~/.bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='\[\033[1;35m\]>\[\033[0m\]'
#source /usr/share/autojump/autojump.bash
alias pacman='sudo pacman --color always'
alias pingg='ping google.com | rg -oP "(?<=time=).*\ " --color=never'
alias wifi='sudo wifi-menu'
alias yay='yay --color always'
alias ls='ls --color=auto'
alias pyserv='python -m http.server'
alias py='python'
#alias factorio='~/Games/Factorio/run.sh'
alias mount='sudo mount'
alias umount='sudo umount'
alias pyserv='python -m http.server'
alias wttr='curl wttr.in/Spb?0 --silent --max-time 3'
alias gpgimport='gpg --keyserver keyserver.ubuntu.com --receive-keys '
alias wttr1='curl wttr.in/Spb?1 --silent --max-time 3'
alias wttr2='curl wttr.in/Spb?2 --silent --max-time 3'
alias wttr3='curl wttr.in/Spb?3 --silent --max-time 3'
alias ableton='wine64 ~/.wine/drive_c/ProgramData/Ableton/Live\ 10\ Suite/Program/Ableton\ Live\ 10\ Suite.exe'
alias grep='rg'
alias ls='exa -a'
alias ll='exa -la'
alias off='systemctl poweroff'
alias che='cheat-sh'
alias hiber='systemctl hibernate'
alias susp='systemctl suspend'
#alias sway='--my-next-gpu-wont-be-nvidia'
alias minecraft='mctlauncher'
alias prime='primusrun'
alias wioff='sudo ip link set wlp3s0 down'
alias widown='sudo ip link set wlp3s0 down'
alias wiup='sudo ip link set wlp3s0 up'
alias wion='sudo ip link set wlp3s0 up'
alias vim='nvim'
alias fzf='fzf --color=16,hl:#ffffff,fg+:#ff00ff,hl+:#ffffff,prompt:#00ffff,pointer:#ffff00,spinner:#ff00ff,info:#ff00ff -m'
alias btr='watch -n0.5 acpi'
alias sctl='sudo systemctl'
alias netctl='sudo netctl'
alias nmr='nmcli n of && sleep 1 && nmcli n on'
alias feh='feh -B black -Z -.'
alias trm='transmission-remote'
alias mpvd='mpv --vf=negate --hue=100'
alias tor1='sudo systemctl start tor-router.service'
alias tor0='sudo systemctl stop tor-router.service'
alias mic1='pactl set-source-mute alsa_input.pci-0000_00_14.2.analog-stereo false'
alias mic0='pactl set-source-mute alsa_input.pci-0000_00_14.2.analog-stereo true'
alias sudo='sudo -E'
reset-cursor() {
	printf '\[\033[3 q\]'
}
export PS1="$(reset-cursor)$PS1"

#source /home/flagrantior/.config/broot/launcher/bash/br
