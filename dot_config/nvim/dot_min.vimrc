set nocompatible              " be iMproved, required
filetype off                  " required

if empty(glob("~/.local/share/nvim/site/autoload"))
    execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim '
endif

call plug#begin('~/.config/nvim/plugged')

" Minimal .vimrc file for Inkscape Shortcut Manager

" NeoViM Plugins
Plug 'chriskempson/base16-vim'
Plug 'honza/vim-snippets', { 'for': 'tex' }
Plug 'lervag/vimtex'    , { 'for': 'tex' }

call plug#end()

if !has('nvim')
  set viminfo+=~/.local/share/vim/viminfo
endif

"================== Theme ================="
syntax enable
if filereadable(expand("~/.config/nvim/vimrc_background"))
    "let base16colorspace=256
    source ~/.config/nvim/vimrc_background
endif

set background=dark
set termguicolors
set softtabstop=4
set expandtab
set shiftwidth=4

"================ Config ==============="
" Sources:
" https://www.reddit.com/r/neovim/comments/8mglne/removing_the_filename_line/
" https://www.reddit.com/r/vim/comments/7hwhll/remove_the_bottom_status_line_in_vim_possible/
" Note that when using inkscape shortcut manager, the popup window ocassionally fails to refresh properly.
" These lines below remove Vim's status bar as a workaround.
set noshowmode
set noruler
set laststatus=0
set noshowcmd
set cmdheight=1
filetype indent on
set autoread
" https://stackoverflow.com/questions/58403300/vimrc-tags-option-specification-for-git-tags-files
set tags^=.git/tags;~

"================ Searching ==============="
set incsearch
set hlsearch
:hi Search ctermbg=3 ctermfg=8

"================ Movement ================"
set ttyfast
nnoremap B ^
nnoremap E $
set backspace=indent,eol,start
nnoremap <C-L> <C-W><C-L>
nnoremap <C-K> <C-W><C-K> nnoremap <C-J> <C-W><C-J>
nnoremap <C-H> <C-W><C-H>

"================ Shortcuts ==============="
let mapleader='\'
set pastetoggle=<F9>
inoremap jk <esc>

" Quickly closing the window by jamming wq
inoremap wq <Esc>:wq<CR>
nnoremap wq :wq<CR>
inoremap qw <Esc>:wq<CR>
nnoremap qw :wq<CR>

" Start insert mode between $$'s
autocmd BufEnter * startinsert | call cursor(1, 2)

" Bind \ q to toggle double quotes
nnoremap <leader>q :cs"q <CR>

" Correct last misspelling
inoremap <leader>s <c-g>u<Esc>[s1z=`]a<c-g>u

" https://github.com/gillescastel/inkscape-figures
" https://castel.dev/post/lecture-notes-2/
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

" ================= Format =================
let g:formatterpath = [ "$HOME/.config/nvim/after/ftplugin/" ]

set ft=tex
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

" Vimtex
let g:tex_flavor = 'latex'
