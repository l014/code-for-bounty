#!/usr/bin/bash

mkdir -p zionk.recon.out/$1
out=zionk.recon.out
spath=`pwd`
subfinder  -silent -nW -dL 3/zlist/subbdomain.list.all.txt  -silent  -rL 3/zlist/resolvers.txt  -d $1  | tee -a $out/$1/$1.subdomains
python3.9 3/waybackurls.py $1 * | tee -a $out/$1/$1-waybackurls 
cat $out/$1/$1.subdomains | sort | while read line;do python3.9 3/waybackurls.py $line * | tee -a $out/$1/$1-waybackurls;done;
cat $out/$1/$1.subdomains | sort -u | httprobe -c 50 -t 3000 >> $out/$1/$1.responsive.txt
cat $out/$1/$1.responsive.txt | sed 's/\http\:\/\///g' |  sed 's/\https\:\/\///g' | sort -u | while read line;do probeurl=$(cat $out/$1/$1.responsive.txt | sort -u | grep -m 1 $line); echo "$probeurl" | tee -a $out/$1/$1.urllist.txt;done
cat $out/$1/$1.urllist.txt | 3/./aquatone -chrome-path /usr/bin/chromium -out $out/$1/$1.aqua_out -threads 10 
touch $out/$1/$1.wafw00f.txt
cat $out/$1/$1.urllist.txt | sort | while read line; do wafw00f $line | tee -a $out/$1/$1.wafw00f.txt;done;
