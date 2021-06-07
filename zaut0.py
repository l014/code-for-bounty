#!/usr/bin/python3
from os import listdir
from os.path import isfile, join
import requests, validators
import subprocess,os,shutil,time
from urllib.parse import urlparse
import random, time


def arjun(url):
    print("\[+]arjun /\_O_o_/\ ")
    subprocess.check_call(['./arj.sh', url])

def dalfox(url):
    print("\[+]dalfox /\_O_o_/\ ")
    subprocess.check_call(['./dalfox.sh', url])

def injuRUN(url):
    print("\[+]injectus /\_O_o_/\ ")
    subprocess.check_call(['./inj0r.sh', url])
    
def xssRUN(url):
    print("\n\t     /\_O_o_/\ ")
    print("\t_(ó-ó)/xxstr.run \_O_o_")
    subprocess.check_call(['./xss.sh', url])

def bonIt(url):
    print("\n\t     /\_O_o_/\ ")
    print("\t_(ó-ó)/bouit.run \_O_o_")
    subprocess.check_call(['./bon.sh', url])
    
def nndd(d):
    print("\n\t     /¯\_O_o_/\ ")
    print("\t_(ó-ó)/.*..run   \_O_o_")
    subprocess.check_call(['./nndd.sh', d])
    

def isDup(endp, actu):    

#   check if url is a dup o_O/ 
#   https://pwned.oo/?para1=39983u9&para2=3989378,https://pwned.oo/?para1=3&para2=89usjk <- dup
#   https://pwned.oo/?para1=39983u9&para2=3989378&para3=93 <- new parameter, not dup , https://pwned.oo/?para1=39983u9&para2=3989378&para3=39  <- dup

#   reminder, fix this ugly function using unfurl or urlparse

    dup = False    
    pnameC =[]
    pnameE = []
    tmp=[]
    ts=""
    dups=[]
    up=urlparse(actu)   
    tmp = up.query.split("&")
    for d in tmp:
        pnameC.append(d.split('=')[0]) 

    for e in endp:
        tmp=urlparse(e)

        tmp = tmp.query.split("&")
        for d in tmp:
            pnameE.append(d.split("=")[0])

        if len(pnameC)==len(pnameE):
        
            for p in pnameC:
                if p in pnameE:
                    dups.append(1)
                else:
                    dups.append(0)
                if sum(dups)!=0:
                    dup=False
                    break
        if sum(dups) == 0:
            dup=True           
        else:
            dup=False
        dups=[]     
    #print(dup)
    return dup

def strCh(u, conOk):

#   check if url is valid
#   
    xbit=[]
    xbit.append(validators.url(u))
    xbit.append(statCh(u))
    if xbit[0] ==True and xbit[1]==True:
        conOk.append(u)
        return True
    else:
        return False

def scanIT(path,scanthis):
    urls=[]
   # for f in scanthis:
   #    urls=[]
    file=open(path+scanthis,"r")
    for u in file:
        urls.append(u)
    file.close() 
    shutil.move("scanthis/"+scanthis, 'history/'+scanthis)
    errIT(urls)

def errIT(urls):

    lisl=len(urls)
    if lisl >=1:
        print("\t                    /¯\_O_o_/\ ")   
        print("\t\____O_x)_/ \_(ó-ó)/          \_O_o_/¯")
        print("\n\t\t\t[i] Got some fine LiN3s ",len(urls))

      
    print("\n[i] moving file.. _/\(oO)/\_\n")
    enddups = []     
    conErr=[]
    conOk=[]
    endpScan=[]  
    nlock=""
    dc=0   
    status=True
    for e in urls:
        us = urlparse(e)
        nlock = us.netloc
        us=(us.scheme+"://"+us.netloc)    
        # 3 checks before adding url for scanning
        if strCh(us,conOk): # if valid url and if responding
            conOk.append(us)
            if isDup(endpScan, e)==False: # if not a duplicate. Checks only whats in the endpscan list
                print("[i] saving : ", e)
                endpScan.append(e)
            else:
                print("[i] dup++ ", e)
                enddups.append(e)    
        else:
            print("[i] con.err++ ", e)
            conErr.append(us)
               
    ulist=list(set(endpScan)) 
 
    for url in ulist:
        global endpDone
        if url not in endpDone:
            
            notex = urlparse(url)
            forbExt = [".pdf",".png",".css",".jpg","jpeg",".gif",".svg",".woff",".ttf"]
            #if not notex.path.endswith not in forbExt:
            if statCh(url)==True:
                try:
                    xssRUN(url)
                except:
                    print("eRRxss ",url) # xsstrike <3

                try:
                    injuRUN(url) # injectus
                except:
                    print("injusERR ",url)

            endpDone.append(url)
        else:
            print("[i] url in history - ",d)



    dlist=list(set(conOk))
    # dlist should only hold the domain without paths and paramters
    for d in dlist:
        global domDone  
        if d not in domDone:
            try:
                zfuzz(d) #
                 
            except:
                print("zfuzzErr ",d)
      
            try:
                arjun(d) # find more parameters
            except:
                print("eRRarjun ",d)
            
            try:                
                nndd(d) # whatweb, skipfish gobuster, and simple header fuzz using curl
                           
            except:
                print("eRRndd ",d)
        
            domDone.append(d)
        else:
            print("[i] url in history - ",d)
            
def statCh(u):
    try:
        requests.get(u)
        return True
    except:
       return False
    

def hcheck(url):
    return False 
    # check if url in any history
#    ish=False
#    history = [f for f in listdir("history/") if isfile(join("history/", f))]
#    if history:
#        for f in history:
        
#            with open("history/"+f) as hfile:
#                if url in hfile.read():
#                    ish=True
#            if ish == True:
#                break    
#    return ish

def moveF(path,fl):
    ts = time.time()
    print("move ",fl)
    
    for f in fl:
        shutil.move("scanthis/"+f, path+f+str(ts))
def banner():
    os.system('clear')
    banner = '''
            mdddhhhhhdddmNNMMMMMMMMMMMMMM
        MMMMMMmmhhhhhdddddhddhhhhhhhdmMMMMMMMMMMM
    MMMMMMMMmhyhhhhdNMMMMMMMNNmhhhhhhhhdNMMMMMMMM
    MMMMMMmhhhhhhhdMMMMMMMNdhhhhhhhhhhhhhhmMMMMMM
    MMMMMdhhhhhhhdNMMMMMMMdhhhhhhhhhhhhhhhhmMMMMM
    MMMNhhhhhhhhhmMMMMMMMMMmdhhhhhhhhhhhhhhhdNM
    mMNhhhhhhhhhmMMMMMMMMMMMMNmhhhhhhhhhhhhhhdMMM
    dMmhhhhhhhhhMMMMMMMMMMMMMMMNhhhhhhhhhhhhhhNMM
    MNhhhhhhhhhhMMMMMMMMMMMMMMMMdhhhhhhhhhhhhhmMM
    MNhhhhhhhhhhmMMMMMMMMMMMMMMMNhhhhhhhhhhhhhhNM
    MNhhhhhhhhhhhmMMMMMMMMMMMMMMMmhhhhhhhhhhhhhNM
    MNhhhhhhhhhhhhmMMMMMMMMMMMMMMNhhhhhhhhhhhhmMM
     MdhhhhhhhhhhhhmMMMMMMMMMMMMMMdhhhhhhhhhhhNMM
    MMNhhhhhhhhhhhhhdMMmhdmNMMMMMMmhhhhhhhhhhdMMM
    MMMNhhhhhhhhhhhhhNNdhhhhhdNMMMMNdhhhhhhhdNMMM
    MMMMMhhhhhhhhhhhdmhhhhhhhhNmMMMMMNhhhhhhMMMMM
    MMMMMMmhhhhhhddmNhhhhhhdddNmhmNMMMdhhhmM
    MMMMMMMMMMMMM    zaut0 beta   MMMMMMMMMMMMMMM
          { zionskompis[at]initgriti[dot]me }
    '''
    print(banner)    
    time.sleep(3)
    
def newFile(spath):
    scanthis = [f for f in listdir(spath) if isfile(join(spath, f))]
    if scanthis:
        return scanthis[0]        
    else: 
        return False
         
def main():
    banner()
    spath = "scanthis/"
    hpath = "history/"
    global endpDone
    global domDone
    endpDone=[]
    domDone=[]
    while newFile(spath):
        scanthis=newFile(spath)
        if scanthis:
            scanIT(spath,scanthis)
        else:
            print("\t___(X_X)_____\n")
            print("\t..more LINES plz..")
            print("calling.die()\n")
            exit()
            #moveF(hpath,scanthis) 
   
     
if __name__ == '__main__':
    main()
