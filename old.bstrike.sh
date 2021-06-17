#!/bin/bash

# snip.snip   old.mod.bountystrike.sh
# check out   -> https://github.com/BountyStrike/Bountystrike-sh <-

#  bash added for starting other hackers scripts/bins                                                                 
#  z.add -	  
#     +   gobuster
#     +   retireJS
#     +   sqlmap
#     +   dalfox
#     +   injectus
#     +   arjun
#     +   meg 
#     +   paramspider
#     +   xsstrike

contentDiscovery(){
    cat final-domains.txt | $tools./waybackurls > waybackurls.txt
    cat waybackurls.txt | $tools./unfurl domains | sort | uniq >> $FINAL_DOMAINS
    sort -u $FINAL_DOMAINS -o $FINAL_DOMAINS
    while read u; do python3 $tools./ParamSpider/paramspider.py --subs False --output psider.out.txt  -d $u | tee -a  psider.stout.log ;done<alive.txt
    while read u; do $tools./getJS --complete --url $u | tee -a  alive-js-files.txt;done<alive.txt 
    sort -u  alive-js-files.txt -o alive-js-final.txt
    while read u; do ./resp.sh $u;done<alive.txt
    $tools./jsfiles.sh
    $tools./endpoints.sh
}

vulnerabilityDiscovery(){
    PATH=$(pwd)
    $tools./retire  scriptsresponse/ | tee -a retirejs-$NOW.txt
    $tools./arjun  -i alive.txt -t 40 -oT  arjun.discovery-$NOW.txt
    $tools./meg   -v --header "Origin: https://svt.app" --header "X-Forwarded-For: nl.svt.app" quickhits.txt  alive.txt | tee -a meg.pewpew-$NOW.txt
    while read u; do timestamp=$(date +%s);echo $u; python3 $tools/XSStrike/xsstrike.py --file-log-level VULN --log-file xsstrike.$timestamp  --crawl -l 10 -t 140 --console-log-level DEBUG -u $u | tee -a xsstrike-$NOW.txt;done<alive.txt
    while read u; do echo $u; gobuster dir -r  -u $u  -t 50 -w $tools/lists/webmerged.txt | tee -a gobuster.final-$NOW.txt;done<alive.txt
    $tools./subzy -targets $FINAL_DOMAINS | grep -i -v -E "not vulnerable|ERROR" | tee -a subtakeovers-$NOW.txt
    sort -u arjun.discovery-$NOW.txt -o arjun.final-$NOW.txt
    python3 $tools/Injectus/Injectus.py -f arjun.final-$NOW.txt -w 20 | tee -a injectus.out-$NOW.txt
    while read u; do timestamp=$(date +%s);echo $u; python3 $tools/XSStrike/xsstrike.py --file-log-level VULN --log-file xsstrike.$timestamp  -t 140 --console-log-level DEBUG -u $u | tee -a xsstrike-$NOW.txt;done<arjun.final-$NOW.txt
    
    #while read u; do python3 $tools/ParamSpider/paramspider.py --subs False --output psider.out.txt  -d $u | .$tools/./dalfox pipe --custom-alert-value 1014 -w 300  -o $PATH/dafox.log1-$NOW.txt --format PLAIN | tee -a dafox.log.stdout.txt;done<alive.txt
    #tools./dalfox --custom-alert-value 1014 -w 300 file arjun.discovery-$NOW.txt  -o $PATH/dafox.log2-$NOW.txt --format PLAIN | tee -a dafox.stdout2.log
    #$tools./arjun  -i alive.txt -t 40 -oT  arjun.discovery-$NOW.txt
    #while read u; do timestamp=$(date +%s);echo $u; skipfish -o skip-$NOW-$timestamp $u;done<alive.txt
    #$tools./meg   -v --header "HOST: svt.app" --header "X-Forwarded-For: nl.svt.app" $tools/list/mpays  alive.txt | tee -a meg.log.$NOW.txt
    #while read u; do timestamp=$(date +%s);echo $u; sqlmap -u $u --user-agent=random --threads=10 -vv --batch --risk 3 --level 5 --flush-session | tee -a sqlmap-$NOW.txt;done<arjun.final-$NOW.txt
}




