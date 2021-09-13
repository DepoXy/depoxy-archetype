" USAGE:
"   m4_shim \
"     "+8" "home/vim-trap/plugin/blocklist-syntax-off.EVAL.vim" \
"     "home/vim-trap/plugin/blocklist-syntax-off.vim"

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" DXY_HEADER_AUTHOR
" DXY_HEADER_PROJECT
" DXY_HEADER_LICENSE

" DEV: Uncomment and <F9> to source/reload.
"  silent! unlet g:plugin_vim_trap_blocklist_syntax_off
if exists("g:plugin_vim_trap_blocklist_syntax_off") || &cp
  finish
endif
let g:plugin_vim_trap_blocklist_syntax_off = 1

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" USAGE: If you want to ignore syntax for specific files, try something like this:
"
"  au BufNewFile,BufRead * if expand('<afile>:p') ==# '/Users/user/path/to/some.file'
"    \ | setlocal syntax=off | endif
"
" OR: if you want to ignore syntax for certain file extenstions, try some like this:
"
"  au BufNewFile,BufRead * if expand('<afile>:e') !=? 'inc' | syntax enable | endif
"
" REFER: https://stackoverflow.com/questions/27440400
"         /disable-syntax-highlighting-for-certain-filenames

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

