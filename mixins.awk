# Work in progress replacement for mixins.sed
#
# Problems:
#
# * Forking a process for each mixin makes it much slower than mixins.sed.
#   Is there a way to insert the mixin by reading instead of forking?
#   ("getline line < file" was tried but it causes a bug where the file
#   fails to load again after the first read)
#
# * Does it work on non-GNU AWK? Is it worth the effort? The sed script is
#   ugly and anti-DRY but it works and is fast.

/^\+[A-Za-z]{1,}/ {
    command = "cat mixins/" tolower(substr($0, 2)) ".nanorc"
    while ((command | getline line) > 0) {
        print line
    }
    close(command)
    next
}

{print}
