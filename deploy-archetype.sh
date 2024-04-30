#!/usr/bin/env bash
# vim:tw=0:ts=2:sw=2:et:norl:ft=bash
# Author: Landon Bouma <https://tallybark.com/>
# Project: https://github.com/DepoXy/depoxy-archetype#🏹
# License: MIT

# Copyright (c) © 2022-2023 Landon Bouma. All Rights Reserved.

# ================================================================= #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ================================================================= #

# USAGE: `register` your own business values for the variables below,
#        and then run this script to deply a fresh DepoXy Client.
#        - Or, set the values when you call this script

# ================================================================= #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ================================================================= #

# DEV: Uncomment next line to print actions without performing them.
#
#  DRY_RUN=${DRY_RUN:-true}
DRY_RUN=${DRY_RUN:-false}

# DEV: If you want to test a specific file, uncomment and change, e.g.,
#
#  TEST_FILE="docs/Backlog_Client.EVAL.rst"

# ================================================================= #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ================================================================= #

# Feel free to set your own headers.
register_customizable_headers () {
  register "DXY_DEPOXY_HUMAN_NAME" "$(user_name_full)"

  # "Author: ..." defaults to what your machine says is your full name.
  register "DXY_HEADER_AUTHOR" "Author: ${DXY_DEPOXY_HUMAN_NAME}"

  # "Project: ..." defaults to the file:/// path to the new DepoXy Client.
  #   💼 🕵 🛒 🚪 👔 🤝 👨 🕴 📞 💰 🚜 🏢 📄 🗡️ 📉 📈 🔺 ♛ 📊 😵 📦 🚗 🛎 🪵 🧳 💁 🎨
  register "DXY_HEADER_PROJECT" "Project: file://${DXY_DEPOXY_CLIENT_FULL}#👔"

  # "License: ..." defaults to what you see here.
  register "DXY_HEADER_LICENSE" "License: PROPRIETARY AND CONFIDENTIAL"
}

# You can set the client ID, and specify a remote Git URL.
register_customizable_client_ids () {
  # The author uses the two-digit year and the week number of their
  # contract start date for the client name, e.g., 2243, but you can
  # use what you want, with the caveat that if code has to suss out
  # the client name from the directory names in ~/.depoxy/stints, and
  # if there are two or more directories, it does an alphanumberic sort
  # and picks the name that's sorted last.
  #
  #  DXY_DEPOXY_CLIENT_ID=2243  # E.g., week of Oct 16, 2022.
  #
  # Default: Concat. two digit year and week number at time this script runs.
  register "DXY_DEPOXY_CLIENT_ID" "$(date +%y)$(date -d"sunday" +%U)"

  # (Optional) Set this value to your private DepoXy Client repo URL, e.g.,
  #   https://github.com/<user>/<depoxy-client-id>.git
  # 
  # Note that the second arg is an empty string, so `register` will see this
  # value is optional (and the script that uses the value will tell you that
  # it cannot run without a remote URL, but at least it'll run to say that).
  register "DXY_DEPOXY_CLIENT_REMOTE" ""
}

# You can set Git user names and emails for business and personal projects.
register_customizable_git_config () {
  # DepoXy wires two sets of Git user.name and user.email:
  # your business user, and your personal user.

  # Business user:
  # - Anything under ~/work will use your business user.
  #   - A few sub-repos of DXC that are uploaded to @biz server also biz user.
  # - You can update/change the Business user later: .gitconfig.user-business

  # The @biz Git server host (i.e., GitHub or GitLab URL),
  # e.g., "gitlab.acme.com".
  register "BUSINESS_GITCONFIG_HUB_HOST" "PLEASE_SET_ME"
  # The @biz Git server user name and email it'll use (you can user whatever
  # you want, but I like to use the same values I see when I approve a PR/MR,
  # or that I see other devs use).
  register "BUSINESS_GITCONFIG_USER_NAME" "PLEASE_SET_ME"
  register "BUSINESS_GITCONFIG_USER_EMAIL" "PLEASE_SET_ME"
  # The Git commit username might differ from your user home on server,
  # e.g., at one job, my commit user was "Last, First", but my server
  # name was "First.Last". This environ is your user name and personal
  # repo name you'll use to backup a few files on your @biz Git server.
  # E.g., BUSINESS_GITSERVER_USER_REPO="First.Last/flast.sh" would
  # make @biz personal URL: https://gitlab.acme.com/First.Last/flast.sh
  register "BUSINESS_GITSERVER_USER_REPO" "PLEASE_SET_ME"
  #
  # E.g., "flast.sh".
  unset -v BUSINESS_PROJECT_NAME_DOTFILES
  register "BUSINESS_PROJECT_NAME_DOTFILES" "$(basename -- "${BUSINESS_GITSERVER_USER_REPO}")"

  # Personal user:
  # - Anything not under ~/work will use your personal user.
  # - You can update/change the Personal user later: .gitconfig.user-personal
  register "PERSONAL_GITCONFIG_USER_NAME" "PLEASE_SET_ME"
  register "PERSONAL_GITCONFIG_USER_EMAIL" "PLEASE_SET_ME@${DXY_HOSTNAME}"

  # A subset of DXC files are backed up to @biz GitHuLaB and are given
  # a one-line URL-only header (i.e., not Author/Project/License lines).
  # E.g.:
  #   https://gitlab.acme.com/User.Name/uname.sh#🥗
  register "DXY_HEADER_DOTFILES" "https://${BUSINESS_GITCONFIG_HUB_HOST}/${BUSINESS_GITSERVER_USER_REPO}#🥗"
  #
  register "DXY_HEADER_DOTPROJECT" "Project: ${DXY_HEADER_DOTFILES}"
}

# You can set URLs for business-specific stuff.
register_customizable_business_values () {
  # Customize where you'd like to keep business code, e.g., ~/acme.
  # - The author generally picks a name or abbreviation for their current
  #   business client, to give their code some honor over a generic default
  #   like ~/work. E.g., Big Business Place might be ~/bbp.
  # - You can obviously keep their code wherever you want, but this location
  #   used for a few conveniences:
  #   - For Git projects under this path, the Git user.name and user.email
  #     are fetched according to the Git config template at:
  #       ~/.depoxy/ambers/archetype/home/.gitconfig.user-business.EVAL
  #   - For Git projects elsewhere on your device (e.g., for the DepoXy
  #     projects installed, the other paths include ~/.homefries, ~/.kit,
  #     and ~/.depoxy itself).
  register "BUSINESS_CODE_PATH" "work"

  # If your client uses an npm registry, you can specify its URL to generate
  # an ~/.npmrc file. E.g., ~/.npmrc might look like this:
  #   registry=https://repo1.employer.tld/artifactory/api/npm/npm-virtual
  # Note, too, that some organizations restrict access to the main npm registry,
  #   http://registry.npmjs.org/npm
  # in which case you'll need to use the corporate npm URL.
  register "BUSINESS_NPM_REGISTRY_URL" ""

  # For the `bugs` alias defined on Bash startup by the template at
  #   ~/.depoxy/ambers/archetype/home/bashrx.private.HOSTNAME.EVAL.sh
  # you can make it easy to open your client's ticketing system.
  register "DXY_VENDOR_ISSUE_TRACKER_URL" "https://en.wikipedia.org/wiki/Bug_tracking_system"
}

# You can set values for non-business things.
register_customizable_personal_values () {
  # Optional: Set the Vim package name the `cvs` alias uses to
  #           `pushd ~/.vim/pack/<PACKAGE_NAME>/start`.
  register "PERSONAL_CVS_VIM_PLUG_PACKAGE_NAME" ""

  # Optional: Specify a GVim --servername so that gvim shortcuts always
  #           send files to the same instance.
  register "PERSONAL_GVIM_OPEN_SERVERNAME" ""
}

# ================================================================= #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ================================================================= #

# Generated variables you don't need to set, but could.
register_generated () {
  register "DXY_USERNAME" "$(id -un)"

  # The ~/.depoxy/running/.hostname file informs DepoXy if certain
  # commands are being run on your @home machine or @work machine.
  # - ALTLY: macOS alternative to `hostname`: `scutil --get LocalHostName`.
  register "DXY_HOSTNAME" "$(hostname)"

  register "DXY_USER_HOME" "${HOME}"

  register "DXY_USER_CONFIG_FULL" "$( \
    os_is_macos && echo "${HOME}/Library/Application Support" || echo "${HOME}/.config")"
  }

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# Note that we unset variables that are formed from other customizable values,
# and that the user shouldn't set, lest they conflict with other variable
# values (and we want to avoid providing unnecessary conflict-conflicting).

# depoxy_fs.sh variables.
register_depoxydir_paths () {
  # E.g., "/(Users|home)/<user>/.depoxy"
  register "DXY_DEPOXYDIR_BASE_FULL" "${DEPOXYDIR_BASE_FULL:-${HOME}/.depoxy}"

  # E.g., ".depoxy"
  unset -v DXY_DEPOXYDIR_BASE_NAME
  register "DXY_DEPOXYDIR_BASE_NAME" "$( \
    echo "${DXY_DEPOXYDIR_BASE_FULL}" \
    | sed "s@^${HOME}/@@"
  )"

  # E.g., "~/.depoxy"
  unset -v DXY_DEPOXYDIR_BASE_TILDE
  register "DXY_DEPOXYDIR_BASE_TILDE" "$( \
    echo "${DXY_DEPOXYDIR_BASE_FULL}" \
    | sed -E "s@^${HOME}(/|$)@~\1@"
  )"

  # E.g., "$HOME/.depoxy"
  unset -v DXY_DEPOXYDIR_BASE_HOME
  register "DXY_DEPOXYDIR_BASE_HOME" "$( \
    echo "${DXY_DEPOXYDIR_BASE_FULL}" \
    | sed -E "s@^${HOME}(/|$)@\\\\\$HOME\1@"
  )"

  # E.g., "${HOME}/.depoxy"
  unset -v DXY_DEPOXYDIR_BASE__HOME_
  register "DXY_DEPOXYDIR_BASE__HOME_" "$( \
    echo "${DXY_DEPOXYDIR_BASE_FULL}" \
    | sed -E "s@^${HOME}(/|$)@\\\\\${HOME}\1@"
  )"

  # ***

  # E.g., "stints"
  register "DXY_DEPOXYDIR_STINTS_NAME" "${DEPOXYDIR_STINTS_NAME:-stints}"

  # E.g., "/(Users|home)/<user>/.depoxy/stints"
  unset -v DXY_DEPOXYDIR_STINTS_FULL
  register "DXY_DEPOXYDIR_STINTS_FULL" \
    "$(eval "echo ${DXY_DEPOXYDIR_BASE_FULL}/${DXY_DEPOXYDIR_STINTS_NAME}")"

  # E.g., "~/.depoxy/stints"
  unset -v DXY_DEPOXYDIR_STINTS_TILDE
  register "DXY_DEPOXYDIR_STINTS_TILDE" "$( \
    echo "${DXY_DEPOXYDIR_STINTS_FULL}" \
    | sed -E "s@^${HOME}(/|$)@~\1@"
  )"

  # E.g., "$HOME/.depoxy/stints"
  unset -v DXY_DEPOXYDIR_STINTS_HOME
  register "DXY_DEPOXYDIR_STINTS_HOME" "$( \
    echo "${DXY_DEPOXYDIR_STINTS_FULL}" \
    | sed -E "s@^${HOME}(/|$)@\\\\\$HOME\1@"
  )"

  # E.g., "${HOME}/.depoxy/stints"
  unset -v DXY_DEPOXYDIR_STINTS__HOME_
  register "DXY_DEPOXYDIR_STINTS__HOME_" "$( \
    echo "${DXY_DEPOXYDIR_STINTS_FULL}" \
    | sed -E "s@^${HOME}(/|$)@\\\\\${HOME}\1@"
  )"

  # ***

  # E.g., "/user/home/.depoxy/running"
  register "DXY_DEPOXYDIR_RUNNING_FULL" \
    "${DEPOXYDIR_RUNNING_FULL:-${HOME}/.depoxy/${DEPOXYDIR_RUNNING_NAME:-running}}"

  # E.g., "running"
  # CXREF: Symlink created by this script;
  #   also reaffirmed by DXC _mrconfig, see: DEPOXYDIR_RUNNING_FULL.
  register "DXY_DEPOXYDIR_RUNNING_NAME" \
    "$(basename -- "${DXY_DEPOXYDIR_RUNNING_FULL}")"

  # E.g., "~/.depoxy/running"
  unset -v DXY_DEPOXYDIR_RUNNING_TILDE
  register "DXY_DEPOXYDIR_RUNNING_TILDE" "$( \
    echo "${DXY_DEPOXYDIR_RUNNING_FULL}" \
    | sed -E "s@^${HOME}(/|$)@~\1@"
  )"

  # E.g., "$HOME/.depoxy/running"
  unset -v DXY_DEPOXYDIR_RUNNING_HOME
  register "DXY_DEPOXYDIR_RUNNING_HOME" "$( \
    echo "${DXY_DEPOXYDIR_RUNNING_FULL}" \
    | sed -E "s@^${HOME}(/|$)@\\\\\$HOME\1@"
  )"

  # E.g., "${HOME}/.depoxy/running"
  unset -v DXY_DEPOXYDIR_RUNNING__HOME_
  register "DXY_DEPOXYDIR_RUNNING__HOME_" "$( \
    echo "${DXY_DEPOXYDIR_RUNNING_FULL}" \
    | sed -E "s@^${HOME}(/|$)@\\\\\${HOME}\1@"
  )"

  # ***

  # Path known to ~/.mrtrust for temporary usage to standup unwired DepoXy Client.
  # - E.g., "/user/home/.depoxy/.adscititious"
  register "DXY_DEPOXYDIR_RESERVABLE_FULL" \
    "${DEPOXYDIR_RESERVABLE_FULL:-${HOME}/.depoxy/${DEPOXYDIR_RESERVABLE_NAME:-.adscititious}}"

  # # E.g., ".adscititious"
  # register "DXY_DEPOXYDIR_RESERVABLE_NAME" \
  #   "$(basename -- "${DXY_DEPOXYDIR_RESERVABLE_FULL}")"

  # ***

  # E.g., ".hostnames"
  register "DXY_DEPOXY_HOSTNAMES_NAME" "${DEPOXY_HOSTNAMES_NAME:-.hostnames}"

  # ***

  # If ${DXY_RUN_MAKE_LNS}, the directory name for the symlinks directory
  # (which will be created in the same directory as the new DXC).
  # USYNC: DXY_MAKE_LNS_NAME and infuse_create_symlinks_docs use same '.syml--' prefix.
  # - E.g., ~/.depoxy/stints/.syml--XXXX
  register "DXY_MAKE_LNS_NAME" ".syml--${DXY_DEPOXY_CLIENT_ID}"
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# Alternative representations of previous values.
register_depoxy_client_path_options () {
  # Setup template variables with the new client path, represented all the ways.

  # - Client tilde path, e.g., "~/.depoxy/stints/XXXX"
  unset -v DXY_DEPOXY_CLIENT_TILDE
  register "DXY_DEPOXY_CLIENT_TILDE" "${DXY_DEPOXYDIR_STINTS_TILDE}/${DXY_DEPOXY_CLIENT_ID}"

  # - Client $HOME path, e.g., "$HOME/.depoxy/stints/XXXX"
  # FIXME/2023-03-03: Currently unused. (Was this for .vimprojects?)
  unset -v DXY_DEPOXY_CLIENT_HOME
  register "DXY_DEPOXY_CLIENT_HOME" "${DXY_DEPOXYDIR_STINTS_HOME}/${DXY_DEPOXY_CLIENT_ID}"

  # - Client full path, e.g., "/(Users|home)/<user>/.depoxy/stints/XXXX"
  unset -v DXY_DEPOXY_CLIENT_FULL
  register "DXY_DEPOXY_CLIENT_FULL" "${DXY_DEPOXYDIR_STINTS_FULL}/${DXY_DEPOXY_CLIENT_ID}"
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

register_depoxy_project_paths () {
  # Note that, because Bash, even DepoXy's Bashrc, when it's sourced on
  # terminal startup, doesn't know where it is. So it checks environs
  # and falls-back on the default path, ~/.depoxy/ambers.
  # - We'll mimic that here, which seems like the best approach.
  # - Alternatively, we could grab the path from `command -v mredit`, e.g.,
  #     ambers_path="$(dirname -- "$(dirname -- "$(command -v mredit)")")"
  #   but that seems fragile.
  # E.g., "/(Users|home)/<user>/.depoxy/ambers"
  local ambers_path="${DEPOXYDIR_BASE_FULL:-${HOME}/.depoxy}/ambers"
  ambers_path="${DEPOXYAMBERS_DIR:-${ambers_path}}"
  register "DXY_DEPOXYAMBERS_DIR" "${ambers_path}"

  # E.g., "ambers".
  unset -v DXY_DEPOXYAMBERS_NAME
  register "DXY_DEPOXYAMBERS_NAME" "$( \
    echo "${DXY_DEPOXYAMBERS_DIR}" \
    | sed "s@^${DXY_DEPOXYDIR_BASE_FULL}/@@"
  )"

  # E.g., "~/.depoxy/ambers"
  unset -v DXY_DEPOXYAMBERS_DIR_TILDE
  register "DXY_DEPOXYAMBERS_DIR_TILDE" "$( \
    echo "${DXY_DEPOXYAMBERS_DIR}" \
    | sed -E "s@^${HOME}(/|$)@~\1@"
  )"

  # E.g., "$HOME/.depoxy/ambers"
  # - CXREF: Vimprojects template:
  #   ~/.depoxy/ambers/archetype/home/.vim/pack/landonb/start/dubs_project_tray/.vimprojects.EVAL
  unset -v DXY_DEPOXYAMBERS_DIR_HOME
  register "DXY_DEPOXYAMBERS_DIR_HOME" "$( \
    echo "${DXY_DEPOXYAMBERS_DIR}" \
    | sed -E "s@^${HOME}(/|$)@\\\\\$HOME\1@"
  )"

  # E.g., "${HOME}/.depoxy/ambers"
  # - Note the extra \\$ delimiter, because m4 command is eval'ed.
  unset -v DXY_DEPOXYAMBERS_DIR__HOME_
  register "DXY_DEPOXYAMBERS_DIR__HOME_" "$( \
    echo "${DXY_DEPOXYAMBERS_DIR}" \
    | sed -E "s@^${HOME}(/|$)@\\\\\${HOME}\1@"
  )"

  # ***

  # At least this script knows where it's at.
  # E.g., "/(Users|home)/<user>/.depoxy/ambers/archetype"
  register "DXY_DEPOXYARCHETYPE_DIR" "${archetype_root}"

  # E.g., "~/.depoxy/ambers/archetype"
  unset -v DXY_DEPOXYARCHETYPE_DIR_TILDE
  register "DXY_DEPOXYARCHETYPE_DIR_TILDE" "$( \
    echo "${DXY_DEPOXYARCHETYPE_DIR}" \
    | sed -E "s@^${HOME}(/|$)@~\1@"
  )"

  # ***

  # E.g., ".projlns", ripgreppable symlinks collector.
  register "DXY_DEPOXY_PROJLNS_NAME" "$(\
    echo "${DEPOXY_PROJLNS:-${HOME}/.projlns}" \
    | sed "s@^${HOME}/@@"
  )"

  # ***

  # E.g., ".homefries"
  register "DXY_HOMEFRIES_DIR_NAME" "$( \
    echo "${HOMEFRIES_DIR:-${HOME}/.homefries}" \
    | sed "s@^${HOME}/@@"
  )"

  # ***

  # FIXME/2022-12-13: Propagate DOPP_KIT/DXY_DOPP_KIT_NAME usage
  #                   (it's not used everywhere it could be).
  #
  # E.g., ".kit"
  register "DXY_DOPP_KIT_NAME" "$( \
    echo "${DOPP_KIT:-${HOME}/.kit}" \
    | sed "s@^${HOME}/@@"
  )"
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

register_git_put_wise_paths () {
  # E.g., "/home/user/.depoxy/patchr"
  register "DXY_PW_PATCHES_REPO" \
    "${PW_PATCHES_REPO:-${DXY_DEPOXYDIR_BASE_FULL}/${PW_PATCHES_NAME:-patchr}}"

  # E.g., "patchr"
  # - Used to generate a Git exclude rule
  unset -v DXY_PW_PATCHES_NAME
  register "DXY_PW_PATCHES_NAME" "$( \
    echo "${DXY_PW_PATCHES_REPO}" \
    | sed "s@^${HOME}/@@"
  )"

  # E.g., "path/to/password/store/key/for/GPW/patches"
  register "DXY_PW_OPTION_PASS_NAME" ""
}

# ================================================================= #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ================================================================= #

source_deps () {
  # Load: DEPOXY_* path and settings environs.
  local ambers_path="${DEPOXYDIR_BASE_FULL:-${HOME}/.depoxy}/ambers"
  local ambers_root="${DEPOXYAMBERS_DIR:-${ambers_path}}"
  . "${ambers_root}/core/depoxy_fs.sh"

  # Required by distro_util.sh: tweak_errexit
  . "${HOMEFRIES_LIB:-${HOME}/.homefries/lib}/process_util.sh"
  # Load os_is_macos.
  . "${HOMEFRIES_LIB:-${HOME}/.homefries/lib}/distro_util.sh"

  # Load user_name_full (requires os_is_macos).
  # - CXREF: ~/.homefries/lib/user_util.sh
  . "${HOMEFRIES_LIB:-${HOME}/.homefries/lib}/user_util.sh"
}

# ================================================================= #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ================================================================= #

declare -a MISSING_VARS=()
declare -a TEMPLATE_VARS=()

register () {
  local vname="$1"
  local value="$2"

  # SAVVY: Note that [ -v FOO ] incompatible with macOS Bash v3,
  # so using [ -n ${!FOO+x} ] test instead.
  # - REMEM: ${!vname+x} prints 'x' unless !vname var. is unset.
  if [ $# -ge 2 ] || [ -n "${!vname+x}" ]; then
    # SAVVY: Avoid variable expansion in ${value}, e.g., don't call this:
    #   eval "${vname}=\"\${${vname}:-${value}}\""
    [ -n "${!vname+x}" ] || eval "${vname}='${value}'"
    TEMPLATE_VARS+=("${vname}")
  else
    # Currently, all `register`'ed variables set a value (which might be
    # empty string, but still a value), so this branch never reached,
    # aka night of the living dead code.
    MISSING_VARS+=("${vname}")
  fi
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

fail_if_missing_vars () {
  [ ${#MISSING_VARS[@]} -ne 0 ] || return 0

  >&2 echo "ERROR: Please define these missing variables:"

  for missing_var in "${MISSING_VARS[@]}"; do
    >&2 echo "- ${missing_var}"
  done

  exit_1
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

DEPOXY_m4_DEFINES=""

prepare_m4_defines () {
  for template_var in "${TEMPLATE_VARS[@]}"; do
    DEPOXY_m4_DEFINES="${DEPOXY_m4_DEFINES} --define=${template_var}=\"${!template_var}\""
  done
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# m4_shim is called by the EVAL headers, to avoid quoting issues with eval.
# - Alternatively, EVAL headers could themselves call `eval m4 ...`
#   just the same. It really only changes the EVAL headers from this:
#     eval m4 "${DEPOXY_m4_DEFINES}" "<(tail ...)" > "..."
#   to this:
#     m4_shim <(tail...) > "..."
#   So a little less verbose, and no need to quote the <(tail ...).
#   - I think quoting the "<(tail ...)" process substitution looks
#     funky, so opting to use m4_shim instead.
# - Also note that if the process substitution in the eval fails, eval does
#   not trip errexit. So that we can catch the error, and report it, we have
#   the caller pass in the tail parameters, and then we check the file path.
#   - Another reason to prefer this shim versus the EVAL files doing it.
m4_shim () {
  local tail_lns="$1"
  local tail_path="$2"
  local client_file="$3"
  # Additional params specify additional m4 definitions
  shift 3

  local dest_path="${DXY_DEPOXY_CLIENT_FULL}/${client_file}"

  m4_shim_make_file "${tail_lns}" "${tail_path}" "${client_file}" "${dest_path}" "$@"

  deployed_file_make_link "${tail_path}" "${dest_path}"
}

m4_shim_make_file () {
  local tail_lns="$1"
  local tail_path="$2"
  local client_file="$3"  # Unused
  local dest_path="$4"
  # Additional params specify additional m4 definitions
  shift 4

  ! ${DXY_RUN_LNS_ONLY:-false} || return 0

  # Because tail will fail in eval without errexit, check file path.
  if [ ! -f "${tail_path}" ]; then
    >&2 echo
    >&2 echo "ERROR: No such input file: “${tail_path}”"

    exit_1
  fi

  # Although the output redirect trips errexit, the error message (that
  # says m4 failed) could be misleading, so at least handle one scenario:
  # unknown directory path (because we called `mkdir` on all the target
  # directories already, the path should exist).
  local dest_dir="$(dirname -- "${dest_path}")"

  if [ ! -d "${dest_dir}" ]; then
    set +x
    >&2 echo
    >&2 echo "ERROR: No such destination directory: “${dest_dir}”"

    exit_1
  fi

  local custom_m4_defines=""
  while [ "$1" != '' ]; do
    m4_define_value_must_be_specified "$@"

    custom_m4_defines="${custom_m4_defines} --define=$1=\"$2\""

    shift 2
  done

  # Finally, generate the client file from the template.

  # SAVVY: Inject "changequote(`[[[', `]]]')" at the start of the m4 doc,
  #        otherwise m4 fails if it finds any `single`- or ``double``-
  #        backticked text, complaining "ERROR: end of file in string".
  #        (And backticks are common in reST and shell files.)
  #
  #        - SAVVY: If you want to expand a macro within another word,
  #          use [[[]]] to break the word.
  #          - E.g., let's say MY_MACRO expands to "AN_EXAMPLE", then this:
  #              echo "${THIS_IS_[[[]]]MY_MACRO}"
  #            will expand to this:
  #              echo "${THIS_IS_AN_EXAMPLE}"
  #
  #        Also inject "changecom()", otherwise m4 ignores lines with
  #        leading `#` characters.
  #
  #        And use --prefix-builtins, so all m4 macros are renamed with
  #        an "m4_" prefix, e.g., "m4_changequote". Otherwise the simply-
  #        named `index()` macro may conflict with some of your code,
  #        e.g., Vim's function of the same name.
  #
  # DUNNO: I'm not sure if the hassle of using m4 makes it easier to use then
  # running a bunch of `sed` commands on each template. Probably a toss-up.
  eval $(m4_kludge) --prefix-builtins "${DEPOXY_m4_DEFINES}" "${custom_m4_defines}" \
    <(printf "m4_changequote(\`[[[', \`]]]')"; printf "m4_changecom()"; tail -n "${tail_lns}" "${tail_path}") \
    > "${dest_path}"

  # The previous `eval` is called from an EVAL header within an outer
  # `eval` (from process_file), and does not trip `set -e`, so up to us.
  if [ $? -ne 0 ]; then
    set +x
    >&2 echo
    >&2 echo "ERROR: m4 failed."

    exit_1
  fi
}

m4_define_value_must_be_specified () {
  local definition="$1"

  [ ${#@} -lt 2 ] || return 0

  >&2 echo "ERROR: Key or value “${definition}” expects a value or key"

  exit_1
}

# KLUGE: macOS Sonoma 14.4.1 `m4` always raises install-Xcode dialog,
# i.e., it's a buggy little scamp.
m4_kludge () {
  command -v gm4 || command -v m4
}

gnu_sed () {
  command -v gsed || command -v sed
}

# ================================================================= #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ================================================================= #

fail_if_target_exists_and_non_empty () {
  [ -d "${DXY_DEPOXY_CLIENT_FULL}" ] || return 0

  [ -n "$(ls -A ${DXY_DEPOXY_CLIENT_FULL})" ] || return 0

  >&2 echo "ERROR: The target directory is not empty!"
  >&2 echo "- Please check: “${DXY_DEPOXY_CLIENT_FULL}”"

  exit_1
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

DXY_CAPTURE_FILE_PREFIX="deploy-archetype-sh-"
DXY_CAPTURE_FILE_PATH=""

prepare_capture_file () {
  DXY_CAPTURE_FILE_PATH="$(mktemp -t ${DXY_CAPTURE_FILE_PREFIX}XXXX)"

  blot "Let's deploy!"
  blot "- Capturing to:"
  blot "  ${DXY_CAPTURE_FILE_PATH}"
  blot
}

finish_capture_file () {
  # Strip color sequences only
  # - REFER: https://superuser.com/a/380778
  $(gnu_sed) -e 's/\x1b\[[0-9;]*m//g' -i "${DXY_CAPTURE_FILE_PATH}"
}

# ***

bg_red () { printf "\033[41m"; }
fg_white () { printf "\033[97m"; }
attr_reset () { printf "\033[0m"; }
alert () { printf "%s" "$(bg_red)$(fg_white)$1$(attr_reset)"; }

blot () {
  echo "$@" | tee_or_cat
}

tee_or_cat () {
  if [ ! -f "${DXY_CAPTURE_FILE_PATH}" ]; then
    cat

    return 0
  fi

  tee -a "${DXY_CAPTURE_FILE_PATH}"
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

prompt_continue_or_exit () {
  blot "Looks good!"
  blot "- All required variables have values"
  blot "- Destination path empty or uncreated"
  blot

  local ignored_key

  # REFER: <ESC+7> Save cursor posit (DEC) / <ESC+8> Restore posit (DEC)
  #   https://gist.github.com/ConnerWill/d4b6c776b509add763e17f9f113fd25b

  (
    printf " 🍍 Press any key to see variable values [.] \0337  🍍\0338"
    # SAVVY: Use -e (readline) so arrow keys, etc., are ignored.
    # - If not using -e, if user presses arrow key, it injects more
    #   than one char (escape code) that can be picked up by a later
    #   `read`.
    #   - You can avoid this with `read -t 0.1` to clear the buffer,
    #     but Bash v3 -t doesn't support fractions (and this script
    #     is macOS Bash v3-compatible), in which case you'd have to
    #     `read -t 1`, which is annoying (and for some reason
    #     `read -t 0` doesn't gobble the excess input).
    read -e -n 1 ignored_key

    [ -z "${ignored_key}" ] || echo

    print_template_vars
    blot
  )

  blot "This script will create a new DepoXy Client at:"
  blot "  ${DXY_DEPOXY_CLIENT_TILDE}"
  blot

  local the_choice

  # The directory doesn't exist or is empty, so defaulting Yes seems fine.
  #  printf " Are you ready to deploy? [y/N] "
  printf " 🍍 Are you ready to deploy? [Y/n] \0337  🍍\0338"
  read -e -n 1 the_choice

  [ -z "${the_choice}" ] || echo

  [ -n "${the_choice}" ] || the_choice="y"

  [ "${the_choice}" = "y" ] || [ "${the_choice}" = "Y" ] || return 1
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

print_template_vars () {
  blot

  for template_var in "${TEMPLATE_VARS[@]}"; do
    blot "${template_var}=\"${!template_var}\""
  done
}

# ================================================================= #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ================================================================= #

prepare_depoxy_fs () {
  ! ${DRY_RUN} || return 0

  blot
  blot "Preparing client tree"
  blot

  # E.g., "/user/home/.depoxy"
  mkdir_with_trace "${DXY_DEPOXYDIR_BASE_FULL}"

  # E.g., "/user/home/.depoxy/stints"
  mkdir_with_trace "${DXY_DEPOXYDIR_STINTS_FULL}"

  ! ${DXY_RUN_LNS_ONLY:-false} || return 0

  # E.g., "/user/home/.depoxy/stints/XXXX"
  mkdir_with_trace "${DXY_DEPOXY_CLIENT_FULL}"

  prepare_depoxy_running_symlink
}

prepare_depoxy_running_symlink () {
  # E.g., "/user/home/.depoxy/running"
  # - This is necessary for infuse and aci.
  if [ -h "${DXY_DEPOXYDIR_RUNNING_FULL}" ]; then
    local running_now
    running_now="$(realpath -- "${DXY_DEPOXYDIR_RUNNING_FULL}")"

    if [ "${DXY_DEPOXY_CLIENT_FULL}" = "${running_now}" ]; then
      blot "Client already wired at “${DXY_DEPOXYDIR_RUNNING_FULL}”"
    else
      >&2 blot
      >&2 blot "$(alert "BWARE: A different client is currently “running”:")"
      >&2 blot "$(alert "  ${running_now}")"
      # Use alternative path in ~/.mrtrust plumbed for this script.
      # - Necessary for running new DXC's 'infuse' and 'autocommit'.
      # - See also: `mr -t/--trust-all`, but ~/.mrconfig still needs
      #   to deliberately load the config, so we need this path anyway.
      >&2 blot "- Using temporarily “reservable” project slot:"
      >&2 blot "  ${DXY_DEPOXYDIR_RESERVABLE_FULL}"
      if [ -h "${DXY_DEPOXYDIR_RESERVABLE_FULL}" ]; then
        command rm -- "${DXY_DEPOXYDIR_RESERVABLE_FULL}"
      fi
      ln_with_trace "${DXY_DEPOXY_CLIENT_FULL}" "${DXY_DEPOXYDIR_RESERVABLE_FULL}"
    fi
  elif [ ! -e "${DXY_DEPOXYDIR_RUNNING_FULL}" ]; then
    ln_with_trace "${DXY_DEPOXY_CLIENT_FULL}" "${DXY_DEPOXYDIR_RUNNING_FULL}"
  else
    >&2 blot "$(alert "ERROR: Not a symlink: ${DXY_DEPOXYDIR_RUNNING_FULL}")"

    exit_1
  fi
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

mkdir_with_trace () {
  local path="$1"

  blot "  mkdir -p -- \"${path}\""

  mkdir -p -- "${path}"
}

ln_with_trace () {
  local source="$1"
  local target="$2"

  if ${DXY_OUTPUT_VERBOSE}; then
    blot "  command ln -s \"${source}\" \"${target}\""
  fi

  command ln -s "${source}" "${target}"
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# TRYME:
#   find . -path ./.git -prune -o -type d -print
# # find . -path ./.git -prune -o -type d -exec echo "${DXY_DEPOXY_CLIENT_HOME}/{}" \;
#   find . -path ./.git -prune -o -type d -exec echo "${DXY_DEPOXY_CLIENT_FULL}/{}" \;

# SAVVY: Use `-mindepth 1` to exclude current directory (.).

# INERT: Add mechanism to use ./.EVAL files to override this `mkdir` behavior.
# - The template currently populates same-named directories in the new client
#   repo, and it places at least one file in each of those directories.
# - But if we ever found that we wanted to do something different, like
#   rename the target directory based on a template variable, we could
#   use an `.EVAL` file in the directory to run `eval` code, like we do
#   for the other template files that include "EVAL" in their name.
# - Fortunately, we don't currently need this complexity.
#   But if we did, here's one idea on how we might do it.

prepare_client_fs () {
  local client_path="$1"

  # client_set set if called by prepare_symlinks_fs, b/c DXY_RUN_MAKE_LNS.
  [ -n "${client_path}" ] || ! ${DXY_RUN_LNS_ONLY:-false} || return 0

  [ -n "${client_path}" ] || client_path=${DXY_DEPOXY_CLIENT_FULL}

  if ${DRY_RUN}; then
    blot
    find . -mindepth 1 -path ./.git -prune -o -type d -exec echo "mkdir: ${client_path}/{}" \; \
      | tee_or_cat

    return 0
  fi

  find . -mindepth 1 -path ./.git -prune -o -type d -exec mkdir "${client_path}/{}" \;
}

prepare_symlinks_fs () {
  # E.g., /user/home/.depoxy/stints/.syml--XXXX
  register "DXY_MAKE_LNS_FULL" "${DXY_DEPOXYDIR_STINTS_FULL}/${DXY_MAKE_LNS_NAME}"

  ${DXY_RUN_MAKE_LNS:-false} || return 0

  ! ${DRY_RUN} || return 0

  if [ -h "${DXY_MAKE_LNS_FULL}/deploy-archetype.sh" ]; then
    blot
    blot "Cleaning up previous symlinks tree"
    blot
    blot "  command rm -rf -- \"${DXY_MAKE_LNS_FULL}\""

    command rm -rf -- "${DXY_MAKE_LNS_FULL}"
  fi

  mkdir_with_trace "${DXY_MAKE_LNS_FULL}"

  prepare_client_fs "${DXY_MAKE_LNS_FULL}"

  # E.g., /Users/user/.depoxy/stints/.syml--XXXX/deploy-archetype.sh
  # - So this path doesn't appear missing on diff/meld.
  ln_with_trace "$(realpath -- "$0")" "${DXY_MAKE_LNS_FULL}/$(basename -- "$0")"
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

process_files () {
  local fname

  blot

  while IFS= read -r -d $'\0' fname; do
    if ! process_file "${fname}"; then
      >&2 blot
      >&2 blot "ERROR: Failed to process “${fname}”."
      >&2 blot "- You'll have to try again!"

      exit_1
    fi
  done < <(git ls-files -z)
}

process_file () {
  local fname="$1"

  local exit_code

  if echo "${fname}" | grep -q -e "EVAL"; then
    process_file_eval "${fname}"
  elif false \
    || [ "${fname}" = "${deploysh_name}" ] \
    || [ "${fname}" = "LICENSE" ] \
  ; then
    blot "SKIP: ${fname}"
    ! ${DXY_OUTPUT_VERBOSE} || blot
  else
    process_file_copy "${fname}"
  fi
}

process_file_copy () {
  local fname="$1"

  local dest_path="${DXY_DEPOXY_CLIENT_FULL}/${fname}"

  local exit_code
  process_file_copy_copy_file "${fname}" "${dest_path}"
  # AUDIT: Because errexit, this work (this in subshell?)?
  exit_code=$?

  deployed_file_make_link "${fname}" "${dest_path}"

  return ${exit_code}
}

process_file_copy_copy_file () {
  local fname="$1"
  local dest_path="$2"

  ! ${DXY_RUN_LNS_ONLY:-false} || return 0

  local exit_code

  blot "COPY: ${fname}"
  ! ${DXY_OUTPUT_VERBOSE} || blot

  if ${DRY_RUN}; then
    blot "  command cp -R -P -- \"${fname}\" \"${dest_path}\""
    blot

    return 0
  fi

  # Note that older `cp` (ahem macos) honor -P but not --no-dereference.
  # - Point being, copy symlinks themselves and not what they reference,
  #   and use more compatible -P option.
  # - Also note that older `cp -P` fails on broken symlink, but `cp -P -R`
  #   works. -R is obviously the recursive option, but we're guaranteed to
  #   only be processing files, and not directories, so can safely add it.
  command cp -R -P -- "${fname}" "${dest_path}"

  exit_code=$?

  return ${exit_code}
}

deployed_file_make_link () {
  local fname="$1"
  local dest_path="$2"

  ${DXY_RUN_MAKE_LNS:-false} || return 0

  if ${DXY_RUN_LNS_ONLY:-false}; then
    blot "LINK: ${fname}"
    blot
  fi

  if ${DRY_RUN}; then
    blot "  command ln -s \"${dest_path}\" \"${DXY_MAKE_LNS_FULL}/${fname}\""
    blot

    return 0
  fi

  # E.g., /Users/user/.depoxy/stints/.syml--XXXX/...
  ln_with_trace "${dest_path}" "${DXY_MAKE_LNS_FULL}/${fname}"

  ! ${DXY_OUTPUT_VERBOSE} || blot
}

process_file_eval () {
  local fname="$1"

  local eval_cmd
  eval_cmd="$(extract_eval_command "${fname}")"
  blot "EVAL: ${fname}"
  ! ${DXY_OUTPUT_VERBOSE} || blot

  # See DEV hook atop file. If set, only test specific file.
  [ -z "${TEST_FILE}" ] || [ "${TEST_FILE}" = "${fname}" ] || return 0

  if ${DRY_RUN}; then
    # The `set -x` before `eval` prints eval_cmd, so only print on DRY_RUN.
    blot "  ${eval_cmd}"
    blot

    return 0
  fi

  local exit_code

  process_eval () {
    set -x
    eval "${eval_cmd}"
    exit_code=$?
    set +x

    return ${exit_code}
  }

  if [ ! -f "${DXY_CAPTURE_FILE_PATH}" ]; then
    if ${DXY_OUTPUT_VERBOSE}; then
      process_eval

      blot
    else
      process_eval 2> /dev/null
    fi
  else
    if ${DXY_OUTPUT_VERBOSE}; then
      process_eval | tee_or_cat
      exit_code=${PIPESTATUS[0]}

      blot
    else
      # Note that `set -x` writes to stdout.
      process_eval >> "${DXY_CAPTURE_FILE_PATH}" 2>&1

      echo >> "${DXY_CAPTURE_FILE_PATH}"
    fi
  fi

  # See DEV hook atop file. If set, only test specific file.
  if [ -n "${TEST_FILE}" ]; then
    blot "DEV: Stopping early so you can check result from:"
    blot "  ${TEST_FILE}"

    exit_1
  fi

  return ${exit_code}
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# NOTE: This awk doesn't check that the first line contains "USAGE:".
#       It just prints output until the first blank line, stripping
#       leading comment characters; and it ignores any line that starts
#       with a comment character and a space followed by "USAGE:".
#       - The convention just happens to be that we start the header
#         with a "USAGE:" line to remind ourselves that the code
#         atop such files in this repo are processed through `eval`.
#       - We could instead remove the "USAGE:" check and just use
#         `tail -n +2`, and assume that the first line is not
#         `eval` code.
#       - Or we could update this `awk` to enforce the "USAGE:"
#         convention. But that doesn't add much value, other than
#         double-checking that the code atop the file is really
#         code that the developer intends to run through `eval`.
#       - But we're already running code through `eval`, which is
#         somewhat dangerous (also very powerful). And we only run
#         `eval` on files from this repo (found via `git ls-files`)
#         that have "EVAL" in their filename.
#         - Basically, as as long as we trust our own repo, and our
#           own work, we should be okay. If something bad happens,
#           it will have been our own fault.

# TRYME: Here's how you can test and verify this function, e.g.,
#
#   TRY_ME="$(extract_eval_command home/_git/info/exclude.m4)"
#   echo "${TRY_ME}"
#   eval "${TRY_ME}"

extract_eval_command () {
  local m4_file="$1"

  awk '
    BEGIN {
      found_blank = 0;
    }

    /^(#|\.\.|"|\/\/) USAGE:/ {
      next;
    }

    /^$/ {
      found_blank = 1;
      next;
    }

    found_blank == 0 {
      gsub(/^(#|\.\.|"|\/\/) /, "");
      print;
    }
  ' "${m4_file}"
}

# ================================================================= #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ================================================================= #

init_repo () {
  ! ${DXY_RUN_LNS_ONLY:-false} || return 0

  ! ${DRY_RUN} || return 0

  cd "${DXY_DEPOXY_CLIENT_FULL}"

  # Note that Git config not guaranteed to be wired, so specify
  # necessary config, like the user.
  local conf_opts=" \
    -c user.name=\"${PERSONAL_GITCONFIG_USER_NAME}\" \
    -c user.email=\"${PERSONAL_GITCONFIG_USER_EMAIL}\" \
  "

  git init -q -b private .

  eval "git ${conf_opts} commit -q --allow-empty \
    -m \"Flaming: hotnew: DepoXy Client ${DXY_DEPOXY_CLIENT_ID}\""

  cd - > /dev/null
}

# ***

omr_dxc_infuse () {
  ! ${DRY_RUN} || return 0

  # Assume not client machine if caller set custom DXY_HOSTNAME.
  [ "${DXY_HOSTNAME}" = "$(hostname)" ] || return 0

  blot
  blot mr -d "${DXY_DEPOXY_CLIENT_FULL}" -n infuse
  blot

  # Meh: We could `| tee_or_cat` but then there's no realtime output,
  # and there's no compelling reason to capture this output anyway.

  SHCOLORS_OFF=false \
  mr -d "${DXY_DEPOXY_CLIENT_FULL}" -n infuse \
    | sed 's/^/  /'
}

# ***

omr_dxc_autocommit () {
  ! ${DRY_RUN} || return 0

  # Assume not client machine if caller set custom DXY_HOSTNAME.
  [ "${DXY_HOSTNAME}" = "$(hostname)" ] || return 0

  blot
  blot mr -d "${DXY_DEPOXY_CLIENT_FULL}" -n autocommit -y
  blot

  SHCOLORS_OFF=false \
  mr -d "${DXY_DEPOXY_CLIENT_FULL}" -n autocommit -y \
    | sed 's/^/  /'
  blot

  omr_dxc_autocommit_verify

  omr_dxc_autocommit_demarcate
}

omr_dxc_autocommit_verify () {
  git_status_without_spell_melds () {
    local ignore_spell_melds="$(echo \
      ":!home/.vim/spell/sync-spells--*-new.sh" \
    )"

    git status --porcelain -- ${ignore_spell_melds}
  }

  (
    cd "${DXY_DEPOXY_CLIENT_FULL}"

    if test -z "$(git_status_without_spell_melds)"; then

      return 0
    fi

    >&2 blot "$(alert "BWARE"): OMR autocommit did not commit all changes"
    blot
    # DXC _mrconfig prints similar:
    #   git_status_without_spell_melds | sed 's/^/  /'
    #   blot
  )
}

omr_dxc_autocommit_demarcate () {
  local empty_msg=""
  if [ -n "${DXY_DEPOXY_INIT_AUTOCOMMIT_HRULE+x}" ]; then
    empty_msg="${DXY_DEPOXY_INIT_AUTOCOMMIT_HRULE}"
  else
    # Note that tig doesn't display many of the colorful emoji,
    # e.g., tig shows 🦆 but not 🪿. Non-colorful characters
    # so far seem to all work. Here we just want to delineate
    # the initial commits of the generated files before any
    # edits the user starts making.
    empty_msg="「 🎀 ────⋆⋅☆⋅⋆──  ﮩ٨ـﮩﮩ٨ـ♡ﮩ٨ـﮩﮩ٨ـ  𖡼𖤣𖥧𖡼𓋼𖤣𖥧𓋼𓍊  ︶꒷꒦︶  ✩ ♬ ₊.🎧⋆☾⋆⁺₊✧  ˚˖𓍢🌷✧˚⋆  ✦ 」"
  fi

  if [ -z "${empty_msg}" ]; then

    return 0
  fi

  (
    cd "${DXY_DEPOXY_CLIENT_FULL}"

    git commit -q --allow-empty -m "${empty_msg}"
  )
}

omr_dxc_cleanup () {
  if [ ! -h "${DXY_DEPOXYDIR_RESERVABLE_FULL}" ]; then
    return 0
  fi

  # Meh: We could cleanup, but what if user wants to run OMR again?
  local cleanup_now=false

  if ${cleanup_now}; then
    omr_dxc_cleanup_now
  else
    omr_dxc_cleanup_reminder
  fi
}

omr_dxc_cleanup_now () {
  >&2 blot "- Removing temporarily “reservable” project slot:"
  >&2 blot "  ${DXY_DEPOXYDIR_RESERVABLE_FULL}"
  >&2 blot

  command rm -- "${DXY_DEPOXYDIR_RESERVABLE_FULL}"
}

omr_dxc_cleanup_reminder () {
  >&2 blot "$(alert "CHORE"): Remove the temporary wiring when you’re done:"
  >&2 blot
  >&2 blot "         command rm -- \"${DXY_DEPOXYDIR_RESERVABLE_FULL}\""
  >&2 blot "         # Just in case"
  >&2 blot "         mr -d ${DXY_DEPOXYDIR_RUNNING_FULL} -n infuse"
  >&2 blot
}

# ***

DEPOXY_DUCK_DUCK_DUCK_DUCK_DUCK_DUCK="     🦆 🦆 🪿  🦆 🦆 🪿  🦆 🦆 🪿  🐤"

announce_completed_symlinks () {
  ${DXY_RUN_MAKE_LNS:-false} || return 0

  # Final COPY or EVAL ended with blank line.
  blot "${DEPOXY_DUCK_DUCK_DUCK_DUCK_DUCK_DUCK}"

  blot
  blot "Your DepoXy Client symlinks are ready at:"
  blot
  blot "  ${DXY_MAKE_LNS_FULL}"
}

announce_completed_client_repo () {
  blot
  blot "Your new DepoXy Client repo is ready at:"
  blot
  blot "  ${DXY_DEPOXY_CLIENT_TILDE}"

  if ! ${DRY_RUN}; then
    blot
    blot "SAVVY: You may want to start a new shell to realize changes"
  fi

  if [ -f "${DXY_CAPTURE_FILE_PATH}" ]; then
    blot
    blot "CXREF: Deploy log was captured to:"
    blot "  ${DXY_CAPTURE_FILE_PATH}"
  fi
}

announce_completed () {
  announce_completed_symlinks
  announce_completed_client_repo
}

# ================================================================= #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ================================================================= #

export DXY_RUN_MAKE_LNS=false
export DXY_RUN_LNS_ONLY=false

export DXY_OUTPUT_VERBOSE=false

parse_args () {
  while [ "$1" != '' ]; do
    case $1 in
      -h | --make-lns)
        export DXY_RUN_MAKE_LNS=true

        shift
        ;;
      -H | --lns-only)
        export DXY_RUN_MAKE_LNS=true
        export DXY_RUN_LNS_ONLY=true

        shift
        ;;
      -v)
        export DXY_OUTPUT_VERBOSE=true

        shift
        ;;
      *)
        >&2 echo "ERROR: Unrecognized argument: “$1”"

        exit_1
        ;;
    esac
  done
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

_NORMAL_EXIT=false

exit_1 () { _NORMAL_EXIT=true; exit 1; }
exit_0 () { _NORMAL_EXIT=true; exit 0; }

exit_cleanup () {
  if ! ${_NORMAL_EXIT}; then
    # USAGE: Alert on unexpected error path, so you can add happy path.
    >&2 echo "ALERT: "$(basename -- "$0")" exited abnormally!"
    >&2 echo "- Hint: Enable \`set -x\` and run again..."
  fi

  trap - EXIT INT

  ${_NORMAL_EXIT} && exit 0 || exit 1
}

int_cleanup () {
  _NORMAL_EXIT=true

  exit_cleanup
}

# ***

main () {
  set -e

  trap -- exit_cleanup EXIT
  trap -- int_cleanup INT

  # Run from the root of this file.
  local archetype_root="$(dirname -- "$(realpath -- "$0")")"
  local deploysh_name="$(basename -- "$0")"

  cd "${archetype_root}"

  source_deps

  parse_args "$@"

  register_customizable_client_ids
  register_generated
  register_depoxydir_paths
  register_depoxy_client_path_options
  register_depoxy_project_paths
  register_git_put_wise_paths
  register_customizable_headers
  register_customizable_git_config
  register_customizable_business_values
  register_customizable_personal_values

  fail_if_missing_vars

  prepare_m4_defines

  fail_if_target_exists_and_non_empty

  prepare_capture_file

  prompt_continue_or_exit

  prepare_depoxy_fs
  prepare_client_fs
  prepare_symlinks_fs
  process_files

  init_repo
  omr_dxc_infuse
  omr_dxc_autocommit
  omr_dxc_cleanup
  finish_capture_file
  announce_completed
  
  trap - EXIT INT
}

if [ "$0" = "${BASH_SOURCE[0]}" ]; then
  # Being executed.
  main "$@"
else
  source_deps
fi

unset -f main
unset -f parse_args
unset -f source_deps

