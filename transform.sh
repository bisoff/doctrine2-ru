#!/bin/sh

#msys 1.9.x

#ex.1: $./transform.sh 08.Работа_с_объектами.asc
#ex.2: $./transform.sh 09*
#ex.3 (cut single cmd): sed -E -i 's/^CREATE TABLE /[source, sql]\n----\nCREATE TABLE /g' 09* > tt

ls "$1"
[[ $? == 1 ]] && echo Not found && exit
fname=$(ls "$1")
echo $fname
#~tmp* нужны т.к. sed -i не работает с кириллическими именами  
sed -E "s/__/_/g" $fname > "~tmp1" # в asciidoc не нужно удвоение
sed -E "s/\*\*/*/g" "~tmp1" > "~tmp2" # ~
sed -E 's/^= /== /g' "~tmp2" > "~tmp3"
#sed -E 's/^= [[:space:]]*[^[:digit:]]/== /g' "~tmp2" > "~tmp3"
#sed -E 's/^= ([[:digit:]])[[:space:]]*/== /g' "~tmp2" > "~tmp3"
sed -E 's/^== [[:digit:]]{1,2}\.[[:digit:]]{1,2}\.[[:space:]]+/=== /g' "~tmp3" > "~tmp4"
#sed -E 's/^= ([[:digit:]]\.[[:digit:]]{1,2}\.)[[:space:]]*/=== /g' "~tmp3" > "~tmp4"
sed -E 's/^== [[:digit:]]{1,2}\.[[:digit:]]{1,2}.[[:digit:]]{1,2}\.[[:space:]]+/==== /g' "~tmp4" > "~tmp5"
sed -E 's/^=== [[:digit:]]{1,2}\.[[:digit:]]{1,2}.[[:digit:]]{1,2}\.[[:digit:]]{1,2}\.[[:space:]]+/===== /g' "~tmp5" > "~tmp6"
sed -E 's/^[[:space:]]*<\?php/[source, php]\n----\n<?php\n/g' "~tmp6" > "~tmp7"
#sed -E 's/^CREATE TABLE /[source, sql]\n----\nCREATE TABLE /g' "~tmp6" > "~tmp7"
==== entityresult[]@EntityResult
sed -E 's/^(=+ )([[:alpha:]]+)\[\](.+)/\1\3 [[\2]]/g' 
mv -f "$fname" "$fname.bak"
mv -f "~tmp7" "$fname"
rm "~tmp1" "~tmp2" "~tmp3" "~tmp4" "~tmp5" "~tmp6"
