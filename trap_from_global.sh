#!/bin/bash
# set -x
set -f 
set -o pipefail
set -o errexit

error() {
  local parent_lineno="$1"
  local message="$2"
  local code="${3:-1}"
  if [[ -n "$message" ]] ; then
    echo "Error on or near line ${parent_lineno}: ${message}; exiting with status ${code}" >&2
  else
    echo "Error on or near line ${parent_lineno}; exiting with status ${code}" >&2
  fi
  exit "${code}"
}
trap 'error ${LINENO}' ERR

function function_with_error() {
  echo "line:$LINENO"
  false
  echo "line:$LINENO"
}

echo "line:$LINENO"
function_with_error
echo "line:$LINENO"


