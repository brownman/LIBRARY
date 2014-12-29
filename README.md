[![Build Status](https://travis-ci.org/brownman/LIBRARY.svg?branch=develop)](https://travis-ci.org/brownman/LIBRARY)

LIBRARY
==
- https://github.com/brownman/idiot2genius

dir structure:
------
- BANK/$category/$script

scripts:
----
- helpers files ( .cfg )
- scripts ( .sh )

workflow
----
- Install:
```
$ ./install.sh                          #creates symlink to path: /tmp
$ ls -l /tmp/library.cfg                #this is the anchor (absolute path)
```
- Activate:
```
$ source /tmp/library.cfg               #export function: use() , use_sh() , finder()
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
