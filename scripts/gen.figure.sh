#!/bin/bash

function main() {
  pushd $(dirname $(realpath "$0"))/../figure
  local dotfile
  for dotfile in *.dot; do
    dot -Tpdf "${dotfile}" -o $(basename "${dotfile}" .dot).pdf
  done
  popd
}

main "$@"
