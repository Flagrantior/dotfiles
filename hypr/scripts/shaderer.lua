return function(mode)
	mode = tonumber(mode) or 0
	local shader_path = "~/.config/hypr/shaders/"

	local configs = {
		[1] = { scale = 1.5, shader = shader_path .. "crt.frag" },
		[2] = { scale = 1.0, shader = shader_path .. "redlight.frag" },
		[3] = { scale = 1.5, shader = shader_path .. "crt_redlight.frag" },
	}

	local current = configs[mode] or { scale = 1.0, shader = "" }

	hl.monitor({
		output = "",
		mode = "preferred",
		position = "auto",
		scale = current.scale,
	})

	hl.config({
		decoration = {
			screen_shader = current.shader,
		},
	})
end
