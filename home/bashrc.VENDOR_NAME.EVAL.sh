# USAGE:
#   m4_shim \
#     "+14" "home/bashrc.VENDOR_NAME.EVAL.sh" \
#     "home/bashrc.${DXY_VENDOR_NAME}.sh" \
#     "DXY_VENDOR_GITSERVER_USER_URL" \
#       "https://${DXY_VENDOR_GITCONFIG_HUB_HOST}/${DXY_VENDOR_GITSERVER_USER_NAME}" \
#     "DXY_VENDOR_ORG01_PROJ01_CD_ALIAS" \
#       "cd${DXY_VENDOR_ORG01_PROJ01_ABBREV}" \
#     "DXY_VENDOR_ORG02_PROJ02_CD_ALIAS" \
#       "cd${DXY_VENDOR_ORG02_PROJ02_ABBREV}"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# vim:tw=0:ts=2:sw=2:et:norl:ft=bash
# DXY_HEADER_AUTHOR
# DXY_HEADER_DOTFILES

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# USAGE: Below are some examples of private Bashrc the author has
#        used in the past. Change or remove this file to taste.

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# YOU: Add aliases as appropriate to the individual client projects.
#
# - E.g., if I was working on a application named 'DXY_VENDOR_ORG01_PROJ01_NAME',
#   I might make an alias called `DXY_VENDOR_ORG01_PROJ01_CD_ALIAS`.
#
#   Or perhaps if the application was called, 'DXY_VENDOR_ORG02_PROJ02_NAME',
#   I might make an alias called `cd[[[]]]DXY_VENDOR_ORG02_PROJ02_ABBREV` or `cd[[[]]]DXY_VENDOR_ORG02_PROJ02_ABBREV3`.
#
#   Basically, I like to use the `cd` prefix and then two or three
#   characters from the project name as an abbreviation or mnemonic
#   to help me remember the alias.
#
# - The `dd`-prefix is also nice to use. Except for the system `dd`
#   command, `dd<Tab>` usually only shows your aliases or commands.

bashdx_wire_aliases_pushd_paths_vendor_projects () {
  # *** User's dot projects
  #
  # - CXREF:
  #   DXY_VENDOR_GITSERVER_USER_URL

  pushd_alias_or_warn "dddf" "${DEPOXYDIR_STINTS_FULL:-DXY_DEPOXYDIR_STINTS__HOME_}/DEPOXY_CLIENT_ID/DXY_VENDOR_DOTFILES_NAME"
  pushd_alias_or_warn "ddac" "${DEPOXYDIR_STINTS_FULL:-DXY_DEPOXYDIR_STINTS__HOME_}/DEPOXY_CLIENT_ID/DXY_VENDOR_ACMESH_NAME"

  # *** Vendor's (example) projects

  pushd_alias_or_warn "cd[[[]]]DXY_VENDOR_ORG02_PROJ01_ABBREV" "${VENDOR_HOME:-DXY_VENDOR_HOME__HOME_}/DXY_VENDOR_ORG02_NAME/DXY_VENDOR_ORG02_PROJ01_NAME"

  # - The author will sometimes create a sibling directory with the 'develop'
  #   branch checked out so that `feature-coverage-report` will run coverage
  #   in parallel.
  #   - REFER: https://github.com/DepoXy/feature-coverage-report#🖌️
  # - For example (i.e., this directory may not exist):
  pushd_alias_or_warn "cd[[[]]]DXY_VENDOR_ORG02_PROJ01_ABBREV[[[]]]d" "${VENDOR_HOME:-DXY_VENDOR_HOME__HOME_}/DXY_VENDOR_ORG02_NAME/DXY_VENDOR_ORG02_PROJ01_NAME--develop"

  # YOU: If you have more complicated setup, you could shove that in an
  # alias, or better yet, kick it out to its own function. For example,
  function DXY_VENDOR_ORG01_PROJ01_CD_ALIAS () {
    pushd "${VENDOR_HOME:-DXY_VENDOR_HOME__HOME_}/DXY_VENDOR_ORG01_NAME/DXY_VENDOR_ORG01_PROJ01_NAME" &> /dev/null;
    [ "$(node -v)" = "v10.23.0" ] || nvm use 10
  }
  # You might also want to look into using dotenv or direnv.
  #   https://direnv.net/
  # Or employ the _work_env_* mechanisms discussed next.
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# Advanced `cd` Project example.
#
# This is change-directory `cdXX` example that grows its own direnv-like
# enter setup and exit cleanup. Except rather than run the exit code when
# you leave the project directory, it'll run when you `cdXX` to another
# project (that uses the same mechanism).
#
# See the _work_env_* defs in ~/.depoxy/ambers/core/cdworkenv.sh

DXY_VENDOR_ORG02_PROJ02_CD_ALIAS () {
  pushd "${VENDOR_HOME:-DXY_VENDOR_HOME__HOME_}/DXY_VENDOR_ORG02_NAME/DXY_VENDOR_ORG02_PROJ02_NAME" &> /dev/null

  [ "$(node -v)" = "v14.16.0" ] || nvm use 14

  _work_env_prepare

  # Set the URL to the 'test' environment.
  _work_env_define 'WORK_URL_TEST' \
    'https://test-local.domain.com/app.html'

  # Set the URL to the 'stage' environments.
  # - Perhaps there are many, one for different portals.
  # PORTAL_A
  _work_env_define 'WORK_URL_STAGE_PORTAL_A' \
    'https://stage-portal-a.domain.com/path/to/app.html'
  # portal_iii:
  _work_env_define 'WORK_URL_STAGE_portal_iii' \
    'https://stage-portal-iii.domain.com/path/to/app.html'
  # The default stage URL:
  _work_env_define 'WORK_URL_STAGE' "${WORK_URL_STAGE_PORTAL_A}"
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# YOU: Set this to run a command when the terminal starts.
# - E.g., if you wanted to change to the DXY_VENDOR_ORG02_PROJ01_NAME
#   directory using the alias you set above, you could do this:
bashhf_set_start_command () {
  HOMEFRIES_EVAL='cd[[[]]]DXY_VENDOR_ORG02_PROJ01_ABBREV'
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

main () {
  bashdx_wire_aliases_pushd_paths_vendor_projects
  unset -f bashdx_wire_aliases_pushd_paths_vendor_projects

  bashhf_set_start_command
  unset -f bashhf_set_start_command
}

main "$@"
unset -f main

