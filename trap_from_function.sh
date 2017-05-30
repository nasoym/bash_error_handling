#!/bin/bash
set -f 
set -o pipefail
set -o errexit

traperror () {
    local err=$? # error status
    local line=$1 # LINENO
    [ "$2" != "" ] && local funcstack=$2 # funcname
    [ "$3" != "" ] && local linecallfunc=$3 # line where func was called
    echo "<---" >&2
    echo "ERROR: line $line - command exited with status: $err" >&2
    if [ "$funcstack" != "" ]; then
        echo -n "   ... Error at function ${funcstack[0]}() " >&2
        if [ "$linecallfunc" != "" ]; then
            echo -n "called at line $3" >&2
        fi
        echo >&2
    fi
    echo "--->" >&2
    }

function function_with_error() {
  trap 'traperror $LINENO ${FUNCNAME} $BASH_LINENO' ERR
  echo "line:$LINENO"
  false
  echo "line:$LINENO"
}

function_with_error


