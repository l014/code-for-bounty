#!/bin/bash
echo $1 
timestamp=$(date +%s)
python3 ../XSStrike/xsstrike.py  -t 70 --console-log-level DEBUG -u $1 | tee -a scan.out/xsserouts/$timestamp
                                                              
