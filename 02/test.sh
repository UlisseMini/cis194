#!/bin/bash
# tfw you dont want to use a stack project

#echo "./LogAnalysis.hs"
ls *.hs | entr -c ghci "./Test.hs" -e "main" -package QuickCheck -package hspec
