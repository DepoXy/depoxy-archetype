" USAGE:
"   m4_shim \
"     "+8" "home/vim-trap/after/plugin/blocklist-nospell.EVAL.vim" \
"     "home/vim-trap/after/plugin/blocklist-nospell.vim"

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" DXY_HEADER_AUTHOR
" DXY_HEADER_PROJECT
" DXY_HEADER_LICENSE

" -------------------------------------------------------------------

" USYNC:
"   meld ~/.depoxy/ambers/archetype/home/vim-trap/after/plugin/blocklist-nospell.EVAL.vim \
"     ~/.depoxy/stints/DXY_DEPOXY_CLIENT_ID/home/vim-trap/after/plugin/blocklist-nospell.vim &

" -------------------------------------------------------------------

" GUARD: Press <F9> to reload this plugin (or :source it).
" - Via: https://github.com/embrace-vim/vim-source-reloader#↩️

if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:plugin_vim_trap_blocklist_nospell
endif

if exists('g:plugin_vim_trap_blocklist_nospell') || &cp

  finish
endif

let g:plugin_vim_trap_blocklist_nospell = 1

" -------------------------------------------------------------------

" Disable spell checking Python comments.
"
" CXREF:
"   /Applications/MacVim.app/Contents/Resources/vim/runtime/syntax/python.vim
"   ~/.kit/nvim/landonb/dubs_ftype_mess/after/syntax/python.vim
" - REFER: Default value has different contains:  contains=pythonTodo,@Spell
au FileType python syn match pythonComment "#.*$" contains=pythonTodo

