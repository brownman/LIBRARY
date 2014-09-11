Shellcheck directives allows selectively silencing warnings, and takes the form of comments in files:

    hexToAscii() {
      # shellcheck disable=SC2059
      printf "\x$1"
    }

The only supported directive is `disable`:

    # shellcheck disable=code[,code...]

Directives are scoped to the structure that follows it. For example, before a function it silences all warnings in the function. Before a case statement, it silences all warnings in all branches of the case statement.

Silencing parser errors is purely cosmetic, and will not make ShellCheck continue.