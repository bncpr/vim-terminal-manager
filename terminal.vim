noremap <space>t :call <SID>TerminalToggle()<CR>

let g:is_open_terminal = 0
let g:terminal_bufnr = 0

function! s:TerminalToggle()
	if g:is_open_terminal
		let g:is_open_terminal = 0
		silent hide
	else
		botright split
		resize 12
		if g:terminal_bufnr == 0
			term
			let g:terminal_bufnr = bufnr()
		else
			execute "buffer" . g:terminal_bufnr
		endif
		let g:is_open_terminal = 1
	endif
endfunction
