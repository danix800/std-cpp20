find . -name "*.aux" -exec rm -v {} \;
find . -name "*.log" -exec rm -v {} \;
find . -name "*.out" -exec rm -v {} \;
find . -name "*.pdf" -exec rm -v {} \;
rm -v *.toc *.fdb_latexmk *.fls *.synctex.gz
