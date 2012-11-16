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

if !exists('g:ack_automap')
	let g:ack_automap = 0
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


if !empty(g:ack_automap)
	if type(g:ack_automap) == type(1)
		let g:ack_automap = 'a'
	endif

	exe 'noremap <leader>'.tolower(g:ack_automap).'a :Ack '
	exe 'noremap <leader>'.toupper(g:ack_aptomap).'d :Ackvanced a '
	exe 'noremap <leader>'.toupper(g:ack_aptomap).'f :Ackvanced f '
	exe 'noremap <leader>'.tolower(g:ack_aptomap).'k :Ack<CR>'
	exe 'noremap <leader>'.toupper(g:ack_aptomap).'s :Ackvanced w <C-R>/'
	exe 'noremap <leader>'.toupper(g:ack_aptomap).'w :Ackvanced w '
endif
