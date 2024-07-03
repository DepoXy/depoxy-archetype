# vim:tw=0:ts=2:sw=2:et:norl:ft=bash

# USAGE:
#   m4_shim \
#     "+10" "home/bashrx.private.HOSTNAME.EVAL.sh" \
#     "home/bashrx.private.${DXY_DEPOXY_HOSTNAME}.sh"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# vim:tw=0:ts=2:sw=2:et:norl:ft=bash
# DXY_HEADER_AUTHOR
# DXY_HEADER_PROJECT
# DXY_HEADER_LICENSE

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

# USAGE: This file is prepopulated by DepoXy Archetype for general usage.
#
# - SAVVY: While you *could* customize this file with your own additions,
#   there's also the username Bashrc which is 100% meant to be customized.
#
#   - CXREF: Consider customizing the other file instead:
#
#       ~/.depoxy/stints/2417/home/bashrx.private.puck.sh
#
#   - That way, consider keeping all your private customizations in the
#     complementary username Bashrc, and leaving this file more in sync
#     with the Archetype (so it's easier to update if the Archetype changes).

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
  local client_dir="${DEPOXYDIR_VENDOR_FULL:-DXY_VENDOR_HOME__HOME_}"

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
#     DXY_DEPOXY_USERNAME@DXC[[[]]]DXY_DEPOXY_CLIENT_ID[[[]]]:~ 🍄 $
# - Disable this to show the machine name in the prompt, e.g.,
#     DXY_DEPOXY_USERNAME@DXY_DEPOXY_HOSTNAME:~ 🍄 $
# - Or set HOMEFRIES_TERM_UTIL_PS1 to your own PS1 prompt (which
#   you'd want to do when ${HOME_FRIES_PRELOAD} is true so that
#   Homefries uses it; or just set your own PS1 here).

bashdx_customize_depoxy_client_PS1 () {
  # CXREF: ~/.kit/sh/home-fries/lib/term/set-shell-prompt-and-window-title.sh
  HOMEFRIES_TERM_UTIL_PS1_HOST="DXC${DEPOXY_CLIENT_ID}" \
    _hf_set_terminal_prompt
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ----------------------------------------------------------------- #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

bashdxy_source_client_bashrc () {
  declare -a bashrcs=()

  append_bashrc () {
    local bashrc="$1"

    if [ -f "${bashrc}" ]; then
      bashrcs+=("${bashrc}")
    fi
  }

  # ***

  # Vendor-specific shell setup (part of corp user's dotfiles project).
  # CXREF: DXY_DEPOXY_CLIENT_TILDE/home/bashrc.DXY_DEPOXY_VENDOR_NAME.sh
  local vendor_wiring="DXY_DEPOXY_CLIENT__HOME_/home/bashrc.DXY_DEPOXY_VENDOR_NAME.sh"
  append_bashrc "${vendor_wiring}"

  # Vendor-specific power(ful) shell project.
  # - This path is set by deploy-archetype.sh per [[[DXY_DEPOXY_VENDOR_NAME]]]
  # CXREF: DXY_DEPOXY_CLIENT_TILDE/DXY_DEPOXY_VENDOR_ACMESH_NAME/DXY_DEPOXY_VENDOR_ACMESH_NAME
  local acme_sh="DXY_DEPOXY_CLIENT__HOME_/DXY_DEPOXY_VENDOR_ACMESH_NAME/DXY_DEPOXY_VENDOR_ACMESH_NAME"
  append_bashrc "${acme_sh}"

  # Non-vendor-related shell setup (i.e., that you could promote to a public project).
  # CXREF: DXY_DEPOXY_CLIENT_TILDE/home/home/bashrc.DXY_DEPOXY_USERNAME.sh
  local user_sh="DXY_DEPOXY_CLIENT__HOME_/home/bashrc.DXY_DEPOXY_USERNAME.sh"
  append_bashrc "${user_sh}"

  # ***

  local ix
  local n_files=${#bashrcs[@]}
  for ((ix = 0; ix < ${n_files}; ix++)); do
    local file_name="${bashrcs[$ix]}"

    test $((${ix} + 1)) -lt ${n_files} || _DXC_SOURCE_IT_FINIS=true

    _dxc_source "${file_name}"
  done
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# For use with `HOMEFRIES_TRACE=true bash` — See also:
#   HOMEFRIES_TRACE=true \
#   HOMEFRIES_PROFILING=true \
#   HOMEFRIES_PROFILE_THRESHOLD=.01 \
#     bash
_DXC_SOURCE_IT_BEGIN=true
_DXC_SOURCE_IT_FINIS=false

# CXREF: _dxy_source_script:
#   ~/.depoxy/ambers/home/.kit/sh/home-fries/.bashrc-bin/bashrx.private.sh:10
_dxc_source () {
  local full_path="$1"

  _SOURCE_IT_BEGIN=${_DXC_SOURCE_IT_BEGIN} \
  _SOURCE_IT_FINIS=${_DXC_SOURCE_IT_FINIS} \
  source_it \
    "${full_path}" \
    "${_dxc_source_it_deps_path_none}" \
    "${_dxc_source_it_log_name_client:-CLIENT}"

  _DXC_SOURCE_IT_BEGIN=false
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ----------------------------------------------------------------- #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

_dxc_bashrc_standup () {
  # Wait for the second pass to run our commands.
  if ${HOME_FRIES_PRELOAD:-false}; then
    _SOURCE_IT_BEGIN=true \
    _SOURCE_IT_FINIS=true \
    source_it_log_trace "${_dxc_source_it_log_name_client:-CLIENT}" "[no-op]"

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

  bashdxy_source_client_bashrc
  unset -f bashdxy_source_client_bashrc

  unset -f _dxc_source

  _dxy_unset_functions
  unset -f _dxy_unset_functions
}

# ***

_dxc_unset_functions_dxc () {
  _wf_unset_functions_wf
  unset -f _wf_unset_functions_wf

  # Self-destruct
  unset -f _dxc_unset_functions_dxc
}

# USYNC: This overrides same-named function upstream:
#   ~/.depoxy/ambers/home/.kit/sh/home-fries/.bashrc-bin/bashrx.private.sh:228
_dxy_unset_functions () {
  # No-op, so DepoXy doesn't clobber functions before we run.
  :
}

# ***

_homefries_private_main_user () {
  _dxc_bashrc_standup "$@"
  unset -f _dxc_bashrc_standup
}

