#!/bin/bash

u=$1
sleep 2
timestamp=$(date +%s)
url=`echo $1 | ~/go/bin/unfurl format %d%p%q% | awk -F= '{print $1"="FUZZ}'` 
mkdir -p scan.out/zfuzz
while read pay; 
do
    url=`echo $1 | ~/go/bin/unfurl format %s"://"%d%p%q% | awk -F= '{print $1"="FUZZ}'`
    echo  $pay;
    curl  -vvvv -H "Origin: https://svt.app" -H "HOST: svt.app" -H "User-Agent: MozillaZIONZIONK/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0" -H "X-Forwarded-For: nl.svt.app" "$unj$pay"  | tee -a scan.out/zfuzz/curl.$timestamp.log
done<../1/zionk.vul.fuzz
