" USAGE:
"   m4_shim \
"     "+8" "home/vim-trap/after/plugin/blocklist-nospell.EVAL.vim" \
"     "home/vim-trap/after/plugin/blocklist-nospell.vim"

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" DXY_HEADER_AUTHOR
" DXY_HEADER_PROJECT
" DXY_HEADER_LICENSE

" DEV: Uncomment and <F9> to source/reload.
"  silent! unlet g:plugin_vim_trap_blocklist_nospell
if exists("g:plugin_vim_trap_blocklist_nospell") || &cp
  finish
endif
let g:plugin_vim_trap_blocklist_nospell = 1

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" Disable spell checking Python comments.
"
" CXREF:
"   /Applications/MacVim.app/Contents/Resources/vim/runtime/syntax/python.vim
"   ~/.vim/pack/landonb/start/dubs_ftype_mess/after/syntax/python.vim
" DEFAULT: au FileType python syn match pythonComment "#.*$" contains=pythonTodo,@Spell
au FileType python syn match pythonComment "#.*$" contains=pythonTodo

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

