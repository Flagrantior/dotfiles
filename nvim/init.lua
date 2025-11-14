-- init.lua

-- =============================================================================
-- 1. LAZY.NVIM BOOTSTRAP
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- 2. CORE NEOVIM SETTINGS
-- =============================================================================
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- Disable standard plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Editor settings
vim.opt.encoding = "utf-8"
vim.opt.scrolloff = 8 -- Increased for better centering
vim.opt.mouse = "a"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true
vim.opt.cmdheight = 1 -- A bit more space for messages
vim.opt.signcolumn = "yes" -- Always show the sign column
vim.opt.number = false -- Show line numbers
vim.opt.relativenumber = false -- Show relative line numbers

-- Tabs and indentation
vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Appearance
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "_", precedes = "-", extends = "-" }
vim.opt.conceallevel = 2
vim.opt.termguicolors = true -- Enable true colors

-- Buffer behavior
vim.opt.swapfile = false
vim.opt.foldenable = false

-- Status Line
vim.opt.statusline = table.concat({
	"%#StatusLine#",
	"%f ", -- имя файла
	"%m ", -- модификатор [+] если изменён
	"%=%r%=", -- разделители / readonly
	" %y", -- тип файла
	" %l:%c/%L", -- позиция курсора
})

-- Restore cursor on exit
vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		vim.opt.guicursor = "a:hor25-blinkon175"
	end,
})

-- =============================================================================
-- 3. KEYMAPS
-- =============================================================================
local keymap = vim.keymap.set
local opts = { silent = true }

-- Modes: n - normal, i - insert, v - visual, x - visual block, o - operator pending
-- Copy to system clipboard
keymap("v", "<C-y>", '"+y', { silent = true })

-- Fast tab switching
for i = 1, 9 do
	keymap("n", string.format("<A-%d>", i), string.format("%dgt", i), opts)
	keymap("n", string.format("<A-C-%d>", i), string.format(":tabmove %d<CR>", i - 1), opts)
end

-- Convenient exits and navigation
keymap("i", "jj", "<Esc>", opts)
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>Q", ":q!<CR>", { desc = "Quit without saving" })
keymap("n", "<S-u>", ":redo<CR>", opts)
keymap("n", "zz", ":q!<CR>")

-- Move lines
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-Down>", ":m .+1<CR>==", opts)

keymap("n", "<A-Up>", ":m .-2<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)

keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)

-- Window navigation
keymap("n", "<C-Up>", ":wincmd k<CR>", opts)
keymap("n", "<C-Down>", ":wincmd j<CR>", opts)
keymap("n", "<C-Left>", ":wincmd h<CR>", opts)
keymap("n", "<C-Right>", ":wincmd l<CR>", opts)

keymap("n", "<C-Right>", ":wincmd l<CR>", opts)

-- Save
keymap({ "n" }, "<C-s>", ":update<CR>", opts)
keymap({ "v" }, "<C-s>", "<C-C>:update<CR>", opts)
keymap({ "i" }, "<C-s>", "<Esc>:update<CR>gi", opts)

-- HEX
vim.api.nvim_create_user_command("Hex", ":set bin | %!xxd", {})
vim.api.nvim_create_user_command("Hexr", ":%!xxd -r", {})

-- THEME
vim.api.nvim_set_hl(0, "Normal", { fg = "#00ffff", bg = "none" })
vim.api.nvim_set_hl(0, "TabLine", { fg = "#008888", bg = "none" })
vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#00ffff", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "TabLineFill", { fg = "#00ffff", bg = "none" })
vim.api.nvim_set_hl(0, "StatusLine", { fg = "#00ffff", bg = "none" })

vim.api.nvim_set_hl(0, "Pmenu", { fg = "#00ffff", bg = "#000000" })
--vim.api.nvim_set_hl(0, "PmenuThumb", { fg = "#ff0000" })
--vim.api.nvim_set_hl(0, "PmenuSbar", { fg = "#00ff00" })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = "#000000", bg = "#00ffff" })

vim.api.nvim_set_hl(0, "@variable", { fg = "#00ffff" })
vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#ff00ff" })
vim.api.nvim_set_hl(0, "@field", { fg = "#00cccc" })
vim.api.nvim_set_hl(0, "@property", { fg = "#00cccc" })

vim.api.nvim_set_hl(0, "@function", { fg = "#ff00ff" })
vim.api.nvim_set_hl(0, "@function.call", { fg = "#00ffff" })
vim.api.nvim_set_hl(0, "@keyword", { fg = "#00ffff", bold = true })
vim.api.nvim_set_hl(0, "@type", { fg = "#6666ff" })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = "#5555dd" })
vim.api.nvim_set_hl(0, "@parameter", { fg = "#00ffaa" })
vim.api.nvim_set_hl(0, "@constant", { fg = "#cccc00" })

vim.api.nvim_set_hl(0, "@number", { fg = "#ff00bb" })
vim.api.nvim_set_hl(0, "@number.float", { fg = "#ff00aa" })
vim.api.nvim_set_hl(0, "@boolean", { fg = "#ff00aa", bold = true })
vim.api.nvim_set_hl(0, "@string", { fg = "#00cc99" })
vim.api.nvim_set_hl(0, "@string.escape", { fg = "#88ffcc" })

vim.api.nvim_set_hl(0, "@operator", { fg = "#88ffff" })
vim.api.nvim_set_hl(0, "@punctuation", { fg = "#66cccc" })

vim.api.nvim_set_hl(0, "@comment", { fg = "#557777", italic = true })

vim.api.nvim_set_hl(0, "@tag", { fg = "#cc66ff" })
vim.api.nvim_set_hl(0, "@tag.attribute", { fg = "#66ffff" })
vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = "#339999" })

-- Diagnostics
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff005f", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#ffaa00", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#00ffff" })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#8888ff" })
-- Подчёркивание { undercurl = true, sp = "#ff00ff" }
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { bg = "#550000" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { bg = "#555500" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { bg = "#005555" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { bg = "#005555" })
-- Знак слева (SignColumn)
vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#ff005f", bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#ffaa00", bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#00ffff", bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#8888ff", bg = "none" })
-- Виртуальный текст
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff005f", bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ffaa00", bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#00ffff", bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#8888ff", bg = "none" })

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#00aa00", bg = "none" })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#005500", bg = "none" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#aa0000", bg = "none" })

-- =============================================================================
-- 4. PLUGINS
-- =============================================================================
require("lazy").setup({
	-- ================== UI & THEME ================== --
	{ "rcarriga/nvim-notify" },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
	},

	-- ================== CORE ================== --
	{ "folke/neodev.nvim" },

	-- ================== TREESITTER ================== --
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"markdown",
					"markdown_inline",
					"javascript",
					"typescript",
					"svelte",
					"rust",
					"lua",
					"vim",
					"bash",
					"html",
					"css",
					"scss",
				},
				highlight = { enable = true },
				autotag = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{ "windwp/nvim-ts-autotag" },

	-- ================== LSP, DAP & AUTOCOMPLETION ================== --
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(client, bufnr)
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
				keymap("n", "K", vim.lsp.buf.hover, bufopts)
				keymap("n", "gi", vim.lsp.buf.implementation, bufopts)
				keymap("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
				keymap({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, bufopts)
				keymap("n", "<leader>lf", function()
					vim.lsp.buf.format({ async = true })
				end, bufopts)
			end

			local servers_to_install = {
				"bashls",
				"cssls",
				"denols",
				"eslint",
				"gopls",
				"html",
				"pyright",
				"rust_analyzer",
				"svelte",
				"emmet_ls",
				"ts_ls",
			}

			local servers_to_setup = {
				"bashls",
				"cssls",
				"eslint",
				"gopls",
				"html",
				"pyright",
				"rust_analyzer",
				"svelte",
				"emmet_ls",
				"ts_ls",
			}

			require("mason-lspconfig").setup({
				ensure_installed = servers_to_install,
			})

			for _, server_name in ipairs(servers_to_setup) do
				vim.lsp.config(server_name, {
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end

			-- Special setup for Deno LSP to activate only in Deno projects
			vim.lsp.config("denols", {
				on_attach = on_attach,
				capabilities = capabilities,
				root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
			})

			vim.lsp.config("gdscript", {
				on_attach = on_attach,
				capabilities = capabilities,
			})

			-- Diagnostics
			vim.keymap.set("n", "<leader>w", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
			vim.keymap.set("n", "[w", vim.diagnostic.goto_prev, { desc = "Go to Previous Diagnostic" })
			vim.keymap.set("n", "]w", vim.diagnostic.goto_next, { desc = "Go to Next Diagnostic" })
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			dap.adapters.godot = {
				type = "server",
				host = "127.0.0.1",
				port = 6006,
			}
			dap.configurations.gdscript = {
				{
					type = "godot",
					request = "launch",
					name = "Launch scene",
					project = "${workspaceFolder}",
					launch_scene = true,
				},
			}
		end,
	},

	-- ================== UTILITIES ================== --
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			toggler = { line = "<C-/>" },
			opleader = { block = "<C-/>" },
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true, -- показывать ли вообще знаки в колонке
				--word_diff = true,
			})
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		modes = {},
		opts = {
			modes = {
				char = {
					keys = {
						["t"] = false, -- вырубает "t"
						["T"] = false, -- вырубает "Shift+T"
					},
				},
			},
		},
		keys = {
			{
				" ",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
		},
	},
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				names = true,
				RGB = true,
				RRGGBB = true,
				RRGGBBAA = true,
				rgb_fn = true,
				hsl_fn = true,
				css = true,
				css_fn = true,
				tailwind = true,
			},
		},
		config = true,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			local function get_git_root()
				local dotgit = vim.fn.finddir(".git", ".;")
				return dotgit and vim.fn.fnamemodify(dotgit, ":h")
			end

			keymap("n", "<leader>ff", function()
				builtin.find_files({ cwd = get_git_root() })
			end, { desc = "Find Files (Git)" })
			keymap("n", "<leader>fg", function()
				builtin.live_grep({ cwd = get_git_root() })
			end, { desc = "Live Grep (Git)" })
			keymap("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
			keymap("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
			keymap("n", "<leader>fo", builtin.oldfiles, { desc = "Find Old Files" })
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				svelte = { "prettier" },
				rust = { "rustfmt" },
				bash = { "shfmt" },
				markdown = { "prettier" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},

	-- ================== FILE MANAGER ================== --
	{
		"mikavilpas/yazi.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		keys = {
			{ "<leader>y", "<cmd>Yazi<CR>", desc = "Open Yazi" },
			{ "<S-Tab>", "<cmd>Yazi<CR>" },
			{ "<S-t>", ":tabnew<CR><cmd>Yazi<CR>" },
			{ "<C-S-Tab>", ":tabnew<CR><cmd>Yazi<CR>" },
		},
	},

	-- ================== NOTES & MARKDOWN ================== --
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = false,
		ft = "markdown",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>oo", "<cmd>ObsidianQuickSwitch<CR>", desc = "Obsidian Quick Switch" },
			{ "<C-k>", "<cmd>ObsidianQuickSwitch<CR>", desc = "Obsidian Quick Switch" },
		},
		opts = {
			workspaces = {
				{
					name = "Kasten",
					path = "~/Kasten",
				},
			},
			ui = { enable = false },
		},
	},
	{
		"meanderingprogrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
		opts = {
			indent = {
				enabled = true,
				skip_heading = true,
				per_level = 4,
			},
			paragraph = {
				enabled = true,
				left_margin = 1,
			},
			heading = {
				icons = { "" },
				sign = false,
				backgrounds = { "FlagMarkdownHead" },
				width = "block",
				left_margin = 0,
				left_pad = 0,
				right_pad = 0,
				position = "inline",
			},
			code = {
				style = "normal",
				width = "block",
				sign = false,
				left_pad = 1,
				highlight = "FlagMarkdownCode",
				highlight_inline = "FlagMarkdownCodeInline",
				border = "thick",
			},
			pipe_table = {
				filler = "",
			},
			dash = {
				width = 20,
				highlight = "FlagMarkdownDash",
			},
			bullet = {
				left_pad = 1,
			},
			anti_conceal = {
				enabled = false,
			},
		},
	},
})
