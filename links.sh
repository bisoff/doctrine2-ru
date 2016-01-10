#!/bin/sh

#msys 1.9.x
#ex.: $./trans.sh "23*" all

fname=$(find $1 -name "*.asc")
[[ "$fname" == "" ]] && echo Not found && exit
#echo "input:     $fname"

grep http $fname | sed -E -n 's/.*(http[[:alnum:]:./]+).*$/\1/p' #show all ext links