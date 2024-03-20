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
#            DXY_DEPOXYDIR_STINTS_TILDE/DXY_DEPOXY_CLIENT_ID/_mrconfig
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

# Opt-in Darwin Keep Alive.
#
# - Runs `caffeinate` and/or `pmset` to keep your machine from sleeping
#   (and, if you can't change the pertinent system settings, from you
#    then needing to enter your password to log back on; useful if you
#    work from home and your bio breaks take longer than 5 minutes, or
#    if you switch to your personal machine for a moment. Or slip away
#    to the kitchen for tea).
#
# - We only enable `caffeinate` by default. For truly nastily-locked
#   machines, you might need to use `pmset`, as well.

bashdx_configure_keep_alives () {
  # Set this to enable both caffeinate and pmset.
  export DEPOXY_ENABLE_KEEP_ALIVE=false

  # Set this to enable only caffeinate.
  export DEPOXY_ENABLE_KEEP_ALIVE_CAFFEINATE=true

  # Set this to enable only pmset.
  export DEPOXY_ENABLE_KEEP_ALIVE_PMSET=false
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ----------------------------------------------------------------- #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# 2021-08-22: Tell DepoXy Ambers how to define `cvs`. E.g.,
#   pushd_alias_or_warn "cvs" "${HOME}/.vim/pack/<username>/start"
bashdx_configure_cvs_alias_target () {
  export DEPOXY_CVS_VIM_PLUG_PACKAGE_NAME='PERSONAL_CVS_VIM_PLUG_PACKAGE_NAME'
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ----------------------------------------------------------------- #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# *** GVim opener project config
#
#   https://github.com/landonb/gvim-open-kindness#🐬

bashdx_configure_gvim_open_kindness () {
  # The Vim server name to connect to. Use the same servername to open files
  # in the same gVim/MacVim instance. - E.g.,
  #   gvim --servername SAMPI --remote-silent <file file...>
  export GVIM_OPEN_SERVERNAME="${GVIM_OPEN_SERVERNAME:-SAMPI}"

  # Set this to override gVim/MacVim initial geometry
  # if gvim-open-kindness opens new instance, e.g.,
  #
  #   export GVIM_OPEN_GEOMETRY="1,414,66,1859,1220"
}

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
#     using the [[[BUSINESS_CODE_PATH]]] environ.
#   - It defaults to '~/work', but author sometimes
#     customizes it to be @biz-specific, e.g.,
#     '~/acme', or '~/fbi/.

bashdx_wire_aliases_pushd_paths_cdw () {
  # CXREF: This path was set by deploy-archetype.sh per [[[BUSINESS_CODE_PATH]]].
  local client_dir="${HOME}/BUSINESS_CODE_PATH"

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

  # [ ! -f "${experimental_sh}" ] || . "${experimental_sh}"
  . "${experimental_sh}"
}

bashdxy_source_BUSINESS_CODE_PATH () {
  local acme_sh="${HOME}/.depoxy/running/home/bashrx.private.BUSINESS_CODE_PATH.sh"

  # [ ! -f "${acme_sh}" ] || . "${acme_sh}"
  . "${acme_sh}"
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ----------------------------------------------------------------- #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

main () {
  if ${HOME_FRIES_PRELOAD}; then
    # Set environs on the first pass.

    bashdx_configure_keep_alives
    unset -f bashdx_configure_keep_alives

    bashdx_configure_cvs_alias_target
    unset -f bashdx_configure_cvs_alias_target

    bashdx_configure_gvim_open_kindness
    unset -f bashdx_configure_gvim_open_kindness
  else
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

    bashdxy_source_BUSINESS_CODE_PATH
    unset -f bashdxy_source_BUSINESS_CODE_PATH
  fi
}

main "$@"
unset -f main

