local target_monitor = "eDP-2"
local monitors = hl.get_monitors()

for _, mon in ipairs(monitors) do
	if mon.name == target_monitor then
		local new_transform = (mon.transform + 4 - 1) % 4

		hl.monitor({
			output = target_monitor,
			mode = "preferred",
			position = "auto",
			scale = 1,
			transform = new_transform,
		})
		break
	end
end
