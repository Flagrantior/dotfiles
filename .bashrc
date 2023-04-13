# ~/.bashrc

[[ $- != *i* ]] && return
PS1='\[\033[1;35m\]>\[\033[0m\]'
source /usr/share/autojump/autojump.bash
#alias pacman='sudo pacman --color always'
#alias factorio='~/Games/Factorio/run.sh'
#alias hiber='systemctl hibernate'
#alias susp='systemctl suspend'
#alias sway='--my-next-gpu-wont-be-nvidia'
#alias instaloader='instaloader --no-metadata-json --no-captions'
#alias teamviewer='QT_QPA_PLATFORM=xcb teamviewer'
#alias tor1='sudo systemctl start tor-router.service'
#alias tor0='sudo systemctl stop tor-router.service'
#alias sctl='sudo systemctl'
alias pingg='ping google.com'
alias wifi='nmcli d w r; nmcli d w'
alias yay='yay --color always'
alias ls='ls --color=auto'
alias pyserv='python -m http.server'
alias py='python'
alias che='cheat-sh'
alias wttr='curl wttr.in/Spb?0Fq --silent --max-time 3'
alias wttr1='curl wttr.in/Spb?1Fq --silent --max-time 3'
alias wttr2='curl wttr.in/Spb?2Fq --silent --max-time 3'
alias wttr3='curl wttr.in/Spb?3Fq --silent --max-time 3'
alias ableton='wine64 ~/.wine/drive_c/ProgramData/Ableton/Live\ 10\ Suite/Program/Ableton\ Live\ 10\ Suite.exe'
alias grep='rg'
alias ls='exa -a'
alias ll='exa -la'
alias off='loginctl poweroff'
alias rb='loginctl reboot'
alias reboot='loginctl reboot'
alias wfup='sudo ip link set wlp3s0 up'
alias wfdown='sudo ip link set wlp3s0 down'
alias wfon='sudo ip link set wlp3s0 up'
alias wfoff='sudo ip link set wlp3s0 down'
alias vim='nvim'
alias fzf='fzf --color=16,hl:#ffffff,fg+:#ff00ff,hl+:#ffffff,prompt:#00ffff,pointer:#ffff00,spinner:#ff00ff,info:#ff0000 -m'
alias btr='watch -n0.5 acpi'
alias netctl='sudo netctl'
alias nmr='nmcli n of && nmcli n on && nmcli d w r'
alias feh='feh -B black -Z --recursive -.'
alias trm='transmission-remote'
alias mpvd='mpv --vf=negate --hue=100'
alias mpv='mpv --audio-display=no'
alias gpgimport='gpg --keyserver keyserver.ubuntu.com --receive-keys '
alias rscp='rsync -aP --'
alias rsmv='rsync -aP --remove-source-files --'
alias myip='curl https://api.db-ip.com/v2/free/self'
alias rustrepl='evcxr'
alias ranger='TERM=alacritty ranger'
alias ns='export {http,https,ftp}_proxy="http://192.168.49.1:8282"'
alias inst='cd ~/Pictures/INST/ && instaloader --no-captions --no-metadata-json --no-compress-json --no-profile-pic --no-video-thumbnails --login flagrantior'
alias js='deno'
alias twt='taskwarrior-tui'
alias trans='trans -t ru'
alias vpn1='sudo -E protonvpn c -f'
alias vpn0='sudo -E protonvpn d'
alias ncdu='sudo -E ncdu --color off'
alias yt-mp3='yt-dlp --extract-audio --audio-format mp3'
alias yt='cd ~/Videos/youtube && yt-dlp -f 22 --'
alias ports='sudo netstat -tulpn | rg LISTEN'
alias haskellrepl='ghci'
alias chmox='chmod +x'

#shopt -s globstar

reset-cursor() {
	printf '\[\033[3 q\]'
}
export PS1="$(reset-cursor)$PS1"
export PATH=~/.local/bin/:~/.cargo/bin/:$PATH

function cdc {
  cd "$(llama "$@")"
}

#source /home/flagrantior/.config/broot/launcher/bash/br
#eval "$(thefuck --alias)"
