# vim:tw=0:ts=2:sw=2:et:norl:ft=bash
#
# USAGE:
#   m4_shim \
#     "+24" "acme.sh/acme.EVAL.sh" \
#     "${DXY_VENDOR_ACMESH_NAME}/${DXY_VENDOR_ACMESH_NAME}" \
#     "DXY_VENDOR_ACMESH_ORG01_VAR" \
#       "ACMESH_ROOT_${DXY_VENDOR_ORG01_NAME^^}" \
#     "DXY_VENDOR_ACMESH_ORG02_VAR" \
#       "ACMESH_ROOT_${DXY_VENDOR_ORG02_NAME^^}" \
#     "DXY_NEXUS_REPOSITORY_URL" \
#       "${DXY_NEXUS_REPOSITORY_URL:-nexus.${DXY_VENDOR_DOMAIN}}" \
#     "DXY_ACMECO_CLUSTER_DB_LOCAL_URL" \
#       "db.${DXY_VENDOR_NAME}.cluster.local" \
#     "DXY_VENDOR_ACMESH_NAMESPACE" \
#       "acme-namespace" \
#     "DXY_ACMECO_FCN_POP_ENVIRONS_EDITABLE_VENDOR_ORG01_NAME" \
#       "_acmeco_populate_environs_editable_${DXY_VENDOR_ORG01_NAME}" \
#     "DXY_ACMECO_VAR_VENDOR_ORG01_PROJ01_NAME" \
#       "$(echo "_ACMECO_${DXY_VENDOR_ORG01_PROJ01_NAME^^}" | sed -e 's/-/_/g')"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# vim:tw=0:ts=2:sw=2:et:norl:ft=bash
# DXY_HEADER_AUTHOR
# DXY_HEADER_ACMESH

# CPYST: How you might re-prefix, e.g., from `ac`/`ac-*` to `xc`/`xc-*`:
#
#   command sed 's/\bac\b/xc/g' -i \
#     "DXY_DEPOXY_CLIENT__HOME_/DXY_VENDOR_ACMESH_NAME/DXY_VENDOR_ACMESH_NAME"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# Path to user secrets.
# - CXREF:
#   DXY_DEPOXY_CLIENT_TILDE/home/DXY_VENDOR_HOME_NAME/DXY_VENDOR_ACMESH_CONF
#   DXY_DEPOXYARCHETYPE_DIR_TILDE/home/work/.acme.conf.EVAL
# E.g., ".acme.conf"
_ACMECO_CONF_BASE="${ACMESH_CONF_BASE:-DXY_VENDOR_ACMESH_CONF}"
# E.g., "/Users/user/.acme.conf"
_ACMECO_CONF_USER="${ACMESH_CONF_USER:-${HOME}/${_ACMECO_CONF_BASE}}"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

DXY_VENDOR_ACMESH_ORG01_VAR="${DXY_VENDOR_ACMESH_ORG01_VAR:-DXY_VENDOR_HOME__HOME_/DXY_VENDOR_ORG01_NAME}"
DXY_VENDOR_ACMESH_ORG02_VAR="${DXY_VENDOR_ACMESH_ORG02_VAR:-DXY_VENDOR_HOME__HOME_/DXY_VENDOR_ORG02_NAME}"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# Example Python config.

_ACMECO_PYENV_PYTHON_VERS="3.11.8"

# How you might pin the Poetry version, if necessary, e.g.,
# if your projects are not yet Poetry 1.2-compatible, you
# might specify this:
_ACMECO_PYTHON_POETRY_VERS="1.1.15"

# Example Sontatype Nexus config.

# CALSO: NEXUS_PASSWORD (private conf)
NEXUS_REPOSITORY_URL="${NEXUS_REPOSITORY_URL:-DXY_NEXUS_REPOSITORY_URL}"
NEXUS_USERNAME="${NEXUS_USERNAME:-PLEASE_SET_ME}"

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ================================================================= #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

_ACMECO_SOURCE_PATH="${BASH_SOURCE[0]}"

_acmeco_print_manual () {
  # Because (author's) Vim heredoc highlight issue, use and `cut` comment leaders.
  # SIMLY: cat << EOF | tail +2 | sed 's/^# \?//'
  cat << EOF | tail +2 | cut -c3-

# USAGE
# =====
#
# Source this script to use its functions in your terminal.
#
# This script wires a set of aliases that each begin with "ac-",
# so you can type "ac-<TAB>" to see a list of commands.
#
# SETUP
# =====
#
# You'll need to supply secrets (see below) and setup the path
# environs if you're using non-standard paths (see also below).
#
# OVERVIEW
# ========
#
# The script defines a number of functions that are useful when
# working on DXY_VENDOR_NAME_PROPER projects.
#
# - This script is designed to help you develop locally, as well
#   as to connect to and to run various operations against any
#   hosted environments.
#
# USAGE
# =====
#
# - Source this script to use it:
#
#     \$ . path/to/DXY_VENDOR_ACMESH_NAME
#
#   E.g.,
#
#     \$ . ${_ACMECO_SOURCE_PATH}
#
#   - Note that, while this is a Bash script, it's meant to be
#     POSIX-compliant.
#
#     - Feel free to submit patches if you have fixes for other
#       shells (e.g., Z shell).
#
# - If you make changes to the DXY_VENDOR_ACMESH_NAME script, reload it:
#
#     \$ ac-reset
#
#   - You can also source the script a second time, but you'd
#     see warnings that the aliases are already in use. So it
#     is preferred that you use the \`ac-reset\` mechanism.
#
# - This script names aliases using the same "ac-" prefix, so
#   you can type "ac-<TAB>" to see all the useful commands.
#
#   - Note that a few commands are not aliased, because they
#     are rarely run (e.g., perhaps they're used once during
#     new-developer onboarding).
#
# - This script echoes most of the commands it runs (e.g., see
#   the \`kubectl\` commands) so that you have a more intimate
#   grasp of what's happening.
#
# SETUP
# =====
#
# - Customize environs in the private config:
#
#     DXY_DEPOXY_CLIENT_TILDE/home/DXY_VENDOR_HOME_NAME/DXY_VENDOR_ACMESH_CONF
#
#   - See inside the file for instructions.
#
EOF
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# The only function "help" is to print the aliases defined below.
# - And if that's not enough help, please read the function code.
DXY_VENDOR_NAME () {
  [ -z "$1" ] && echo "USAGE: ac-<TAB>" && return 0

  case $1 in
    -h | --help | help)
      _acmeco_print_aliases
      ;;
    -c | --commands | commands)
      _acmeco_print_aliases
      ;;
    -m | --man | man)
      _acmeco_print_manual
      ;;
    *)
      :
      ;;
  esac
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ================================================================= #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

DXY_ACMECO_FCN_POP_ENVIRONS_EDITABLE_VENDOR_ORG01_NAME () {
  # E.g., ${HOME}/work/soylent
  local base_path="${DXY_VENDOR_ACMESH_ORG01_VAR}"

  # *** DXY_VENDOR_ORG01_PROJ01_NAME project

  _acmeco_set_environ_path_unless_set "DXY_ACMECO_VAR_VENDOR_ORG01_PROJ01_NAME" \
    "${base_path}/DXY_VENDOR_ORG01_PROJ01_NAME"
}

# ***

_acmeco_populate_environs_secret () {
  _acmeco_conf_find || return 0

  _acmeco_conf_get "_ENV_LOCAL_DB_PASSW"

  # *** kubectl creds
  _acmeco_conf_get "_ENV_LOCAL_KUBECONFIG"
  _acmeco_conf_get "_ENV_DEV_KUBECONFIG"
  _acmeco_conf_get "_ENV_STAGE_KUBECONFIG"

  # *** Environment tokens (as an example of env-specific values)
  _acmeco_conf_get "_ENV_TOKEN_LOCAL"
  _acmeco_conf_get "_ENV_TOKEN_DEV"
  _acmeco_conf_get "_ENV_TOKEN_STAGE"

  # *** Third-party tokens and values
  _acmeco_conf_get "MAPBOX_TOKEN"
}

_acmeco_conf_find () {
  if [ -f "${_ACMECO_CONF_BASE}" ]; then
    # Found in current directory.
    _ACMECO_CONF_PATH="${_ACMECO_CONF_BASE}"
  elif [ -f "${_ACMECO_CONF_USER}" ]; then
    # Found in user home, or wherever ${ACMESH_CONF_USER} pointed.
    _ACMECO_CONF_PATH="${_ACMECO_CONF_USER}"
  else
    echo "WARNING: Skipping user secrets, because no local" \
      "\"${_ACMECO_CONF_BASE}\" or \"${_ACMECO_CONF_USER}\""
    _ACMECO_CONF_PATH=""

    return 1
  fi
}

# CAVEAT: User cannot use comments on VAR=VAL lines (from = to $ is considered VAL).
_acmeco_conf_get () {
  test $# -ge 1 \
    || return

  local ename="$1"

  # Note that if quotes are used in conf file, they'll be gobbled when the
  # shell processed the eval (so we don't have to parse them).
  eval "${ename}=$(grep -e "^${ename}=" "${_ACMECO_CONF_PATH}" | sed "s/^${ename}=//")"

  # echo "${ename}=${!ename}"
}

# ***

_acmeco_populate_environs_static () {
  _acmeco_populate_environs_static_env_environs
  _acmeco_populate_environs_static_env_nexus
  _acmeco_populate_environs_static_env_application
}

_acmeco_populate_environs_static_env_environs () {
  _acmeco_populate_environs_static_env_environs_local
  _acmeco_populate_environs_static_env_environs_dev
  _acmeco_populate_environs_static_env_environs_stage
}

# local environment
_acmeco_populate_environs_static_env_environs_local () {
  _acmeco_set_environ_value "_ENV_LOCAL_DB_PASSW"
  if [ -n "${_ENV_LOCAL_DB_PASSW}" ]; then
    ACMECO_DB_URL="${ACMECO_DB_URL:-postgresql://postgres:${_ENV_LOCAL_DB_PASSW}@127.0.0.1:${_docker_pg_port_5432:-30432}}"
    export ACMECO_DB_URL
  else
    echo "WARNING: Skipping ACMECO_DB_URL, because no _ENV_LOCAL_DB_PASSW."
    unset -v ACMECO_DB_URL
  fi

  _ENV_LOCAL_BASE_URL="http://dev.DXY_VENDOR_NAME.local"
  _acmeco_set_environ_value "_ENV_TOKEN_LOCAL"

  # FIXME/2022-01-01: This work for local?:
  _acmeco_set_environ_value_path "_ENV_LOCAL_KUBECONFIG" \
    "${HOME}/.kube/config"
}

# 'dev' environment
_acmeco_populate_environs_static_env_environs_dev () {
  _ENV_DEV_BASE_URL="https://dev.DXY_VENDOR_DOMAIN"

  _acmeco_set_environ_value "_ENV_TOKEN_DEV"

  local username="$(id -un)"
  _acmeco_set_environ_value_path "_ENV_DEV_KUBECONFIG" \
    "${HOME}/.kube/DXY_VENDOR_NAME-dev-${username}.yaml"

  # SAVVY: You might not have access to list namespaces:
  #   $ kubectl --kubeconfig "${_ACMECO_KUBECONFIG}" get namespace
  #   Error from server (Forbidden): namespaces is forbidden: User "user"
  #     cannot list resource "namespaces" in API group "" at the cluster scope:
  #     RBAC: clusterrole.rbac.authorization.k8s.io "implementation" not found
  # - So check local cluster for list.
  #   - If you use OpenLens, you'll need to add each namespace manually to
  #     the app, using Cluster > Settings > Namespaces.
  #   E.g.,
  #     kubectl --kubeconfig ~/.kube/config get namespace
}

# 'stage' environment
_acmeco_populate_environs_static_env_environs_stage () {
  _ENV_STAGE_BASE_URL="https://stage.DXY_VENDOR_DOMAIN"

  _acmeco_set_environ_value "_ENV_TOKEN_STAGE"

  _acmeco_set_environ_value_path "_ENV_STAGE_KUBECONFIG" \
    "${HOME}/.kube/acme-stage.yaml"

  _ENV_STAGE_AWS_CLIENT="acme-stage"
}

# Loads Nexus username and password from ~/.netrc
#
# - Assumes you've created a ~/.netrc file and populated it with Nexus
#   read-only creds (which are oftentimes shared between devs).
_acmeco_populate_environs_static_env_nexus () {
  if [ -f "${HOME}/.netrc" ]; then
    # CXREF: NEXUS_REPOSITORY_URL, NEXUS_USERNAME
    _acmeco_set_environ_value "NEXUS_PASSWORD" \
      "$(cat "${HOME}/.netrc" | grep "^password " | awk '{ print $2 }')"
  fi
}

_acmeco_populate_environs_static_env_application () {
  # Virtual environment names
  _ACMECO_APPLICATION_PYENV="application-venv"

  # Third-party tokens, IDs, and keys.

  _acmeco_set_environ_value "MAPBOX_TOKEN"
}

# ***

declare -a _ACMECO_ENVIRONS_PATHS
declare -a _ACMECO_ENVIRONS_VALUES

_ACMECO_ENVIRONS_PATHS=()
_ACMECO_ENVIRONS_VALUES=()

_acmeco_set_environ_path_unless_set () {
  # echo eval "$1=\"\${$1:-$2}\""
  eval "$1=\"\${$1:-$2}\""
  _ACMECO_ENVIRONS_PATHS+=("$1")
}

_acmeco_set_environ_value () {
  # echo eval "$1=\"\${$1:-$2}\""
  eval "$1=\"\${$1:-$2}\""
  _ACMECO_ENVIRONS_VALUES+=("$1")
}

_acmeco_set_environ_value_path () {
  # echo eval "$1=\"\${$1:-$2}\""
  eval "$1=\"\${$1:-$2}\""
  _ACMECO_ENVIRONS_PATHS+=("$1")
}

_acmeco_populate_environs_verify () {
  warn_if_incorrect_environ_paths
  warn_if_missing_environ_values
}

warn_if_incorrect_environ_paths () {
  # In case this script sourced on shell startup, don't complain
  # about absent paths unless being reloaded (i.e., only warn if
  # user explicitly loading this script).
  ${audit_environs:-false} || return 0

  for path_env in "${_ACMECO_ENVIRONS_PATHS[@]}"; do
    if [ ! -d "${!path_env}" ] && [ ! -f "${!path_env}" ]; then
      >&2 echo "Warning: Value for environment not file or directory: ${path_env}: ${!path_env}"
    fi
  done
}

warn_if_missing_environ_values () {
  for value_env in "${_ACMECO_ENVIRONS_VALUES[@]}"; do
    if [ -z "${!value_env}" ]; then
      >&2 echo "Warning: Value for environment not assigned: ${value_env}"
    fi
  done
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ================================================================= #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

_acmeco_namespace_database_create () {
  local previous_venv="${VIRTUAL_ENV}"

  # YOU: Plumb create

  echo "./foo create"
}

_acmeco_namespace_database_migrate () {
  local previous_venv="${VIRTUAL_ENV}"

  # YOU: Plumb migrate

  echo "./foo migrate"
}

# ***

_acmeco_namespace_database_connect () {
  echo "psql \"${ACMECO_DB_URL}\""

  psql "${ACMECO_DB_URL}" "$@"
}

_acmeco_namespace_database_connect_env () {
  if [ -z "${_ACMECO_KUBECONFIG}" ]; then
    >&2 echo "ERROR: Please setup the env first, e.g., call \`ac-env-(local|dev|stage)\`."

    return 1
  # elif [ "${_ACMECO_KUBECONFIG}" = "${_ENV_LOCAL_KUBECONFIG}" ]; then
  elif ${_ACMECO_ENV_IS_LOCAL:-false}; then
    _acmeco_namespace_database_connect
  else
    _acmeco_cluster_database_psql_session_primary_pod_raw
  fi
}

# *** Commands made from client's <setup>.sh output.

# Cluster psql superuser password
_acmeco_cluster_database_psql_password_su () {
  must_selected_kubeconfig || return $?

  local namespace="DXY_VENDOR_ACMESH_NAMESPACE"

  local resource_name="acme-credentials-psql"

  kubectl --kubeconfig "${_ACMECO_KUBECONFIG}" \
    get secret --namespace "${namespace}" \
      ${resource_name} \
      -o jsonpath="{.data.PSQL_SUPERUSER_PASSWORD}" \
      | base64 --decode
}

# Cluster psql admin password
_acmeco_cluster_database_psql_password_admin () {
  must_selected_kubeconfig || return $?

  local namespace="DXY_VENDOR_ACMESH_NAMESPACE"

  local resource_name="acme-credentials-psql"

  kubectl --kubeconfig "${_ACMECO_KUBECONFIG}" \
    get secret --namespace "${namespace}" \
      ${resource_name} \
      -o jsonpath="{.data.PSQL_ADMIN_PASSWORD}" \
      | base64 --decode
}

# There are two methods for connecting to the database: directly
# to the primary pod, or passively using a hopper pod.

# 1. Run a postgres pod and connect using the psql cli.
_acmeco_cluster_database_psql_session_hopper_pod_su () {
  must_selected_kubeconfig || return $?

  local PGPASSWORD_POSTGRES="$(_acmeco_cluster_database_psql_password_su)"

  local psql_host="DXY_ACMECO_CLUSTER_DB_LOCAL_URL"

  kubectl --kubeconfig "${_ACMECO_KUBECONFIG}" \
    run -i --tty --rm psql --image=postgres \
      --env "PGPASSWORD=${PGPASSWORD_POSTGRES}" \
      --command -- psql -U postgres \
      -h "${psql_host}" postgres
}

_acmeco_cluster_database_psql_session_hopper_pod_admin () {
  must_selected_kubeconfig || return $?

  local PGPASSWORD_ADMIN="$(_acmeco_cluster_database_psql_password_admin)"

  local psql_host="DXY_ACMECO_CLUSTER_DB_LOCAL_URL"

  kubectl --kubeconfig "${_ACMECO_KUBECONFIG}" \
    run -i --tty --rm psql --image=postgres \
      --env "PGPASSWORD=${PGPASSWORD_ADMIN}" \
      --command -- psql -U admin \
      -h "${psql_host}" postgres
}

# 2. Directly execute a psql session on the primary pod.
_acmeco_cluster_database_psql_session_primary_pod_raw () {
  local tty_option="$1"
  shift

  must_selected_kubeconfig || return $?

  local selector_label_query_filter="release=prod-db,role=production"

  local primary_pod="$( \
    kubectl --kubeconfig "${_ACMECO_KUBECONFIG}" \
      get pod -o name --namespace DXY_VENDOR_ACMESH_NAMESPACE \
      -l ${selector_label_query_filter} \
  )"
  echo "Primary pod: ${primary_pod}"

  echo "kubectl --kubeconfig \"${_ACMECO_KUBECONFIG}\" \\
    exec -i ${tty_option} --namespace DXY_VENDOR_ACMESH_NAMESPACE \\
    ${primary_pod} -- psql -U postgres $@"

  kubectl --kubeconfig "${_ACMECO_KUBECONFIG}" \
    exec -i ${tty_option} --namespace DXY_VENDOR_ACMESH_NAMESPACE \
    ${primary_pod} -- psql -U postgres "$@"
}

_acmeco_cluster_database_psql_session_primary_pod () {
  _acmeco_cluster_database_psql_session_primary_pod_raw "--tty" "$@"
}

_acmeco_cluster_database_psql_session_primary_pod_no_tty () {
  _acmeco_cluster_database_psql_session_primary_pod_raw "" "$@"
}

# Note that the postgres command is run on the pod, so
# you cannot pass it `-f <filepath>`. But you can use a
# heredoc with the file contents injected (and suggested
# by `man psql`).
# - This command is not wired, but you could call directly
#   and pass it a file.
_acmeco_cluster_database_psql_session_primary_pod_file () {
  local cmds_file="$1"
  shift

  if [ ! -f "${cmds_file}" ]; then
    >&2 echo "ERROR: Missing file: ${cmds_file}"

    return 1
  fi

  # Call kubectl without --tty, else you'll see (though still works):
  #   Unable to use a TTY - input is not a terminal or the right kind of file

  _acmeco_cluster_database_psql_session_primary_pod_no_tty "$@" <<EOF
$(cat "${cmds_file}")
EOF
}

# 3. Tunnel to the psql db in a namespace kubernetes cluster.
_acmeco_cluster_database_psql_session_port_forwarding__example () {
  >&2 echo "ERROR: Not implemented" && return 1

  # Forward postgresql to localhost:5432
  kubectl port-forward -n DXY_VENDOR_ACMESH_NAMESPACE statefulset/acme-db-timescaledb 5432:postgresql

  # Get cluster postgres admin password
  local db_password=$( \
    kubectl get secret -n DXY_VENDOR_ACMESH_NAMESPACE acme-credentials-psql \
      -o jsonpath="{.data.PSQL_SUPERUSER_PASSWORD}" \
      | base64 --decode \
  )

  # Connect on port-forwarded connection as admin
  psql postgresql://postgres:$db_password@localhost:5432/postgres

  # *** The following is CPYST you might try.
  #
  # - The following is not a continuation of this function.

  # Check if read-only transaction (meaning replica, not leader)
  show transaction_read_only;

  # To write data, connect to the leader — try different -0/-1/-2/-etc. postfixes:
  kubectl -n DXY_VENDOR_ACMESH_NAMESPACE port-forward pod/acme-db-timescaledb-2 5432:postgresql
  #
  # ALTLY: To skip the guess-work, use patronictl (if available):
  kubectl -n DXY_VENDOR_ACMESH_NAMESPACE exec -it acme-db-timescaledb-0 -- /bin/bash
  # - And then run, e.g.,:
  patronictl -c /etc/timescaledb/patroni.yaml list
}
# Unsetting because function is untested code copied from Confluence doc.
# - Also seems effectively same as using a hopper pod:
#     _acmeco_cluster_database_psql_session_hopper_pod_su
unset -f _acmeco_cluster_database_psql_session_port_forwarding__example

_acmeco_cluster_open_shell_bash () {
  local namespace="${1:-DXY_VENDOR_ACMESH_NAMESPACE}"
  local pod="${2:-acme-pod/acme-deployed}"
  local container="$3"

  # "If omitted, use the kubectl.kubernetes.io/default-container annotation
  #  for selecting the container to be attached or the first container in
  #  the pod will be chosen" [`kubectl attach` help]
  local container_opt=""
  [ -z "${container}" ] || container_opt="-c ${container}"

  kubectl --kubeconfig "${_ACMECO_KUBECONFIG}" \
    -n ${namespace} \
    exec -it ${pod} ${container_opt} -- /bin/bash
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ================================================================= #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# You could run this from your terminal, or you could copy-paste and run
# from an OpenLens terminal (so that you're not using an AltTab or Dock
# slot for something you won't interact with).
# - SAVVY: 50051 is default gRPC port.
_acmeco_application_port_forward () {
  echo "kubectl port-forward service/acme-application 50051:50051 -n DXY_VENDOR_ACMESH_NAMESPACE"

  kubectl port-forward service/acme-application 50051:50051 -n DXY_VENDOR_ACMESH_NAMESPACE
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# *** Acmeco Application

_acmeco_application_virtualenv_activate () {
  _acmeco_virtualenv_deactivate

  echo "cd \"${DXY_ACMECO_VAR_VENDOR_ORG01_PROJ01_NAME}\""
  pushd "${DXY_ACMECO_VAR_VENDOR_ORG01_PROJ01_NAME}" > /dev/null

  echo "pyenv activate --quiet ${_ACMECO_APPLICATION_PYENV}"
  pyenv activate --quiet ${_ACMECO_APPLICATION_PYENV}

  _acmeco_cdproject_wire
}

# ***

_acmeco_application_run_server () {
  _acmeco_application_virtualenv_activate

  echo "PYTHONPATH=. python src/widget/app.py"
  eval "PYTHONPATH=. python src/widget/app.py"
}

# ***

# CAVEAT: Local auth currently only works with Client ID/Client Secret,
#         and not with global auth (session cookie).
# MAYBE/2023-01-05: Can you port-forword to cluster Keyclock oauth2 endpoint?:
#   http://dev.DXY_VENDOR_NAME.local/oauth2/auth
# and then resolving bearer token from session cookie should work.
_acmeco_application_run_server_local () {
  _acmeco_environment_populate_environs__local
  _acmeco_application_run_server
}

_acmeco_environment_populate_environs__local () {
  _acmeco_auth_populate_environs_for_environment \
    "${_ENV_LOCAL_BASE_URL}" \
    "${_ENV_TOKEN_LOCAL}" \
    "${_ENV_LOCAL_KUBECONFIG}"
  _ACMECO_ENV_IS_LOCAL=true
}

# ***

_acmeco_application_run_server__dev () {
  _acmeco_environment_populate_environs__dev
  _acmeco_application_run_server
}

_acmeco_environment_populate_environs__dev () {
  _acmeco_auth_populate_environs_for_environment \
    "${_ENV_DEV_BASE_URL}" \
    "${_ENV_TOKEN_DEV}" \
    "${_ENV_DEV_KUBECONFIG}"
}

_acmeco_cluster_database_psql_session_primary_pod_raw__dev () {
  _acmeco_environment_populate_environs__dev
  _acmeco_cluster_database_psql_session_primary_pod_raw
}

# ***

_acmeco_application_run_server__stage () {
  _acmeco_environment_populate_environs__stage
  _acmeco_application_run_server
}

_acmeco_environment_populate_environs__stage () {
  _acmeco_auth_populate_environs_for_environment \
    "${_ENV_STAGE_BASE_URL}" \
    "${_ENV_TOKEN_STAGE}" \
    "${_ENV_STAGE_KUBECONFIG}"
}

_acmeco_cluster_database_psql_session_primary_pod_raw__stage () {
  _acmeco_environment_populate_environs__stage
  _acmeco_cluster_database_psql_session_primary_pod_raw
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

_acmeco_auth_populate_environs_for_environment () {
  local env_url="$1"
  local client_token="$2"
  local cluster_kubeconfig="$3"

  # ***

  # Up to caller to set this true.
  _ACMECO_ENV_IS_LOCAL=false

  # ***

  # The server always needs three auth URLs to authenticate requests.
  JWKS_URL="${env_url}/auth/realms/acme/protocol/openid-connect/certs"
  AUTH_URL="${env_url}/auth/realms/acme/protocol/openid-connect/auth"
  TOKEN_URL="${env_url}/auth/realms/acme/protocol/openid-connect/token"
  echo "export JWKS_URL=\"${JWKS_URL}\""
  echo "export AUTH_URL=\"${AUTH_URL}\""
  echo "export TOKEN_URL=\"${TOKEN_URL}\""
  export JWKS_URL
  export AUTH_URL
  export TOKEN_URL

  # ***

  echo "Using ACMECO_DB_URL=\"${ACMECO_DB_URL}\""

  # ***

  # Populate environs for said environment.

  CLIENT_TOKEN="${client_token}"
  echo "export CLIENT_TOKEN=\"${CLIENT_TOKEN}\""
  export CLIENT_TOKEN

  CLIENT_ID="acme-application"
  echo "export CLIENT_ID=\"${CLIENT_ID}\""
  export CLIENT_ID

  BEARER_TOKEN="$( \
    curl -s --location --request POST \
      "${TOKEN_URL}" \
        --header "Content-Type: application/x-www-form-urlencoded" \
        --data-urlencode "client_id=${CLIENT_ID}" \
        --data-urlencode "client_token=${CLIENT_TOKEN}" \
        --data-urlencode "scope=profile" \
        --data-urlencode "grant_type=client_credentials" \
          | jq -r .access_token
  )"
  echo "export BEARER_TOKEN=\"${BEARER_TOKEN}\""
  export BEARER_TOKEN

  # ***

  # Used internally when calling kubectl.
  _ACMECO_KUBECONFIG="${cluster_kubeconfig}"
  echo "export _ACMECO_KUBECONFIG=\"${_ACMECO_KUBECONFIG}\""
  export _ACMECO_KUBECONFIG

  # ***

  # Third-party API token(s).
  echo "export MAPBOX_TOKEN=${MAPBOX_TOKEN}"
  export MAPBOX_TOKEN

  # (lb): (My) sh-logger names LOG_LEVEL; might conflict with vendor's code.
  echo "unset LOG_LEVEL"
  unset LOG_LEVEL
}

must_selected_kubeconfig () {
  if [ -z "${_ACMECO_KUBECONFIG}" ]; then
    >&2 echo "ERROR: Seed an env first."

    return 1
  fi

  return 0
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# Create cluster environment kubeconfig, e.g.,:
#   ~/.kube/acme-dev.yaml
#   ~/.kube/acme-stage.yaml
_acmeco_kubeconfig_create_env () {
  local cluster_name="$1"

  [ -z "${cluster_name}" ] && >&2 echo "ERROR: Not callable" && return 1 || true

  local target="${HOME}/.kube/${cluster_name}.yaml"

  echo "aws eks --region us-east-1 update-kubeconfig" \
    "--name \"${cluster_name}\" --kubeconfig \"${target}\""

  aws eks --region us-east-1 update-kubeconfig \
    --name "${cluster_name}" --kubeconfig "${target}"

  [ -f "${target}" ] && echo "Prepared kubeconfig: ${target}"
}

_acmeco_kubeconfig_create_env_stage () {
  _acmeco_kubeconfig_create_env "${_ENV_STAGE_AWS_CLIENT}"
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ================================================================= #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

_acmeco_virtualenv_recreate () {
  local pyenv_env="$1"
  local proj_path="$2"
  local use_latest_poetry=${3:-false}
  local config_nexus_dev=${4:-false}

  _acmeco_virtualenv_deactivate

  echo "cd \"${proj_path}\""
  pushd "${proj_path}" > /dev/null

  # Setup pyenv.

  # FIXME/2024-05-09: Consider `py3 -m venv .venv/` instead of using pyenv.
  # - I've found it simpler recently to use built-in virtualenvs.
  #   - Obvi, still use pyenv to set to correct Python version.
  # - CXREF: Add `workon`, `off`, and `cdproject` virtualenv helpers:
  #     https://github.com/landonb/virtualenvwrapper

  echo "pyenv virtualenv-delete \"${pyenv_env}\""
  pyenv virtualenv-delete "${pyenv_env}"

  echo "pyenv virtualenv ${_ACMECO_PYENV_PYTHON_VERS} \"${pyenv_env}\""
  pyenv virtualenv ${_ACMECO_PYENV_PYTHON_VERS} "${pyenv_env}"

  _acmeco_cdproject_wire

  # EQUIV: pyenv activate --quiet "${pyenv_env}"
  _acmeco_virtualenv_activate "${pyenv_env}" "${proj_path}"
  # Alternatively:
  #   pyenv global ${_ACMECO_PYENV_PYTHON_VERS}
  #   pyenv local ${_ACMECO_PYENV_PYTHON_VERS}
  #   python3 -m virtualenv ".venv"
  #   . ".venv/bin/activate"

  # Not necessary, but avoids pip's update-pip notice.
  echo "python -m pip install --upgrade pip"
  python -m pip install --upgrade pip

  # Pin Poetry, because Nexus issue.
  #
  local pin_poetry=""
  ${use_latest_poetry} || pin_poetry="==${_ACMECO_PYTHON_POETRY_VERS}"
  #
  echo "pip install poetry${pin_poetry}"
  pip install poetry${pin_poetry}

  # (lb): Not sure (haven't tested-confirmed) that this option (absolutely) necessary.
  echo "poetry config virtualenvs.create \"false\""
  poetry config virtualenvs.create "false"

  if ${config_nexus_dev}; then
    poetry config repositories.nexus-dev "${NEXUS_REPOSITORY_URL}/acme-application-dev/simple"
    poetry config http-basic.nexus-dev "${NEXUS_USERNAME}" "${NEXUS_PASSWORD}"
  fi

  poetry config repositories.nexus "${NEXUS_REPOSITORY_URL}/acme-applicationa/simple"
  poetry config http-basic.nexus "${NEXUS_USERNAME}" "${NEXUS_PASSWORD}"

  echo "poetry install"
  poetry install
}

# ***

_acmeco_virtualenv_activate () {
  local pyenv_env="$1"
  local proj_path="$2"

  _acmeco_virtualenv_deactivate

  echo "cd \"${proj_path}\""
  pushd "${proj_path}" > /dev/null

  echo "pyenv activate --quiet ${pyenv_env}"
  pyenv activate --quiet ${pyenv_env}

  # Append to PATH, in case project installs executable.
  local venv_root
  venv_root="$(poetry env info -p 2> /dev/null)"
  _acmeco_pathadd "${venv_root}/bin"

  _acmeco_cdproject_wire
}

_acmeco_pathadd () {
  [ -d "$1" ] || return 1

  [[ ":$PATH:" != *":$1:"* ]] || return 0

  PATH="${PATH:+"$PATH:"}$1"
  export PATH
}

_acmeco_pathdel () {
  [ -d "$1" ] || return 1

  PATH="$( \
    echo "$PATH" \
      | sed -e "s@\(^\|:\)$1\(:\|\$\)@:@" \
      | sed -e 's/^://' \
      | sed -e 's/:$//'
  )"
  export PATH
}

# ***

# Use VIRTUAL_ENV to suss if virtualenv active.
# - See also pyenv environs:
#   PYENV_VIRTUAL_ENV (same path as VIRTUAL_ENV)
#   PYENV_VIRTUALENV_INIT=1 (static; means pyenv ready, i.e., your
#                            shell eval'd `pyenv virtualenv-init -`)
_acmeco_virtualenv_deactivate () {
  local previous_venv="$1"

  if [ -n "${VIRTUAL_ENV}" ]; then
    echo ". deactivate"

    . deactivate
  fi

  local venv_root
  venv_root="$( \
    _acmeco_cdproject

    poetry env info -p 2> /dev/null
  )"
  _acmeco_pathdel "${venv_root}/bin"

  if [ -n "${previous_venv}" ]; then
    echo ". ${previous_venv}"

    . "${previous_venv}"
  else
    _acmeco_cdproject_wipe
  fi

  return 0
}

# ***

_acmeco_cdproject_wipe () {
  unset _ACMECO_CDPROJECT_PATH
}

_acmeco_cdproject_wire () {
  _ACMECO_CDPROJECT_PATH="$(pwd)"
}

_acmeco_cdproject () {
  [ -n "${_ACMECO_CDPROJECT_PATH}" ] || return 0

  # echo "cd \"${_ACMECO_CDPROJECT_PATH}\""
  pushd "${_ACMECO_CDPROJECT_PATH}" > /dev/null
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

_ACMECO_OPTION_RESET_VARS="--reset"
_ACMECO_OPTION_AUDIT_VARS="--audit"

# Makes this script reentrant.
_acmeco_reset_environment () {
  _acmeco_reset_unalias_all

  local reset=""

  if [ "$1" == "--all" ]; then
    _acmeco_reset_environment_unset_vars
    reset="${_ACMECO_OPTION_RESET_VARS}"
  fi

  # This feels weird: Source ourselves.

  echo ". \"${BASH_SOURCE[0]}\" \"${reset}\" \"${_ACMECO_OPTION_AUDIT_VARS}\""

  eval . "${BASH_SOURCE[0]}" "${reset}" "${_ACMECO_OPTION_AUDIT_VARS}"
}

# MAYBE/2022-12-14: Note that these variables are only set if not set,
# so after normal ac-reset, any changes you made to the Bash source
# won't apply, because those environs are already set in your shell.
# - MEH: We could DRY this using flattened array, like we do for
#        _ACMECO_ALIASES_SCALAR_ARRAY. For now, it's simpler to just
#        list the variables below and to manually update as needed.
_acmeco_reset_environment_unset_vars () {
  # USYNC: Update this list: Uncomment echoes in _acmeco_set_environ_* fcns above.

  unset -v DXY_ACMECO_VAR_VENDOR_ORG01_PROJ01_NAME

  unset -v _ENV_LOCAL_DB_PASSW

  unset -v _ENV_TOKEN_LOCAL
  unset -v _ENV_LOCAL_KUBECONFIG

  unset -v _ENV_TOKEN_DEV
  unset -v _ENV_DEV_KUBECONFIG

  unset -v _ENV_TOKEN_STAGE
  unset -v _ENV_STAGE_KUBECONFIG

  unset -v NEXUS_PASSWORD

  unset -v MAPBOX_TOKEN

  # From ac-env-*
  unset -v JWKS_URL
  unset -v AUTH_URL
  unset -v TOKEN_URL
  unset -v ACMECO_DB_URL
  unset -v CLIENT_TOKEN
  unset -v CLIENT_ID
  unset -v BEARER_TOKEN
  unset -v _ACMECO_KUBECONFIG
  unset -v MAPBOX_TOKEN
  unset -v LOG_LEVEL
}

# ***

declare -a _ACMECO_ALIASES

_claim_alias_or_warn () {
  local the_alias="$1"
  local the_command="$2"
  local force=${3:-false}

  ! ${force_aliases:-false} || force=true

  if ${force} || ! type "${the_alias}" > /dev/null 2>&1; then
    eval "alias ${the_alias}=\"${the_command}\""

    _ACMECO_ALIASES+=("${the_alias}")
  else
    >&2 echo "WARNING: Refusing to alias existing command “${the_alias}”."
  fi

  # Note that Bash does not support exporting an array to the environment,
  # so to track which aliases were added (so we can unalias them on reset)
  # we have to export a flattened array (its definition).
  #  https://stackoverflow.com/questions/5564418/exporting-an-array-in-bash-script
  _ACMECO_ALIASES_SCALAR_ARRAY=$(declare -p _ACMECO_ALIASES)
}

_acmeco_reset_unalias_all () {
  eval ${_ACMECO_ALIASES_SCALAR_ARRAY}

  local claimed_alias

  # We could just go through aliases as listed:
  #   for claimed_alias in "${_ACMECO_ALIASES[@]}"; do
  # Or we could sort 'em.
  for claimed_alias in $( \
    echo "${_ACMECO_ALIASES[@]}" |
      xargs printf "%s\0" |
      sort -z |
      xargs -0 printf "%s\n" \
    ); do
    echo "unalias \"${claimed_alias}\""

    unalias "${claimed_alias}"
  done
}

_acmeco_print_aliases () {
  eval ${_ACMECO_ALIASES_SCALAR_ARRAY}

  local claimed_alias

  echo "Commands:"

  (
    for claimed_alias in "${_ACMECO_ALIASES[@]}"; do
      echo "  ${claimed_alias}"
    done
  ) | sort

  echo "Setup and overview:"
  # echo "  ac-help-man | DXY_VENDOR_ACMESH_CMD man | DXY_VENDOR_ACMESH_CMD -m | DXY_VENDOR_ACMESH_CMD --man"
  echo "  DXY_VENDOR_ACMESH_CMD man"
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

_acmeco_wire_aliases () {

  # *** Meta tasks (re: this script; not DXY_VENDOR_NAME_PROPER-related)

  _acmeco_wire_aliases_meta_commands_main
  unset -f _acmeco_wire_aliases_meta_commands_main

  _acmeco_wire_aliases_meta_commands
  unset -f _acmeco_wire_aliases_meta_commands

  # *** Postgres tasks

  _acmeco_wire_aliases_postgres
  unset -f _acmeco_wire_aliases_postgres

  # *** Virtualenv tasks

  _acmeco_wire_aliases_virtualenv
  unset -f _acmeco_wire_aliases_virtualenv

  # *** Application tasks

  # USAGE: Add additional applications here.
  # - FTREQ: When more than 1 app, rather than wire all simultaneously,
  #   you could wire dispatchers for each app exclusively (i.e., user
  #   has to, e.g., ac-some-app-workon, which loads dispatchers for
  #   that app; then, later, user runs ac-other-app-workon, which
  #   unloads dispatchers for some-app and loads 'em for other-app).

  _acmeco_wire_aliases_dispatcher_application
  unset -f _acmeco_wire_aliases_dispatcher_application
}

_acmeco_wire_aliases_dispatcher_application () {
  _acmeco_wire_aliases_dispatcher_application_envs
  unset -f _acmeco_wire_aliases_dispatcher_application_envs

  _acmeco_wire_aliases_dispatcher_application_wiring
  unset -f _acmeco_wire_aliases_dispatcher_application_wiring

  _acmeco_wire_aliases_dispatcher_application_runners
  unset -f _acmeco_wire_aliases_dispatcher_application_runners
}

# ***

# *** Meta commands (this script)
_acmeco_wire_aliases_meta_commands_main () {
  local force_alias=false

  # USAGE: If your abbreviation conflicts with an existing command,
  #        normally claim-alias will warning without wiring. But if
  #        it's a specific command we don't care about, force it.
  # - E.g., `/usr/sbin/ac` on @macOS is "connect time accounting",
  #   something you'll probably never use.
  if command -v "ac" > /dev/null \
    && [ "$(command -v "ac")" = "/usr/sbin/ac" ] \
  ; then
    force_alias=true
  fi

  _claim_alias_or_warn "ac" "DXY_VENDOR_ACMESH_CMD" ${force_alias}
}

_acmeco_wire_aliases_meta_commands () {
  _claim_alias_or_warn "ac-" "_acmeco_print_aliases"

  _claim_alias_or_warn "ac-help" "DXY_VENDOR_ACMESH_CMD --help"

  _claim_alias_or_warn "ac-help-commands" "_acmeco_print_aliases"

  _claim_alias_or_warn "ac-help-man" "_acmeco_print_manual"

  _claim_alias_or_warn "ac-reset" "_acmeco_reset_environment"

  _claim_alias_or_warn "ac-reset-all" "_acmeco_reset_environment --all"
}

# *** Postgres
_acmeco_wire_aliases_postgres () {
  _claim_alias_or_warn "ac-psql-db-create" "_acmeco_namespace_database_create"
  _claim_alias_or_warn "ac-psql-db-migrate" "_acmeco_namespace_database_migrate"

  # Logon the local cluster DB.
  _claim_alias_or_warn "ac-psql" "_acmeco_namespace_database_connect"

  # Logon the primary DB cluster pod using KUBECONFIG specified by latest ac-seed-environment-*.
  _claim_alias_or_warn "ac-psql-kubeconfig" "_acmeco_cluster_database_psql_session_primary_pod_raw"

  # Logon the DB specified by latest ac-env-* call.
  _claim_alias_or_warn "ac-psql-env" "_acmeco_namespace_database_connect_env"
}

# *** Virtualenv
_acmeco_wire_aliases_virtualenv () {
  # Because when you call `deactivate`, it'll tell you to source it.
  _claim_alias_or_warn "ac-deactivate" "_acmeco_virtualenv_deactivate"

  # `cdproject` is named for a virtualenvwrapper project function.
  _claim_alias_or_warn "ac-cdproject" "_acmeco_cdproject"
}

# ***

_acmeco_wire_aliases_dispatcher_application_envs () {
  # These were `ac-seed-environment-(local|dev|stage)` but trying ac-env- prefix.
  #  _claim_alias_or_warn "ac-env-local" "_acmeco_environment_populate_environs__local"
  _claim_alias_or_warn "ac-env-dev" "_acmeco_environment_populate_environs__dev"
  _claim_alias_or_warn "ac-env-stage" "_acmeco_environment_populate_environs__stage"

  # Logon the specified cluster psql.
  _claim_alias_or_warn "ac-psql-dev" "_acmeco_cluster_database_psql_session_primary_pod_raw__dev"
  _claim_alias_or_warn "ac-psql-stage" "_acmeco_cluster_database_psql_session_primary_pod_raw__stage"

}

_acmeco_wire_aliases_dispatcher_application_wiring () {
  _claim_alias_or_warn "ac-forward-port-application-50051" "_acmeco_application_port_forward"
}

_acmeco_wire_aliases_dispatcher_application_runners () {
  # One-time stand-up.
  _claim_alias_or_warn "ac-standup-application" "_acmeco_virtualenv_recreate"

  # Virtualenv activate.
  _claim_alias_or_warn "ac-application-workon" "_acmeco_application_virtualenv_activate"

  _claim_alias_or_warn "ac-run-application-using-local-auth" "_acmeco_application_run_server_local"
  _claim_alias_or_warn "ac-run-application-using-dev-auth" "_acmeco_application_run_server__dev"
  _claim_alias_or_warn "ac-run-application-using-stage-auth" "_acmeco_application_run_server__stage"
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

inject_environs () {
  local force_aliases=false
  local audit_environs=false

  parse_args "$@"

  DXY_ACMECO_FCN_POP_ENVIRONS_EDITABLE_VENDOR_ORG01_NAME
  unset -f DXY_ACMECO_FCN_POP_ENVIRONS_EDITABLE_VENDOR_ORG01_NAME

  _acmeco_populate_environs_secret
  unset -f _acmeco_populate_environs_secret

  _acmeco_populate_environs_static
  unset -f _acmeco_populate_environs_static

  _acmeco_populate_environs_verify
  unset -f _acmeco_populate_environs_verify

  _acmeco_wire_aliases
  unset -f _acmeco_wire_aliases
}

parse_args () {
  while [ $# -gt 0 ]; do
    case $1 in
      ${_ACMECO_OPTION_RESET_VARS})
        force_aliases=true

        shift
        ;;
      ${_ACMECO_OPTION_AUDIT_VARS})
        audit_environs=true

        shift
        ;;
      "")
        # Empty argument

        shift
        ;;
      *)
        >&2 echo "Warning: Unrecognized DXY_VENDOR_ACMESH_NAME arg: “$1”"

        shift
        ;;
    esac
  done
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

main () {
  inject_environs "$@"
}

if [ "$0" = "${BASH_SOURCE[0]}" ]; then
  # Being executed.
  >&2 echo "Thanks, but you’re better off sourcing this file"
fi

main "$@"
unset -f main

