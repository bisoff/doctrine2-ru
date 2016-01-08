#!/bin/sh
#transform 08.Работа_с_объектами.asc
echo "$1"
sed -E -i 's/__/_/g' -i $1
sed -E -i 's/^= ([[:digit:]])\s/== /g' $1
sed -E -i 's/^= ([[:digit:]]\.[[:digit:]]{1,2}\.)\s/=== /g' $1
sed -E -i 's/^== ([[:digit:]]\.[[:digit:]]{1,2}.[[:digit:]]{1,2}\.)\s/==== /g' $1
sed -E -i 's/^<\?php/[source, php]\n----\n<?php\n/g' $1
