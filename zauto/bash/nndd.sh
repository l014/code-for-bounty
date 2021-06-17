#!/bin/bash
timestamp=$(date +%s)
u=$1
mkdir -p scan.out/response
export CURRENT_PATH=$(pwd)
fetch_resp() {
	echo -e "Scanning: $1"
	#NAME=$(echo $1 | cut -d "/" -f 3)
	curl -s -X GET -H "X-Forwarded-For: svt.app" $1 -kLI >> "$CURRENT_PATH/response/$timestamp"
	curl -s -X GET -H "X-Forwarded-For: svt.app" -kL $1 >> "$CURRENT_PATH/response/$timestamp"
	curl -s -X GET -H "HOST: svt.app" -kL $1 >> "$CURRENT_PATH/response/$timestamp"
	curl -s -X POST -H "HOST: zion'><ZIONK:zi//<5555><<K" -kL $1 >> "$CURRENT_PATH/response/$timestamp"
	curl -s -X PUT -H "HOST: localhost" $1 -kLI >> "$CURRENT_PATH/response/$1"
	curl -s -X GET -H 'HOST: %0B`sleep$(IFS)55`svt.app' $1 -kLI >> "$CURRENT_PATH/response/$timestamp"
	curl -s -X OPTIONS -H 'HOST: %0B`sleep$(IFS)55`svt.app' $1 -kLI >> "$CURRENT_PATH/response/$timestamp"
	curl -s -X HEAD -H 'HOST: %0B`sleep$(IFS)55`svt.app' $1 -kLI >> "$CURRENT_PATH/response/$timestamp"
}


export -f fetch_resp
cat $1 | xargs -P 50 -n 1 -I {} bash -c "fetch_resp {}"

mkdir -p scan.out/nmapscans
mkdir -p scan.out/uniscans
mkdir -p scan.out/whatweb
#mkdir -p scan.out/xss.$1
mkdir -p scan.out/dirb 
mkdir -p scan.out/gobust
mkdir -p scan.out/skip 
mkdir -p scan.out/nikto 
mkdir -p scan.out/ownfuzz.$1
#host $1 | grep 'has address' | ip = `cut -d " " -f 4`

#nmap -A -T5 -v -v -Pn -p- -oA scan.out/nmapscans/$timestamp
whatweb -a 3 -v -v $u | tee -a scan.out/whatweb/$timestamp
#uniscan -dsgj -u $u | tee -a scan.out/uniscans/$timestamp
#gobuster dir -r  -u $u  -t 50 -w lists/webmerged.txt | tee -a scan.out/gobust/$timestamp
gobuster dir -r -l -k -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0, Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8, Pragma: no-cache, Cache-Control: no-cache' -u $u  -t 50 -w lists/webmerged.txt | tee -a scan.out/gobust/gob.http.out
#nikto -url $u | tee -a scan.out/nikto/$u.out
#skipfish -o scan.out/skip/$timestamp $u
