" USAGE:
"   m4_shim \
"     "+8" "home/vim-trap/after/plugin/pdbr-insert-set-trace.EVAL.vim" \
"     "home/vim-trap/after/plugin/pdbr-insert-set-trace.vim"

" -------------------------------------------------------------------

" USYNC:
"   meld ~/.depoxy/ambers/archetype/home/vim-trap/after/plugin/pdbr-insert-set-trace.EVAL.vim \
"     ~/.depoxy/stints/DXY_DEPOXY_CLIENT_ID/home/vim-trap/after/plugin/pdbr-insert-set-trace.vim &

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" DXY_HEADER_AUTHOR
" DXY_HEADER_PROJECT
" DXY_HEADER_LICENSE

" -------------------------------------------------------------------

" GUARD: Press <F9> to reload this plugin (or :source it).
" - Via: https://github.com/embrace-vim/vim-source-reloader#↩️

if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:plugin_vim_trap_pdbr_drop_set_trace
endif

if exists('g:plugin_vim_trap_pdbr_drop_set_trace') || &cp

  finish
endif

let g:plugin_vim_trap_pdbr_drop_set_trace = 1

" -------------------------------------------------------------------

" Note the `# fmt: skip`, so `black` does not split line into three (import, blank, set_trace).
" - Note also I tried to combine with `noqa: E702` but failed, so `flake8` will still complain.
function! s:Python_Abbrev_PDB_Set_Trace_Right_Hand_Middle_Pointy_Middle_Pointy()
  " HSTRY/2023-01-27: Would previously move cursor to
  " start of inserted text, i.e., before the "import":
  "   autocmd BufEnter,BufRead *.py iabbrev <buffer> ';';
  "     \ import pdbr; pdbr.set_trace()  # fmt: skip<C-o>41<Left><C-R>
  " - But I often type 'pass' below a set_trace (so if comes as
  "   the last line of a function, you don't end up stopped on
  "   the return call).
  "   - I usually follow ';'; with Alt-right<CR>pass
  " SAVVY/2023-12-20: Note `black` ignores `# fmt: skip` unless it's
  " the sole comment.
  " - So cannot add `noqa: E702` to tell flake8 to not gripe, e.g.,
  "     E702 multiple statements on one line (semicolon)
  " - Issue is sorta fixed, but requires `black --preview`, which you
  "   don't want to use.
  "     https://github.com/psf/black/pull/3959
  "   - SPIKE/2025-10-06: Test if the black issue fixed.
  autocmd BufEnter,BufRead *.py iabbrev <buffer> ';';
    \ import pdbr; pdbr.set_trace()  # fmt: skip<CR>pass<C-R>
endfunction

function! s:Python_Main()
  call <SID>Python_Abbrev_PDB_Set_Trace_Right_Hand_Middle_Pointy_Middle_Pointy()
endfunction

call <SID>Python_Main()

