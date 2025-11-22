#!/bin/bash

# Compilation script for LaTeX report
# This script runs pdflatex -> bibtex -> pdflatex (twice) to ensure proper references

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

# Copy aaai.bst to report if it exists in root
if [ -f aaai.bst ] && [ ! -f report/aaai.bst ]; then
    cp aaai.bst report/
    echo "Copied aaai.bst to report/"
fi

cd report || exit 1

echo "Step 1: Running pdflatex (first pass)..."
pdflatex -interaction=nonstopmode main.tex > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: pdflatex failed. Check main.tex for errors."
    pdflatex main.tex
    exit 1
fi

echo "Step 2: Running bibtex..."
bibtex main > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Warning: bibtex had issues. Continuing anyway..."
fi

echo "Step 3: Running pdflatex (second pass)..."
pdflatex -interaction=nonstopmode main.tex > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: pdflatex failed on second pass."
    pdflatex main.tex
    exit 1
fi

echo "Step 4: Running pdflatex (third pass for cross-references)..."
pdflatex -interaction=nonstopmode main.tex > /dev/null 2>&1

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f main.aux main.bbl main.blg main.log main.out

# Move PDF to parent directory if compilation successful
if [ -f main.pdf ]; then
    mv main.pdf ../final_report.pdf
    echo ""
    echo "✓ Success! Report compiled to final_report.pdf"
    echo "  Page count: $(pdfinfo ../final_report.pdf 2>/dev/null | grep Pages | awk '{print $2}' || echo 'unknown')"
else
    echo "Error: main.pdf was not created."
    exit 1
fi

