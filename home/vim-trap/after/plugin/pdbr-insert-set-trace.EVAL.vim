" USAGE:
"   m4_shim \
"     "+8" "home/vim-trap/plugin/pdbr-insert-set-trace.EVAL.vim" \
"     "home/vim-trap/plugin/pdbr-insert-set-trace.vim"

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" DXY_HEADER_AUTHOR
" DXY_HEADER_PROJECT
" DXY_HEADER_LICENSE

" DEV: Uncomment and <F9> to source/reload.
"  silent! unlet g:plugin_vim_trap_pdbr_drop_set_trace
if exists("g:plugin_vim_trap_pdbr_drop_set_trace") || &cp
  finish
endif
let g:plugin_vim_trap_pdbr_drop_set_trace = 1

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

function! s:Python_Abbrev_PDB_Set_Trace_Right_Hand_Middle_Pointy_Middle_Pointy()
  " Note the `# fmt: skip`, so `black` does not split line into three (import, blank, set_trace).
  " - Note also I tried to combine with `noqa: E702` but failed, so `flake8` will still complain.
  "   - Issue is sorta fixed, but requires `black --preview`, which you don't want to use.
  "     https://github.com/psf/black/pull/3959
  autocmd BufEnter,BufRead *.py iabbrev <buffer> ';';
    \ import pdbr; pdbr.set_trace()  # fmt: skip<CR>pass<C-R>
endfunction

function! s:Python_Main()
  call <SID>Python_Abbrev_PDB_Set_Trace_Right_Hand_Middle_Pointy_Middle_Pointy()
endfunction

call <SID>Python_Main()

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

