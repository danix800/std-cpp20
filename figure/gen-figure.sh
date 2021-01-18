for f in *.dot; do dot -Tpdf $f -o $(basename $f .dot).pdf; done
