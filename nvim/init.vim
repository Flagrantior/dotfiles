call plug#begin('~/.vim/plugged')
	Plug 'easymotion/vim-easymotion'
	"Plug 'jiangmiao/auto-pairs'
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'mattn/emmet-vim'
	Plug 'preservim/nerdtree', {'on': 'NERDTreeToggle'}
	Plug 'preservim/nerdcommenter'
	Plug 'ap/vim-css-color'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'preservim/tagbar'
	Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
	Plug 'prettier/vim-prettier'
	Plug 'junegunn/fzf'
	"Plug 'yuezk/vim-js'
	"Plug 'maxmellon/vim-jsx-pretty'
call plug#end()

"set number
"set colorcolumn=79
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
set list listchars=tab:\ \ ,trail:_
set showbreak=\\
set noexpandtab
set smartcase
set statusline=
set statusline+=%#StatusLine#
set statusline+=%f\ 
set statusline+=%m\ 
set statusline+=%=%r%=
set statusline+=\ %y
set statusline+=\ %l:%c/%L
set fillchars+=vert:\|,stlnc:-
"set statusline+=%#PmenuSel#
"set statusline+=%#CursorColumn#
"set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
"set statusline+=\[%{&fileformat}\]
filetype indent on
syntax on

set completeopt-=preview

map <M-1> 1gt
map <M-2> 2gt
map <M-3> 3gt
map <M-4> 4gt
map <M-5> 5gt

hi Comment ctermfg=DarkRed
hi TabLineFill ctermfg=none ctermbg=none cterm=none
hi TabLine ctermfg=Cyan ctermbg=none cterm=none
hi TabLineSel ctermfg=Cyan cterm=underline
hi StatusLine ctermbg=none cterm=bold
hi VertSplit cterm=NONE
hi Pmenu ctermfg=cyan ctermbg=black gui=bold
hi PmenuSel ctermfg=black ctermbg=cyan
hi SignColumn ctermbg=black
"hi StatusLine ctermfg=16 ctermbg=Cyan

map <C-t> :tabnew<CR>
map <S-t> :tabclose<CR>
nmap <C-x> :NERDTreeToggle<CR>
map <C-/> <Plug>NERDCommenterToggle
map <Space> <Plug>(easymotion-bd-f)
nmap <Space> <Plug>(easymotion-overwin-f)
nnoremap <CR> :noh<CR><CR>
nnoremap <Space><Space><Space> :nohlsearch<CR>
inoremap jk <esc>
nnoremap <S-u> :redo<CR>
nnoremap ZZ :q!<cr>
nnoremap ZW :wq<cr>

" Run current script with python3 by CTRL+R in command and insert mode
autocmd FileType python map <buffer> <C-r> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <C-r> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" Emmet
let g:user_emmet_mode='in'
imap <C-y> <Plug>(emmet-expand-abbr)
"let g:user_emmet_install_global = 0
"let g:user_emmet_expandabbr_key='<Tab>'
"imap <buffer> <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

