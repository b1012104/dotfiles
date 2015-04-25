" ~/.vimrc (configuration file for vim only)
" skeletons
function! SKEL_spec()
	0r /usr/share/vim/current/skeletons/skeleton.spec
	language time en_US
	if $USER != ''
	    let login = $USER
	elseif $LOGNAME != ''
	    let login = $LOGNAME
	else
	    let login = 'unknown'
	endif
	let newline = stridx(login, "\n")
	if newline != -1
	    let login = strpart(login, 0, newline)
	endif
	if $HOSTNAME != ''
	    let hostname = $HOSTNAME
	else
	    let hostname = system('hostname -f')
	    if v:shell_error
		let hostname = 'localhost'
	    endif
	endif
	let newline = stridx(hostname, "\n")
	if newline != -1
	    let hostname = strpart(hostname, 0, newline)
	endif
	exe "%s/specRPM_CREATION_DATE/" . strftime("%a\ %b\ %d\ %Y") . "/ge"
	exe "%s/specRPM_CREATION_AUTHOR_MAIL/" . login . "@" . hostname . "/ge"
	exe "%s/specRPM_CREATION_NAME/" . expand("%:t:r") . "/ge"
	setf spec
endfunction
augroup SKEL
	autocmd!
	autocmd BufNewFile	*.spec	call SKEL_spec()
augroup END
" filetypes
filetype plugin on
filetype indent on

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
" Number of spaces that TAB
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
	"	return "\<CR>)\<Up>\<End>\<CR>"
	"elseif l =~ '[$'
	"	return "\<CR>]\<Up>\<End>\<CR>"
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
colorscheme jellybeans
if $TERM != 'screen-256colors'
	set t_Co=256
endif

" ~/.vimrc end
