#!/bin/bash

declare file
declare dir
while IFS='|' read empty id paras ref en zh; do
  id="${id%%  *}"
  oid="${id}"
  id="${id,,}"
  paras="${paras%%  *}"
  ref="${ref%%  *}"
  en="${en%%  *}"
  zh="${zh%%  *}"
  # zh=$(echo "${zh}" | sed -E 's/([a-zA-Z0-9<>:_*.-]+)/\\tm{\1}/g')
  # zh="${zh//_/\\_}"
  # zh="${zh//#/\\#}"
  : echo "zh = ${zh}"
  : continue

  level=$(echo "${id}" | awk -F. '{print NF}')
  chapter="${id%%.*}"
  # echo "id = $id, ref = $ref, en = $en, zh = $zh, level = $level, file = $file"

  if [[ "${chapter}" == "0" ]]; then
    # foreword
    mkdir -p "chapters/paragraphs/f"
    touch "chapters/paragraphs/f/0.${ref}.tex"
    cat > "chapters/0.${ref}.tex" << EOF
\\chapter*{${zh}}
\\addcontentsline{toc}{chapter}{${zh}}
\\markboth{${zh}}{}

\\noindent
\\input{chapters/paragraphs/f/0.${ref}.tex}
EOF
    continue
  elif [[ "${level}" -eq 1 ]]; then
    chapter_dir="chapters/paragraphs/${chapter}"
    mkdir -p "${chapter_dir}"
    file="chapters/${chapter}.${ref}.tex"
    # generate header
    echo -n > "${file}"
  elif [[ "${chapter}" == '3' || "${id}" =~ ^30\.2\. ]]; then
    zh="${zh%%\[*}"
    cat >> "${file}" << EOF
\\defns{${zh}}{${ref}}{${en}}{<++>}

EOF
    continue
  fi

  echo "% $oid $en [$ref]" >> "${file}"
  if [[ "${level}" -eq 1 ]]; then
    if [[ "${id}" =~ ^[0-9] ]]; then
      echo "\\chptr{${zh}}{${ref}}" >> "${file}"
    else
      echo "\\annex{${zh}}{${ref}}" >> "${file}"
    fi
  else
    sectcmd=ect
    for i in $(seq 1 "$((level - 1))"); do
      sectcmd="s${sectcmd}"
    done
    echo "\\${sectcmd}{${zh}}{${ref}}" >> "${file}"
  fi

  parafile="${chapter_dir}/${id}.${ref}.tex"

  if [[ "${paras}" -gt 0 ]]; then
    echo "\\input{chapters/paragraphs/${chapter}/${id}.${ref}.tex}" >> "${file}"
    if [[ ! -f "${parafile}" ]]; then
      echo "% $oid $en [$ref]" >> "${parafile}"
      for i in $(seq 1 "${paras}"); do
        cat >> "${parafile}" << EOF
\paragraph{}
<++>

EOF
      done
    fi
  fi

  if [[ "${level}" -eq 2 && "${chapter}" == "a" ]]; then
    sid=$(echo "${id}" | awk -F. '{print $2}')
    if [[ "${sid}" -ge 3 ]]; then
      echo "\\input{chapters/paragraphs/${chapter}/${id}.${ref}.tex}" >> "${file}"
      if [[ ! -f "chapters/paragraphs/${chapter}/${id}.${ref}.tex" ]]; then
        cat >> "chapters/paragraphs/${chapter}/${id}.${ref}.tex" << EOF
% $oid $en [$ref]
<++>
EOF
      fi
    fi
  fi
done <<< $(sed 1d toc.lst)
