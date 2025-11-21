#!/bin/bash
# Setup LaTeX PATH and install packages

echo "=========================================="
echo "Setting up LaTeX for compilation"
echo "=========================================="
echo ""

# Correct path for 2025basic
TEXLIVE_PATH="/usr/local/texlive/2025basic/bin/universal-darwin"

# Check if path exists
if [ ! -d "$TEXLIVE_PATH" ]; then
    echo "❌ ERROR: LaTeX not found at $TEXLIVE_PATH"
    echo ""
    echo "Please install BasicTeX first:"
    echo "  brew install --cask basictex"
    exit 1
fi

echo "✓ Found LaTeX at: $TEXLIVE_PATH"
echo ""

# Add to PATH for current session
export PATH="$TEXLIVE_PATH:$PATH"

# Verify commands are accessible
if command -v tlmgr &> /dev/null; then
    echo "✓ tlmgr is accessible"
else
    echo "❌ tlmgr not found. Adding to PATH..."
    export PATH="$TEXLIVE_PATH:$PATH"
fi

if command -v pdflatex &> /dev/null; then
    echo "✓ pdflatex is accessible"
    pdflatex --version | head -1
else
    echo "❌ pdflatex not found"
    exit 1
fi

echo ""
echo "=========================================="
echo "Installing required LaTeX packages"
echo "=========================================="
echo ""

# Update tlmgr first
echo "Step 1: Updating tlmgr..."
sudo "$TEXLIVE_PATH/tlmgr" update --self

# Install required packages
echo ""
echo "Step 2: Installing packages..."
sudo "$TEXLIVE_PATH/tlmgr" install collection-latexextra times helvet courier

echo ""
echo "=========================================="
echo "✅ Setup complete!"
echo "=========================================="
echo ""
echo "To use LaTeX in this terminal session, run:"
echo "  export PATH=\"$TEXLIVE_PATH:\$PATH\""
echo ""
echo "To make it permanent, add to ~/.zshrc:"
echo "  echo 'export PATH=\"$TEXLIVE_PATH:\$PATH\"' >> ~/.zshrc"
echo "  source ~/.zshrc"
echo ""


