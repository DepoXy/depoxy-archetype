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

# You can set names, paths, and URLS for business-specific stuff.
register_customizable_business_values () {
  # What to name some client-specific files, functions, projects,
  # directories, etc.
  register "DXY_VENDOR_NAME_PROPER" "${VENDOR_NAME_PROPER:-ACME}"
  register "DXY_VENDOR_DOMAIN" "${VENDOR_DOMAIN:-acme.tld}"
  register "DXY_VENDOR_NAME" "${VENDOR_NAME:-${VENDOR_DOMAIN%.tld}}"

  # Customize where you'd like to keep business code, e.g., ~/work
  # - You might want to use a name or abbreviation for your current
  #   business client, to give their code some honor over a generic
  #   default like ~/work. E.g., Acme Industries might be ~/acme
  # - This location is used for a few conveniences:
  #   - For Git projects under this path, the Git user.name and user.email
  #     are fetched according to the Git config template at:
  #       ~/.depoxy/ambers/archetype/home/.gitconfig.user-business.EVAL
  #   - The ~/.depoxy/running/.mrconfigs/_mrconfig-DXY_VENDOR_HOME* config
  #     come pre-wired.
  #
  # E.g., "/home/user/work"
  register "DXY_VENDOR_HOME" "${VENDOR_HOME:-${HOME}/work}"

  # E.g., "work"
  unset -v DXY_VENDOR_HOME_NAME
  register "DXY_VENDOR_HOME_NAME" "$( \
    echo "${DXY_VENDOR_HOME}" \
    | sed -E "s@^${HOME}/@@"
  )"

  # E.g., "/work/"
  # - Used to generate ~/.git/info/exclude
  local vendor_home_home_path="$( \
    format_exclude_rule_home_gitignore "${DXY_VENDOR_HOME}"
  )"
  unset -v DXY_VENDOR_HOME_EXCLUDE_RULE
  register "DXY_VENDOR_HOME_EXCLUDE_RULE" "${vendor_home_home_path}"

  # E.g., "~/work"
  unset -v DXY_VENDOR_HOME_TILDE
  register "DXY_VENDOR_HOME_TILDE" "$( \
    echo "${DXY_VENDOR_HOME}" \
    | sed -E "s@^${HOME}(/|$)@~\1@"
  )"

  # E.g., "$HOME/work"
  # - CXREF: Vimprojects template:
  #   ~/.depoxy/ambers/archetype/home/.vim/pack/landonb/start/dubs_project_tray/.vimprojects.EVAL
  unset -v DXY_VENDOR_HOME_HOME
  register "DXY_VENDOR_HOME_HOME" "$( \
    echo "${DXY_VENDOR_HOME}" \
    | sed -E "s@^${HOME}(/|$)@\\\\\$HOME\1@"
  )"

  # E.g., "${HOME}/work"
  unset -v DXY_VENDOR_HOME__HOME_
  register "DXY_VENDOR_HOME__HOME_" "$( \
    echo "${DXY_VENDOR_HOME}" \
    | sed -E "s@^${HOME}(/|$)@\\\\\${HOME}\1@"
  )"

  # If your client uses an npm registry, you can specify its URL to generate
  # an ~/.npmrc file. E.g., ~/.npmrc might look like this:
  #   registry=https://repo1.employer.tld/artifactory/api/npm/npm-virtual
  # Note, too, that some organizations restrict access to the main npm registry,
  #   http://registry.npmjs.org/npm
  # in which case you'll need to use the corporate npm URL.
  register "DXY_VENDOR_NPM_REGISTRY_URL" ""

  # 1 configurable ~/.netrc machine.
  # - E.g., "nexus.acme.com"
  register "DXY_VENDOR_NETRC_TOKENS01_MACHINE" ""
  # - E.g., "acme"
  register "DXY_VENDOR_NETRC_TOKENS01_LOGIN" ""
  # - E.g., "pass"
  register "DXY_VENDOR_NETRC_TOKENS01_PASS" ""

  # For the `bugs` alias defined on Bash startup by the template at
  #   ~/.depoxy/ambers/archetype/home/bashrx.private.HOSTNAME.EVAL.sh
  # you can make it easy to open your client's ticketing system.
  register "DXY_VENDOR_ISSUE_TRACKER_URL" "https://en.wikipedia.org/wiki/Bug_tracking_system"
}

# You can set Git user names and emails for business and personal projects.
register_customizable_git_config () {
  # DepoXy wires two sets of Git user.name and user.email:
  # your business user, and your personal user.

  # The @biz Git server host (i.e., a GitHub or GitLab URL),
  # e.g., "gitlab.acme.com".
  register "DXY_VENDOR_GITCONFIG_HUB_HOST" "PLEASE_SET_ME"

  # Business user:
  # - Anything under ~/work will use your business user.
  #   - A few sub-repos of DXC that are uploaded to @biz server also biz user.
  # - User can change this user later via .gitconfig.user-business:
  #     ~/.depoxy/ambers/archetype/home/.gitconfig.user-business.EVAL
  # - You can technically use whatever values you want, but I like to use the
  #   same value I see when I approve a PR/MR, or that I see other devs use.
  register "DXY_VENDOR_GITCONFIG_USER_NAME" "PLEASE_SET_ME"
  register "DXY_VENDOR_GITCONFIG_USER_EMAIL" "PLEASE_SET_ME"

  # Git URL user name:
  # - The Git commit username might differ from your user home on
  #   the server, e.g., at one job, the author's commit user was
  #   "Last, First", but the Git URL name was "First.Last".
  # E.g., "First.Last"
  register "DXY_VENDOR_GITSERVER_USER_NAME" "PLEASE_SET_ME"

  # *** user.sh

  # User dotfiles project name:
  # - This is the project name of your corp user's dotfiles project, which
  #   you could push to the vendor's Git server (to share with other devs,
  #   or so it's backed up).
  # E.g., "flast.sh", "firstl.sh", "username.sh"
  register "DXY_VENDOR_DOTFILES_NAME" "${DXY_USERNAME}.sh"

  # - And then, if, e.g.,
  #     DXY_VENDOR_GITCONFIG_HUB_HOST="gitlab.acme.com"
  #     DXY_VENDOR_GITSERVER_USER_NAME="First.Last"
  #     DXY_VENDOR_DOTFILES_NAME="flast.sh"
  #   the complete dotfiles URL is:
  #     https://gitlab.acme.com/First.Last/flast.sh

  # A subset of DXC files are backed up to @biz GitHuLaB and are given
  # a one-line URL-only header (i.e., not Author/Project/License lines).
  # E.g., "https://gitlab.acme.com/User.Name/uname.sh#🥗"
  #  unset -v DXY_VENDOR_DOTFILES_URL
  register "DXY_VENDOR_DOTFILES_URL" \
    "https://${DXY_VENDOR_GITCONFIG_HUB_HOST}/${DXY_VENDOR_GITSERVER_USER_NAME}/${DXY_VENDOR_DOTFILES_NAME}#🥗"
  #
  # E.g., "Project: https://gitlab.acme.com/User.Name/uname.sh#🥗"
  unset -v DXY_HEADER_DOTFILES
  register "DXY_HEADER_DOTFILES" "Project: ${DXY_VENDOR_DOTFILES_URL}"

  # *** acme.sh

  # E.g., "acme.sh".
  register "DXY_VENDOR_ACMESH_NAME" "${DXY_VENDOR_NAME:-acme}.sh"
  #
  # E.g., "https://gitlab.acme.com/User.Name/acme.sh#🧨"
  #  unset -v DXY_VENDOR_ACMESH_URL
  register "DXY_VENDOR_ACMESH_URL" \
    "https://${DXY_VENDOR_GITCONFIG_HUB_HOST}/${DXY_VENDOR_GITSERVER_USER_NAME}/${DXY_VENDOR_ACMESH_NAME}#🧨"
  #
  # E.g., "Project: https://gitlab.acme.com/User.Name/acme.sh#🧨"
  unset -v DXY_HEADER_ACMESH
  register "DXY_HEADER_ACMESH" "Project: ${DXY_VENDOR_ACMESH_URL}"

  # E.g., "acme".
  register "DXY_VENDOR_ACMESH_CMD" "${DXY_VENDOR_ACMESH_NAME%.sh}"

  # E.g., ".acme.conf".
  register "DXY_VENDOR_ACMESH_CONF" ".${DXY_VENDOR_ACMESH_CMD}.conf"
}

# You can set values for non-business things.
register_customizable_personal_values () {
  # Personal user:
  # - Anything not under ~/work will use your personal user.
  # - User can change this user later via .gitconfig.user-personal:
  #     ~/.depoxy/ambers/archetype/home/.gitconfig.user-personal.EVAL
  register "DXY_PERSON_GITCONFIG_USER_NAME" "PLEASE_SET_ME"
  register "DXY_PERSON_GITCONFIG_USER_EMAIL" "PLEASE_SET_ME@${DXY_HOSTNAME}"

  # Optional: Set the Vim package name the `cvs` alias uses to
  #           `pushd ~/.vim/pack/<PUBLISHER>/start`.
  register "DXY_DEPOXY_CVS_ALIAS_VIM_PLUG_ORG" ""

  # Optional: Specify a GVim --servername so that gvim shortcuts always
  #           send files to the same instance.
  # - CXREF: GVIM_OPEN_SERVERNAME
  # - CALSO: DEPOXY_GVIM_ALTERNATE (`fa` command)
  # - Maybe use the client ID instead of default ('SAMPI'):
  #     register "DXY_DEPOXY_GVIM_SERVERNAME" "${DXY_DEPOXY_CLIENT_ID}"
  #   Or for now we'll demo using an emoji.
  register "DXY_DEPOXY_GVIM_SERVERNAME" "🦢"
}

register_placeholder_project_config_values () {
  register "DXY_VENDOR_ORG01_NAME" "soylent"
  #
  register "DXY_VENDOR_ORG01_PROJ01_NAME" "soylent-red"
  register "DXY_VENDOR_ORG01_PROJ01_ABBREV" "sr"

  register "DXY_VENDOR_ORG02_NAME" "globex"
  #
  register "DXY_VENDOR_ORG02_PROJ01_NAME" "hammock-district"
  register "DXY_VENDOR_ORG02_PROJ01_ABBREV" "hd"
  #
  register "DXY_VENDOR_ORG02_PROJ02_NAME" "cypress-creek-running"
  register "DXY_VENDOR_ORG02_PROJ02_ABBREV" "cc"
  register "DXY_VENDOR_ORG02_PROJ02_ABBREV3" "ccr"
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

  # E.g., "/.depoxy/"
  # - Used to generate ~/.gitignore.
  local depoxy_home_path="$( \
    format_exclude_rule_home_gitignore "${DXY_DEPOXYDIR_BASE_FULL}"
  )"
  unset -v DXY_DEPOXYDIR_BASE_EXCLUDE_RULE
  register "DXY_DEPOXYDIR_BASE_EXCLUDE_RULE" "${depoxy_home_path}"

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

  # E.g., "/home/user/.depoxy/running"
  register "DXY_DEPOXYDIR_RUNNING_FULL" \
    "${DEPOXYDIR_RUNNING_FULL:-${HOME}/.depoxy/${DEPOXYDIR_RUNNING_NAME:-running}}"

  # E.g., "running"
  # CXREF: Symlink created by this script;
  #   also reaffirmed by DXC _mrconfig, see: DEPOXYDIR_RUNNING_FULL.
  unset -v DXY_DEPOXYDIR_RUNNING_NAME
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
  # - E.g., "/home/user/.depoxy/.adscititious"
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

register_depoxy_client_paths () {
  # Setup template variables with the new client path, represented all the ways.

  # - Client tilde path, e.g., "~/.depoxy/stints/XXXX"
  unset -v DXY_DEPOXY_CLIENT_TILDE
  register "DXY_DEPOXY_CLIENT_TILDE" "${DXY_DEPOXYDIR_STINTS_TILDE}/${DXY_DEPOXY_CLIENT_ID}"

  # - Client full path, e.g., "/(Users|home)/<user>/.depoxy/stints/XXXX"
  unset -v DXY_DEPOXY_CLIENT_FULL
  register "DXY_DEPOXY_CLIENT_FULL" "${DXY_DEPOXYDIR_STINTS_FULL}/${DXY_DEPOXY_CLIENT_ID}"

  # - Client ${HOME} path, e.g., "${HOME}/.depoxy/stints/XXXX"
  unset -v DXY_DEPOXY_CLIENT__HOME_
  register "DXY_DEPOXY_CLIENT__HOME_" "$( \
    echo "${DXY_DEPOXY_CLIENT_FULL}" \
    | sed -E "s@^${HOME}(/|$)@\\\\\${HOME}\1@"
  )"
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

  # E.g., "/Users/user/.projlns", ripgreppable symlinks collector.
  register "DXY_DEPOXY_PROJLNS" "${DEPOXY_PROJLNS:-${HOME}/.projlns}"

  # E.g., "/.projlns/"
  # - Used to generate ~/.gitignore.
  local projlns_home_path="$( \
    format_exclude_rule_home_gitignore "${DXY_DEPOXY_PROJLNS}"
  )"
  unset -v DXY_DEPOXY_PROJLNS_EXCLUDE_RULE
  register "DXY_DEPOXY_PROJLNS_EXCLUDE_RULE" "${projlns_home_path}"

  # E.g., "~/.projlns"
  unset -v DXY_DEPOXY_PROJLNS_DIR_TILDE
  register "DXY_DEPOXY_PROJLNS_DIR_TILDE" "$( \
    echo "${DXY_DEPOXY_PROJLNS}" \
    | sed -E "s@^${HOME}(/|$)@~\1@"
  )"

  # E.g., "${HOME}/.projlns"
  unset -v DXY_DEPOXY_PROJLNS_DIR__HOME_
  register "DXY_DEPOXY_PROJLNS_DIR__HOME_" "$( \
    echo "${DXY_DEPOXY_PROJLNS}" \
    | sed -E "s@^${HOME}(/|$)@\\\\\${HOME}\1@"
  )"

  # ***

  # Not quite a "project" path, but a customizable path nonetheless.
  # - E.g., "/Users/user/Documents/screencaps"
  register "DXY_DEPOXY_SCREENCAPS_DIR" \
    "${DEPOXY_SCREENCAPS_DIR:-${HOME}/Documents/screencaps}"

  # E.g., "${HOME}/Documents/screencaps"
  unset -v DXY_DEPOXY_SCREENCAPS_DIR__HOME_
  register "DXY_DEPOXY_SCREENCAPS_DIR__HOME_" "$( \
    echo "${DXY_DEPOXY_SCREENCAPS_DIR}" \
    | sed -E "s@^${HOME}(/|$)@\\\\\${HOME}\1@"
  )"

  # E.g., "/Documents/screencaps/"
  # - Used to generate ~/.gitignore (though when under Documents/,
  #   that directory already excluded, so this rule unnecessary;
  #   but included to support alternative screecaps/ paths).
  local screencaps_home_path="$( \
    format_exclude_rule_home_gitignore "${DXY_DEPOXY_SCREENCAPS_DIR}"
  )"
  unset -v DXY_DEPOXY_SCREENCAPS_EXCLUDE_RULE
  register "DXY_DEPOXY_SCREENCAPS_EXCLUDE_RULE" "${screencaps_home_path}"

  # ***

  # E.g., "/Users/user/.kit/sh/home-fries"
  register "DXY_HOMEFRIES_DIR" "${HOMEFRIES_DIR:-${DOPP_KIT:-${HOME}/.kit}/sh/home-fries}"

  # E.g., ".kit/sh/home-fries"
  unset -v DXY_HOMEFRIES_DIR_NAME
  register "DXY_HOMEFRIES_DIR_NAME" "$( \
    echo "${DXY_HOMEFRIES_DIR}" \
    | sed "s@^${HOME}/@@"
  )"

  # E.g., "~/.kit/sh/home-fries"
  unset -v DXY_HOMEFRIES_DIR_TILDE
  register "DXY_HOMEFRIES_DIR_TILDE" "$( \
    echo "${DXY_HOMEFRIES_DIR}" \
    | sed -E "s@^${HOME}(/|$)@~\1@"
  )"

  # E.g., "/.kit/sh/home-fries/"
  # - Used to generate ~/.gitignore.
  local homefries_home_path="$( \
    format_exclude_rule_home_gitignore "${DXY_HOMEFRIES_DIR}"
  )"
  unset -v DXY_HOMEFRIES_DIR_EXCLUDE_RULE
  register "DXY_HOMEFRIES_DIR_EXCLUDE_RULE" "${homefries_home_path}"

  # ***

  # FIXME/2022-12-13: Propagate DOPP_KIT/DXY_DOPP_KIT_NAME usage
  #                   (it's not used everywhere it could be).

  # E.g., "/Users/user/.kit"
  register "DXY_DOPP_KIT" "${DOPP_KIT:-${HOME}/.kit}"

  # E.g., ".kit"
  unset -v DXY_DOPP_KIT_NAME
  register "DXY_DOPP_KIT_NAME" "$( \
    echo "${DXY_DOPP_KIT}" \
    | sed "s@^${HOME}/@@"
  )"

  # E.g., "~/.kit"
  unset -v DXY_DOPP_KIT_TILDE
  register "DXY_DOPP_KIT_TILDE" "$( \
    echo "${DXY_DOPP_KIT}" \
    | sed -E "s@^${HOME}(/|$)@~\1@"
  )"

  # E.g., "/.kit/"
  # - Used to generate ~/.gitignore.
  local dopp_kit_home_path="$( \
    format_exclude_rule_home_gitignore "${DXY_DOPP_KIT}"
  )"
  unset -v DXY_DOPP_KIT_EXCLUDE_RULE
  register "DXY_DOPP_KIT_EXCLUDE_RULE" "${dopp_kit_home_path}"
}

# ***

format_exclude_rule_home_gitignore () {
  local full_path="$1"

  local home_path
  home_path="$(echo "${full_path}" | sed "s@^${HOME}/@@")"

  if [ "${home_path}" != "${full_path}" ]; then
    home_path="/${home_path}/"
  else
    # Not under home.
    home_path=""
  fi

  printf "%s" "${home_path}"
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

# A typical `source_deps` would plumb error checking and would
# localize third-party files under 'deps/'. But the Archetype
# is so tightly coupled to other components of the DepoXy stack
# that we can skip the overhead of a more robust deps setup.

source_deps () {
  # Load: DEPOXY_* path and settings environs.
  local ambers_path="${DEPOXYDIR_BASE_FULL:-${HOME}/.depoxy}/ambers"
  local ambers_root="${DEPOXYAMBERS_DIR:-${ambers_path}}"
  . "${ambers_root}/core/depoxy_fs.sh"

  # Required by distro_util.sh: tweak_errexit
  . "${HOMEFRIES_LIB:-${HOME}/.kit/sh/home-fries/lib}/process_util.sh"
  # Load os_is_macos.
  . "${HOMEFRIES_LIB:-${HOME}/.kit/sh/home-fries/lib}/distro_util.sh"

  # Load user_name_full.
  # - CXREF: ~/.kit/sh/home-fries/lib/user_util.sh
  . "${HOMEFRIES_LIB:-${HOME}/.kit/sh/home-fries/lib}/user_util.sh"
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

  m4_shim_make_file "${tail_lns}" "${tail_path}" "${client_file}" "${dest_path}" "$@" \
    || return 1

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
    >&2 blot
    >&2 blot "ERROR: No such input file: “${tail_path}”"

    return 1
  fi

  prepare_client_fs_dest "${dest_path}" \
    || return 1

  local custom_m4_defines=""
  while [ "$1" != '' ]; do
    m4_define_value_must_be_specified "$@" \
      || return 1

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
  eval $(m4_kludge) \
    --prefix-builtins \
    "${DEPOXY_m4_DEFINES}" \
    "${custom_m4_defines}" \
    <( \
        printf "m4_changecom()"; \
        printf "m4_changequote(\`[[[', \`]]]')"; \
        tail -n "${tail_lns}" "${tail_path}"; \
    ) \
    > "${dest_path}"

  # The previous `eval` is called from an EVAL header within an outer
  # `eval` (from process_file), and does not trip `set -e`, so up to us.
  if [ $? -ne 0 ]; then
    set +x
    >&2 blot
    >&2 blot "ERROR: m4 failed."

    return 1
  fi
}

m4_define_value_must_be_specified () {
  local definition="$1"

  [ ${#@} -lt 2 ] || return 0

  >&2 blot "ERROR: Key or value “${definition}” expects a value or key"

  return 1
}

# KLUGE: macOS Sonoma 14.4.1 `m4` always raises install-Xcode dialog,
# i.e., it's a buggy little scamp.
m4_kludge () {
  command -v gm4 || command -v m4
}

gnu_readlink () {
  command -v greadlink || command -v readlink
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

  >&2 blot "ERROR: The target directory is not empty!"
  >&2 blot "- Please check: “${DXY_DEPOXY_CLIENT_FULL}”"

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
    # - Caveat: readline <Up> is usually bound to previous-history
    #   and/or history-search-backward, so if user presses <Up>, it
    #   uses the previous command line as `read` input. This can be
    #   very confusing to the user! So it's a trade-off, really,
    #   and maybe it makes more sense *not* to use `read -e`...
    #   - CXREF: See Homefries for a more complete sol'n that
    #     temporarily unbinds <Up> during the `read` prompt:
    #       ~/.kit/sh/home-fries/lib/ask_yes_no_default.sh
    read -e -n 1 ignored_key

    [ -z "${ignored_key}" ] || echo

    blot
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

  # E.g., "/home/user/.depoxy"
  mkdir_with_trace "${DXY_DEPOXYDIR_BASE_FULL}"

  # E.g., "/home/user/.depoxy/stints"
  mkdir_with_trace "${DXY_DEPOXYDIR_STINTS_FULL}"

  ! ${DXY_RUN_LNS_ONLY:-false} || return 0

  # E.g., "/home/user/.depoxy/stints/XXXX"
  mkdir_with_trace "${DXY_DEPOXY_CLIENT_FULL}"

  prepare_depoxy_running_symlink
}

prepare_depoxy_running_symlink () {
  # E.g., "/home/user/.depoxy/running"
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
    # Usually ~/.depoxy/stints/<ID> is subdir of ~/.depoxy so use easy
    # prefix removal to produce relative path.
    local rel_path="${DXY_DEPOXY_CLIENT_FULL#$(dirname -- "${DXY_DEPOXYDIR_RUNNING_FULL}")/}"
    ln_with_trace "${rel_path}" "${DXY_DEPOXYDIR_RUNNING_FULL}"
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

# Insists target directory is subdirectory.
prepare_client_fs_dest () {
  local dest_path="$1"

  local dest_dir
  dest_dir="$(dirname -- "${dest_path}")"

  local dest_dir_abs
  dest_dir_abs="$($(gnu_readlink) -m -- "${dest_dir}")"

  local client_dir_abs
  client_dir_abs="$($(gnu_readlink) -m -- "${DXY_DEPOXY_CLIENT_FULL}")" 

  if [ "${dest_dir_abs#${client_dir_abs}}" = "${dest_dir_abs}" ]; then
    # Prefix not stripped, i.e., not a subdir.
    >&2 blot "$(alert "ERROR: Not a symlink: ${DXY_DEPOXYDIR_RUNNING_FULL}")"

    return 1
  fi

  mkdir -p -- "${dest_dir}"
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
#   find . -path ./.git -prune -o -type d -exec echo "${DXY_DEPOXY_CLIENT_FULL}/{}" \;

# SAVVY: Use `-mindepth 1` to exclude current directory (.).

# This fcn. prepares an empty directory hierarchy matching DXA's hierarchy.
# - This is used to prepared the symlinks tree before populating symlinks.
# - Note that is not used to seed the new DepoXy Client directory, because
#   some directory names are based on template values, and we don't want to
#   end up with empty directories.
#   - Note this means m4_shim will call `mkdir -p` as necessary, and that
#     EVAL files are aware they must create destination paths as appropriate.

prepare_client_fs () {
  local client_path="$1"

  ${DXY_RUN_MAKE_LNS:-false} || return 0

  if ${DRY_RUN}; then
    blot
    find . -mindepth 1 -path ./.git -prune -o -type d -exec echo "mkdir: ${client_path}/{}" \; \
      | tee_or_cat

    return 0
  fi

  find . -mindepth 1 -path ./.git -prune -o -type d -exec mkdir "${client_path}/{}" \;
}

prepare_symlinks_fs () {
  # E.g., /home/user/.depoxy/stints/.syml--XXXX
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

    if ${DRY_RUN}; then
      blot
    fi
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

  local blot_fname=""
  ${DRY_RUN} || blot_fname=" ${fname}"
  blot "COPY:${blot_fname}"
  ! ${DXY_OUTPUT_VERBOSE} || blot

  if ${DRY_RUN}; then
    blot "$(\
      printf "%s\n%s\n%s" \
        "  command cp -R -P -- \\" \
        "    \"${fname}\" \\" \
        "    \"${dest_path}\""
      )"
    blot

    return 0
  fi

  prepare_client_fs_dest "${dest_path}" \
    || return 1

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

  local blot_fname=""
  ${DRY_RUN} || blot_fname=" ${fname}"
  if ${DXY_RUN_LNS_ONLY:-false}; then
    blot "LINK:${blot_fname}"
    blot
  fi

  if ${DRY_RUN}; then
    blot "LINK:"
    blot "$(\
      printf "%s\n%s\n%s" \
        "  command ln -s \\" \
        "    \"${dest_path}\" \\" \
        "    \"${DXY_MAKE_LNS_FULL}/${fname}\""
      )"
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

  local blot_fname=""
  ${DRY_RUN} || blot_fname=" ${fname}"
  blot "EVAL:${blot_fname}"
  ! ${DXY_OUTPUT_VERBOSE} || blot

  # See DEV hook atop file. If set, only test specific file.
  [ -z "${TEST_FILE}" ] || [ "${TEST_FILE}" = "${fname}" ] || return 0

  if ${DXY_OUTPUT_VERBOSE} || ${DRY_RUN}; then
    # The `set -x` before `eval` prints eval_cmd, so only print on DRY_RUN.
    blot "${eval_cmd}"
    blot
  fi

  if ${DRY_RUN}; then
    # Note on DRY_RUN, won't process_eval, so EVAL `LINK:` won't be traced.

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
      echo "${eval_cmd}" >> "${DXY_CAPTURE_FILE_PATH}"
      echo >> "${DXY_CAPTURE_FILE_PATH}"

      # Note that `set -x` writes to stdout.
      if ! process_eval >> "${DXY_CAPTURE_FILE_PATH}" 2>&1; then
        blot
        blot "ERROR: EVAL failed:"

        # This will errexit.
        process_eval
        # Unreachable, but what effectively happens.
        exit_1
      fi

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

init_repo_with_empty_message () {
  local git_user_name="$1"
  local git_user_email="$2"
  local repo_path="$3"
  local branch="$4"
  local empty_msg="$5"

  ! ${DXY_RUN_LNS_ONLY:-false} || return 0

  ! ${DRY_RUN} || return 0

  if [ -z "${empty_msg}" ]; then
    blot "Skipping git-init without commit message: ${repo_path}"

    return 0
  fi

  mkdir -p -- "${repo_path}"

  cd "${repo_path}"

  # Note that Git config not guaranteed to be wired, so specify
  # necessary config, like the user.
  local conf_opts=" \
    -c user.name=\"${git_user_name}\" \
    -c user.email=\"${git_user_email}\" \
  "

  git init -q -b "${branch}" .

  eval "git ${conf_opts} commit -q --allow-empty -m \"${empty_msg}\""

  cd - > /dev/null
}

init_repo_with_empty_message_person_user () {
  init_repo_with_empty_message \
    "${DXY_PERSON_GITCONFIG_USER_NAME}" \
    "${DXY_PERSON_GITCONFIG_USER_EMAIL}" \
    "$@"
}

init_repo_with_empty_message_vendor_user () {
  init_repo_with_empty_message \
    "${DXY_VENDOR_GITCONFIG_USER_NAME}" \
    "${DXY_VENDOR_GITCONFIG_USER_EMAIL}" \
    "$@"
}

# ***

init_repo_client () {
  local empty_msg=""
  if [ -n "${DXY_DEPOXY_INIT_CLIENT_COMMIT+x}" ]; then
    empty_msg="${DXY_DEPOXY_INIT_CLIENT_COMMIT}"
  else
    empty_msg="Flaming: hotnew: DepoXy Client ${DXY_DEPOXY_CLIENT_ID}"
  fi

  init_repo_with_empty_message_person_user \
    "${DXY_DEPOXY_CLIENT_FULL}" \
    "private" \
    "${empty_msg}"
}

# ***

init_repo_acmesh () {
  local empty_msg=""
  if [ -n "${DXY_DEPOXY_INIT_ACMESH_COMMIT+x}" ]; then
    empty_msg="${DXY_DEPOXY_INIT_ACMESH_COMMIT}"
  else
    empty_msg="${DXY_VENDOR_ACMESH_NAME}: ${DXY_VENDOR_NAME_PROPER} shell juice"
  fi

  init_repo_with_empty_message_vendor_user \
    "${DXY_DEPOXY_CLIENT_FULL}/${DXY_VENDOR_ACMESH_NAME}" \
    "release" \
    "${empty_msg}"
}

# ***

# Create the ~/work project stubs
omr_acme_checkout () {
  ! ${DRY_RUN} || return 0

  # Assume not client machine if caller set custom DXY_HOSTNAME.
  [ "${DXY_HOSTNAME}" = "$(hostname)" ] || return 0

  # CXREF: E.g.,
  #   ~/work/globex/hammock-district
  #   ~/work/soylent/soylent-red
  #   ~/work/soylent/ignore-tests--soylent-red
  for vendor_proj in \
    "${DXY_VENDOR_HOME}/${DXY_VENDOR_ORG02_NAME}/${DXY_VENDOR_ORG02_PROJ01_NAME}" \
    "${DXY_VENDOR_HOME}/${DXY_VENDOR_ORG01_NAME}/${DXY_VENDOR_ORG01_PROJ01_NAME}" \
    "${DXY_VENDOR_HOME}/${DXY_VENDOR_ORG01_NAME}/ignore-tests--${DXY_VENDOR_ORG01_PROJ01_NAME}" \
  ; do
    local base_dir
    base_dir="$(dirname -- "${vendor_proj}")"

    blot
    blot mkdir -p -- "${base_dir}"
    blot cd "${base_dir}"
    blot mr -d "${vendor_proj}" -n checkout
    blot

    mkdir -p -- "${base_dir}"

    (
      cd "${base_dir}"

      # Meh: We could `| tee_or_cat` but then there's no realtime output,
      # and there's no compelling reason to capture this output anyway.

      SHCOLORS_OFF=false \
      mr -d "${vendor_proj}" -n checkout \
        | sed 's/^/  /'
    )
  done
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

# Avoid spells.sh creating <DXC>/home/.vim/spell/en.utf-8.add--compiled
# and telling you to merge into <DXC>/home/.vim/spell/en.utf-8.add (which
# is symlinked from ~/.vim/spell/en.utf-8.add), because when --compiled
# differs from canon, it sometimes indicates non-obvious issue occurred.
# - But in this case, indicates that canon not synced with spells yet,
#   which we'll automate here.

omr_dxc_compile_spells () {
  ! ${DRY_RUN} || return 0

  (
    local homeish_path="${DXY_DEPOXY_CLIENT_FULL}/home"

    local compiled_spells
    compiled_spells="$(spells.sh compile-spells "${homeish_path}" 2> /dev/null)"

    # Loads: SPF_SPELLS
    # CXREF: ~/.depoxy/ambers/bin/spells.sh
    . "spells.sh"
    init_spellssh
    # Loads: SPELLS_COMPILED_SUFFIX
    # CXREF: ~/.kit/txt/spellfile.txt/bin/spells.sh
    # - ALTLY:
    #   . "${SPELLFILE_DIR:-${DOPP_KIT:-${HOME}/.kit}/txt/spellfile.txt}/bin/spells.sh"
    . "${SPF_SPELLS}"
    init_spellssh

    blot
    blot command mv -- "${compiled_spells}" "${compiled_spells%${SPELLS_COMPILED_SUFFIX}}"
    blot

    command mv -- "${compiled_spells}" "${compiled_spells%${SPELLS_COMPILED_SUFFIX}}"
  )
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

_promote_homebrew_bash () {
  # CUPLD/2024-05-15: As mentioned atop source_deps, don't worry about
  # dependency error checking, or localizing 'deps/'.
  . "${MOSREPOSPATH:-${DOPP_KIT:-${HOME}/.kit}/mOS}/macOS-onboarder/lib/promote-homebrew-bash.sh"

  promote_homebrew_bash "$@"
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

clear_traps () {
  trap - EXIT INT
}

set_traps () {
  trap -- trap_exit EXIT
  trap -- trap_int INT
}

exit_0 () {
  clear_traps

  exit 0
}

exit_1 () {
  clear_traps

  exit 1
}

trap_exit () {
  clear_traps

  # USAGE: Alert on unexpected error path, so you can add happy path.
  >&2 echo "ALERT: "$(basename -- "$0")" exited abnormally!"
  >&2 echo "- Hint: Enable \`set -x\` and run again..."

  exit 2
}

trap_int () {
  clear_traps

  exit 3
}

# ***

main () {
  set -e

  set_traps

  # Run from the root of this file.
  local archetype_root="$(dirname -- "$(realpath -- "$0")")"
  local deploysh_name="$(basename -- "$0")"

  cd "${archetype_root}"

  source_deps

  parse_args "$@"

  register_customizable_client_ids
  register_generated
  register_depoxydir_paths
  register_depoxy_client_paths
  register_depoxy_project_paths
  register_git_put_wise_paths
  register_customizable_headers
  register_customizable_business_values
  register_customizable_personal_values
  register_customizable_git_config
  register_placeholder_project_config_values

  fail_if_missing_vars

  prepare_m4_defines

  fail_if_target_exists_and_non_empty

  prepare_capture_file

  prompt_continue_or_exit

  prepare_depoxy_fs
  prepare_symlinks_fs
  process_files

  init_repo_client
  init_repo_acmesh
  omr_acme_checkout
  omr_dxc_infuse
  omr_dxc_compile_spells
  omr_dxc_autocommit
  omr_dxc_cleanup
  finish_capture_file
  announce_completed
  
  clear_traps
}

if [ "$0" = "${BASH_SOURCE[0]}" ]; then
  # Being executed.
  # - Promote to Bash v5 (avoid Bash v3) so EVAL scripts can use ${foo^^}, etc.
  if ! _promote_homebrew_bash "$@"; then
    main "$@"
  fi
else
  source_deps
fi

unset -f main
unset -f parse_args
unset -f source_deps

