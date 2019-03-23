#!/bin/bash
# tfw you dont want to use a stack project

file="Test.hs"
cmd=$(cat <<-EOF
    echo ":!clear
          main
         " | ghci $file -package QuickCheck -package hspec
EOF)

echo "./LogAnalysis.hs" | entr -c bash -c "$cmd"
