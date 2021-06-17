#!/usr/bin/bash


# target- the best is reading a file if the scope contains xx domains
# for now a single domain

# a dir for each target

mkdir ./$1
touch $1/$1.subdomains

print "starting amass.."
amass -active -d $1 | tee -a $1/$1.subdomains
print "starting subfinder.."
subfinder  -silent -nW -dL subdomain.list.all.txt  -silent  -rL resolvers.txt  -d $1  | tee -a $1/$1.subdomains
print "starting waybackurls.."
python3.9 waybackurls.py $1 * >> $1/$1.waybackurls 


echo "Probing for live hosts woth httprobe..."
cat $1/$1.subdomains | sort -u | httprobe -c 50 -t 3000 >> $1/$1.responsive.txt
cat $1/$1.responsive.txt | sed 's/\http\:\/\///g' |  sed 's/\https\:\/\///g' | sort -u | while read line; do
probeurl=$(cat $1/$1.responsive.txt | sort -u | grep -m 1 $line)
echo "$probeurl" >> $1/$1.urllist.txt
done
echo  "${yellow}Total of $(wc -l $1/$1.urllist.txt domains)"



echo "Starting aquatone scan... >> $1/$1.waybackurls.txt"
cat $1/$1.urllist.txt | ./aquatone -chrome-path /usr/bin/chromium -out $1/$1.aqua_out -threads 10 -silent

echo "Starting wafw00f .."
touch $1/$1.wafw00f.txt
#cat $1/$1.urllist.txt | sort | while read line; do wafw00f $line | tee -a $1/$1.wafw00f.txt;done;


cat $1/$1.urllist.txt | sort | while read line; do wafw00f $line | tee -a $1/$1.wafw00f.txt;done;

cat subdomains.txt | xargs -n1 host | grep "has address" | cut -d" " -f4 | sort -u > ips.txt


## eof.recon

#echo "starting skipfish..."
#cat $1/$1.urllist.txt | sort | while read line;do f=$line;  fn=$('s~http[s]*://~~g' $f); skipfish -o $1/skip.$fn $line;done;

#cat $1/$1.urllist.txt | sort | while read line;do fn=`echo $line|cut -d'/' -f3`; skipfish -o skip.$fn $line ;done;

# add code that removes domains that points to gmail, outlook etc.

# test
#           spider  paramspider, reconspider  
# ok        sqli    sqlmap 
# ok        xss     xsstrike
# ok        brute   gobuster, ffuf, masscan
#           fuzz    ffuf, bountyit
# ok        ports   nmap, masscan
#           .*.     uniscan, skipfish, whatweb, wfuzz
echo "starting paramspider.. "
cat $1/$1.urllist.txt | sort | while read line; do fn=`echo $line|cut -d'/' -f3`;python3.9 3/ParamSpider/paramspider.py --level high -d $line -o $1/$1.parameters; cat $1/$1.parameters |~/go/bin/./BountyIt -p 1/zloads | tee -a $1/$1.bountyit; done;

#echo "bountyit on parameters.."


#echo "starting xsstrike .."
#cat $1/$1.urllist.txt  | sort | while read line; do echo xsstrike running @ $line; fn=`echo $line|cut -d'/' -f3`;  python3.9 ~/priv/code/projects.clon/XSStrike/xsstrike.py --blind --console-log-level GOOD -t 10 --params  --crawl -l 10 -u $line | tee -a $1/$fn.xsstrike; done;


#cat  |~/go/bin/./BountyIt -p 3/
