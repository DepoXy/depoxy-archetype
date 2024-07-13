# vim:tw=0:ts=2:sw=2:et:norl:ft=bash
# Author: Landon Bouma <https://tallybark.com/>
# Project: https://github.com/DepoXy/depoxy-archetype#🏹
# License: MIT

# Copyright (c) © 2020-2023 Landon Bouma. All Rights Reserved.

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# (Surprisingly, perhaps) this path is not environ-overrideable.
NOT_NOT_VIB_DIR="notable-notes--vibrant"
NOT_NOT_WOO_DIR="notable-notes--woodlot"

# CPYST: To resolve Unicode escapes in normal `ls`, echo it, e.g.,
#   /bin/ls         # shows, e.g., '05☞☞☞☞☞☞'$'\360\237\247\275''☞☞...'
#   echo "$(ll)"    # shows, e.g., '05☞☞☞☞☞☞🧽☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞...'

print_placeholders__vibrant () {
  cat << EOF
01☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞👈☞☞☞☞☞☞☞☞
02☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
03☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
04☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞🐍☞
05☞☞☞☞☞☞🧽☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
06☞☞☞☞☞☞🍌☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
07☞☞☞☞☞☞🐥☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
08☞☞☞☞☞☞🍱☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
09☞☞☞☞☞☞🧀☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
10☞☞☞☞☞☞🦲☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
11☞☞☞☞☞☞🍋☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
12☞☞☞☞☞☞🌮☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
13☞☞☞☞☞☞🌔☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
14☞☞☞☞☞☞👝☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
15☞☞☞☞☞☞😰☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
16☞☞☞☞☞☞🍯☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
17☞☞☞☞☞☞🥟☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
18☞☞☞☞☞☞🧈☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
19☞☞☞☞☞☞🥪☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
20☞☞☞☞☞☞🐝☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
21☞☞☞☞☞☞🏵☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
22☞☞☞☞☞☞🍰☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
23☞☞☞☞☞☞🥯☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
24☞☞☞☞☞☞👃☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
25☞☞☞☞☞☞🥧☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
26☞☞☞☞☞☞🏚☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
27☞☞☞☞☞☞🌼☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
28☞☞☞☞☞☞👑☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
29☞☞☞☞☞☞🪤☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
30☞☞☞☞☞☞🎾☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞☞
EOF
}

print_placeholders__woodlot () {
  cat << EOF
01
02
03
04
05
06
07
08
09
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
EOF
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

manage_netrw_placeholders () {
  (
    cd "$(dirname -- "$0")/${NOT_NOT_VIB_DIR}"
    print_placeholders__vibrant | revive_or_die_placeholder_assets
  )

  (
    cd "$(dirname -- "$0")/${NOT_NOT_WOO_DIR}"
    print_placeholders__woodlot | revive_or_die_placeholder_assets
  )
}

# ***

revive_or_die_placeholder_assets () {
  local line
  while read -r line; do
    local prefix="$(echo "${line}" | sed 's/^\([0-9]\+\).*/\1/')"

    # Allow easy renaming: remove any file with same prefix (we'll recreate
    # it if necessary; or leave it removed if corresponding symlink exists).
    find . -maxdepth 1 -type f -iname "${prefix}*" -exec /bin/rm {} +

    if test -n "$(find . -maxdepth 1 -type l -iname "${prefix}*")"; then
      >&2 echo "${prefix}: Removed placeholder(s)"
    else
      touch "${line}"

      >&2 echo "${prefix}: Created placeholder"
    fi
  done
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

main () {
  manage_netrw_placeholders
}

# Run iff executed.
if ! $(printf %s "$0" | grep -q -E '(^-?|\/)(ba|da|fi|z)?sh$' -); then
  main "$@"
fi

