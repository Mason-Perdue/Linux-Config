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

" originally from sudo apt install vim-lastplace
" ============================================================================
" File:        vim-lastplace.vim
" Description: Reopen files where you left off. Configurable.
" Author:      Gregory L. Dietsche <vim@gregd.org>
" Licence:     MIT
" Website:     https://www.gregd.org/
" Version:     3.1.1
" ============================================================================

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
		"if the file does not exist on disk (a new, unsaved file) then do nothing
		if empty(glob(@%))
			return
		endif
	catch
		return
	endtry

	if line("'\"") > 0 && line("'\"") <= line("$")
		"if the last edit position is set and is less than the
		"number of lines in this buffer.

		if line("w$") == line("$")
			"if the last line in the current buffer is
			"also the last line visible in this window
			execute "normal! g`\""

		elseif line("$") - line("'\"") > ((line("w$") - line("w0")) / 2) - 1
			"if we're not at the bottom of the file, center the
			"cursor on the screen after we make the jump
			execute "normal! g`\"zz"

		else
			"otherwise, show as much context as we can by jumping
			"to the end of the file and then to the mark. If we
			"pressed zz here, there would be blank lines at the
			"bottom of the screen. We intentionally leave the
			"last line blank by pressing <c-e> so the user has a
			"clue that they are near the end of the file.
			execute "normal! \G'\"\<c-e>"
		endif
	endif
	if foldclosed(".") != -1 && g:lastplace_open_folds
		"if we're in a fold, make the current line visible
		execute "normal! zv"
	endif
endf

augroup lastplace_plugin
	autocmd!
	autocmd BufWinEnter * call s:lastplace()
augroup END

" from password store github
"
" redact_pass.vim: Switch off the 'viminfo', 'backup', 'writebackup',
" 'swapfile', and 'undofile' globally when editing a password in pass(1).
"
" This is to prevent anyone being able to extract passwords from your Vim
" cache files in the event of a compromise.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_redact_pass') || &compatible
  finish
endif
if !has('autocmd') || v:version < 600
  finish
endif
let g:loaded_redact_pass = 1

" Check whether we should set redacting options or not
function! s:CheckArgsRedact()

  " Ensure there's one argument and it's the matched file
  if argc() != 1 || fnamemodify(argv(0), ':p') !=# expand('<afile>:p')
    return
  endif

  " Disable all the leaky options globally
  set nobackup
  set nowritebackup
  set noswapfile
  set viminfo=
  if has('persistent_undo')
    set noundofile
  endif

  " Tell the user what we're doing so they know this worked, via a message and
  " a global variable they can check
  redraw
  echomsg 'Editing password file--disabled leaky options!'
  let g:redact_pass_redacted = 1

endfunction

" Auto function loads only when Vim starts up
augroup redact_pass
  autocmd!
  autocmd VimEnter
        \ /dev/shm/pass.?*/?*.txt
        \,$TMPDIR/pass.?*/?*.txt
        \,/tmp/pass.?*/?*.txt
        \ call s:CheckArgsRedact()
  " Work around macOS' dynamic symlink structure for temporary directories
  if has('mac')
    autocmd VimEnter
          \ /private/var/?*/pass.?*/?*.txt
          \ call s:CheckArgsRedact()
  endif
augroup END

