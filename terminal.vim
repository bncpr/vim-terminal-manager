" Mappings {{{
if !hasmapto('<Plug>TerminalToggleOpen')
	map <unique> <space>t <Plug>TerminalToggleOpen
endif
if !hasmapto('<Plug>TerminalToggleFocus')
	map <unique> <leader>t <Plug>TerminalToggleFocus
endif
noremap <unique> <script> <Plug>TerminalToggleOpen <SID>ToggleOpen
noremap <unique> <script> <Plug>TerminalToggleFocus <SID>ToggleFocus
noremap <SID>ToggleOpen :call <SID>ToggleOpen()<cr>
noremap <SID>ToggleFocus :call <SID>ToggleFocus()<cr>
" }}}

let g:terminal_height = 12
let s:terminal_height = 0

let s:is_open_terminal = 0
let s:term_name = ""

augroup terminal
	autocmd!
	" autocmd TermOpen * echom bufname()
augroup END

function! s:ToggleFocus()
	echom "ToggleFocus: not implemented"
endfunction

function! s:ToggleOpen()
	if s:is_open_terminal
		let s:term_bufwinid = bufwinid(s:term_name)
		if s:term_bufwinid != -1
			let s:term_bufwinnr = win_id2win(s:term_bufwinid)
			if s:term_bufwinnr
				let s:terminal_height = winheight(s:term_bufwinnr)
				execute s:term_bufwinnr "wincmd c"
			endif
		endif
		let s:is_open_terminal = 0
	else
		botright split
		call s:OpenTerminalBuffer()
		if !s:terminal_height
			let s:terminal_height = g:terminal_height
		endif
		execute "resize" s:terminal_height
		let s:is_open_terminal = 1
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
