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
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers

-- Tabs and indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Appearance
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", precedes = "‹", extends = "›" }
vim.opt.conceallevel = 2
vim.opt.termguicolors = true -- Enable true colors

-- Buffer behavior
vim.opt.swapfile = false
vim.opt.foldenable = false

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
keymap("n", ";", ":", { silent = false })
keymap("n", "<S-u>", ":redo<CR>", opts)

-- Move lines
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Window navigation
keymap("n", "<C-Up>", ":wincmd k<CR>", opts)
keymap("n", "<C-Down>", ":wincmd j<CR>", opts)
keymap("n", "<C-Left>", ":wincmd h<CR>", opts)
keymap("n", "<C-Right>", ":wincmd l<CR>", opts)

-- Save
keymap({ "i", "v", "n" }, "<C-s>", ":update<CR>", opts)

-- HEX
vim.api.nvim_create_user_command("Hex", ":set bin | %!xxd", {})
vim.api.nvim_create_user_command("Hexr", ":%!xxd -r", {})

-- =============================================================================
-- 4. PLUGINS
-- =============================================================================
require("lazy").setup({
	-- ================== UI & THEME ================== --
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		opts = {
			style = "night",
			transparent = true,
			colors = {
				neon_cyan = "#00ffff",
				neon_magenta = "#ff00ff",
			},
			on_highlights = function(hl, c)
				-- Main text and variables
				hl.Normal = { fg = c.neon_cyan }
				hl.Variable = { fg = c.neon_cyan }
				hl.Identifier = { fg = c.neon_cyan }

				-- Accents
				hl.Function = { fg = c.neon_magenta, bold = true }
				hl.Statement = { fg = c.neon_magenta }
				hl.Type = { fg = c.neon_magenta }
				hl.Constant = { fg = c.neon_magenta }
				hl.String = { fg = c.green } -- Keep some variety
				hl.Number = { fg = c.orange } -- Keep some variety

				-- UI
				hl.Visual = { bg = "#440044" } -- Dark magenta for selection
				hl.Comment = { fg = "#808080", italic = true } -- Grey out comments
				hl.LineNr = { fg = "#808080" }
			end,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight")

			-- Make tabs less bright
			vim.api.nvim_set_hl(0, "TabLine", { fg = "#666666", bg = "#1a1a1a" })
			vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#cccccc", bg = "#333333", bold = true })
			vim.api.nvim_set_hl(0, "TabLineFill", { fg = "#666666", bg = "#1a1a1a" })
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "tokyonight",
					icons_enabled = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				tabline = {
					lualine_a = { { "tabs", padding = { left = 0, right = 0 } } },
				},
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	-- ================== CORE ================== --
	{ "nvim-lua/plenary.nvim" },
	{ "folke/neodev.nvim", opts = {} },
	{ "slint-ui/vim-slint" }, -- For Slint UI framework, remove if not used

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
			vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to Previous Diagnostic" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to Next Diagnostic" })
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
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
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
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			keymap("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			keymap("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
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
		opts = {},
	},
})
