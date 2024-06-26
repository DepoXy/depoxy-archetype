# USAGE:
#   m4_shim \
#     "+15" "home/bashrx.private.HOSTNAME.EVAL.sh" \
#     "home/bashrx.private.${DXY_HOSTNAME}.sh"

# ALTLY: Homefries would autoload file w/ username instead.
# - E.g., this would also wire into Homefries:
#
#   m4_shim \
#     "+15" "home/bashrx.private.USERNAME.EVAL.sh" \
#     "home/bashrx.private.${DXY_USERNAME}.sh"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# vim:tw=0:ts=2:sw=2:et:norl:ft=bash
# DXY_HEADER_AUTHOR
# DXY_HEADER_PROJECT
# DXY_HEADER_LICENSE

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

# SAVVY: This file is loaded on terminal startup.
#
#        - It's symlinked under ~/.kit/sh/home-fries/.bashrc-bin
#          so that Homefries loads it.
#
#        - CXREF: See the `symlink_overlay_file` infuse task
#                 which creates the symlink:
#
#            DXY_DEPOXY_CLIENT_TILDE/.mrconfigs/_mrconfig
#
# SAVVY: This file must be named with $(hostname) or $LOGNAME
#        for Homefries to automatically load it.
#
# SAVVY: This file is sourced twice, once before the Home Fries and
#        DepoXy Ambers Bashrc is sourced (with HOME_FRIES_PRELOAD=true)
#        and again after HF and DXA is sourced (HOME_FRIES_PRELOAD=false).
#
#        This script doesn't (currently) need to change any environs to
#        affect HF or DXA loading, so it returns immediately on the first
#        sourcing and waits to load until the second sourcing so that HF
#        and DXA utils are loaded.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ----------------------------------------------------------------- #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# Changes Directories to your Work directory [cdw].
# ↑       ↑                   ↑
#
# - I.e., where you keep @biz-specific projects.
#
# - Obviously, this location is highly subjective.
#   - You can set this when generating a DepoXy Client
#     using the [[[DXY_VENDOR_HOME]]] environ.
#   - It defaults to '~/work', but author sometimes
#     customizes it to be @biz-specific, e.g.,
#     '~/acme', or '~/fbi/'.

bashdx_wire_aliases_pushd_paths_cdw () {
  # CXREF: This path is set by deploy-archetype.sh per [[[DXY_VENDOR_HOME]]]
  local client_dir="${VENDOR_HOME:-DXY_VENDOR_HOME__HOME_}"

  if [ -d "${client_dir}" ]; then
    # CXREF: ~/.kit/sh/home-fries/lib/path_util.sh
    pushd_alias_or_warn "cdw" "${client_dir}"
  elif ! type "cdw" > /dev/null 2>&1; then
    # YOU: Feel free to remove this else block. Or not.
    eval "function cdw {
      error 'The \`cdw\` command is not configured. Please customize it.'
      error \"- Edit the function “${FUNCNAME[0]}” from the file:\"
      error
      error \"    \$(realpath -- \"\${BASH_SOURCE[0]}\")\"
    }"
  fi
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# Opens the enterprise issue-tracker or project management web site.
#
# Similar to the _work_env_* mechanism (and `app-test` and `app-stage`)
# it remains to be seen how useful this function is. You might just find
# it quicker to add a shortcut to your browser bar.

# MAYBE/2021-08-23: I feel like `issues` makes more sense as the
# command name, but `bugs` seems quicker to type, and livelier.

bashdx_wire_aliases_open_tracker () {
  local bugs_alias="bugs"

  if ! type "${bugs_alias}" > /dev/null 2>&1; then
    eval "alias ${bugs_alias}='sensible-open \
      \"\${VENDOR_ISSUE_TRACKER_URL}\"'"
  else
    >&2 echo "WARNING: Cannot alias: “${bugs_alias}” already assigned"
  fi
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ----------------------------------------------------------------- #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# USAGE: Customize this to (help) configure PS1.
# - Defaults to showing the DepoXy Client ID e.g.,
#     DXY_USERNAME@DXC[[[]]]DXY_DEPOXY_CLIENT_ID[[[]]]:~ 🍄 $
# - Disable this to show the machine name in the prompt, e.g.,
#     DXY_USERNAME@DXY_HOSTNAME:~ 🍄 $
# - Or set HOMEFRIES_TERM_UTIL_PS1 to your own PS1 prompt (which
#   you'd want to do when ${HOME_FRIES_PRELOAD} is true so that
#   Homefries uses it; or just set your own PS1 here).

bashdx_customize_depoxy_client_PS1 () {
  # CXREF: ~/.kit/sh/home-fries/lib/term/set-shell-prompt-and-window-title.sh
  . "${HOMEFRIES_LIB:-${HOME}/.kit/sh/home-fries/lib}/term/set-shell-prompt-and-window-title.sh"

  HOMEFRIES_TERM_UTIL_PS1_HOST="DXC${DEPOXY_CLIENT_ID}" \
    _hf_set_terminal_prompt
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ----------------------------------------------------------------- #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

bashdx_alias_bye () {
  claim_alias_or_warn "bye" "say 'see e yuh wunt wanna be e yuh'"
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ----------------------------------------------------------------- #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# Vendor-specific shell setup (part of corp user's dotfiles project).
bashdxy_source_vendor_dotfiles () {
  local vendor_wiring="DXY_DEPOXYDIR_RUNNING__HOME_/home/bashrc.DXY_VENDOR_NAME.sh"

  if [ -f "${vendor_wiring}" ]; then
    . "${vendor_wiring}"
  fi
}

# Vendor-specific power(ful) shell (the more robust acmesh project).
bashdxy_source_vendor_acmesh () {
  # CXREF: This path is set by deploy-archetype.sh per [[[DXY_VENDOR_NAME]]]
  #  local acme_sh="DXY_DEPOXYDIR_RUNNING__HOME_/home/bashrc.private.DXY_VENDOR_NAME.sh"
  local acme_sh="DXY_DEPOXY_CLIENT__HOME_/DXY_VENDOR_ACMESH_NAME/DXY_VENDOR_ACMESH_NAME"

  if [ -f "${acme_sh}" ]; then
    . "${acme_sh}"
  fi
}

# Non-vendor-related shell setup (i.e., that you could promote to a public project).
bashdxy_source_experimental () {
  local experimental_sh="DXY_DEPOXYDIR_RUNNING__HOME_/home/bashrc.DXY_USERNAME.sh"

  if [ -f "${experimental_sh}" ]; then
    . "${experimental_sh}"
  fi
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ----------------------------------------------------------------- #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

main () {
  # Wait for the second pass to run.
  ${HOME_FRIES_PRELOAD:-false} && return

  # Set aliases on the second pass.
  # - By setting our aliases later, we'll alert if our aliases conflict
  #   with any that DepoXy sets up, as opposed to that happening in the
  #   reverse (i.e., us setting aliases first, and then DepoXy griping
  #   if we blocked any of theirs).

  bashdx_wire_aliases_pushd_paths_cdw
  unset -f bashdx_wire_aliases_pushd_paths_cdw

  bashdx_wire_aliases_open_tracker
  unset -f bashdx_wire_aliases_open_tracker

  # ***

  bashdx_customize_depoxy_client_PS1
  unset -f bashdx_customize_depoxy_client_PS1

  # ***

  bashdxy_source_vendor_dotfiles
  unset -f bashdxy_source_vendor_dotfiles

  bashdxy_source_vendor_acmesh
  unset -f bashdxy_source_vendor_acmesh

  bashdxy_source_experimental
  unset -f bashdxy_source_experimental
}

main "$@"
unset -f main

