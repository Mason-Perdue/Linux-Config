colorscheme torte
set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on
set mouse=a
set number
set cursorline
" set cursorcolumn
set shiftwidth=4
set ruler
set encoding=utf-8
set wrap
set smartindent
set ttyfast
set tabstop=4
set softtabstop=4
set expandtab
set nobackup
set scrolloff=10
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch
set hlsearch
set history=1000
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set foldmethod=syntax

" key remaps
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

if exists("b:loaded_lastplace_plugin") || &cp
	finish
endif
let b:loaded_lastplace_plugin = 1

scriptencoding utf-8

if !exists('g:lastplace_ignore')
	let g:lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"
endif

if !exists('g:lastplace_open_folds')
	let g:lastplace_open_folds = 1
endif

if !exists('g:lastplace_ignore_buftype')
	let g:lastplace_ignore_buftype = "quickfix,nofile,help"
endif

fu! s:lastplace()
	if index(split(g:lastplace_ignore_buftype, ","), &buftype) != -1 
		return
   	endif

	if index(split(g:lastplace_ignore, ","), &filetype) != -1
		return
	endif

	try
		if empty(glob(@%))
			return
		endif
	catch
		return
	endtry

	if line("'\"") > 0 && line("'\"") <= line("$")
		if line("w$") == line("$")
			execute "normal! g`\""
		elseif line("$") - line("'\"") > ((line("w$") - line("w0")) / 2) - 1
			execute "normal! g`\"zz"
		else
			execute "normal! \G'\"\<c-e>"
		endif
	endif
	if foldclosed(".") != -1 && g:lastplace_open_folds
		execute "normal! zv"
	endif
endf

augroup lastplace_plugin
	autocmd!
	autocmd BufWinEnter * call s:lastplace()
augroup END