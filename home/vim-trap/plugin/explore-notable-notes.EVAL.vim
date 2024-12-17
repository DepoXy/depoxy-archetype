" USAGE:
"   m4_shim \
"     "+8" "home/vim-trap/plugin/explore-notable-notes.EVAL.vim" \
"     "home/vim-trap/plugin/explore-notable-notes.vim"

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" DXY_HEADER_AUTHOR
" DXY_HEADER_PROJECT
" DXY_HEADER_LICENSE

" -------------------------------------------------------------------

" USYNC:
"
" meld ~/.depoxy/ambers/archetype/home/vim-trap/plugin/explore-notable-notes.EVAL.vim \
"   ~/.depoxy/running/home/vim-trap/plugin/explore-notable-notes.vim &

" -------------------------------------------------------------------

" USAGE: Unlet var (or nix finish) & press <F9> to reload this plugin.
" USING: https://github.com/landonb/vim-source-reloader#↩️
"
"  silent! unlet g:loaded_vim_trap_explore_notable_notes

if exists('g:loaded_vim_trap_explore_notable_notes') || &cp || v:version < 700

  finish
endif

let g:loaded_vim_trap_explore_notable_notes = 1

" -------------------------------------------------------------------

" This is only enabled when running on the DepoXy Client, so that
" one can wire their DXC/home/vim-trap plugin on the @leader host
" but not pickup these bindings thereon.

let s:notable_notes_mappings = []

if hostname() == 'DXY_DEPOXY_HOSTNAME'
  let s:notable_notes_mappings = [
    \   ["<Leader>p", "DXY_DEPOXY_CLIENT_TILDE/docs/notable-notes--vibrant"],
    \   ["<Leader>P", "DXY_DEPOXY_CLIENT_TILDE/docs/notable-notes--woodlot"],
    \ ]
endif

" CXREF:
" ~/.vim/pack/embrace-vim/start/vim-netrw-map/autoload/embrace/explore.vim

if !empty(s:notable_notes_mappings)
  call g:embrace#explore#CreateMapsAndSetupNetrw(s:notable_notes_mappings)
endif

