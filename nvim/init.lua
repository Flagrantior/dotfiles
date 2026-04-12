vim.loader.enable()

-- Leaders
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- Editor options
local opt = vim.opt
opt.mouse = "a"
opt.termguicolors = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.number = false
opt.relativenumber = false
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true
opt.expandtab = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.list = true
opt.listchars = { tab = "  ", trail = "_", precedes = "-", extends = "-" }
opt.conceallevel = 2
opt.swapfile = false
opt.foldenable = false

-- Statusline
opt.statusline = "%#StatusLine# %f %m %= %y %l:%c/%L "

-- Cursor behavior
vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		vim.opt.guicursor = "a:hor25-blinkon175"
	end,
})

-- PACKAGE MANAGER
vim.pack.add({
	-- UI & Aesthetics
	"https://github.com/rcarriga/nvim-notify",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/NvChad/nvim-colorizer.lua",
	"https://github.com/folke/which-key.nvim",

	-- Treesitter & Languages
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
	"https://github.com/windwp/nvim-ts-autotag",
	"https://github.com/OXY2DEV/markview.nvim",

	-- LSP & Autocomplete
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/saadparwaiz1/cmp_luasnip",
	"https://github.com/rafamadriz/friendly-snippets",

	-- Utils
	"https://github.com/numToStr/Comment.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/folke/flash.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mikavilpas/yazi.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/kndndrj/nvim-dbee",
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/epwalsh/obsidian.nvim",
})

-- PLUGIN CONFIGURATION

local function safe_config(plugin_name, module_name, callback)
	module_name = module_name or plugin_name
	pcall(vim.cmd, "packadd " .. plugin_name)
	local ok, mod = pcall(require, module_name)
	if ok then
		callback(mod)
	end
end

-- Treesitter Configuration
safe_config("nvim-treesitter", "nvim-treesitter.configs", function(ts)
	ts.setup({
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"markdown",
			"markdown_inline",
			"svelte",
			"javascript",
			"typescript",
			"html",
			"css",
			"scss",
		},
		highlight = { enable = true },
		indent = { enable = true },
	})
end)

-- Auto-close tags
safe_config("nvim-ts-autotag", nil, function(at)
	at.setup({})
end)

-- Force Treesitter attachment for Svelte
vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
	pattern = { "svelte", "html", "javascript", "css", "scss" },
	callback = function()
		local lang = vim.treesitter.language.get_lang(vim.bo.filetype) or vim.bo.filetype
		pcall(vim.treesitter.start, 0, lang)
	end,
})

-- LSP Keymaps (Modern way via LspAttach)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local k = vim.keymap.set
		local bopts = { buffer = bufnr, silent = true }
		k("n", "gd", vim.lsp.buf.definition, bopts)
		k("n", "gr", vim.lsp.buf.references, bopts)
		k("n", "K", vim.lsp.buf.hover, bopts)
		k("n", "<leader>rn", vim.lsp.buf.rename, bopts)
		k("n", "<leader>ca", vim.lsp.buf.code_action, bopts)
		k("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, bopts)
	end,
})

-- Markview
vim.g.markview_alpha = 0
safe_config("markview", nil, function(m)
	m.setup({ preview = { hybrid_mode = true } })
end)

-- LSP & Mason
safe_config("mason", nil, function(m)
	m.setup()
end)
safe_config("mason-lspconfig", nil, function(ml)
	local servers = { "svelte", "ts_ls", "html", "cssls", "eslint", "emmet_ls" }
	ml.setup({ ensure_installed = servers })
	for _, s in ipairs(servers) do
		vim.lsp.config(s, { install = true })
		vim.lsp.enable(s)
	end
end)

-- Completion & Snippets
safe_config("nvim-cmp", "cmp", function(cmp)
	local luasnip = require("luasnip")
	pcall(require("luasnip.loaders.from_vscode").lazy_load)

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({ ["<CR>"] = cmp.mapping.confirm({ select = true }) }),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
		}, {
			{ name = "buffer" },
			{ name = "path" },
		}),
	})
end)

-- Formatting
safe_config("conform.nvim", "conform", function(c)
	c.setup({
		formatters_by_ft = { svelte = { "prettier" }, lua = { "stylua" } },
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
	})
end)

-- Other Utilities
safe_config("yazi.nvim", "yazi", function(y)
	y.setup({})
end)
safe_config("gitsigns.nvim", "gitsigns", function(g)
	g.setup({})
end)
safe_config("Comment.nvim", "Comment", function(c)
	c.setup({ toggler = { line = "<C-/>" } })
end)
safe_config("nvim-autopairs", nil, function(a)
	a.setup({})
end)
safe_config("which-key.nvim", "which-key", function(wk)
	wk.setup({})
end)

-- Obsidian
safe_config("obsidian.nvim", "obsidian", function(obs)
	obs.setup({
		workspaces = { { name = "Kasten", path = "~/Kasten" } },
		ui = { enable = false },
	})
end)

-- DAP (Godot)
safe_config("nvim-dap", "dap", function(dap)
	dap.adapters.godot = { type = "server", host = "127.0.0.1", port = 6006 }
	dap.configurations.gdscript = {
		{
			type = "godot",
			request = "launch",
			name = "Launch scene",
			project = "${workspaceFolder}",
			launch_scene = true,
		},
	}
end)

-- KEYMAPS
local map = vim.keymap.set
local kopts = { silent = true }

-- Basic navigation & clipboard
map("i", "jj", "<Esc>", kopts)
map("v", "<C-y>", '"+y', kopts)
map("n", "<S-u>", ":redo<CR>", kopts)

-- Move lines
map("n", "<A-j>", ":m .+1<CR>==", kopts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", kopts)

map("n", "<A-Down>", ":m .+1<CR>==", kopts)
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", kopts)

map("n", "<A-Up>", ":m .-2<CR>==", kopts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", kopts)

map("n", "<A-k>", ":m .-2<CR>==", kopts)
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", kopts)

-- Diagnostics
map("n", "<leader>w", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "[w", vim.diagnostic.goto_prev, { desc = "Go to Previous Diagnostic" })
map("n", "]w", vim.diagnostic.goto_next, { desc = "Go to Next Diagnostic" })

-- Window navigation
map("n", "<C-Up>", ":wincmd k<CR>", kopts)
map("n", "<C-Down>", ":wincmd j<CR>", kopts)
map("n", "<C-Left>", ":wincmd h<CR>", kopts)
map("n", "<C-Right>", ":wincmd l<CR>", kopts)

-- Exits
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>Q", ":q!<CR>", { desc = "Quit without saving" })
map("n", "zz", ":q!<CR>")

-- Save
map("n", "<C-s>", ":update<CR>", kopts)
map("v", "<C-s>", "<C-C>:update<CR>", kopts)
map("i", "<C-s>", "<Esc>:update<CR>gi", kopts)

-- Tabs
map("n", "<S-t>", ":tabnew<CR>", kopts)
for i = 1, 9 do
	map("n", string.format("<A-%d>", i), string.format("%dgt", i), kopts)
	map("n", string.format("<A-C-%d>", i), string.format(":tabmove %d<CR>", i - 1), kopts)
end

-- Move lines
map("n", "<A-j>", ":m .+1<CR>==", kopts)
map("n", "<A-k>", ":m .-2<CR>==", kopts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", kopts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", kopts)

-- Yazi, Obsidian & Telescope
map("n", "<leader>y", "<cmd>Yazi<CR>", kopts)
map("n", "<S-Tab>", "<cmd>Yazi<CR>", kopts)
map("n", "<leader>oo", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Obsidian Quick Switch" })
map("n", "<C-k>", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Obsidian Quick Switch" })

local function get_git_root()
	local dotgit = vim.fn.finddir(".git", ".;")
	return dotgit ~= "" and vim.fn.fnamemodify(dotgit, ":h") or nil
end

safe_config("telescope.nvim", "telescope.builtin", function(builtin)
	map("n", "<leader><leader>", function()
		builtin.find_files({ cwd = get_git_root() })
	end)
	map("n", "<leader>/", function()
		builtin.live_grep({ cwd = get_git_root() })
	end)
	map("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
	map("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
	map("n", "<leader>fo", builtin.oldfiles, { desc = "Find Old Files" })
end)

-- HEX commands
vim.api.nvim_create_user_command("Hex", ":set bin | %!xxd", {})
vim.api.nvim_create_user_command("Hexr", ":%!xxd -r", {})

-- THEME
vim.cmd("syntax on")
local hl = vim.api.nvim_set_hl

-- Base palette
hl(0, "Normal", { fg = "#00ffff", bg = "none" })
hl(0, "StatusLine", { fg = "#00ffff", bg = "none" })
hl(0, "TabLine", { fg = "#008888", bg = "none" })
hl(0, "TabLineSel", { fg = "#00ffff", bg = "none", bold = true })
hl(0, "TabLineFill", { fg = "#00ffff", bg = "none" })

-- Pmenu
hl(0, "Pmenu", { fg = "#00ffff", bg = "#000000" })
hl(0, "PmenuSel", { fg = "#000000", bg = "#00ffff" })

-- Treesitter palette
hl(0, "@variable", { fg = "#00ffff" })
hl(0, "@variable.builtin", { fg = "#ff00ff" })
hl(0, "@field", { fg = "#00cccc" })
hl(0, "@property", { fg = "#00cccc" })
hl(0, "@function", { fg = "#ff00ff" })
hl(0, "@function.call", { fg = "#00ffff" })
hl(0, "@keyword", { fg = "#00ffff", bold = true })
hl(0, "@type", { fg = "#6666ff" })
hl(0, "@string", { fg = "#00cc99" })
hl(0, "@comment", { fg = "#557777", italic = true })
hl(0, "@tag", { fg = "#cc66ff" })
hl(0, "@tag.attribute", { fg = "#66ffff" })
hl(0, "@tag.delimiter", { fg = "#339999" })

-- Diagnostics
hl(0, "DiagnosticError", { fg = "#ff005f", bold = true })
hl(0, "DiagnosticWarn", { fg = "#ffaa00", bold = true })
hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff005f" })
hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#ffaa00" })
hl(0, "DiagnosticSignError", { fg = "#ff005f", bg = "none" })
hl(0, "DiagnosticSignWarn", { fg = "#ffaa00", bg = "none" })

-- Markview
hl(0, "MarkviewCode", { bg = "#000000" })
hl(0, "MarkviewCodeInfo", { fg = "#00ffff", bg = "#001a1a", italic = true })
hl(0, "MarkviewInlineCode", { fg = "#00ffff", bg = "#001a1a" })

for i = 1, 6 do
	hl(0, "MarkviewHeading" .. i, { bg = "none" })
	hl(0, "MarkviewHeading" .. i .. "Sign", { bg = "none" })
end

hl(0, "MarkviewBlockQuote", { bg = "none" })
hl(0, "MarkviewTableBorder", { bg = "none" })
hl(0, "MarkviewTableHeader", { bg = "none" })
hl(0, "MarkviewHorizontalRule", { bg = "none" })
