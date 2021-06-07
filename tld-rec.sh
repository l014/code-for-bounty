#!/bin/bash

# country tld check
d=$1
mkdir -p recTLD/$d
log=recTLD/$d/$d.tld.check.log
final=recTLD/$d/$d-tld.final
echo "[+] running tld list against "$d
while read t;do l=`echo $t | cut -f 1 -d " "`;host $d$l|tee -a $log;done<lists/tld-countries.txt 
egrep 'address|handled' $log | sort -u | tee -a $final
echo "[+] done.."
