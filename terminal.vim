" Mappings {{{
if !hasmapto('<Plug>TerminalToggleOpen')
	map <unique> <space>t <Plug>TerminalToggleOpen
endif
if !hasmapto('<Plug>TerminalToggleFocus')
	map <unique> <leader>t <Plug>TerminalToggleFocus
endif
command! TermAutoInsertToggle call <SID>ToggleAutoInsert()
noremap <unique> <script> <Plug>TerminalToggleOpen <SID>ToggleOpen
noremap <unique> <script> <Plug>TerminalToggleFocus <SID>ToggleFocus
noremap <unique> <script> <Plug>TerminalToggleAutoInsert <SID>ToggleAutoInsert
noremap <SID>ToggleOpen :call <SID>ToggleOpen()<cr>
noremap <SID>ToggleFocus :call <SID>ToggleFocus()<cr>
noremap <SID>ToggleAutoInsert :call <SID>ToggleAutoInsert()<cr>
" }}}

let g:terminal_height = 12
let g:terminal_auto_insert_mode = 0

let s:terminal_height = 0
let s:is_open_terminal = 0
let s:prev_window = 0
let s:term_name = ""

augroup terminal
	autocmd!
	autocmd BufWinEnter * call s:TerminalEnterAucmd()
	autocmd BufWinLeave * call s:TerminalLeaveAucmd()
augroup END

function! s:TerminalEnterAucmd()
	if s:term_name ==# expand("<afile>") && s:term_name != ""
		call s:UpdateTerminalOnOpen()
	endif
endfunction

function! s:TerminalLeaveAucmd()
	if s:term_name ==# expand("<afile>") && s:term_name != ""
		let s:is_open_terminal = 0
		let s:term_bufwinnr = bufwinnr(s:term_name)
		let s:terminal_height = winheight(s:term_bufwinnr)
	endif
endfunction

function! s:ToggleFocus()
	if !s:is_open_terminal
		call s:ToggleOpen()
	else
		let s:prev_window = winnr()
		execute bufwinnr(s:term_name) "wincmd w"
	endif
endfunction

function! s:ToggleOpen()
	if s:is_open_terminal
		if winnr() != bufwinnr(s:term_name)
			let s:prev_window = winnr()
		endif
		execute bufwinnr(s:term_name) "wincmd c"
		execute s:prev_window "wincmd w"
	else
		let s:prev_window = winnr()
		botright split
		call s:OpenTerminalBuffer()
	endif
endfunction

" Open terminal buffer in window
function! s:OpenTerminalBuffer()
	if s:term_name == ""
		term
		call s:InitTerminal()
	else
		execute "buffer" s:term_name
	endif
endfunction

function! s:InitTerminal()
	setlocal bufhidden=hide
	let s:term_name = bufname()
	if !s:terminal_height
		let s:terminal_height = g:terminal_height
	endif
	" Call UpdateTerminalOnOpen because the autocmd seems to happen before
	" InitTerminal
	call s:UpdateTerminalOnOpen()
endfunction

function! s:UpdateTerminalOnOpen()
	let s:is_open_terminal = 1
	execute "resize" s:terminal_height
	if g:terminal_auto_insert_mode
		startinsert
	endif
endfunction

function! s:ToggleAutoInsert()
	let g:terminal_auto_insert_mode = !g:terminal_auto_insert_mode
endfunction
