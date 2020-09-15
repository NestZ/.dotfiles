" The default vimrc file.
"
" Maintainer:	NestZ
" Last change:	2020 March 29
"
" This is loaded if no vimrc file was found.
" Except when Vim is run with "-u NONE" or "-C".
" Individual settings can be reverted with ":set option&".
" Other commands can be reverted as mentioned below.


""""""""""""""""""""""""Plug In""""""""""""""""""""""""""""""

call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'christianchiarulli/nvcode.vim'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'leafgarland/typescript-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""Key Mapping"""""""""""""""""""""""""""

:imap ii <Esc>
map <C-n> :NERDTreeToggle<CR>
nnoremap <F8> :!g++ -o  %:r.out % -std=c++17 -Wshadow -Wall -O2 -Wno-unused-result<CR>
nnoremap <F9> :!g++ -o  %:r.out % -std=c++17 -Wshadow -Wall -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG<CR>
nnoremap <F5> :!./%:r.out<CR>
nnoremap <C-p> :Files<CR>
map <C-c> <plug>NERDCommenterToggle
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""Command Mapping"""""""""""""""""""""""""""

:command Ca !cat % | clip.exe
:command Clr !clear

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""NerdTree"""""""""""""""""""""""""""""

let g:NERDTreeWinSize = 40
let g:plug_window = 'noautocmd vertical topleft new'
let NERDTreeShowHidden = 1
let NERDTreeIgnore = ['^node_modules$', '^.git$']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""Set Up""""""""""""""""""""""""""""""""

set signcolumn=yes
set noswapfile
set guicursor=
set relativenumber
set backspace=indent,eol,start
set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line
set number
set hlsearch
set showmatch
set lazyredraw
set incsearch
set smartcase
set ignorecase
set noerrorbells
set novisualbell
set encoding=utf8
set ai
set si
set shiftwidth=2
set tabstop=2
set smarttab
set wrap
set termguicolors
set cursorline
set laststatus=2
set guicursor=a:blinkon100
set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key
set noshowmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""Theme""""""""""""""""""""""""""""""""

let g:nvcode_hide_endofbuffer=1
let g:nvcode_terminal_italics=1
let g:nvcode_termcolors=256

syntax on
colorscheme nvcode

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""GitGutter Config"""""""""""""""""""""""""

let g:gitgutter_enabled = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""Air line"""""""""""""""""""""""""""""

let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1
let g:airline_section_warning = ''
filetype plugin on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""fzf""""""""""""""""""""""""""""""""

let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.7 } }
let $FZF_DEFAULT_OPTS='--reverse'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""Coc"""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:coc_global_extensions = [
	\ 'coc-tsserver',
	\ 'coc-eslint',
	\ 'coc-prettier',
	\ 'coc-json',
	\ 'coc-yaml',
	\ 'coc-python',
	\ 'coc-java',
	\ 'coc-css',
	\ 'coc-git',
	\ 'coc-html',
	\ ]

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
