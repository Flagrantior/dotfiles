call plug#begin()
	Plug 'easymotion/vim-easymotion'
	Plug 'jiangmiao/auto-pairs'
	Plug 'kien/ctrlp.vim'
	Plug 'mattn/emmet-vim'
	Plug 'preservim/nerdtree', {'on': 'NERDTreeToggle'}
	Plug 'preservim/nerdcommenter'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	"Plug 'majutsushi/tagbar'
	"Plug 'mattn/emmet-vim'
	"Plug 'terryma/vim-multiple-cursors'
	"Plug 'valloric/youcompleteme'
call plug#end()

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

scriptencoding utf-8
set encoding=utf-8

let g:airline_left_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_section_z = airline#section#create(['%3v', 'linenr', 'maxlinenr'])
let g:airline_skip_empty_sections = 1
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.branch = ''
let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinear = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.readonly = ''
let g:airline_symbols.whitespace = ''
let g:airline_theme='monochrome'

map <C-t> :tabnew<CR>
map <S-t> :tabclose<CR>
nmap <C-x> NERDTreeToggle<CR>
nmap <C-_> <Plug>NERDCommenterToggle
nmap <Space> <Plug>(easymotion-overwin-f)

set mouse=a
set gdefault
set guifont=Source\ Code\ Pro\ for\ Powerline:h15:cANSI
set hlsearch
set ignorecase
set incsearch
set list listchars=tab:\ \ ,trail:_
set showbreak=\\
set noexpandtab
set shiftwidth=4
set smartcase
set softtabstop=4
set tabstop=4
syntax on
hi Comment ctermfg=DarkRed

"hi LineNr ctermfg=Black
"set number
"set cursorline
"highlight clear CursorLine
"highlight CursorLineNR ctermfg=DarkMagenta
