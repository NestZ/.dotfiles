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

Plug 'preservim/nerdtree'
Plug 'sainnhe/sonokai'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Bail out if something that ran earlier, e.g. a system wide vimrc, does not
" want Vim to use these default values.
if exists('skip_defaults_vim')
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
  set nocompatible
silent! endwhile


"""""""""""""""""""""""Key Mapping"""""""""""""""""""""""""""

:imap ii <Esc>
map <C-n> :NERDTreeToggle<CR>
nnoremap <F8> :!g++ -o  %:r.out % -std=c++17 -Wshadow -Wall -O2 -Wno-unused-result<CR>
nnoremap <F9> :!g++ -o  %:r.out % -std=c++17 -Wshadow -Wall -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG<CR>
nnoremap <F5> :!./%:r.out<CR>
map <C-_> <plug>NERDCommenterToggle

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""Command Mapping"""""""""""""""""""""""""""

:command Ca !cat % | clip.exe
:command Clr !clear

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""GitGutter Config"""""""""""""""""""""""""

highlight GitGutterAdd guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
let g:gitgutter_enabled = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""Set Up""""""""""""""""""""""""""""""""

" Allow backspacing over everything in insert mode.
:set guicursor=
:set relativenumber
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
set shiftwidth=4
set tabstop=4
set smarttab
set wrap
set termguicolors
set cursorline
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""Theme""""""""""""""""""""""""""""""""

let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1
let g:sonokai_style = 'shusia'
" {maia, atlantis, shusia, andromeda}
colorscheme sonokai

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""Air line"""""""""""""""""""""""""""""

let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1
let g:airline_section_warning = ''
filetype plugin on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


syntax enable
set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
  set guioptions-=t
endif

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
" Only xterm can grab the mouse events when using the shift key, for other
" terminals use ":", select text and press Esc.
if has('mouse')
  if &term =~ 'xterm'
    set mouse=a
  else
    set mouse=nvi
  endif
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

" Only do this part when Vim was compiled with the +eval feature.
if 1

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif
