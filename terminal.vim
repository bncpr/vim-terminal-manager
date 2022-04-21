if !hasmapto('<Plug>TerminalToggle')
	map <unique> <space>t <Plug>TerminalToggle
endif
noremap <unique> <script> <Plug>TerminalToggle <SID>Toggle
noremap <SID>Toggle :call <SID>Toggle()<cr>

let g:terminal_height = 12

let s:is_open_terminal = 0
let s:term_name = ""

augroup terminal
	autocmd!
	" autocmd TermOpen * echom bufname()
augroup END

function! s:Toggle()
	if s:is_open_terminal
		let s:term_bufwinid = bufwinid(s:term_name)
		if s:term_bufwinid != -1
			let s:term_bufwinnr = win_id2win(s:term_bufwinid)
			if s:term_bufwinnr
				execute s:term_bufwinnr "wincmd c"
			endif
		endif
		let s:is_open_terminal = 0
	else
		botright split
		execute "resize" g:terminal_height
		if s:term_name == ""
			term
			setlocal bufhidden=hide
			let s:term_name = bufname()
			" echom s:term_name
		else
			execute "buffer" s:term_name
		endif
		let s:is_open_terminal = 1
	endif
endfunction
