let mapleader = ','
" --------------------------------------- Plugins -----------------------------------------

filetype plugin indent on               " automatically detect file types

call plug#begin()
" keybindings for commenting
" gc                base operator
Plug 'tpope/vim-commentary' 
" function / structure browser based on ctags
" open via ,tt
Plug 'majutsushi/tagbar'
" Surround easy
" sa                add surroundings
" sr                replace surroundings
Plug 'machakann/vim-sandwich'
" fzf fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" git diff annotations
" :GitGutterPreviewHunk     See changes under cursor 
Plug 'airblade/vim-gitgutter'
call plug#end()

" invoke gutter symbol update on write
autocmd BufWritePost * GitGutter
" Let vim safe the buffer to swap more often also triggering refocus, thus
" gutter update
set updatetime=200

" fzf mappings
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" remap tagbar
nnoremap <silent> <leader>tt :TagbarToggle<CR>

" cpp comment style with //
autocmd FileType c,cpp,cxx,h,hpp,hxx setlocal commentstring=//\ %s
autocmd FileType gp,gpl,gnuplot setlocal commentstring=#\ %s


" ----------------------------------------- Style ------------------------------------------
colorscheme torte
syntax on                               " Enable syntax highlighting
" highlight Visual term=reverse cterm=reverse    " Make sure visual mode is visible

set number                              " Line numbers

set showcmd                             " Show Buttons pressed in normal mode

" Formatting stuff
set autoindent                          " Indent at the same level of the previous line
set shiftwidth=2                        " Use indents of 4 spaces
set expandtab                           " Tabs are spaces, not tabs
set tabstop=2                           " An indentation every four columns
set softtabstop=2                       " Let backspace delete indent
set nojoinspaces                        " Prevents inserting two spaces after punctuation on a join (J)
set splitright                          " Puts new vsplit windows to the right of the current
set splitbelow                          " Puts new split windows to the bottom of the current

" -------------------------------------- Statusline ----------------------------------------
set laststatus=2                        " Every window gets a status line
set statusline=                         " Clear status line
set statusline+=%r                      " Read only flag
set statusline+=%n:                     " Buffer number
set statusline+=%<                      " Start truncating here
set statusline+=%F\                     " Filename (full path)
set statusline+=%=                      " Start inserting from the right now
set statusline+=[%Y]\                   " Filetype
set statusline+=%-8.(%l,%c%V%)          " Line and col info with offsets
set statusline+=\ %p%%                  " Right aligned file nav info
set wildmenu                            " Show auto complete choices
set shortmess-=S                        " Show number of search hits

" -------------------------------------- Convenience ---------------------------------------
set backspace=indent,eol,start          " make backspace work as expected

set autochdir                           " always set working dir to current file

set hidden                              " allow buffer switching without saving

" Persistent undo (undo after reopening file)
set undofile                            " So is persistent undo ...
set undodir=$HOME/.vim/tmp//            " location where to store the undo files
set undolevels=1000                     " Maximum number of changes that can be undone
set undoreload=10000                    " Maximum number lines to save for undo on a buffer reload

set directory=$HOME/.vim/tmp//          " location where to store the swap files

" Set clipboard to use system clipboard (needs +clipboard)
set clipboard=unnamed,unnamedplus

" Smart search
set ignorecase                          " search is case insensitive
set smartcase                           " if needle contains uppercase -> search case sensitive
set hlsearch                            " highlight search results
set incsearch                           " highlighting starts while typing
set iskeyword-=_                        " consider '_' as word delimiter

" Spellcheck 
set spell                               " Enable spellchecker -> z=
highlight clear SpellBad                " Clear misspell style
highlight SpellBad cterm=underline      " Underline misspells
set spelllang=en,de

" Since makefiles depend on tabs do not expand them there
autocmd FileType make setlocal noexpandtab

" Associate .gp files with gnuplot syntax highlighting
autocmd BufRead,BufNewFile *.gp set filetype=gnuplot

" In order to switch to python 2 delete compiled pyc files
" find ~/.vim/bundle/python-mode -name '*.pyc' -delete
let g:pymode_python = 'python3'

" --------------------------------------- Shortcuts ----------------------------------------
" Shortcut for writing in a read only file
cmap w!! w !sudo tee % >/dev/null

" Switch to buffer when listing them
nnoremap <leader>l :ls<cr>:buffer<space>

" Fast buffer cycling via Tab
nnoremap <Tab> :bnext<CR>zR
nnoremap <S-Tab> :bprevious<CR>zR

"shortcut for running the current script in the shell
nnoremap <leader>r :w\|!%:p<Enter>

" Search and replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Switch between .h and .cpp
nnoremap <F10> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" search for selected text via //
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" --------------------------------------- Color fix ----------------------------------------
"  These colors need to be set in the end otherwise they would be overwritten
"  (e.g. by syntax=on)
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

