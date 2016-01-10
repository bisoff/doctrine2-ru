#!/bin/sh
#msys 1.9.x
fname=$(find $1 -name "*.asc")
[[ "$fname" == "" ]] && echo Not found && exit

trans.sh "$fname" aih
trans.sh "$fname" s3s 
trans.sh "$fname" s2s
trans.sh "$fname" s1s
trans.sh "$fname" enum
trans.sh "$fname" note
trans.sh "$fname" java
links.sh "$fname" 
