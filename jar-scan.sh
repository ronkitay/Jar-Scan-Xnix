#!/bin/tcsh -f

if ( $#argv < 2 ) then
        printf "Scans all the JARs in the specified directory for classes matching the specified string\n"
        printf "Usage: $0 <dir> <class-name-pattern>\n"
        printf "Example: $0 . Exception\n"
        printf 'Example: '$0' $JAVA_HOME/lib "com\/sun\/.*action"\n'
        exit 1
endif

set DIR = "$1"
set CLASS = "$2"

foreach J ( `find $DIR -name "*.jar"` )
        printf "."
        set res=`jar tvf $J | grep "$CLASS" | sed 's/$/;/'`
        set outputsize = `echo $res|wc -c`
        if ( $outputsize > 1 )  then
                printf "\nMatch found in [$J]\n "
                printf  "$res\n" | tr ';' '\n' | grep --color "$CLASS"
        endif
end

printf "\n"
