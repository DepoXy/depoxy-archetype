" USAGE:
"   m4_shim \
"     "+8" "home/vim-trap/after/plugin/blocklist-syntax-off.EVAL.vim" \
"     "home/vim-trap/after/plugin/blocklist-syntax-off.vim"

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" DXY_HEADER_AUTHOR
" DXY_HEADER_PROJECT
" DXY_HEADER_LICENSE

" -------------------------------------------------------------------

" USYNC:
"   meld ~/.depoxy/ambers/archetype/home/vim-trap/after/plugin/blocklist-syntax-off.EVAL.vim \
"     ~/.depoxy/stints/DXY_DEPOXY_CLIENT_ID/home/vim-trap/after/plugin/blocklist-syntax-off.vim &

" -------------------------------------------------------------------

" GUARD: Press <F9> to reload this plugin (or :source it).
" - Via: https://github.com/embrace-vim/vim-source-reloader#↩️

if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:plugin_vim_trap_blocklist_syntax_off
endif

if exists('g:plugin_vim_trap_blocklist_syntax_off') || &cp

  finish
endif

let g:plugin_vim_trap_blocklist_syntax_off = 1

" -------------------------------------------------------------------

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

