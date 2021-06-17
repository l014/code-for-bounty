#!/bin/bash
timestamp=$(date +%s)
python3.9 ../3/Injectus/Injectus.py -u $1 | tee -a ../scan.out/injus.out/$timestamp
