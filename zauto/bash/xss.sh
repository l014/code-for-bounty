#!/bin/bash

echo "xss start "
echo $1 

timestamp=$(date +%s)
#while read u; do echo $u; 
 
#host $1 | grep 'has address' | ip = `cut -d " " -f 4`

python3 ../XSStrike/xsstrike.py  -t 70 --console-log-level DEBUG -u $1 | tee -a scan.out/xsserouts/$timestamp


#python3.9 ~/priv/code/projects.clon/XSStrike/xsstrike.py --console-log-level INFO -u  $1 | tee -a scan..out/randstad                                                                    
echo $1
