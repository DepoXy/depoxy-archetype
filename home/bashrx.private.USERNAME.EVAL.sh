# USAGE:
#   m4_shim \
#     "+10" "home/bashrx.private.USERNAME.EVAL.sh" \
#     "home/bashrx.private.${DXY_USERNAME}.sh" \
#     "BUSINESS_PROJECT_BASE" \
#       "https://${BUSINESS_GITCONFIG_HUB_HOST}/$(dirname -- "${DXY_VENDOR_GITSERVER_USER_REPO}")"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# vim:tw=0:ts=2:sw=2:et:norl:ft=bash
# DXY_HEADER_AUTHOR
# DXY_HEADER_DOTPROJECT

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# USAGE: See the example file for an idea of what to add herein:
#
#   DXY_DEPOXY_CLIENT_TILDE/home/bashrx.private.DXY_USERNAME.EVAL.sh.example

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

main () {
  # Wait for the second pass to run.
  ${HOME_FRIES_PRELOAD} && return

  # No-op.
  :
}

main "$@"
unset -f main

