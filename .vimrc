" filetypes

" const variable
let s:FALSE = 0
let s:TRUE  = !s:FALSE

filetype plugin on
filetype indent on

" Neobundle Settings
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

let s:is_neobundle_installed = s:TRUE
try
    call neobundle#begin(expand('~/.vim/bundle'))
catch /^Vim\%((\a\+)\)\=:E117/› " catch error E117: Unkown function
    let s:is_neobundle_installed = s:FALSE
    set title titlestring=NeoBundle\ Error
endtry

if s:is_neobundle_installed
    NeoBundleFetch 'Shougo/neobundle.vim'
    " Plugins
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'PeterRincker/vim-argumentative'
    NeoBundle 'easymotion/vim-easymotion'
    nmap s <Plug>(easymotion-s2)
    nmap g/ <Plug>(easymotion-sn)
    let g:EasyMotion_smartcase = 1
    let g:EasyMotion_use_upper = 1
    let g:EasyMotion_enter_jump_first = 1
    " Plugins end

    NeoBundleCheck
    call neobundle#end()
endif
" Neobundle end

" -------- User settings --------
" Use English
language C
" Disable compatible mode
set nocompatible
" Incremental search
set incsearch
" Ignore uppercase and lowercase
set ignorecase
" Command-line completion
set wildmenu
" Show commands in the last of the screen
set showcmd
" Number of spaces of TAB
set tabstop=4
" Space when auto indent
set shiftwidth=4
" Expand tabs
"set expandtab
" C indent
set cindent
" Set scroll offset
set scrolloff=8
" Add matchpairs
set mps+=<:>
" Hidden
set hidden
" Cmdline history
set history=50

" -------- Plugin settings --------
let g:netrw_altv=1

" -------- Display settings --------
" Show line numbers
set number
" Show cursor line
set cursorline
" Always display status Line
set laststatus=2
" Status line settings
set statusline=%<%f\ [%n]%y%h%m%r%=%-14.(%l,%c%V%)\ %P
" Show invisible character
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«
" Show the cursor position
set ruler
" Syntax highlight on
syntax on

" -------- File settings --------
" Backup directory
if isdirectory(expand("~/vimbackup"))
    set backupdir=~/vimbackup
endif
" Enable clip board
set clipboard=unnamed,unnamedplus
" Do not make swap file
set noswapfile

" -------- Map settings --------
nnoremap <C-c> I/* <ESC>A */<ESC>F*F*<ESC>
"nnoremap <C-m> o<ESC>
noremap <F4> :<C-u>sp $MYVIMRC<C-m>
noremap <F5> :<C-u>vs $MYVIMRC<C-m>
noremap <F6> :<C-u>source $MYVIMRC<C-m>
noremap <Space>m :<C-u>marks<C-m>
noremap <Space>r :<C-u>registers<C-m>
noremap <Space>b :<C-u>buffers<C-m>
noremap <ESC><ESC> :<C-u>nohlsearch<CR><C-l>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
noremap Y y$
"noremap <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
"noremap <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>

"change ';' and ':' in normal mode
noremap ; :
noremap : ;

":noremap <ESC>[17~ ggO#!/bin/sh<ESC>
":inoremap ( ()<ESC>i
":inoremap { {<CR>}<ESC>ko
inoremap <expr><CR> <SID>ExCr()

" -------- User functions --------
function! s:ExCr()
    if col('.') != col('$')
        return "\<CR>"
    endif
    let l = getline('.')
    if l =~ '{$'
        return "\<CR>}\<Up>\<End>\<CR>"
    "elseif l =~ '($'
    "    return "\<CR>)\<Up>\<End>\<CR>"
    "elseif l =~ '[$'
    "    return "\<CR>]\<Up>\<End>\<CR>"
    else
        return "\<CR>"
    endif
endfunction

function! EraseWhiteSpace()
    %s/\s\+$//g
endfunction

function! PrintDate()
    :r! date +\%Y/\%m/\%d
endfunction

function! SayHello()
    echo "Hello, World!"
endfunction

" -------- User commands --------
" Erase white space at the end of line
command! Ews call EraseWhiteSpace()
" Print today's date
command! Date call PrintDate()

" -------- My autocmd --------
augroup MYAUTOCMD
    autocmd!
    autocmd WinEnter,VimEnter * match Error /\s\+$/
augroup END

augroup CMDWINDOW
    autocmd!
    autocmd winEnter,VimEnter * nnoremap <C-m> o<ESC>
    autocmd CmdwinEnter * nnoremap <C-m> <C-m>
    autocmd Cmdwinleave * nnoremap <C-m> o<ESC>
augroup END

" -------- Color scheme --------
if filereadable(expand("~/.vim/colors/jellybeans.vim"))
    colorscheme jellybeans
    if $TERM != 'screen-256colors'
    set t_Co=256
    endif
endif
" ~/.vimrc end
