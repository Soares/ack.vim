# ack.vim
## Acknowledge the superiority

Vim gives you some nifty commands to search for files. Almost nifty enough.

Perhaps you prefer [ack](http://betterthangrep.com/) to grep.

Maybe you'd like to use [CtrlP](https://github.com/kien/ctrlp.vim) to browse the
results instead of blindly jumping to the first one.

It might be you want to automatically search for the word under the cursor.

If any of these sound good to you, it's time to acknowledge that this plugin
might rock your world.

# Usage

To search for the word under the cursor:
	:Ack

That's it.

Of course, you can `:Ack search_terms` to search something else and `:Ack! "I'm
feeling lucky"` to auto-jump to the results.

Or you can `let g:ack_qhandler = 'CtrlPQuickfix'` to use CtrlP.

There's much more for the ackvanced users. See for yourself! Install and
type `:help Ackvanced`.
