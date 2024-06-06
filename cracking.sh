#!/usr/bin/bash
 
read -p 'Type: ' type
read -p 'DIR: ' local
read -p 'Filename: ' hash
 
basedir='/home/korang/cracking/'
path="$basedir$local/$hash"
outhash="${hash}cracked.txt"
pot="$hash.pot"
session="$hash"
 
dicts=("wordlist.txt")
rules=("best64.rule" "d3ad0ne.rule" "dive.rule" "OneRuleToRuleThemAll.rule")
 
# Standard hashcat commands without rules
for dict in "${dicts[@]}"; do
    ./hashcat.bin -m $type -w 3 $path $basedir'dict/'$dict --session $session --potfile-path $pot -o $basedir$local'/'$outhash -O
done
 
# Hashcat commands with rules
for dict in "${dicts[@]}"; do
    for rule in "${rules[@]}"; do
        ./hashcat.bin -m $type -w 3 --loopback $path $basedir'dict/'$dict -r rules/$rule --session $session --potfile-path $pot -o $basedir$local'/'$outhash -O
    done
done
