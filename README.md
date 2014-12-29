[![Build Status](https://travis-ci.org/brownman/LIBRARY.svg?branch=develop)](https://travis-ci.org/brownman/LIBRARY)

LIBRARY
==

- [Tricks explained](https://github.com/brownman/idiot2genius)

Directory structure:
------
```
$ BANK / $category / $sub-category / $filename .{cfg,sh}

#Example: 
$ BANK/PRINT/print_line.cfg 
```

script types
----
- **LONG LIFETIME:**
- source the file to update the Shell-Environment
- .cfg : export functions
```
export -f some_func 
```
- .conf: export variables
```
export my_var='x'
alias my_alias='y'
```

- **SHORT LIFETIME: **
- run the file on demand
- .sh: regular scripts 
```
./translate.sh ru dog #translate 'dog' to 'russian'
```



WORKFLOW
----

- Install:
```
$ ./install.sh                          #creates symlink to path: /tmp
$ ls -l /tmp/library.cfg                #this is the anchor (absolute path)
```

- Activate:
```
$ source /tmp/library.cfg               #export function: use() , use_sh() , finder(), updatedb1
```

- Expose:
```
$ cat /tmp/target                       #current index
$ updatedb1                             #update the index if you added new files
```
- Use:
```
$ use print
$ print ok
$ finder translate sh 
```
- Update:
```
$ alias libraryE  
```
- to activate the library: source /tmp/library.cfg
- to edit library.cfg:  libraryE
