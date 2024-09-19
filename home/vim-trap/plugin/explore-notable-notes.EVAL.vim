" USAGE:
"   m4_shim \
"     "+8" "home/vim-trap/plugin/explore-notable-notes.EVAL.vim" \
"     "home/vim-trap/plugin/explore-notable-notes.vim"

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" DXY_HEADER_AUTHOR
" DXY_HEADER_PROJECT
" DXY_HEADER_LICENSE

" ***

" From Original (with all the comment-fixins) at / and/or SYNC_ME:
" meld ~/.vim/pack/landonb/start/landonbs_privates/plugin/explore-notable-notes.vim \
"      ~/.depoxy/running/home/vim-trap/plugin/explore-notable-notes.vim

" ***

" DEV: Uncomment and <F9> to source/reload.
"  silent! unlet g:loaded_vim_trap_explore_notable_notes

if exists("g:loaded_vim_trap_explore_notable_notes") || &cp
  finish
endif
let g:loaded_vim_trap_explore_notable_notes = 1

" ***

" 2020-03-19: Idea with 'Numbered' Notes:
" - Open netrw browser
" - Look at file you want to open, and
"     Input the number indicated
"   Hit the down arrow
"   Press Enter
" - E.g., ``\p4↓<CR>`` is 5 keystrokes to open a popular notes file.
"   - Goal is to be faster and more predictable than `fzf`,
"     but not quite as fast as system-wide binding (e.g., DepoXy's
"     <Cmd-u> that opens emoji-lookup from anywhere).

function! s:mappings_explore_docs_clear()
  silent! unmap <Leader>p
  silent! iunmap <Leader>p

  silent! unmap <Leader>P
  silent! iunmap <Leader>P
endfunction

function! s:mappings_explore_docs_setup()
  call <SID>mappings_explore_docs_clear()

  " NOTE/2020-07-13: (lb): If there's a '$' in the filename, :Explore appears to
  " substitute 'hBc'. The netrw docs says it uses shellescape() and fnameescape(),
  " but I nonetheless have issues with the character. The netrw docs also say this:
  " “Still, my advice is, if the 'filename' looks like a vim command that you aren't
  "  comfortable with having executed, don't open it.” Albeit that's under a section
  " on Network-Oriented File Transfer (netrw-xfer), i.e., ftp. But I think the comment
  " 'still' applies to all commands.

  " Note that netrw whines on Enter when used from insert mode:
  "   'E21: Cannot make changes, 'modifiable' is off.'
  " So we have to use <ESC> in the inoremap below, not <C-O>.
  " - E.g., this causes an issue:
  "     inoremap <silent> <Leader>p
  "       <C-O>:Explore DXY_DEPOXY_CLIENT_TILDE/docs/notable-notes--vibrant<CR>

  noremap <silent> <unique> <Leader>p
    \ :Explore DXY_DEPOXY_CLIENT_TILDE/docs/notable-notes--vibrant<CR>
  inoremap <silent> <unique> <Leader>p
    \ <ESC>:Explore DXY_DEPOXY_CLIENT_TILDE/docs/notable-notes--vibrant<CR>

  noremap <silent> <unique> <Leader>P
    \ :Explore DXY_DEPOXY_CLIENT_TILDE/docs/notable-notes--woodlot<CR>
  inoremap <silent> <unique> <Leader>P
    \ <ESC>:Explore DXY_DEPOXY_CLIENT_TILDE/docs/notable-notes--woodlot<CR>

endfunction

" This is only enabled when running on the DepoXy Client, so that
" one can wire their DXC/home/vim-trap plugin on the @leader host.
if hostname() == 'DXY_DEPOXY_HOSTNAME'
  call <SID>mappings_explore_docs_setup()
endif

