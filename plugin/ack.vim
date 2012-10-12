" ack.vim: Grep better.
"
" Author:	   Nate Soares <http://so8r.es>
" Version:	  1.0
" License:	  The same as vim itself. (See |license|)

if exists('g:loaded_ack') || &cp || v:version < 700
	finish
endif
let g:loaded_ack = 1


" Whether or not to clobber &grepprg. May also be a string, in which case it
" will be used as the new grep command.
if !exists('g:ack_clobber_grep')
	let g:ack_clobber_grep = 1
endif


" What to do when ack finishes dumping results into the quickfix list.
if !exists('g:ack_qhandler')
	let g:ack_qhandler = 'botright copen'
endif


" What to do when ack finishes dumping results into the location list.
if !exists('g:ack_lhandler')
	let g:ack_lhandler = 'botright lopen'
endif


" Whether to use the location list by default.
if !exists('g:ack_ldefault')
	let g:ack_ldefault = 0
endif


" Whether to automatically make key mappings.
if !exists('g:ack_automap')
	let g:ack_automap = 0
endif


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
