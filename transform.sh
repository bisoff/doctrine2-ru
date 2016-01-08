#!/bin/sh

#msys 1.9.x
#./transform.sh 08.Работа_с_объектами.asc
#./transform.sh 09*
#single cmd ex.: sed -E -i 's/^CREATE TABLE /[source, sql]\n----\nCREATE TABLE /g' 09*

ls "$1"
[[ $? == 1 ]] && echo Not found && exit
sed -E -i "s/__/_/g" "$1" # в asciidoc не нужно удвоение
sed -E -i "s/**/*/g" "$1" # ~
sed -E -i 's/^= ([[:digit:]])\s/== /g' "$1"
sed -E -i 's/^= ([[:digit:]]\.[[:digit:]]{1,2}\.)\s/=== /g' "$1"
sed -E -i 's/^== ([[:digit:]]\.[[:digit:]]{1,2}.[[:digit:]]{1,2}\.)\s/==== /g' "$1"
sed -E -i 's/^<\?php/[source, php]\n----\n<?php\n/g' "$1"
sed -E -i 's/^CREATE TABLE /[source, sql]\n----\nCREATE TABLE /g' "$1"
