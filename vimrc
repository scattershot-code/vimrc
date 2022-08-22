" Disable compatibility with vi which can cause unexpected issues, must come first
set nocompatible

" Set tab width to 4 columns
set tabstop=4

"""""""""""""""""""""""""""""""""""""""""""
" These are from:
" https://vim.fandom.com/wiki/Example_vimrc

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" Enable use of the mouse for all modes
if has('mouse')
  set mouse=a
endif

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

"""""""""""""""""""""""""""""""""""""""""""
" from: https://chrisyeh96.github.io/2017/12/18/vimrc.html
"""" Basic Behavior

set number              " show line numbers
set wrap                " wrap lines
set encoding=utf-8      " set encoding to UTF-8 (default was "latin1")
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw screen only when we need to
set showmatch           " highlight matching parentheses / brackets [{()}]
set laststatus=2        " always show statusline (even with only single window)
set ruler               " show line and column number of the cursor on right side of statusline
set visualbell          " blink cursor on error, instead of beeping

"""" Search settings

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

"""" Tab settings

set autoindent          " copy indent from current line when starting a new line
set smartindent         " even better autoindent (e.g. add indent after '{')

"""" Miscellaneous settings that might be worth enabling

"set cursorline         " highlight current line
"set background=dark    " configure Vim to use brighter colors

"""""""""""""""""""""""""""""""""""""""""""""""""
" status bar jiggery pokery
" courtesy of: https://stackoverflow.com/questions/9065941/how-can-i-change-vim-status-line-color

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Cyan ctermfg=6 guifg=Black ctermbg=0
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  else
    hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

" default the statusline to green when entering Vim
hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

" Formats the statusline
set statusline=%f                           " file name
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%y      "filetype
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag

set statusline+=\ %=                        " align left
set statusline+=Line:%l/%L[%p%%]            " line X of Y [percent of file]
set statusline+=\ Col:%c                    " current column
set statusline+=\ Buf:%n                    " Buffer number
set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor

" Use the following mapping code in your .vimrc file for compiling and running a c programming file.
" F8 key is for run the mapping. % is to take the current file name.
" saves it
" uses the file basename not the default 'a.out' as the executable file name
map <F8> :w <CR> :!gcc % -o %< && ./%< <CR>
" < after % removes extension and dot (foo.c => foo), so %< is the file basename.
" it will save it, compile it to the filename, and then run it. Things might break, but a good start.
" source for this: https://stackoverflow.com/questions/2627886/how-do-i-run-a-c-program-from-vim

" Copies the currently selected text to the system clipboard (OSX)
let @c = ':w !pbcopy'
" Pastes the currently selected text to the system clipboard (OSX)
let @p = ':r !pbpaste'
