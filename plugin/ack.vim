if exists('g:loaded_ack')
	finish
endif
let g:loaded_ack = 1


if !exists('g:ack_clobber_grep')
	let g:ack_clobber_grep = 1
endif

if !exists('g:ack_qhandler')
	let g:ack_qhandler = 'botright copen'
endif

if !exists('g:ack_lhandler')
	let g:ack_lhandler = 'botright lopen'
endif

if !exists('g:ack_ldefault')
	let g:ack_ldefault = 0
endif

if !exists('g:ack_enable_mappings')
	let g:ack_enable_mappings = 0
endif


if type(g:ack_clobber_grep) == type('')
	let &grepprg = g:ack_clobber_grep
elseif g:ack_clobber_grep
	let &grepprg = 'ack -H --nocolor --nogroup --column'
endif


command! -bang -nargs=* -complete=file Ack
		\ call ack#ack('<bang>', <q-args>)
command! -bang -nargs=* -complete=file Ackvanced
		\ call ack#vanced('<bang>', <q-args>)


if !empty(g:ack_enable_mappings)
	if type(g:ack_enable_mappings) == type('')
		let s:leader = g:ack_enable_mappings
	else
		let s:leader = 'a'
	endif

	exe 'noremap <leader>'.tolower(s:leader).'k :Ack '
	exe 'noremap <leader>'.toupper(s:leader).'a :Ackvanced a '
	exe 'noremap <leader>'.toupper(s:leader).'s :Ack <C-R><C-/>'
	exe 'noremap <leader>'.toupper(s:leader).'f :Ackvanced f '
endif
