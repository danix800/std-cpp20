#!/bin/bash

function install_texlive() {
  local mirror="${APT_MIRROR:-mirror.sjtu.edu.cn}"
  sed -i "s:deb.debian.org:${mirror}:;" /etc/apt/sources.list
  sed -i "s:security.debian.org:${mirror}:;" /etc/apt/sources.list
  sed -i 's:main$:main non-free contrib:;' /etc/apt/sources.list
  apt-get update
  local -a pkgs
  pkgs+=(graphviz)
  pkgs+=(texlive-fonts-extra)
  pkgs+=(texlive-lang-chinese)
  pkgs+=(texlive-latex-extra)
  pkgs+=(texlive-latex-recommended)
  pkgs+=(texlive-xetex)
  apt-get install -y "${pkgs[@]}"
}

install_texlive
