#!/bin/sh

#msys 1.9.x
#ex.: $./trans.sh "23*" all

#ex.: $./trans.sh "23*" aih # anchorInHead
#ex.: $./trans.sh "23*" s3s 
#ex.: $./trans.sh "23*" s2s
#ex.: $./trans.sh "23*" s1s
#ex.: $./trans.sh "23*"  

[[ "$1" == "" ]] && echo aih italic bold s1 s1 s111 s1111 php ddl && exit
fname=$(find $1 -name "*.asc")
[[ "$fname" == "" ]] && echo Not found && exit
echo "input:     $fname"
skip_backup=$3

function transform {
	echo transform: "$1"
	sed -E "$1" "$fname" > "~tmp" #~tmp* нужен т.к. msys 'sed -i' не работает с кириллическими именами  
	if !([ "$skip_backup" == "-" ]); then 
		echo "backup:    $fname.$2$(echo bak)"
		mv -f "$fname" "$fname.$2$(echo bak)"
	  fi
	mv -f "~tmp" "$fname"	
	}

# test your ones on text window: sed -E 's/^=== ([][:alpha:] []+)/==== \1/g' 23* | head -n 30 | tail -n 10

# links:
[[ "$2" == "aih"	|| "$2" == "all" ]] && transform 's/^(=+ )[^#]+#([[:alpha:]-]+)\[\](.+)/\1\3 [[\2]]/g' 'aih.' #anchorInHead

# style
[[ "$2" == "italic" 	|| "$2" == "all" ]] && transform 's/__/_/g' "italic."  # в asciidoc не нужно удвоение
[[ "$2" == "bold"  	|| "$2" == "all" ]] && transform 's/\*\*/*/g' "bold."

# headers:
[[ "$2" == "s1" 	|| "$2" == "all" ]] && transform 's/^= [[:alpha:]]+$/== /g' "s1." # top level section 
[[ "$2" == "s2"	 	|| "$2" == "all" ]] && transform 's/^== [[:digit:]]{1,2}\.[[:digit:]]{1,2}\.[[:space:]]+/=== /g' 's2.' # 1.1 Section
[[ "$2" == "s3"	 	|| "$2" == "all" ]] && transform 's/^== [[:digit:]]{1,2}\.[[:digit:]]{1,2}.[[:digit:]]{1,2}\.[[:space:]]+/==== /g' 's3.' # 1.1.1 Section
[[ "$2" == "s4" 	|| "$2" == "all" ]] && transform 's/^=== [[:digit:]]{1,2}\.[[:digit:]]{1,2}.[[:digit:]]{1,2}\.[[:digit:]]{1,2}\.[[:space:]]+/===== /g' 's4.'

[[ "$2" == "s3s" 	|| "$2" == "all" ]] && transform 's/^=== ([][:alpha:] []+)/==== \1/g' 's3s.' #s3 shift to s4
[[ "$2" == "s2s" 	|| "$2" == "all" ]] && transform 's/^== ([][:alpha:] []+)/=== \1/g' 's2s.' #s3 shift to s4
[[ "$2" == "s1s" 	|| "$2" == "all" ]] && transform 's/^= ([][:alpha:] []+)/== \1/g' 's2s.' #s3 shift to s4

# source:
[[ "$2" == "php" 	|| "$2" == "all" ]] && transform 's/^[[:space:]]*<\?php/[source, php]\n----\n<?php\n/g' 'php.'
[[ "$2" == "ddl" 	|| "$2" == "all" ]] && transform 's/^CREATE TABLE /[source, sql]\n----\nCREATE TABLE /g' 'ddl.'
[[ "$2" == "java" 	|| "$2" == "all" ]] && transform 's/^\[source,java\]/[source, php]/g' 'java.'

# enums:
[[ "$2" == "enum" 	|| "$2" == "all" ]] && transform '\#^\*#, \#^[^*].*$# s/(^[^*].*)/\n\1/' 'enum.'

# spec paragraphs:
[[ "$2" == "note" 	|| "$2" == "all" ]] && transform ':a;N;N;$!ba;s/Note\n\n/> /g' 'note.' #sed -E '\#^Note#, \#^.+$# s/.*/> /g' 23*.asc | head -n 250 | tail -n 10 



#sed -E 's/^= [[:space:]]*[^[:digit:]]/== /g' "~tmp2" > "~tmp3"
#sed -E 's/^= ([[:digit:]])[[:space:]]*/== /g' "~tmp2" > "~tmp3"
#sed -E 's/^= ([[:digit:]]\.[[:digit:]]{1,2}\.)[[:space:]]*/=== /g' "~tmp3" > "~tmp4"

#links:
# <https://github.com/doctrine/cache/tree/master/lib/Doctrine/Common/Cache[https://github.com/doctrine/cache/tree/master/lib/Doctrine/Common/Cache]>
# grep http 23*.asc | sed -E -n 's/.*(http[[:alnum:]:./]+).*$/\1/p' #show all ext links