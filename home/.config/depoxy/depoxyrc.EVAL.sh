# USAGE:
#   m4_shim \
#     "+8" "home/.config/depoxy/depoxyrc.EVAL.sh" \
#     "home/.config/depoxy/depoxyrc"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

#!/usr/local/bin/bash
# vim:tw=0:ts=2:sw=2:et:norl:ft=bash
# DXY_HEADER_AUTHOR
# DXY_HEADER_PROJECT
# DXY_HEADER_LICENSE

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# BWARE: Be sure to edit this file from within your DepoXy Client project.
#        - Do not edit ~/.config/depoxy/depoxyrc, which is a copy, and
#          will be overwritten on `mr infuse`.

# USAGE: Edit this file — then call `infuse`.

# SAVVY: This file is essentially used to set
#
#          export DEPOXY_IS_CLIENT=true
#
#        on the client machine.

# CXREF: See also the private Bashrc that's sourced on Bash init, which
#        is a better place to customize most aspects of the environment:
#
#           ~/.depoxy/ambers/archetype/home/bashrx.private.HOSTNAME.sh
#
#        But note that this file is meant to be persistently accessible,
#        whereas a `23skidoo` will unmount your DepoXy Client project,
#        including `home/bashrx.private.HOSTNAME.sh`.

# BWARE: While DepoXy *tries* to support personalized (non-standard) paths,
#        e.g., perhaps `DEPOXYDIR_BASE_FULL="${HOME}/your/preferred/path"`,
#        the author has not tested this functionality. You're welcome to
#        try, and you're welcome to submit PRs, but there's no guarantee
#        you won't find issues.

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# *** DepoXy Ambers project config
#
#   https://github.com/DepoXy/depoxy#🍯

# ***

# NOTE: The DEPOXY_IS_CLIENT environ duplicates an older mechanism,
#       which was to check a hostnames file:
#         DXY_DEPOXY_CLIENT_TILDE/.hostnames
#       The .hostnames file is still used as a validity check to
#       verify that certain functions are only run on the client,
#       or not run on the client.
#       - Search DEPOXY_HOSTNAMES_NAME for usage.
# MAYBE: We could remove this variable if we made a depoxy_fs.sh
#        function that returns true if host matches ./.hostnames
#        file. Or maybe we could remove .hostnames now that this
#        environ is available. Not the DRYest, but not used much.
export DEPOXY_IS_CLIENT=true

# E.g., "2324" [*YRWK* format]
export DEPOXY_CLIENT_ID="DXY_DEPOXY_CLIENT_ID"

# ***

# E.g., "${HOME}/.depoxy/ambers"
export DEPOXYAMBERS_DIR="DXY_DEPOXYAMBERS_DIR"

# E.g., "${HOME}/.depoxy/ambers/archetype"
export DEPOXYARCHETYPE_DIR="DXY_DEPOXYARCHETYPE_DIR"

# ***

# ***** DepoXy filespace
#
#   CXREF: ~/.depoxy/ambers/core/depoxy_fs.sh

# E.g., "${HOME}/.depoxy"
export DEPOXYDIR_BASE_FULL="DXY_DEPOXYDIR_BASE_FULL"

# E.g., "stints" (relative to ~/.depoxy)
export DEPOXYDIR_STINTS_NAME="DXY_DEPOXYDIR_STINTS_NAME"

# E.g., "running" (relative to ~/.depoxy)
export DEPOXYDIR_RUNNING_NAME="DXY_DEPOXYDIR_RUNNING_NAME"

# E.g., ".hostnames" (relative to ~/.depoxy/stints/${DEPOXY_CLIENT_ID}/)
export DEPOXY_HOSTNAMES_NAME="DXY_DEPOXY_HOSTNAMES_NAME"

# E.g., "${HOME}/.projlns"
export DEPOXY_PROJLNS="DXY_DEPOXY_PROJLNS_DIR__HOME_"

# E.g., "${HOME}/Documents/screencaps"
export DEPOXY_SCREENCAPS_DIR="DXY_DEPOXY_SCREENCAPS_DIR__HOME_"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# *** Homefries project config
#
#   CXREF: ~/.homefries
#     https://github.com/landonb/home-fries#🍟

# Path to home-fries checkout, e.g., ~/.homefries
#
#  export HOMEFRIES_DIR="${HOME}/.homefries"

# Path to home-fries bin/. e.g., ~/.homefries/bin
#
#  export HOMEFRIES_BIN="${HOMEFRIES_DIR:-${HOME}/.homefries}/bin"

# Assortment of different shell projects' scripts
#
#  export SHOILERPLATE="${HOME}/.kit/sh"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# *** Oh My Repos project config
#
#   CXREF: ~/.kit/git/ohmyrepos
#     https://github.com/landonb/ohmyrepos#😤

# Path to OMR lib/, e.g., ~/.kit/git/ohmyrepos/lib
#
#  export OHMYREPOS_LIB="${GITREPOSPATH:-${HOME}/.kit/git}/ohmyrepos/lib"

# Specify base URL for `_github_url_according_to_user`.
# - Defaults https://github.com/
# - Used by `git_clone_giturl`:
#   - Via `mr_repo_checkout` via 'checkout'.
#   - Via 'wireRemotes' and 'reportRemotes'.
# - On @leader machine where personal Git SSH is setup, you might use:
#     export MR_GIT_HOST_ORIGIN="git@github.com:"
# - On @client, you might just use HTTPS for pull access only:
#     export MR_GIT_HOST_ORIGIN="https://github.com/"
#
#  export MR_GIT_HOST_ORIGIN="git@github.com:"
export MR_GIT_HOST_ORIGIN="https://github.com/"

# *** Unless the 🧜 is the famous `mredit`
#
#   CXREF: ~/.kit/git/myrepos-mredit-command
#     https://github.com/DepoXy/myrepos-mredit-command#🧜

# Path to generated mrconfig symlinks, used by `mredit`/`mropen`.
export MREDIT_CONFIGS="${DEPOXY_PROJLNS:-${HOME}/.projlns}/mymrconfigs"

# Specify known remotes not configured in OMR (e.g., those
# managed by 'ffssh', and 'travel' and 'unpack').
#
#  export MR_KNOWN_REMOTES="host1 host2 host3"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# *** git-put-wise patch sharing
#
#   CXREF: ~/.kit/git/git-put-wise

# E.g., ${HOME}/.depoxy/patchr
export PW_PATCHES_REPO="DXY_PW_PATCHES_REPO"

# Password Store entry containing GPG passphrase to use.
# - Without this, when git-put-wise calls GPG, you'll be
#   prompted twice for each archive being created, or once
#   for each archive being unpacked, which quickly becomes
#   tedious.
export PW_OPTION_PASS_NAME="DXY_PW_OPTION_PASS_NAME"

# So `pw push` doesn't over-prompt (and `pw apply` can be illustrative).
export PW_OPTION_QUICK_TIG=true

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# Prefer tig-newton's editor-vim-0-0-insert-minimal.
export TN_OPTION_EDITOR_VIM=true

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# Add post rebase `exec` to repair hard links broken on Git rebase.
# - The author uses hard links to keep deps/ dependencies synced
#   across disparate Git repos.
#   - Look for link_hard usage in DepoXy OMR 'infuse' tasks.
# - CXREF: Used by git-smart (git-abort and git-fup)
#   and by tig-newtons (each of the rebase commands):
#     ~/.kit/git/git-smart/bin/git-abort
#     ~/.kit/git/git-smart/bin/git-fup
#     ~/.kit/git/tig-newtons/tig/bind-rebase
#     ~/.kit/git/tig-newtons/bin/range-command-apply-rebase

export GIT_POST_REBASE_EXEC="(mr -q -d . -n infusePostRebase && echo 'Effectually reinfused hard links.' || true)"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# Enable unnecessary git-bump dependency.

export GIT_BUMP_VERSION_TAG_PEP400CMP_ENABLE=true

export GITNUBS_DEV=true

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# Tell slather-defaults (macOS-onboarder) if personal or professional machine.
# - On personal machine, reminders include all OMR install tasks.
# - On professional machine, reminders omit projects you won't need
#   (like GnuCash).

export OMR_ECHO_INSTALL_DXY_SCOPE="dxy_pro"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

export DEPOXY_PYENV_PYVERS="3.12.1"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# For `grip-pass`
#
# export GRIP_PASS_ADDY="localhost:6419"
# export GRIP_PASS_PATH="pass/path/to/github/token"

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

# Set this to enable both caffeinate and pmset.
export DEPOXY_ENABLE_KEEP_ALIVE=false

# Set this to enable only caffeinate.
# - BWARE: Inhibits macOS "Screen Saver" (that you might set via macOS's
#   14.4.1's Prefs. > Lock Screen > *Start Screen Saver when inactive*).
#   - UCASE: Your org locks system prefs (you cannot change timeout) and
#     screen saver requires pwd logon.
#     - I.e., you cannot tea or bio break, or check your phone without
#       having to log back on again.
export DEPOXY_ENABLE_KEEP_ALIVE_CAFFEINATE=false

# Set this to enable only pmset.
export DEPOXY_ENABLE_KEEP_ALIVE_PMSET=false

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# 2021-08-22: Tell DepoXy Ambers how to define `cvs`. E.g.,
#   pushd_alias_or_warn "cvs" "${HOME}/.vim/pack/<username>/start"
export DEPOXY_CVS_ALIAS_VIM_PLUG_ORG='DXY_DEPOXY_CVS_ALIAS_VIM_PLUG_ORG'

# *** GVim opener project config
#
#   CXREF: ~/.kit/sh/gvim-open-kindness/bin/gvim-open-kindness
#     https://github.com/landonb/gvim-open-kindness#🐬

# The Vim server name used to open files in the same instance. E.g.,
#   gvim --servername SAMPI --remote-silent <file file...>
# - Used by `fs` command, among other mechanisms.
export GVIM_OPEN_SERVERNAME="DXY_DEPOXY_GVIM_SERVERNAME"

# The complementary `fa` command (for running 2 gvim, e.g.,) uses
# a separate servername you could customize here.
#
# export DEPOXY_GVIM_ALTERNATE=ALPHA

# Set this to override gVim/MacVim initial geometry
# if gvim-open-kindness opens new instance, e.g.,
#
#   export GVIM_OPEN_GEOMETRY="1,414,66,1859,1220"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

export ACMESH_CONF_USER="DXY_DEPOXY_CLIENT__HOME_/home/DXY_VENDOR_HOME_NAME/DXY_VENDOR_ACMESH_CONF"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

