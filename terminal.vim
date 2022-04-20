noremap <space>t :call <SID>TerminalToggle()<CR>

let g:terminal_height = 12

let s:is_open_terminal = 0
let s:terminal_bufnr = 0

function! s:TerminalToggle()
	if s:is_open_terminal
		let s:is_open_terminal = 0
		" TODO: check if buffer is open
		silent hide
	else
		botright split
		execute "resize" g:terminal_height
		if s:terminal_bufnr == 0
			term
			let s:terminal_bufnr = bufnr()
		else
			execute "buffer" s:terminal_bufnr
		endif
		let s:is_open_terminal = 1
	endif
endfunction
