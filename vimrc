"
" Romain Dorgueil's VimRC.
"
" My own vim. Don't give it to little children.
"
" Chances are that nothing will work under mswin.
" And yes, it's Beyrut style, don't complain.
"

"
" Include local settings if available
"
if filereadable("~/.vimrc.local")
  source ~/.vimrc.local
endif

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

let g:tex_flavor='latex'
let g:Tex_ViewRule_pdf = '/usr/bin/evince'

syntax on
"set background=dark
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd    " Show (partial) command in status line.
set showmatch  " Show matching brackets.
set ignorecase " Do case insensitive matching
set smartcase  " Do smart case matching
set incsearch  " Incremental search
set autowrite  " Automatically save before commands like :next and :make
set hidden     " Hide buffers when they are abandoned
set mouse=a    " Enable mouse usage (all modes) in terminals
set tabstop=2
set shiftwidth=2
set expandtab
set number
set hlsearch
set scrolljump=4
set scrolloff=2

" this will show tabs and trailing spaces
set list
set listchars=tab:>-,trail:-

" Auto indent after a {
set autoindent
set smartindent

" Linewidth to endless
set textwidth=0
set nowrap

" GUI
set guioptions-=T

set showmode                    " always show command or insert mode-
set whichwrap=b,s,<,>,[,]       " cursors will now wrap
set browsedir=buffer
set autoread

" always show the tabline...
set showtabline=2

" The completion dictionary is provided by Rasmus:
" http://lerdorf.com/funclist.txt
set dictionary+=~/.vim/php-func.lst
set complete-=k complete+=k

" Automatically reload .vimrc when changing
autocmd! bufwritepost .vimrc source %

" ctrl-w+n creates a new split, so I've mapped ctrl-w+t+n to create a new tab, and ctrl-w+t+t to move to the next tab
noremap <C-W>tn :tabnew<CR>
noremap <C-W>tt :tabnext<CR>
noremap <C-W>tr :tabprevious<CR>
noremap <C-L> :tabnext<CR>
noremap <C-H> :tabprevious<CR>
noremap <C-X><C-W> :browse sav<CR>
noremap <C-X><C-K> :confirm close<CR>
noremap <C-X><C-S>b :set browsedir=buffer<CR>
noremap <C-X><C-S>c :set browsedir=current<CR>
noremap <C-X>+ <C-W>5+
noremap <C-X>- <C-W>5-
noremap <silent><C-X>dos :%s/\$//g<CR>
noremap <C-X>4<C-F> :browse split<CR>
noremap <C-X>5<C-F> :browse tabe<CR>
nnoremap <silent> <C-X>notrailing :%s/\s\+$//g!<CR>
nnoremap <silent> <C-X>notab :%s/  /  /g<CR>
nnoremap <silent> <C-X>nowin :0,$s///g!<CR>
nnoremap <silent> <C-X>tag :TlistToggle<CR>
nnoremap <silent> <C-X>sob oSigned-off-by: Romain Dorgueil <romain.dorgueil@dakrazy.net><ESC>
nnoremap <silent> <C-X>rb oReviewed-by: Romain Dorgueil <romain.dorgueil@dakrazy.net><ESC>
nnoremap <silent> <C-X>tb oTested-by: Romain Dorgueil <romain.dorgueil@dakrazy.net><ESC>
nnoremap <silent> <C-X>mod Go# vim: et ts=4 sw=4<ESC>'':w<CR>:e %<CR>
nnoremap <silent> <C-N> :tabnew<CR>
nnoremap <silent> <D-N> :tabnew<CR>
nnoremap <silent> <M-LEFT> :tabprevious<CR>
nnoremap <silent> <M-RIGHT> :tabnext<CR>
nnoremap <silent> <D-LEFT> :tabprevious<CR>
nnoremap <silent> <D-RIGHT> :tabnext<CR>
nnoremap <silent> <C-X><LEFT> <C-W>h
nnoremap <silent> <C-X><RIGHT> <C-W>l
nnoremap <silent> <C-X><UP> <C-W>k
nnoremap <silent> <C-X><DOWN> <C-W>j
nnoremap <silent> <F3> :split<CR>
nnoremap <C-X><C-B> :!php -l %<CR>
nnoremap <silent> <C-Q> :silent noh<CR>
inoremap (); ();
inoremap (), (),
inoremap ()- ()-
inoremap ()) ())
inoremap ()<space> ()<space>
inoremap () ()<C-O>F(<C-O>l
inoremap © ()<C-O>F(<C-O>l
inoremap {} {}<C-O>F{<C-O>l
inoremap ∂ {}<C-O>F{<C-O>l
inoremap []<space> []<space>
inoremap []; [];
inoremap [] []<C-O>F[<C-O>l
inoremap æ []<C-O>F[<C-O>l
inoremap ''; '';
inoremap '' @''<C-O>F@<C-O>"_x<C-O>l
inoremap "" @""<C-O>F@<C-O>"_x<C-O>l

" very few schemes have tab highlighting in yet, so lets set this outselves...
hi TabLine     term=bold,reverse cterm=bold ctermfg=lightblue ctermbg=white gui=bold guifg=blue guibg=white
hi TabLineFill term=bold,reverse cterm=bold ctermfg=lightblue ctermbg=white gui=bold guifg=blue guibg=white
hi TabLineSel  term=reverse ctermfg=white ctermbg=lightblue guifg=white guibg=blue
hi Comment term=NONE ctermfg=DarkGrey guifg=DarkGrey
hi Constant term=underline ctermfg=DarkBlue gui=NONE guifg=DarkGreen

" }}} tabbing config

let g:netrw_liststyle = 3
let g:VEConf_showHiddenFiles = 0

" autocmd FileType php set keywordprg=~/etc/vim/getphpdoc
autocmd FileType php set foldlevelstart=2
" autocmd FileType php let php_folding=1

" ctags stuff
let g:ctags_path='/usr/bin/ctags'
let g:ctags_args='-I __declspec+'
let g:ctags_title=1
let g:ctags_statusline=1
let generate_tags=1

" source ~/etc/vim/ctags.vim

" au Filetype html,php let g:closetag_html_style=1
" au Filetype html,xml,xsl,php source ~/.vim/scripts/closetag.vim

" Map <F5> to turn spelling on (VIM 7.0+)
map <F5> :setlocal spell! spelllang=en_us<cr>

" Highlight current line in insert mode.
"autocmd InsertLeave * se nocul
"autocmd InsertEnter * se cul
"
" {{{ .phps filesall handled like .php

filetype plugin on
au BufRead,BufNewFile *.phps set filetype=php

autocmd BufWritePre *.php :%s/\s\+$//e
autocmd BufWritePre *.js :%s/\s\+$//e
autocmd BufWritePre *.xml :%s/\s\+$//e
autocmd BufWritePre *.html :%s/\s\+$//e
autocmd BufWritePre *.htm :%s/\s\+$//e
autocmd BufWritePre *.yml :%s/\s\+$//e

" }}}

" {{{  Settings

" Use filetype plugins, e.g. for PHP

" Show nice info in ruler
set ruler
set laststatus=2

" Set standard setting for PEAR coding standards
""set tabstop=4
""set shiftwidth=4

" Show line numbers by default
set number

" Enable folding by fold markers
set foldmethod=indent

" Autoclose folds, when moving out of them
" set foldclose=""
" set foldopen=insert,search,tag,mark,jump
set foldnestmax=2
set foldlevel=1
set foldlevelstart=1
" Use incremental searching
""set incsearch

" Do not highlight search results
""set nohlsearch

" Jump 5 lines when running out of the screen
set scrolljump=5

" Indicate jump out of the screen when 3 lines before end of the screen
set scrolloff=3

" Repair wired terminal/vim settings
set backspace=start,eol,indent

" Allow file inline modelines to provide settings
set modeline

" }}}

set nocompatible

set guifont=Monospace\ 11

:function! s:svnBlame()
   let line = line(".")
   setlocal nowrap
   " create a new window at the left-hand side
   aboveleft 18vnew
   " blame, ignoring white space changes
   %!svn blame -x-w "#"
   setlocal nomodified readonly buftype=nofile nowrap winwidth=1
   setlocal nonumber
   if has('&relativenumber') | setlocal norelativenumber | endif
   " return to original line
   exec "normal " . line . "G"
   " synchronize scrolling, and return to original window
   setlocal scrollbind
   wincmd p
   setlocal scrollbind
   syncbind
:endfunction
":map! gb :call <SID>svnBlame()<CR>
:command! Blame call s:svnBlame()

colorscheme wombat

:autocmd FileType mail :nmap <C-X>en :w<CR>:!aspell -e -c -l en %<CR>:e<CR>
:autocmd FileType mail :nmap <C-X>fr :w<CR>:!aspell -e -c -l fr %<CR>:e<CR>
