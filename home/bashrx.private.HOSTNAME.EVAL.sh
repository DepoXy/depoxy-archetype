# USAGE:
#   m4_shim \
#     "+8" "home/bashrx.private.HOSTNAME.EVAL.sh" \
#     "home/bashrx.private.${DXY_HOSTNAME}.sh"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# vim:tw=0:ts=2:sw=2:et:norl:ft=bash
# DXY_HEADER_AUTHOR
# DXY_HEADER_PROJECT
# DXY_HEADER_LICENSE

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

# SAVVY: This file is loaded on terminal startup.
#
#        - It's symlinked under ~/.homefries/.bashrc-bin
#          so that Homefries loads it.
#
#        - CXREF: See the `symlink_overlay_file` infuse task
#                 which creates the symlink:
#
#            DXY_DEPOXY_CLIENT_TILDE/_mrconfig
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
#     using the [[[DXY_VENDOR_CODE_PATH]]] environ.
#   - It defaults to '~/work', but author sometimes
#     customizes it to be @biz-specific, e.g.,
#     '~/acme', or '~/fbi/.

bashdx_wire_aliases_pushd_paths_cdw () {
  # CXREF: This path was set by deploy-archetype.sh per [[[DXY_VENDOR_CODE_PATH]]].
  local client_dir="${HOME}/DXY_VENDOR_CODE_PATH"

  if [ -d "${client_dir}" ]; then
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
      \"DXY_VENDOR_ISSUE_TRACKER_URL\"'"
  else
    >&2 echo "WARNING: Cannot alias: “${bugs_alias}” already assigned"
  fi
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ----------------------------------------------------------------- #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

bashdx_customize_depoxy_client_PS1 () {
  . "${HOMEFRIES_LIB:-${HOME}/.homefries/lib}/term/set-shell-prompt-and-window-title.sh"

  # USAGE: Disable this if you want to see the machine name in the prompt
  # instead of the DXC Client ID.
  # - ALTLY: Customize this name part or all of PS1 to your liking.
  HOMEFRIES_TERM_UTIL_PS1_HOST="DXC${DEPOXY_CLIENT_ID}" \
    dubs_set_terminal_prompt
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

bashdxy_source_experimental () {
  local experimental_sh="${HOME}/.depoxy/running/home/bashrx.private.experimental.sh"

  if [ -f "${experimental_sh}" ]; then
    . "${experimental_sh}"
  fi
}

bashdxy_source_business_code_path () {
  # CXREF: This path was set by deploy-archetype.sh per [[[DXY_VENDOR_CODE_PATH]]].
  local acme_sh="${HOME}/.depoxy/running/home/bashrx.private.DXY_VENDOR_CODE_PATH.sh"

  if [ -f "${acme_sh}" ]; then
    . "${acme_sh}"
  fi
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ----------------------------------------------------------------- #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

main () {
  if ${HOME_FRIES_PRELOAD}; then

    return 0
  fi

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

  bashdxy_source_experimental
  unset -f bashdxy_source_experimental

  bashdxy_source_business_code_path
  unset -f bashdxy_source_business_code_path
}

main "$@"
unset -f main

