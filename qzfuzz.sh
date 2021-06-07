#!/bin/bash

# header/path - quick fuzz
u=$1
timestamp=$(date +%s) 
while read pay 
do
    curl -I -vvvv -H "Origin: https://svt.app" -H "HOST: svt.app" -H "User-Agent: ZIONZIONK/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0" -H "X-Forwarded-For: nl.svt.app" "$u$pay"  | tee -a zfuzz.$timestamp.log
done<lists/zionkpays
