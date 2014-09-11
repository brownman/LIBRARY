This page is about how ShellCheck reports parser errors, to aid you in finding problems. If you're getting a parser error for code you know or think is correct, you should [submit a bug](https://github.com/koalaman/shellcheck/issues/new) with an example!

When ShellCheck is unable to parse a file, it'll output several errors to help pinpoint the problem:

Consider this script, with a missing double quote on line 1:

    ssh host "$cmd
    echo "Finished"

Bash says:
   
    file: line 2: unexpected EOF while looking for matching `"'
    file: line 3: syntax error: unexpected end of file

Shellcheck says:
    
    In file line 1:
    ssh host "$cmd
    ^-- SC1009: The mentioned parser error was in this simple command.

    In file line 2:
    echo "Finished"
                  ^-- SC1073: Couldn't parse this double quoted string.
                   ^-- SC1072: Unexpected eof. Fix any mentioned problems and try again.


1. One error showing the direct problem (SC1072, unexpected eof)
1. One error showing the construct being parsed (SC1073)
1. One info showing the outer construct being parsed (SC1009)
1. Potentially some specific suggestions, such as when missing a `fi`. 

Here, shellcheck says that the command on line 1 is faulty, which makes it easier to find and fix the actual problem. 