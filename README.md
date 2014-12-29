[![Build Status](https://travis-ci.org/brownman/LIBRARY.svg?branch=develop)](https://travis-ci.org/brownman/LIBRARY)

LIBRARY
==

- [Bash Tricks - explained](https://github.com/brownman/idiot2genius)

Directory structure:
------
```
$ BANK / $category / $sub-category / $filename .{cfg,sh}

#Example: 
$ BANK/PRINT/print_line.cfg 
```

script types
----

- LONG LIFETIME: source the file to update the Shell-Environment

- **.cfg**: export functions
```
export -f some_func 
```

- **.conf**: export variables
```
export my_var='x'
alias my_alias='y'
```

- SHORT LIFETIME: run the file on demand
- **.sh**: regular scripts 
```
./translate.sh ru dog #translate 'dog' to 'russian'
```



WORKFLOW
----

- Install:
```
$ ./install.sh                          #creates symlink on path: /tmp
$ ls -l /tmp/library.cfg                #this is the anchor for the project (absolute path)
```

- Activate:
```
$ source /tmp/library.cfg               #export function: use() , use_sh() , finder(), updatedb1()
```

- Expose:
```
$ cat /tmp/target                       #current index
$ touch BANK/my_file.cfg                #USER ACTION
$ touch BANK/my_file.sh                 #USER ACTION
$ updatedb1                             #update the index:  after adding new files ( under BANK/ )
$ finder my_file                        #will print the location of the new file: my_file.cfg
$ finder my_file                        #will print the location of the new file: my_file.sh
```

- **Use:**
- Example: for enabling the command: print ok
```
$ cat /tmp/target | grep print          #if you want to make sure that file: print.cfg is indexed
$ use print                             #it source file: print.cfg (wherever located)
$ type print                            #the file print.cfg has command: export -f print
$ print ok                              #pass parameter: 'ok' to function: print()
```

- Example: for enabling the command: $translate_sh ru dog
```
$ cat /tmp/target | grep translate      #if you are curious where translate.sh is
$ finder translate sh                   #if you are curious where translate.sh is
$ use_sh translate                      #this will export variable: translate_sh (which point to the script)
$ $translate_sh ru dog                  #this will actualy run the file: translate.sh with params: ( ru , dog )
```

- Update the library anchor:
```
$ alias libraryE
$ libraryE
```

- to activate the library: source /tmp/library.cfg
