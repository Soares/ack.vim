" Translates a command's [!] into whether the search jumps to the 1st result.
" @param {string} bang The command's [!] in string form.
" @return {boolean}
" @private
function! s:bang2jump(bang)
	return a:bang ? 1 : 0
endfunction


" Preform a search.
" This is an abstraction over :[l]grep[add][!]
" @param {boolean} loc Whether to use the location list.
" @param {boolean} add Whether to add to existing results.
" @param {string} flags Flags to add to the args.
" @param {boolean} jump Whether to jump to the first result.
" @param {string} args Args to use with the command.
function! ack#search(loc, add, jump, flags, args)
	let l:args = empty(a:args) ? expand('<cword>') : a:args
	let l:args = empty(a:flags) ? l:args : (a:flags.' '.l:args)
	let l:prefix = a:loc ? 'l' : ''
	let l:suffix = (a:add ? 'add' : '') . (a:jump ? '' : '!')
	silent execute l:prefix.'grep'.l:suffix.' '.l:args
	let l:handler = a:loc ? g:ack_lhandler : g:ack_qhandler
	if !empty(l:handler)
		execute l:handler
	endif
	redraw!
endfunction


" Ack for a file.
" @param {boolean} loc Whether to use the location list.
" @param {boolean} add Whether to add to existing results.
" @param {boolean} jump Whether to jump to the first result.
" @param {string} args Args to use with the command.
function! ack#file(loc, add, jump, args)
	let l:format_bak = &grepformat
	let &grepformat = '%f'
	try
		call ack#search(a:loc, a:add, a:jump, '-g', a:args)
	finally
		let &grepformat = l:format_bak
	endtry
endfunction


" Preform an ack.
" @param {string} bang The command's <bang> in string form.
" @param {string} args The args, potentially containing options.
function! ack#ack(bang, args)
	call ack#search(0, 0, s:bang2jump(a:bang), '', a:args)
endfunction


" Preform an ack with options.
" @param {string} bang The command's <bang> in string form.
" @param {string} args The args, containing options.
function! ack#vanced(bang, args)
	let l:words = split(a:args, ' ')
	let l:opts = l:words[0]
	let l:args = join(l:words[1:], ' ')
	let l:add = match(l:opts, 'a') > -1
	let l:file = match(l:opts, 'f') > -1
	let l:jump = s:bang2jump(a:bang)
	let l:loc = g:ack_ldefault ?
			\ match(l:opts, 'q') == -1 :
			\ match(l:opts, 'l') > -1
	if l:file
		call ack#file(l:loc, l:add, l:jump, l:args)
	else
		call ack#search(l:loc, l:add, l:jump, '', l:args)
	endif
endfunction
