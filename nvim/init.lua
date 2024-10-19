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

require("lazy").setup({
	{ "folke/neodev.nvim" },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "neovim/nvim-lspconfig" },
	{ "ap/vim-css-color" },
	{ "hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
		},
	},
	{ "numToStr/Comment.nvim", lazy = false },
	--[[ { "nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	config = function()
		require("nvim-tree").setup {}
	end,
	}, ]]
	{ 'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
	},
	{ "lewis6991/gitsigns.nvim" },
	{ "windwp/nvim-ts-autotag" },
	{ "phaazon/hop.nvim",
		branch = "v2",
		config = function()
		require"hop".setup { keys = "fqwerasdmnkj123vg4tcxz" }
		end
	},
	{ "https://github.com/aca/emmet-ls" }, --- ???
	{ "williamboman/mason.nvim" }, --- ???
	{ "hrsh7th/vim-vsnip" }, --- ???
	{ "hrsh7th/vim-vsnip-integ" }, --- ???
	--[[ { "renerocksai/telekasten.nvim",
		dependencies = { "renerocksai/calendar-vim"	}
	}, ]]
	{ "nvim-telescope/telescope.nvim",
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
	},
	{ "slint-ui/vim-slint" },
	-- { "Exafunction/codeium.vim", event = 'BufEnter' },
	{ "sbdchd/neoformat" },
	{ "mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{ "<C-Tab>", "<cmd>Yazi<cr>" },
		},
		---@type YaziConfig
		opts = {
		-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			keymaps = {
				show_help = '<f1>',
			},
		},
	},
	{ 'epwalsh/obsidian.nvim',
		version = "*",  -- recommended, use latest release instead of latest commit
		lazy = false,
		ft = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
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
	{ 'meanderingprogrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.userconfig
    opts = {
			code = {
				highlight = '',
			},
			pipe_table = {
				 filler = '',
			}
		},
	},
})


-- vim.g.codeium_enabled = false

-- map
vim.keymap.set('n', '<m-1>', '1gt')
vim.keymap.set('n', '<m-2>', '2gt')
vim.keymap.set('n', '<m-3>', '3gt')
vim.keymap.set('n', '<m-4>', '4gt')
vim.keymap.set('n', '<m-5>', '5gt')
vim.keymap.set('n', '<m-6>', '6gt')
vim.keymap.set('n', '<m-7>', '7gt')
vim.keymap.set('n', '<m-8>', '8gt')
vim.keymap.set('n', '<m-9>', '9gt')
vim.keymap.set('n', 'zz', ':q!<cr>')
vim.keymap.set('i', 'jj', '<esc>')
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', 'kj', '<esc>')
-- vim.keymap.set({'n', 'x', 'v'}, ' ', '<cmd>HopChar1<CR>', { silent = true })
vim.keymap.set({'n', 'x'}, ' ', '<cmd>HopChar1<CR>', { silent = true })
vim.keymap.set('n', ';', ':')
vim.keymap.set('', '<C-t>', ':tabnew<CR>')
vim.keymap.set('n', '<S-u>' , ':redo<CR>')
vim.keymap.set('n', '<C-k>', ':ObsidianQuickSwitch<CR>')
vim.api.nvim_create_user_command('Hex', ':set bin | %!xxd', {})
vim.api.nvim_create_user_command('Hexr', ':%!xxd -r', {})

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})


-- COLORS/SETS
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
	" hi CocInlayHint ctermfg=8
	" hi CocGitAddedSign ctermbg=none ctermfg=green
	" hi CocGitChangeRemovedSign ctermbg=none ctermfg=magenta
	" hi CocGitChangedSign ctermbg=none ctermfg=magenta
	" hi CocGitRemovedSign ctermbg=none ctermfg=red
	" hi CocGitTopRemovedSign ctermbg=none ctermfg=magenta
	" hi! link GitSignsAdd CocGitAddedSign
	" hi! link GitSignsChange CocGitChangedSign
	" hi! link GitSignsDelete CocGitRemovedSign

	set encoding=utf-8
	set noswapfile
	set scrolloff=7
	set autoindent
	set wrap nowrap
	" set fileformat=unix
	set expandtab tabstop=2 shiftwidth=2 softtabstop=2
	set mouse=a
	set gdefault
	set guifont=Source\ Code\ Pro\ for\ Powerline:h15:cANSI
	set hlsearch
	set ignorecase
	set incsearch
	set list listchars=tab:\ \ ,trail:_,precedes:-,extends:-
	set noexpandtab		
	set smartcase
	set statusline=		
	set statusline+=%#StatusLine#
	set statusline+=%f\ 
	set statusline+=%m\ 
	set statusline+=%=%r%=
	set statusline+=\ %y
	set statusline+=\ %l:%c/%L
	set fillchars+=vert:\ 
	set nofoldenable
	set foldlevel=99
	set cmdheight=0
	au BufNewFile,BufRead *.md set conceallevel=2

	let g:vim_markdown_edit_url_in = 'tab'

	nmap <silent> <A-k> :wincmd k<CR>
	nmap <silent> <A-j> :wincmd j<CR>
	nmap <silent> <A-h> :wincmd h<CR>
	nmap <silent> <A-l> :wincmd l<CR>
	nmap <silent> <A-Up> :wincmd k<CR>
	nmap <silent> <A-Down> :wincmd j<CR>
	nmap <silent> <A-Left> :wincmd h<CR>
	nmap <silent> <A-Right> :wincmd l<CR>

	nnoremap <A-j> :m .+1<CR>==
	nnoremap <A-k> :m .-2<CR>==
	inoremap <A-j> <Esc>:m .+1<CR>==gi
	inoremap <A-k> <Esc>:m .-2<CR>==gi
	vnoremap <A-j> :m '>+1<CR>gv=gv
	vnoremap <A-k> :m '<-2<CR>gv=gv

	" noremap <C-Tab>		 :NvimTreeToggle<CR>
	" vnoremap <C-Tab>		<C-C>:NvimTreeToggle<CR>
	" inoremap <C-Tab>		<Esc>:NvimTreeToggle<CR>gi

	noremap <C-S>			 :update<CR>
	vnoremap <C-S>			<C-C>:update<CR>
	inoremap <C-S>			<Esc>:update<CR>gi
]])
	-- set statusline+=%{get(b:,'gitsigns_status','')}


-- restore cursor
vim.api.nvim_create_autocmd('VimLeave', {
	callback = function()
		vim.opt.guicursor = 'a:hor25-blinkon175'
	end,
})

-- COMMENT
	require('Comment').setup({
		toggler = { line = '<C-/>' },
		opleader = { block = '<C-/>' },
	})
-- LSP
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
	local lspconfig = require('lspconfig')
	lspconfig.ts_ls.setup {}
	lspconfig.eslint.setup {}
	lspconfig.pyright.setup {}
	lspconfig.html.setup {}
	lspconfig.cssls.setup {
			capabilities = capabilities
	}
	local configs = require('lspconfig/configs')
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	lspconfig.emmet_ls.setup({ --- ???
		-- on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
		init_options = {
			html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
			},
		}
	})
	lspconfig.golangci_lint_ls.setup {}
	lspconfig.rust_analyzer.setup {
		settings = {
			['rust-analyzer'] = {
				diagnostics = {
			enable = true,
			experimental = {
					enable = true,
			},
				},
			},
		},
	}
	lspconfig.bashls.setup {}

	-- Global mappings.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	vim.keymap.set('n', '<leader>lD', vim.diagnostic.open_float)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
	vim.keymap.set('n', '<leader>ld', vim.diagnostic.setloclist)

	vim.o.updatetime = 250
	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
		callback = function ()
		vim.diagnostic.open_float(nil, {focus=false})
		end
})

	-- Use LspAttach autocommand to only map the following keys
	-- after the language server attaches to the current buffer
	vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		local opts = {buffer = ev.buf}
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		-- vim.keymap
		--		 .set('n', '<Leader>sa', vim.lsp.buf.add_workspace_folder, opts)
		-- vim.keymap.set('n', '<Leader>sr', vim.lsp.buf.remove_workspace_folder,
		--				        opts)
		-- vim.keymap.set('n', '<Leader>sl', function()
		--		 print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- end, opts)
		-- vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename, opts)
		vim.keymap.set({'n', 'v'}, '<Leader>la', vim.lsp.buf.code_action, opts)
		-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<Leader>lf',
						 function() vim.lsp.buf.format {async = true} end, opts)
			end
	})


-- CMP
	local cmp = require'cmp'

	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
				-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},
		window = {
			-- completion = cmp.config.window.bordered(),
			-- documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			-- { name = 'vsnip' }, -- For vsnip users. ?
			{ name = 'luasnip' }, -- For luasnip users.
			-- { name = 'ultisnips' }, -- For ultisnips users.
			-- { name = 'snippy' }, -- For snippy users.
		}, {
			{ name = 'buffer' },
		})
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources({
			{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
		}, {
			{ name = 'buffer' },
		})
	})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{ name = 'cmdline' }
		})
	})

	-- Set up lspconfig.
	local capabilities = require('cmp_nvim_lsp').default_capabilities()
	-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
	require('lspconfig')['ts_ls'].setup {
		capabilities = capabilities
	}

-- LUALINE
--[[ local flagline = require'lualine.themes.16color'

flagline.normal.a.bg = '#000000'
flagline.normal.a.fg = '#00ffff'
flagline.normal.b.bg = '#000000'
flagline.normal.b.fg = '#00ffff'
flagline.normal.c.bg = '#000000'
flagline.normal.c.fg = '#00ffff'

flagline.insert.a.bg = '#000000'
flagline.insert.a.fg = '#00ff00'

flagline.visual.a.fg = '#000000'
flagline.visual.a.bg = '#ff00ff'

require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = flagline,
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
	-- lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_x = {'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
} ]]


-- GITSIGNS
require('gitsigns').setup()

-- AUTOTAG
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "markdown", "markdown_inline", "javascript", "python", "rust" },
	highlight = {
			enable = true,
			additional_vim_regex_highlighting = {"markdown"},
	},
}
require('nvim-ts-autotag').setup()

-- KASTEN
--[[ require('telekasten').setup({
	home = vim.fn.expand("~/Kasten"), -- Put the name of your notes directory here
}) ]]
