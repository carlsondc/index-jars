#!/bin/bash
log=log
read jarFile
while [ "$jarFile" != "" ]
do
  echo "indexing $jarFile " >> $log
  #seriously, there's no good awk syntax for "all-but-the-last field"?
  jar tf $jarFile | egrep '.(class|java)$' | tr '/' '.' \
    | awk -F . '{
      if ($(NF) == "java"){
        print "S " $0
      }else{
        print "C " $0
      }
    }' | rev | cut -d '.' -f 1 --complement \
      | rev | awk "{print \$0 \" $jarFile\"}" 2>> $log
  read jarFile
done
