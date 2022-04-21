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
	" autocmd TermOpen * echom bufname()
augroup END

function! s:ToggleFocus()
	echom "Not Implemented"
	" if !s:is_open_terminal
		" call s:ToggleOpen()
	" endif
endfunction

function! s:ToggleOpen()
	if s:is_open_terminal
		let s:term_bufwinnr = bufwinnr(s:term_name)
		if s:term_bufwinnr != -1
			if winnr() != s:term_bufwinnr
				let s:prev_window = winnr()
			endif
			let s:terminal_height = winheight(s:term_bufwinnr)
			execute s:term_bufwinnr "wincmd c"
			execute s:prev_window "wincmd w"
		endif
		let s:is_open_terminal = 0
	else
		let s:prev_window = winnr()
		botright split
		call s:OpenTerminalBuffer()
		if !s:terminal_height
			let s:terminal_height = g:terminal_height
		endif
		execute "resize" s:terminal_height
		let s:is_open_terminal = 1
		if g:terminal_auto_insert_mode
			startinsert
		endif
	endif
endfunction

" Open terminal buffer in window
function! s:OpenTerminalBuffer()
	if s:term_name == ""
		term
		setlocal bufhidden=hide
		let s:term_name = bufname()
	else
		execute "buffer" s:term_name
	endif
endfunction

function! s:ToggleAutoInsert()
	let g:terminal_auto_insert_mode = !g:terminal_auto_insert_mode
endfunction
