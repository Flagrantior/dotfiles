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
vim.g.mapleader = " " -- Set Leader key to space
vim.g.maplocalleader = " "

-- Disable standard plugins we don't need
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Editor settings
vim.opt.encoding = "utf-8"
vim.opt.scrolloff = 7
vim.opt.mouse = "a"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true -- Use /g flag for :s by default
vim.opt.cmdheight = 0 -- Hide the command line

-- Tabs and indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Appearance
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "_", precedes = "-", extends = "-" }
vim.opt.fillchars:append({ vert = " " })
vim.opt.conceallevel = 2
vim.opt.guifont = "Source Code Pro for Powerline:h15:cANSI"

-- Buffer behavior
vim.opt.swapfile = false
vim.opt.foldenable = false
vim.opt.foldlevel = 99

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
keymap("i", "jk", "<Esc>", opts)
keymap("i", "kj", "<Esc>", opts)
keymap("n", "zz", ":q!<CR>", opts)
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

-- Obsidian
keymap("n", "<C-k>", ":ObsidianQuickSwitch<CR>", opts)

-- HEX
vim.api.nvim_create_user_command("Hex", ":set bin | %!xxd", {})
vim.api.nvim_create_user_command("Hexr", ":%!xxd -r", {})

-- =============================================================================
-- 4. COLORSCHEME
-- =============================================================================
vim.cmd([[
  colorscheme vim
  set notermguicolors
  hi Comment ctermfg=darkred
  hi Visual ctermfg=none ctermbg=23
  hi TabLineFill ctermfg=none ctermbg=none cterm=none
  hi TabLine ctermfg=cyan ctermbg=none cterm=none
  hi TabLineSel ctermfg=cyan cterm=underline
  hi StatusLine ctermbg=none cterm=bold
  hi VertSplit cterm=none
  hi Pmenu ctermfg=13 ctermbg=black
  hi PmenuThumb ctermbg=23
  hi PmenuSbar ctermbg=black
  hi PmenuSel ctermfg=black ctermbg=cyan
  hi SignColumn ctermbg=none
  hi Folded ctermbg=17
  hi FoldColumn ctermbg=0
  hi MatchParen cterm=bold ctermbg=none ctermbg=darkmagenta
  hi FlagMarkdownHead ctermfg=darkyellow ctermbg=none
  hi FlagMarkdownDash ctermfg=53 ctermbg=none
  hi FlagMarkdownCode ctermbg=none
  hi FlagMarkdownCodeInline ctermbg=none ctermfg=magenta

  set statusline=
  set statusline+=%#StatusLine#
  set statusline+=%f\ 
  set statusline+=%m\ 
  set statusline+=%=%r%=
  set statusline+=\ %y
  set statusline+=\ %l:%c/%L
]])

-- =============================================================================
-- 5. PLUGINS
-- =============================================================================
require("lazy").setup({
	-- Core dependencies
	{ "nvim-lua/plenary.nvim" },
	{ "folke/neodev.nvim" },

	-- Colors
	{ "ap/vim-css-color" },
	{ "slint-ui/vim-slint" },

	-- Treesitter for syntax highlighting
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
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "markdown" },
				},
				autotag = {
					enable = true,
				},
			})
		end,
	},

	-- Auto-close tags
	{ "windwp/nvim-ts-autotag" },

	-- LSP, DAP and autocompletion
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
			-- Define common settings for all LSP servers
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

			-- List of servers for automatic installation and setup
			local servers = {
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

			require("mason-lspconfig").setup({
				ensure_installed = servers,
				handlers = {
					-- Use the new vim.lsp.config API, as mentioned in the warning
					function(server_name)
						vim.lsp.config(server_name, {
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,
				},
			})

			-- Separate setup for Godot, also using the new API
			vim.lsp.config("gdscript", {
				on_attach = on_attach,
				capabilities = capabilities,
			})

			-- Diagnostics (errors and warnings)
			vim.keymap.set("n", "<leader>lD", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.o.updatetime = 250
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false })
				end,
			})
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

	-- Utilities
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				toggler = { line = "<C-_>", block = "<S-C-_>" }, -- Use standard <C-/>
				opleader = { block = "<S-C-_>" },
			})
		end,
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
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup({ keys = "fqwerasdmnkj123vg4tcxz" })
			keymap({ "n", "x", "o" }, " ", "<cmd>HopChar1<CR>", { silent = true })
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			keymap("n", "ff", builtin.find_files, {})
			keymap("n", "fg", builtin.live_grep, {})
			keymap("n", "fb", builtin.buffers, {})
			keymap("n", "fh", builtin.help_tags, {})
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

	-- File manager
	{
		"mikavilpas/yazi.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		keys = {
			{ "<leader>y", "<cmd>Yazi<CR>", desc = "Open Yazi" },
		},
	},

	-- Notes and Markdown
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = false,
		ft = "markdown",
		dependencies = { "nvim-lua/plenary.nvim" },
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
			-- Settings for render-markdown
		},
	},
})

