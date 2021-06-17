
while read u;do curl -vvvv -L -1 "https://"$u;curl -vvvv -L -1 "http://"$u;done<amass.recon.domain.tld | tee alive.subdomains.domain.tld
while read u;do host $u | tee -a aliive.subdomains;done<subdomains.sorted
while read x;f="?FUZZ"; do echo $x$f | ~/go/bin/./BountyIt -p 1/zpays  | tee -a domains.fuzz.log;done<domain.tld-waybackurls.alive  
while read d; do /usr/bin/bash zionk.rec.sh $d;done<ing.domains.scope
while read d;do ./zionk.rec.sh $d;done<.tld.sorted.txt

