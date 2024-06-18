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
  -- { "folke/neoconf.nvim", cmd = "Neoconf" },
  { "folke/neodev.nvim" },
  { "nvim-treesitter/nvim-treesitter" },
  { "neovim/nvim-lspconfig" },
  { "kelly-lin/ranger.nvim",
    config = function()
    require("ranger-nvim").setup({ replace_netrw = true })
    vim.api.nvim_set_keymap("n", "<C-o>", "", {
      noremap = true,
      callback = function()
        require("ranger-nvim").open()
      end,
    })
    end,
  },
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
  --[[ { "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true }
  }, ]]
  --[[ { "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 1, -- High priority is needed if you will use `autoremap()`
    config = function()
      require("langmapper").setup({})
    end,
  }, ]]
  --[[ { "nvim-neorg/neorg", -- ???
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      }
    end,
  }, ]]
  { "lewis6991/gitsigns.nvim" },
  { "windwp/nvim-ts-autotag" },
  { "phaazon/hop.nvim",
    branch = "v2",
    config = function()
	  require"hop".setup { keys = "fqwerasdzxcmnkj" }
      -- require"hop".setup { keys = "etovxqpdygfblzhckisuran123ETOVXQPDYGFBLZHCKISURAN" }
    end
  },
  { "https://github.com/aca/emmet-ls" }, --- ???
  { "williamboman/mason.nvim" }, --- ???
  { "hrsh7th/vim-vsnip" }, --- ???
  { "hrsh7th/vim-vsnip-integ" }, --- ???
  { "renerocksai/telekasten.nvim",
    dependencies = { "renerocksai/calendar-vim"	}
  },
  { "nvim-telescope/telescope.nvim",
	dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { "nvim-telescope/telescope-media-files.nvim" },
  { "Exafunction/codeium.vim", event = 'BufEnter' },
})


vim.g.codeium_enabled = false

-- MAP
vim.keymap.set('n', '<M-1>', '1gt')
vim.keymap.set('n', '<M-2>', '2gt')
vim.keymap.set('n', '<M-3>', '3gt')
vim.keymap.set('n', '<M-4>', '4gt')
vim.keymap.set('n', '<M-5>', '5gt')
vim.keymap.set('n', '<M-6>', '6gt')
vim.keymap.set('n', '<M-7>', '7gt')
vim.keymap.set('n', '<M-8>', '8gt')
vim.keymap.set('n', '<M-9>', '9gt')
vim.keymap.set('n', 'ZZ', ':q!<CR>')
vim.keymap.set('i', 'jk', '<esc>')
-- vim.keymap.set({'n', 'x', 'v'}, ' ', '<cmd>HopChar1<CR>', { silent = true })
vim.keymap.set({'n', 'x'}, ' ', '<cmd>HopChar1<CR>', { silent = true })
vim.keymap.set('n', ';', ':')
vim.keymap.set('', '<C-t>', ':tabnew<CR>')
vim.keymap.set('n', '<S-u>' , ':redo<CR>')
vim.keymap.set('n', '<C-k>', ':Telekasten<CR>')
vim.api.nvim_create_user_command('Hex', ':set bin | %!xxd', {})
vim.api.nvim_create_user_command('Hexr', ':%!xxd -r', {})


-- COLORS
-- vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg=0, bg=LightGrey })
vim.cmd([[
	colorscheme vim
	set notermguicolors
	hi Comment ctermfg=darkred
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
	hi CocInlayHint ctermfg=8
	hi CocGitAddedSign ctermbg=none ctermfg=green
	hi CocGitChangeRemovedSign ctermbg=none ctermfg=magenta
	hi CocGitChangedSign ctermbg=none ctermfg=magenta
	hi CocGitRemovedSign ctermbg=none ctermfg=red
	hi CocGitTopRemovedSign ctermbg=none ctermfg=magenta
	hi Folded ctermbg=17
	hi FoldColumn ctermbg=0
	hi MatchParen cterm=bold ctermbg=none ctermbg=darkmagenta
	hi! link GitSignsAdd CocGitAddedSign
	hi! link GitSignsChange CocGitChangedSign
	hi! link GitSignsDelete CocGitRemovedSign
]])



-- SETS
vim.cmd([[
	set encoding=utf-8
	set noswapfile
	set scrolloff=7
	set autoindent
	set fileformat=unix
	set expandtab tabstop=4 shiftwidth=4 softtabstop=4
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
	set fillchars+=vert:\|
	set nofoldenable
	set foldlevel=99
	set cmdheight=0
	au BufNewFile,BufRead *.md set conceallevel=2
	let g:vim_markdown_edit_url_in = 'tab'
]])
	-- set statusline+=%{get(b:,'gitsigns_status','')}

-- COMMENT
	require('Comment').setup({
	  toggler = { line = '<C-/>' },
	  opleader = { block = '<C-/>' },
	})
-- LSP
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
	local lspconfig = require('lspconfig')
	lspconfig.tsserver.setup {}
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
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		-- vim.keymap
		--     .set('n', '<Leader>sa', vim.lsp.buf.add_workspace_folder, opts)
		-- vim.keymap.set('n', '<Leader>sr', vim.lsp.buf.remove_workspace_folder,
		--                opts)
		-- vim.keymap.set('n', '<Leader>sl', function()
		--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
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
	      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
	      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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
	    { name = 'vsnip' }, -- For vsnip users.
	    -- { name = 'luasnip' }, -- For luasnip users.
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
	require('lspconfig')['tsserver'].setup {
	  capabilities = capabilities
	}

-- LUALINE
	--[[ require('lualine').setup {
	  options = {
	    icons_enabled = true,
	    theme = 'auto',
	    component_separators = { left = '', right = ''},
	    section_separators = { left = '', right = ''},
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
	    lualine_x = {'encoding', 'fileformat', 'filetype'},
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
	  winbar = {},  • Default color scheme has been updated to be "Nvim branded" and accessible.
    Use `:colorscheme vim` to revert to the old legacy color scheme.
	  inactive_winbar = {},
	  extensions = {}
	} ]]


-- GITSIGNS
require('gitsigns').setup()

-- AUTOTAG
--[[ require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  }
} ]]
require('nvim-ts-autotag').setup()
-- KASTEN
require('telekasten').setup({
  home = vim.fn.expand("~/Kasten"), -- Put the name of your notes directory here
})
