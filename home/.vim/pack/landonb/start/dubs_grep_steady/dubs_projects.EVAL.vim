" USAGE:
"   m4_shim \
"     "+6" "home/.vim/pack/landonb/start/dubs_grep_steady/dubs_projects.EVAL.vim" \
"     "home/.vim/pack/landonb/start/dubs_grep_steady/dubs_projects.vim"

" ====================================================================
" vim:tw=0:ts=2:sw=2:et:norl
" DXY_HEADER_AUTHOR
" DXY_HEADER_PROJECT
" DXY_HEADER_LICENSE
" Summary: This is a user-customizable file loaded by Dubs Grep Steady.
" Helpful: :GrepSteadyReload / :h dubs-grep-steady / See also hints below.

let g:ds_simple_grep_locat_lookup = [
  \ "Search in:",
  \
  \ "[Enter 1 to Cancel]",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "~/DXY_DEPOXY_PROJLNS_NAME/depoxy-deeplinks ",
  \ "",
  \ "",
  \ "",
  \ "~/DXY_DEPOXY_PROJLNS_NAME/docs-and-backlog ",
  \ "",
  \ "",
  \ " ",
  \ "~/DXY_DEPOXYDIR_BASE_NAME/DXY_DEPOXYAMBERS_NAME ",
  \ "~/DXY_HOMEFRIES_DIR_NAME ",
  \ "~/.vim/pack/PERSONAL_CVS_VIM_PLUG_PACKAGE_NAME ",
  \ "",
  \ "~/BUSINESS_CODE_PATH/division1 ",
  \ "",
  \ "~/BUSINESS_CODE_PATH/division1/project-AA ",
  \ "~/BUSINESS_CODE_PATH/projectZ/superflycool ",
  \ "~/BUSINESS_CODE_PATH/projectZ/project-123-testless ",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "─────────────────────────────────────────────────────────────"
  \]

" ====================================================================
" USAGE: Modify the list above to customize the grep project paths prompt.
"      - The ~/BUSINESS_CODE_PATH paths above are examples.
"      - The other default paths above are wired to real paths.
"      - The lines above are +10 offset from how they're numbered by
"        the `inputlist` command (:h inputlist).
" USAGE: Run :GrepSteadyReload (or restart Vim) after you modify the list.
" ====================================================================

" *********************************************************************** "

" SOME HINTS BELOW
"
" Above is the list of directories you'll see when performing a search
" using the <Leader>g or <F4> commands.
"
"   See :h dubs-grep-steady

" TO CUSTOMIZE THE LIST:
"
" Add your own paths and reorder the list however you'd like.
"
" Note: The file line numbers of the list above are 10 more than the
" number that you'd type to choose that entry (path) when you search.
" (E.g., the 'press 1 to cancel' hint is on line 11 of this file.)
"
" Note: If the list is too tall for your Vim window, you'll have to hit
" Space to scroll it. So you'll probably want to limit the number of
" projects to around ~40, so you can avoid scrolling if your Gvim window
" is reasonably sized (i.e., not too short).
"
" Hint: You can specify multiple paths in one entry by separating paths
" with a space, e.g.,
"
"   \ ""
"   \   . $HOME . "/DXY_DEPOXYDIR_BASE_NAME "
"   \   . $HOME . "/DXY_HOMEFRIES_DIR_NAME "
"   \   . $HOME . "/.vim/pack/PERSONAL_CVS_VIM_PLUG_PACKAGE_NAME ",
"
" Hint: You can run embedded commands to help build the list, e.g.,
"
"   \ "`echo " . $HOME . "/DXY_HOMEFRIES_DIR_NAME/.bashrc-bin/bash*`",

" *********************************************************************** "

