from os import listdir
from os.path import isfile, join
import requests, validators
import subprocess,os,shutil,time
from urllib.parse import urlparse
import random, time



def arjun(url):
    
    #print("\n\t     /¯\_O_o_/\ ")
    #print("\t_(ó-ó)/arjun.run \_O_o_")
    
    os.system("./arj.sh "+str(url))
    #subprocess.check_call(['./arj.sh', url])
    
def xssRUN(url):
    
    print("\n\t     /¯\_O_o_/\ ")
    print("\t_(ó-ó)/xxstr.run \_O_o_")
    subprocess.check_call(['./xss.sh', url])

def bonIt(url):
    print("\n\t     /¯\_O_o_/\ ")
    print("\t_(ó-ó)/bouit.run \_O_o_")
    subprocess.check_call(['./bon.sh', url])
    
def nndd(d):
    print("\n\t     /¯\_O_o_/\ ")
    print("\t_(ó-ó)/.*..run   \_O_o_")
    subprocess.check_call(['./nndd.sh', d])
    
def headerFUZZ(url):

    print("fuzz headers ", url)    

def isDup(endp, actu):    
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
    
    
    #print("checking url list..\n")
    
    lisl=len(urls)
    if lisl >=1:
        print("\t                    /¯\_O_o_/\ ")
        print("\t\____O_x)_/ \_(ó-ó)/          \_O_o_/¯")
        print("\n\t\t\tGot some fine LiN3s ",len(urls))
        print("\t\n\_(ó-ó)/°°¹¹°¹°°¹¹°¹¹¹°°¹¹¹¹¹°¹°°¹°°¹)-(O_o_/")
       

      
    print("\n moving file.. _/\(oO)/\_\n")
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
        if strCh(us,conOk):
            if isDup(endpScan, e)==False:
                
                endpScan.append(e)
            else:
                enddups.append(e)    
        else:
            conErr.append(us)
               



    ulist=list(set(endpScan))    
    
    for url in ulist:
        global endpDone
        if url not in endpDone:
            notex = urlparse(url)
            if not notex.path.endswith("min.js") or not notex.path.endswith(".pdf") or not notex.path.endswith(".png") or not notex.path.endswith(".css") or not notex.path.endswith(".jpg") or not notex.path.endswith(".jpeg") or not notex.path.endswith(".gif") or not notex.path.endswith(".svg")   or not notex.path.endswith(".woff") or not notex.path.endswith(".ttf") or not notex.path.endswith(".js"):
                
                try:
                    xssRUN(url)
                except:
                    print("eRRxss ",url)
                try:    
                    bonIt(url)
                except:
                    print("eRRbonit ",url)
                endpDone.append(url)

    dlist=list(set(conOk))
    for d in dlist:
        global domDone
        
        if d not in domDone:
          
            try:
                arjun(d)
            except:
                print("eRRarjun ",d)
            
            try:                
                nndd(d)
                           
            except:
                print("eRRndd ",d)
                
            domDone.append(d)
            
            
def statCh(u):
    return True
    r=requests.get(u)
    if r.status_code:
        print(r.status_code)
        print(u)
        return True
    else:
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
    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
    MMMMMMMMMMMMMMNNmdddhhhhhdddmNNMMMMMMMMMMMMMM
    MMMMMMMMMMmmhhhhhdddddhddhhhhhhhdmMMMMMMMMMMM
    MMMMMMMMmhyhhhhdNMMMMMMMNNmhhhhhhhhdNMMMMMMMM
    MMMMMMmhhhhhhhdMMMMMMMNdhhhhhhhhhhhhhhmMMMMMM
    MMMMMdhhhhhhhdNMMMMMMMdhhhhhhhhhhhhhhhhmMMMMM
    MMMNhhhhhhhhhmMMMMMMMMMmdhhhhhhhhhhhhhhhdNMMM
    mMNhhhhhhhhhmMMMMMMMMMMMMNmhhhhhhhhhhhhhhdMMM
    dMmhhhhhhhhhMMMMMMMMMMMMMMMNhhhhhhhhhhhhhhNMM
    MNhhhhhhhhhhMMMMMMMMMMMMMMMMdhhhhhhhhhhhhhmMM
    MNhhhhhhhhhhmMMMMMMMMMMMMMMMNhhhhhhhhhhhhhhNM
    MNhhhhhhhhhhhmMMMMMMMMMMMMMMMmhhhhhhhhhhhhhNM
    MNhhhhhhhhhhhhmMMMMMMMMMMMMMMNhhhhhhhhhhhhmMM
    MMdhhhhhhhhhhhhmMMMMMMMMMMMMMMdhhhhhhhhhhhNMM
    MMNhhhhhhhhhhhhhdMMmhdmNMMMMMMmhhhhhhhhhhdMMM
    MMMNhhhhhhhhhhhhhNNdhhhhhdNMMMMNdhhhhhhhdNMMM
    MMMMMhhhhhhhhhhhdmhhhhhhhhNmMMMMMNhhhhhhMMMMM
    MMMMMMmhhhhhhddmNhhhhhhdddNmhmNMMMdhhhmMMMMMM
    MMMMMMMMmhhhdddmmmmhhhhhhdddhhhhdhhdNMMMMMMMM
    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
    MMMMMMMMMMMMM    zaut0 beta   MMMMMMMMMMMMMMM
    '''
    print(banner)    
    print("\t\n{  zionskompis[at]initgriti[dot]me  }  \n")
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
            print("\t..more LINES plz..die()\n")
            exit()
            #moveF(hpath,scanthis) 
   
     
if __name__ == '__main__':
    main()
