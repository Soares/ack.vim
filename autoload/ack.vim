" Build a regex for the word under the cursor.
" @return {string} The (already quoted) string.
function s:curword()
	return '"\b' . escape(expand('<cword>'), '"') . '\b"'
endfunction

" Preform a search.
" This is an abstraction over :[l]grep[add][!]
" @param {boolean} local Whether to use the location list.
" @param {boolean} add Whether to add to existing results.
" @param {string} flags Flags to add to the args.
" @param {boolean} jump Whether to jump to the first result.
" @param {string} args Args to use with the command.
function! ack#search(local, add, jump, flags, args)
	let l:args = empty(a:args) ? s:curword() : a:args
	let l:args = empty(a:flags) ? l:args : (a:flags.' '.l:args)
	let l:prefix = a:local ? 'l' : ''
	let l:suffix = (a:add ? 'add' : '') . (a:jump ? '' : '!')
	silent execute l:prefix.'grep'.l:suffix.' '.l:args
	let l:handler = a:local ? g:ack_lhandler : g:ack_qhandler
	if !empty(l:handler)
		execute l:handler
	endif
	redraw!
endfunction


" Ack for a file.
" @param {boolean} local Whether to use the location list.
" @param {boolean} add Whether to add to existing results.
" @param {boolean} jump Whether to jump to the first result.
" @param {string} args Args to use with the command.
function! ack#file(local, add, jump, args)
	let l:grepformat = &grepformat
	let &grepformat = '%f'
	try
		call ack#search(a:local, a:add, a:jump, '-g', a:args)
	finally
		let &grepformat = l:grepformat
	endtry
endfunction


" Preform an ack.
" @param {string} bang The command's <bang> in string form.
" @param {string} args The args, potentially containing options.
function! ack#ack(jump, args)
	call ack#search(0, 0, a:jump, '', a:args)
endfunction


" Preform an ack with options.
" @param {string} bang The command's <bang> in string form.
" @param {string} args The args, containing options.
function! ack#vanced(jump, args)
	let l:words = split(a:args, ' ')
	let l:opts = l:words[0]
	let l:args = join(l:words[1:], ' ')
	let l:add = match(l:opts, 'a') > -1
	let l:file = match(l:opts, 'f') > -1
	let l:local = g:ack_ldefault ?
			\ match(l:opts, 'q') == -1 :
			\ match(l:opts, 'l') > -1
	if l:file
		call ack#file(l:local, l:add, a:jump, l:args)
	else
		call ack#search(l:local, l:add, a:jump, '', l:args)
	endif
endfunction
