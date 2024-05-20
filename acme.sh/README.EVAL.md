// USAGE:
//   m4_shim \
//     "+8" "acme.sh/README.EVAL.md" \
//     "${DXY_VENDOR_ACMESH_NAME}/README.md"

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# DXY_VENDOR_ACMESH_NAME 🧨

## What is

Bash shell integration that codifies common workflows.

## For whom

If you live in the terminal, this project might appeal to you.

## How works

Source the included shell script to codify a lot
of the DXY_VENDOR_NAME_PROPER shell workflows you'll find in various
project *READMEs*, comments, the Corporate wiki, etc.

- Essentially, these are shell commands that the author found
  themself too often copy-pasting from others docs, or from
  their own notes.

  By codifying these tasks in a shell script, it makes them more
  convenient to run, and it ensures they're always run the same way.

## Quick-start

```
  $ . path/to/DXY_VENDOR_ACMESH_NAME

  $ ac-
  Commands:
    ac
    ac-
    ac-acme-financials-workon
    ac-cluster-reset-empty-db
  ...

  $ ac-<TAB>
  ac-                                    ac-psql
  ac-acme-financials-workon              ac-psql-connector-table-insert
  ac-cluster-reset-empty-db              ac-widget-project-workon
  ...

  $ ac-acme-financials-workon
  cd "/Users/user/work/acme/financials"
  . .venv/bin/activate
```

## Compatibility

This library esteems to be POSIX-compatible, so it *should* work anywhere.

- For Mac devs that prefer Z shell, this code should work, but it has not
  been tested.

  - If you find anything, please DM, file an issue, or fork and PR.

