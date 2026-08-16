---@module 'hl'

-- VARS

local home = os.getenv("HOME")
local config_home = os.getenv("XDG_CONFIG_HOME") or (home .. "/.config")
local hypr_config = config_home .. "/hypr"
local wallpaper = hypr_config .. "/wp.jpg"

local terminal = "hyprctl switchxkblayout all 0; foot"

local menu =
	'bash -c \'hyprctl switchxkblayout all 0; rofi -show run -lines 5 -width 20 -run-shell-command "foot bash -c \\"{cmd}; read -n 1 -s\\"" --run-command "hyprctl dispatch exec {cmd}"\''

local locker =
	'hyprctl switchxkblayout all 0; swaylock -c 000000 --font "Hurmit Nerd Font Mono" --line-color ff00ff --ring-color ff00ff -n --key-hl-color 00ffff -l --inside-ver-color 000000 --ring-ver-color 000000 --indicator-thickness 10 --ring-color 000000 --inside-wrong-color 000000 --ring-wrong-color ff0000 --bs-hl-color ff0000 --inside-clear-color 00000055 --ring-clear-color 00ffff -K'

local audio = {
	mute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
	down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-",
	up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+",
}

-- ENVIRONMENT

hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_THEME", "Dot-Flagrantior")

-- MONITORS

hl.monitor({
	output = "eDP-2",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

-- GENERAL

hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 0,
		border_size = 0,
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
		col = {
			active_border = "rgb(000000)",
			inactive_border = "rgb(000000)",
		},
	},
	decoration = {
		rounding = 2,
		active_opacity = 1.0,
		inactive_opacity = 0.95,
		fullscreen_opacity = 1.0,
		shadow = {
			enabled = true,
			color = "rgba(00000055)",
			offset = { 0, 2 },
			range = 25,
			render_power = 4,
		},
		blur = {
			enabled = true,
			size = 4,
			passes = 3,
			vibrancy = 0.1696,
			new_optimizations = true,
			ignore_opacity = true,
		},
	},
	cursor = {
		inactive_timeout = 5,
		zoom_rigid = true,
	},
	render = {
		direct_scanout = true,
	},
	dwindle = {
		preserve_split = true,
		force_split = 2,
		smart_split = false,
	},
	master = {
		new_status = "master",
	},
	misc = {
		disable_hyprland_logo = true,
		background_color = "0x000000",
		force_default_wallpaper = 0,
		animate_manual_resizes = true,
		font_family = "White Rabbit",
		middle_click_paste = true,
		always_follow_on_dnd = true,
	},
	input = {
		kb_layout = "us,ru",
		kb_options = "grp:alt_shift_toggle,caps:escape",
		follow_mouse = 1,
		numlock_by_default = true,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
			disable_while_typing = false,
			drag_lock = 0,
		},
	},
	gestures = {
		workspace_swipe_forever = true,
		workspace_swipe_cancel_ratio = 0.2,
		workspace_swipe_invert = false,
		workspace_swipe_direction_lock = false,
	},
	binds = {
		pass_mouse_when_bound = true,
		workspace_back_and_forth = true,
	},
})

-- DEVICES

hl.device({
	name = "hs6209-mi-wireless-receiver-mouse",
	sensitivity = -0.5,
})

-- ANIMATIONS

hl.config({ animations = { enabled = true } })

hl.animation({ leaf = "windows", enabled = true, speed = 1.5, bezier = "default", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "slide" })
hl.animation({ leaf = "fade", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, bezier = "default", style = "slide" })
hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 4, bezier = "default", style = "slidevert" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 8, bezier = "default", style = "slidevert" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 15, bezier = "default" })

-- GESTURES

hl.gesture({ fingers = 4, direction = "horizontal", scale = 1.5, action = "workspace" })
hl.gesture({ fingers = 3, direction = "pinch", action = "cursorZoom", zoom_level = 1.2, mode = "live" })

-- KEYBINDS

hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind("SUPER + T", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + E", hl.dsp.exit())
hl.bind("SUPER + SPACE", hl.dsp.window.float())
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + B", hl.dsp.exec_cmd("killall waybar || waybar"))
hl.bind("SUPER + D", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + W", hl.dsp.layout("togglesplit"))

-- AUDIO / BRIGHTNESS

hl.bind("XF86AudioMute", hl.dsp.exec_cmd(audio.mute), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(audio.down), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(audio.up), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("SUPER + M", hl.dsp.exec_cmd(audio.mute))

-- FOCUS

hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))

-- SWAP

hl.bind("SUPER + SHIFT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind("SUPER + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.swap({ direction = "down" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))

-- SEND SHORTCUTS

hl.bind("SUPER + CTRL + left", hl.dsp.send_shortcut({ mods = "", key = "Home", window = "activewindow" }))
hl.bind("SUPER + CTRL + right", hl.dsp.send_shortcut({ mods = "", key = "End", window = "activewindow" }))
hl.bind("SUPER + CTRL + up", hl.dsp.send_shortcut({ mods = "", key = "Page_Up", window = "activewindow" }))
hl.bind("SUPER + CTRL + down", hl.dsp.send_shortcut({ mods = "", key = "Page_Down", window = "activewindow" }))

-- WINDOW MOVE & RESIZE

hl.bind("SUPER + ALT + left", hl.dsp.window.move({ x = -100, y = 0, relative = true }))
hl.bind("SUPER + ALT + H", hl.dsp.window.move({ x = -100, y = 0, relative = true }))
hl.bind("SUPER + ALT + right", hl.dsp.window.move({ x = 100, y = 0, relative = true }))
hl.bind("SUPER + ALT + L", hl.dsp.window.move({ x = 100, y = 0, relative = true }))
hl.bind("SUPER + ALT + up", hl.dsp.window.move({ x = 0, y = -100, relative = true }))
hl.bind("SUPER + ALT + K", hl.dsp.window.move({ x = 0, y = -100, relative = true }))
hl.bind("SUPER + ALT + down", hl.dsp.window.move({ x = 0, y = 100, relative = true }))
hl.bind("SUPER + ALT + J", hl.dsp.window.move({ x = 0, y = 100, relative = true }))

hl.bind("SUPER + ALT + CTRL + left", hl.dsp.window.resize({ x = -200, y = 0, relative = true }))
hl.bind("SUPER + ALT + CTRL + H", hl.dsp.window.resize({ x = -200, y = 0, relative = true }))
hl.bind("SUPER + ALT + CTRL + right", hl.dsp.window.resize({ x = 200, y = 0, relative = true }))
hl.bind("SUPER + ALT + CTRL + L", hl.dsp.window.resize({ x = 200, y = 0, relative = true }))
hl.bind("SUPER + ALT + CTRL + down", hl.dsp.window.resize({ x = 0, y = -200, relative = true }))
hl.bind("SUPER + ALT + CTRL + J", hl.dsp.window.resize({ x = 0, y = -200, relative = true }))
hl.bind("SUPER + ALT + CTRL + up", hl.dsp.window.resize({ x = 0, y = 200, relative = true }))
hl.bind("SUPER + ALT + CTRL + K", hl.dsp.window.resize({ x = 0, y = 200, relative = true }))

hl.bind("SUPER + CTRL + S", hl.dsp.exec_cmd("hyprctl dispatch pin active"))
hl.bind("SUPER + CTRL + C", hl.dsp.exec_cmd("hyprctl dispatch centerwindow"))

-- WORKSPACES

for i = 1, 9 do
	hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }, { follow = false }))
end

hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }, { follow = false }))

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- SPECIAL WORKSPACE

hl.bind("SUPER + Tab", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + Tab", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind("ALT + Tab", hl.dsp.focus({ last = true }))

-- SCREENSHOTS

hl.bind("Print", hl.dsp.exec_cmd("grimblast copy output"))
hl.bind("SUPER + S", hl.dsp.exec_cmd("grimblast copy output"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("SLURP_ARGS='-B 000000cc -c 006666 -w 1' grimblast --freeze copy area"))

-- SYSTEM

hl.bind("SUPER + R", hl.dsp.exec_cmd(hypr_config .. "/scripts/screen_rotator"))
hl.bind("SUPER + SHIFT + D", hl.dsp.exec_cmd("yes | wf-recorder -f rec.mp4"))
hl.bind("SUPER + CTRL + D", hl.dsp.exec_cmd("killall --signal 2 wf-recorder"))
hl.bind("SUPER + C", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind("SUPER + I", hl.dsp.exec_cmd("hyprctl dispatch invertactivewindow"))
hl.bind("SUPER + O", hl.dsp.exec_cmd(hypr_config .. "/scripts/activeinfo"))
hl.bind("SUPER + G", hl.dsp.exec_cmd(hypr_config .. "/scripts/gamemode"))
--hl.bind("SUPER + F1", hl.dsp.exec_cmd(hypr_config .. "/scripts/shaderer"))
--hl.bind("SUPER + F2", hl.dsp.exec_cmd(hypr_config .. "/scripts/shaderer 1"))
--hl.bind("SUPER + F3", hl.dsp.exec_cmd(hypr_config .. "/scripts/shaderer 2"))
--hl.bind("SUPER + F4", hl.dsp.exec_cmd(hypr_config .. "/scripts/shaderer 3"))
hl.bind("SUPER + Z", hl.dsp.exec_cmd("hyprwhspr record toggle"))

-- LOCKSCREEN

hl.bind("SUPER + X", hl.dsp.exec_cmd(locker))
hl.bind("SUPER + SHIFT + F", hl.dsp.exec_cmd(locker .. " & sleep 0.5; loginctl hibernate"))

-- MOUSE

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- AUTOSTART

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("mako")
	hl.exec_cmd("fusuma")
	hl.exec_cmd("hyprpm reload")
	hl.exec_cmd("swaybg --mode fill --image '" .. wallpaper .. "'")
end)
