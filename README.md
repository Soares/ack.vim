# ack.vim #

This plugin is a front for the Perl module
[App::Ack](http://search.cpan.org/~petdance/ack/ack).  Ack can be used as
a replacement for 99% of the uses of _grep_.  This plugin will allow you to run
ack from vim, and shows the results in a split window.

The *Official Version* of this plugin is available at
[vim.org](http://www.vim.org/scripts/script.php?script_id=2572).

## Differences ##

- CtrlP Quickfix mode integrated. Quickfix mode bindings were removed, CtrlP
  & various other plugins do quickfix navigation better and more consistently.
- Sets your grepprg to ack globally. You can always change it back.
  temporarily, but we now assume that you actually want your `grepprg` to be ack.
- Do not automatically jump the cursor to the first result. (You can get the old
  behavior back with `:Ack!`.)
- `:AckFromSearch` removed. The conversion of vim to perl regexes was incomplete.
  Besides, you can already `:Ack <C-R>/` to ack from search and it's actually
  less keystrokes than the old command.

(In case you didn't know, `<C-R>` in command mode allows you to paste from
a register. See `:help c_^R`.)

#### Minor Differences:
- g:ackhighlight has been removed. It doesn't play nice with alternative
  quickfix searchers such as CtrlPQuickfix.
- Move functions into `autoload/` directory to reduce vim start time.
- The Rakefile has been removed. It doesn't correctly use XDG_CONFIG_HOME to
  detect your vim directory. Either copy the files in by hand or use one of the
  plethora of vim plugin managers.

## Usage ##

    :Ack [options] {pattern} [{directory}]

Search recursively in {directory} (which defaults to the current directory) for
the {pattern}.

By default the quickfix window will be opened when searching is done, though you
can override this with `g:ack_qhandler`. We recommend `:CtrlPQuickfix`, but you
can use any handler of your choice.

If you want more options that mirror :grepadd, :lgrep, etc. check out the
`:Ackvanced` function (`:help :Ackvanced`).
