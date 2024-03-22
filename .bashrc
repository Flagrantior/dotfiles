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
alias wttr='curl v2d.wttr.in/Spb --silent --max-time 3'
alias wttr1='curl wttr.in/Spb?1Fq --silent --max-time 3'
alias wttr2='curl wttr.in/Spb?2Fq --silent --max-time 3'
alias wttr3='curl wttr.in/Spb?3Fq --silent --max-time 3'
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
alias feh='feh -B black -Z --recursive --force-aliasing -.'
alias trm='transmission-remote'
alias mpva='mpv --no-video --shuffle'
alias mpvv='mpv --no-video --force-window'
alias mpvn='mpv --vf=negate --hue=100'
alias mpv='mpv --audio-display=no'
alias mpvt='mpv --vo=tct --really-quiet'
alias mpvs='mpv --vo=sixel --really-quiet'
alias gpgimport='gpg --keyserver keyserver.ubuntu.com --receive-keys'
alias rscp='rsync -aP --'
alias rsmv='rsync -aP --remove-source-files --'
alias myip='curl https://api.db-ip.com/v2/free/self'
alias rustrepl='evcxr'
alias ranger='TERM=alacritty ranger'
alias js='deno'
alias twt='taskwarrior-tui'
alias trans='trans -t ru'
alias transi='trans -t ru -I -b'
alias vpn1='sudo -E protonvpn c -f'
alias vpn0='sudo -E protonvpn d'
alias ncdu='sudo -E ncdu --color off'
alias ytm='yt-dlp --extract-audio --audio-format mp3 -P "~/Music/"'
alias yt='cd ~/Videos/yt && yt-dlp -f 22 --'
alias ytfzf='ytfzf -f'
alias ports='sudo netstat -tulpn | rg LISTEN'
alias haskellrepl='ghci'
alias chmox='chmod +x'
alias drag='ripdrag'
alias typespeed='thokr'
alias surf='GDK_BACKEND=x11 surf'
alias wr='sudo ip link set wlan0 down ; sudo ip link set wlan0 up'
alias ns='export {http,https,ftp}_proxy="http://192.168.49.1:8282"'
alias prox+='export {HTTP,HTTPS}_PROXY=socks5://localhost:1080; export {http,https}_proxy=socks5://localhost:1080'
alias prox-='unset {HTTP,HTTPS}_PROXY; unset {http,https}_proxy'

#shopt -s globstar

reset-cursor() {
	printf '\[\033[3 q\]'
}
export PS1="$(reset-cursor)$PS1"
export PATH=~/.local/bin/:~/.cargo/bin/:$PATH

function cdc {
  cd "$(llama "$@")"
}

eval "$(zoxide init bash)"

#source ~/.config/broot/launcher/bash/br
#eval "$(thefuck --alias)"
