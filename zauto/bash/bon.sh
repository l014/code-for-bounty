#!/bin/bash
timestamp=$(date +%s)
u=$1
mkdir -p ../scan.out/bitOut
echo $u"FUZZ" | ~/go/bin/./BountyIt --header "HOST: host" -t 100 -p lists/zpays | tee -a scan.out/bitOut/$timestamp
