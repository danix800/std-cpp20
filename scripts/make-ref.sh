#!/bin/bash

set -o pipefail -eu

declare proj_home=$(realpath $(dirname "$0")/..)

function help() {
  echo "$(basename "$0") file"
}

function make_ref() {
  local file="${1:-}"
  if [[ ! -f "${file}" ]]; then
    help
    exit 0
  fi

  local toc="${proj_home}/toc.lst"
  local metachar='[0-9A-D.-]'

  local -A ref_ids
  while read -r line; do
    while true; do
      if [[ "${line}" =~ \\ref\{($metachar$metachar*)\} ]]; then
        local ref_id="${BASH_REMATCH[1]}"
        ref_ids["${ref_id}"]="${ref_id}"
        line="${line#*\\ref\{${ref_id}\}}"
        echo "found new ref_id: ${ref_id}"
        echo "remaining: [${line}]"
      else
        break;
      fi
    done
  done <<< $(grep "\\ref{$metachar$metachar*}" "${file}")
  local ref_id
  for ref_id in "${!ref_ids[@]}"; do
    ref_id="${ref_id//./\\.}"
    local ref
    ref=$(sed -n "/^|${ref_id} /s/^|${ref_id}  *|[0-9]* *|\([^ ]*\)  *|.*$/\1/p" "${toc}")
    if [[ -z "${ref:-}" ]]; then
      echo "warning: ref not found for [${ref_id}]"
      continue
    else
      sed -i "s/[\]ref{${ref_id}}/\\\\ref{${ref}}/" "${file}"
    fi
  done
}

make_ref "$@"
