#!/bin/bash
# tfw you dont want to use a stack project

file="Test.hs"
cmd=$(cat <<-EOF
    echo ":set -package hspec
          :set -package QuickCheck
          :!clear
          :l $file
          main" | ghci
EOF)

echo "./LogAnalysis.hs" | entr -c bash -c "$cmd"
