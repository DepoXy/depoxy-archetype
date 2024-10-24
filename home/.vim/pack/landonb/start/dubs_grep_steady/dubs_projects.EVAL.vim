" USAGE:
"   m4_shim \
"     "+11" "home/.vim/pack/landonb/start/dubs_grep_steady/dubs_projects.EVAL.vim" \
"     "home/.vim/pack/landonb/start/dubs_grep_steady/dubs_projects.vim"

# (Filler so line numbers align with lookup indices.)
#

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" vim:tw=0:ts=2:sw=2:et:norl
" DXY_HEADER_AUTHOR
" DXY_HEADER_PROJECT
" DXY_HEADER_LICENSE
" Summary: This is a user-customizable file loaded by Dubs Grep Steady
" Helpful: :GrepSteadyReload / \dp / :h dubs-grep-steady / More hints below

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
  \ "DXY_DEPOXY_PROJLNS_DIR_TILDE/depoxy-deeplinks ",
  \ "",
  \ "",
  \ "",
  \ "DXY_DEPOXY_PROJLNS_DIR_TILDE/docs-and-backlog ",
  \ "",
  \ "",
  \ " ",
  \ "DXY_DEPOXYAMBERS_DIR_TILDE ",
  \ "DXY_HOMEFRIES_DIR_TILDE ",
  \ "~/.vim/pack/DXY_DEPOXY_CVS_ALIAS_VIM_PLUG_ORG ",
  \ "",
  \ "DXY_VENDOR_HOME_TILDE ",
  \ "DXY_VENDOR_HOME_TILDE/DXY_VENDOR_ORG01_NAME ",
  \ "DXY_VENDOR_HOME_TILDE/DXY_VENDOR_ORG02_NAME ",
  \ "DXY_VENDOR_HOME_TILDE/DXY_VENDOR_ORG01_NAME/DXY_VENDOR_ORG01_PROJ01_NAME ",
  \ "DXY_VENDOR_HOME_TILDE/DXY_VENDOR_ORG02_NAME/DXY_VENDOR_ORG02_PROJ01_NAME ",
  \ "DXY_VENDOR_HOME_TILDE/DXY_VENDOR_ORG02_NAME/DXY_VENDOR_ORG02_PROJ02_NAME ",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "",
  \ "DXY_VENDOR_HOME_TILDE/DXY_VENDOR_ORG01_NAME/ignore-tests--[[[]]]DXY_VENDOR_ORG01_PROJ01_NAME ",
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
"      - The DXY_VENDOR_HOME_TILDE paths above are examples.
"      - The other default paths above are wired to real paths.
"      - The lines above are +10 offset from how they're numbered by
"        the `inputlist` command (:h inputlist).
" USAGE: Run :GrepSteadyReload (or \dp, or restart Vim) after editing above.
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
"   \   . $HOME . "/.vim/pack/DXY_DEPOXY_CVS_ALIAS_VIM_PLUG_ORG ",
"
" Hint: You can run embedded commands to help build the list, e.g.,
"
"   \ "`echo " . $HOME . "/DXY_HOMEFRIES_DIR_NAME/.bashrc-bin/bash*`",

" *********************************************************************** "

