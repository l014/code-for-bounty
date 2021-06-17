

the py script reads files placed in the folder scanthis. 
  - files placed in scanthis contains urls to target(s) - raw text files with one url on each line
  - scan.out folder - output is saved
  - eg arjun finds paths/paramaters it writes output to scanthis - and when the script is finished with the current scan it reads the new files - checks again if valid, not a dup.. ..and so on..
  - ... the script never stops if the scope is big - "never" is of couse not true, but i have never let it finished without interupting...

- flow zio.py   
```  
   scanit()
     if_file_in scanthis() 
     read_urlfile()
     for url in urlfile
        check if valid url()
        check_if_not_a_duplicate() # already in que/scanned
        check_if_alive()
        if_checks_ok()
        for url in que
          start_stuff(url) # (bash files)
     main()
    
   main()
     scanit()
```
    

