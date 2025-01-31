" USAGE:
"   m4_shim \
"     "+11" "home/.kit/nvim/landonb/start/dubs_grep_steady/dubs_projects.EVAL.vim" \
"     "home/.kit/nvim/landonb/start/dubs_grep_steady/dubs_projects.vim"

" (Filler so line numbers align with lookup indices.)
"

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" vim:tw=0:ts=2:sw=2:et:norl
" DXY_HEADER_AUTHOR
" DXY_HEADER_PROJECT
" DXY_HEADER_LICENSE
" Summary: This is a user-customizable file loaded by Dubs Grep Steady
" Helpful: :GrepSteadyReload / \dp / :h dubs-grep-steady / See USAGE below

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
  \ "~/.kit/nvim/DXY_DEPOXY_CVS_ALIAS_VIM_PLUG_ORG ",
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

" *********************************************************************** "

" USAGE: Modify the list above to customize the grep project paths prompt.
"
"        REFER: https://github.com/landonb/dubs_grep_steady#🧐
"
"      - The ~/work paths above are examples.
"
"      - The other default paths above are wired to real paths.
"
"      - The lines above are +10 offset from how they're numbered by
"        the `inputlist` command (:h inputlist) so you can easily
"        align which path with which numberic input.
"
" NTHEN: After editing the list, you can either run
"
"          :GrepSteadyReload (or \dp)
"
"        or restart Vim.
"
" USAGE: Use <Leader>g and various <F4> commands to search your files.
"
"      - See :h dubs-grep-steady
"
" HINTS: Add your own paths and reorder the list however you'd like.
"
"  Note: The file line numbers of the list above are 10 more than the
" number that you'd type to choose that entry (path) when you search.
" (E.g., the 'press 1 to cancel' hint is on line 11 of this file.)
"
"  Note: If the list is too tall for your Vim window, you may have to
" hit on Space to scroll it. So you may want to limit the list length
" to ~40 projects (depending on your screen), to keep it from paging.
"
"  Hint: To specify multiple paths in one entry, separate each path
" with a space, e.g.,
"
"     \ ""
"     \   . $HOME . "/DXY_DEPOXYDIR_BASE_NAME "
"     \   . $HOME . "/DXY_HOMEFRIES_DIR_NAME "
"     \   . $HOME . "/.kit/nvim/DXY_DEPOXY_CVS_ALIAS_VIM_PLUG_ORG ",
"
"  Hint: You can run embedded commands to help build the list, e.g.,
"
"     \ "`echo " . $HOME . "/DXY_HOMEFRIES_DIR_NAME/.bashrc-bin/bash*`",

" *********************************************************************** "

" CXREF: DEPOXY_PROJLNS="${DEPOXY_PROJLNS:-${HOME}/.projlns}"
"   ~/.depoxy/ambers/home/.projlns/infuse-projlns-*.sh
"     ~/.depoxy/ambers/home/.projlns/infuse-projlns-core.sh
"     etc.
"
" USYNC:
"   meld \
"     ~/.depoxy/ambers/archetype/home/.kit/nvim/landonb/start/dubs_grep_steady/dubs_projects.EVAL.vim \
"     ~/.depoxy/running/home/.kit/nvim/landonb/start/dubs_grep_steady/dubs_projects.vim &

" *********************************************************************** "

