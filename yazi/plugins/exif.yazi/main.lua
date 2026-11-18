local M = {}

-- Shown in this order; exiftool omits tags the file doesn't have
local TAGS = {
	"FileType",
	"FileDescription", "ProductName", "CompanyName", "FileVersion",

	"Make", "Model", "LensModel",
	"DateTimeOriginal", "CreateDate",
	"ExposureTime", "FNumber", "ISO", "FocalLength", "Orientation",
	"GPSPosition",

	"Title", "Artist", "Album", "Genre", "Year", "TrackNumber",

	"Duration", "ImageSize", "VideoFrameRate", "AvgBitrate",
	"AudioChannels", "AudioSampleRate", "AudioBitrate", "SampleRate", "Channels",
}

local function exif(path)
	local cmd = Command("exiftool"):arg({ "-q", "-q", "-s", "-charset", "filename=utf8" })
	for _, tag in ipairs(TAGS) do
		cmd:arg("-" .. tag)
	end

	local output, err = cmd:arg(path):output()
	if not output then
		return nil, err
	elseif not output.status.success then
		return nil, output.stderr
	end
	return output.stdout
end

local function rows(stdout)
	local found = {}
	for line in stdout:gmatch("[^\r\n]+") do
		local k, v = line:match("^(.-)%s*:%s*(.*)$")
		if k and v ~= "" and found[k] == nil then
			found[k] = v
		end
	end

	local rows = {}
	for _, tag in ipairs(TAGS) do
		if found[tag] then
			rows[#rows + 1] = { tag, found[tag] }
		end
	end
	return rows
end

local function cached(job)
	local cache = ya.file_cache(job)
	local cha = cache and fs.cha(cache)
	return cha and cha.len > 0 and cache or nil
end

-- Cover art for audio, written into yazi's preview cache
local function audio_cover(job)
	if cached(job) then
		return cached(job)
	end

	local cache = ya.file_cache(job)
	if not cache then
		return nil
	end

	local output = Command("exiftool")
		:arg({ "-q", "-q", "-b", "-CoverArt", tostring(job.file.path) })
		:output()
	if not output or #output.stdout == 0 then
		return nil
	end

	return fs.write(cache, output.stdout) and cache or nil
end

local function image_source(job)
	local mime = job.mime
	if mime:match("^audio/") then
		return audio_cover(job)
	elseif mime:match("^video/") then
		if not cached(job) then
			pcall(function() require("video"):preload(job) end)
		end
		return cached(job)
	elseif mime:match("^image/") then
		return cached(job) or Url(job.file.path)
	end
	return nil
end

function M:peek(job)
	local area = job.area
	local key = ui.Style():fg("magenta")
	local lines = {
		ui.Line({ ui.Span(job.file.name):style(ui.Style():bold()) }),
		ui.Line(""),
		ui.Line({ ui.Span("Type: "):style(key), job.mime }),
		ui.Line({ ui.Span("Size: "):style(key), ya.readable_size(job.file.cha.len) }),
		ui.Line({ ui.Span("Modified: "):style(key), os.date("%Y-%m-%d %H:%M", math.floor(job.file.cha.mtime)) }),
		ui.Line(""),
	}

	local stdout, err = exif(tostring(job.file.path))
	if not stdout then
		lines[#lines + 1] = ui.Line("exiftool: " .. tostring(err))
	else
		for _, kv in ipairs(rows(stdout)) do
			lines[#lines + 1] = ui.Line({ ui.Span(kv[1] .. ": "):style(key), kv[2] })
		end
	end

	-- Image on top, metadata below it
	local text_h = math.min(#lines + 1, math.max(1, math.floor(area.h * 0.55)))
	local top = 0

	local src = image_source(job)
	if src and area.h - text_h >= 4 then
		local rect = ui.Rect { x = area.x, y = area.y, w = area.w, h = area.h - text_h }
		local shown = ya.image_show(src, rect)
		if shown then
			top = shown.y + shown.h - area.y + 1
		end
	end

	local text_area = ui.Rect { x = area.x, y = area.y + top, w = area.w, h = math.max(1, area.h - top) }
	ya.preview_widget(job, ui.Text(lines):area(text_area):wrap(ui.Wrap.YES))
end

function M:seek() end

return M
