#!/bin/bash

set -eu -o pipefail

function main() {
  local script_home=$(dirname $(realpath "$0"))

  "${script_home}"/gen.figure.sh
  "${script_home}"/gen.toc.sh

  xelatex cpp20.tex
  xelatex cpp20.tex
  xelatex cpp20.tex
}

main "$@"
