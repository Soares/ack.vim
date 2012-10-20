if exists('g:loaded_ack') || &cp || v:version < 700
	finish
endif
let g:loaded_ack = 1


" g:ack_ack_clobber_grep: Whether or not to clobber &grepprg. May be a string,
"		in which case it is used as the new grep command.
" g:ack_qhandler: What to do after ack dumps results in the quickfix list.
" g:ack_lhandler: What to do after ack dumps results in the location list.
" g:ack_ldefault: Whether to use the location list by default.
" g:ack_automap:  Whether or not to define the default ack mappings.
call hume#0#def('ack', {
		\ 'clobber_grep': 1,
		\ 'qhandler': 'botright copen',
		\ 'lhandler': 'botright lopen',
		\ 'ldefault': 0,
		\ 'automap': 0,
		\ })


command! -bang -nargs=* -complete=file Ack
		\ call ack#ack('<bang>', <q-args>)

command! -bang -nargs=* -complete=file Ackvanced
		\ call ack#vanced('<bang>', <q-args>)


if type(g:ack_clobber_grep) == type('')
	let &grepprg = g:ack_clobber_grep
elseif g:ack_clobber_grep
	let &grepprg = 'ack -H --nocolor --nogroup --column'
endif


if g:ack_automap
	noremap <leader>a  :Ack 
	noremap <leader>Aa :Ackvanced a 
	noremap <leader>Aw :Ack <C-R><C-W> 
	noremap <leader>Af :Ackvanced f 
endif
