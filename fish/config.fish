if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_prompt; end
function fish_greeting; end

function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color --bold blue
      echo '>'
    case insert
      set_color --bold magenta
      echo '>'
    case replace_one
      set_color --bold green
      echo '>'
    case visual
      set_color --bold yellow
      echo '>'
    case '*'
      set_color --bold red
      echo '?'
  end
  set_color normal
end

function zz
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

function che
  cheat-sh $argv[1]
  tldr $argv[1]
end

set fish_color_command 00ffff
set fish_color_error 00dddd
set -g fish_key_bindings fish_vi_key_bindings
set fish_cursor_insert underscore blink
set fish_color_param 00dddd

_ZO_ECHO=1 zoxide init fish | source
fzf_configure_bindings --directory=\cf

alias pingg='ping 8.8.8.8'
alias wttr='curl v2d.wttr.in/Spb --silent --max-time 3'
alias wttr1='curl wttr.in/Spb\?1Fq --silent --max-time 3'
alias wttr2='curl wttr.in/Spb\?2Fq --silent --max-time 3'
alias wttr3='curl wttr.in/Spb\?3Fq --silent --max-time 3'
alias myip='curl https://api.db-ip.com/v2/free/self'
alias prox+='export {HTTP,HTTPS}_PROXY=socks5://localhost:20170; export {http,https}_proxy=socks5://localhost:20170'
alias prox-='set -e {HTTP,HTTPS}_PROXY; set -e {http,https}_proxy'
alias js='deno'
alias pyserv='python -m http.server'
alias py='python'
alias off='loginctl poweroff'
alias rb='loginctl reboot'
alias mpv='mpv --audio-display=no'
alias mpva='mpv --no-video --shuffle --loop-playlist'
alias mpva1='mpv --no-video --shuffle --directory-mode=ignore --loop-playlist --loop=inf'
alias mpvv='mpv --no-video --force-window'
alias mpv_negate='mpv --vf=negate --hue=100'
alias mpv_termpixel='mpv --vo=tct --really-quiet'
alias mpv_termsixel='mpv --vo=sixel --really-quiet'
alias trans='trans -t ru'
alias transi='trans -t ru -I -b'
alias ytm='yt-dlp --extract-audio --audio-format mp3 -P "~/Music/"'
alias yt='cd ~/Videos/yt && yt-dlp --'
alias nvim='nvim -p'
