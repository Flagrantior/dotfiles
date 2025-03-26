Status:children_remove(1, Status.LEFT)
Status:children_remove(3, Status.LEFT)
Status:children_remove(5, Status.RIGHT)
Status:children_add(
	function()
		local h = cx.active.current.hovered
		if h == nil or ya.target_family() ~= "unix" then
			return ui.Line {}
		end

		return ui.Line {
			" ",
			ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("cyan"),
			ui.Span(":"):fg("magenta"),
			ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("cyan"),
			" ",
		}
	end, 2000, Status.LEFT
)
Header:children_add(
	function()
		local h = cx.active.current.hovered
		if h == nil or ya.target_family() ~= "unix" then
			return ui.Line {}
		end
		return ui.Line({
			ui.Span(" " .. h.name:gsub("\r", "?", 1))
		})
	end, 2000, Header.LEFT
)
Status:children_add(
	function()
			return ui.Span(" ")
	end, 1000, Status.RIGHT
)


THEME.git = THEME.git or {}
THEME.git.added_sign    = "A"; THEME.git.added    = ui.Style():fg("green");
THEME.git.updated_sign  = "U"; THEME.git.updated  = ui.Style():fg("green");
THEME.git.modified_sign = "M"; THEME.git.modified = ui.Style():fg("yellow");
THEME.git.deleted_sign  = "X"; THEME.git.deleted  = ui.Style():fg("red");
THEME.git.untracked_sign = "?"
THEME.git.ignored_sign = "-"
require("git"):setup()

