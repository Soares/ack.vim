" ack.vim: Grep better.
"
" Author:	   Nate Soares <http://so8r.es>
" Version:	  1.0
" License:	  The same as vim itself. (See |license|)

if exists('g:loaded_ack') || &cp || v:version < 700
	finish
endif
let g:loaded_ack = 1


if !exists('g:ack_program')
	let g:ack_program = "ack -H --nocolor --nogroup --column"
endif

if g:ack_program != ''
	let &grepprg=g:ack_program
endif

if !exists('g:ack_qhandler')
	let g:ack_qhandler = 'botright copen'
endif

if !exists('g:ack_lhandler')
	let g:ack_lhandler = 'botright lopen'
endif


function! s:AckFile(cmd, bang, args)
	let l:format_bak = &grepformat
	let &grepformat = '%f'
	try
		call s:Ack(a:cmd, a:bang, '-g', a:args)
	finally
		let &grepformat = l:format_bak
	endtry
endfunction


function! s:Ack(cmd, bang, flags, args)
	" If no pattern is provided, search for the word under the cursor
	let l:args = empty(a:args) ? expand('<cword>') : a:args

	" Jump to the file only if they give the bang.
	let l:cmd = a:cmd . (a:bang == '!' ? '' : '!')
	if a:flags != '' |
		let l:cmd = l:cmd.' '.a:flags
	endif

	silent execute l:cmd.' '.l:args

	let l:handler = a:cmd =~# '^l' ? g:ack_lhandler : g:ack_qhandler
	if l:handler != ''
		exe l:handler
	endif

	redraw!
endfunction

command! -bang -nargs=* -complete=file Ack
		\ call s:Ack('grep', '<bang>', '', <q-args>)
command! -bang -nargs=* -complete=file AckAdd
		\ call s:Ack('grepadd', '<bang>', '', <q-args>)
command! -bang -nargs=* -complete=file LAck
		\ call s:Ack('lgrep', '<bang>', '', <q-args>)
command! -bang -nargs=* -complete=file LAckAdd
		\ call s:Ack('lgrepadd', '<bang>', '', <q-args>)
command! -bang -nargs=* -complete=file AckFile
		\ call s:AckFile('grep', '<bang>', <q-args>)
