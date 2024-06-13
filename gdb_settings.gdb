# vim: set ft=gdb:
set print vtbl on
set print pretty on
set print object on
set print demangle on
set auto-solib-add off
set print static-members on
## Don't display the thread creation/deletion/switch messages
## This doesn't work on MACI, so comment it out when debuggin on MACI
set print thread-events off

# No limit on how many elements of an array is printed
# This is helpful in printing long strings
set print elements 0
set print array on
set print array-indexes on
set demangle-style gnu-v3
set print sevenbit-strings off
set print null-stop
set print union on
set print asm-demangle on

# To print file location of an address
# usage : p/a pointer
set print symbol-filename on

set history filename ~jbarik/.gdbhistory

# Don't wrap line or the coloring regexp won't work.
set width 0
# Don't let gdb pause when console is full of text
set height 0

set print frame-arguments scalars
set pagination off
#set non-stop on

set logging file gdb_output_log.txt
set logging enabled on
#set logging redirect on
#set logging file /dev/null
#set print finish off
# Start: Styling ===================================================================
set style address foreground red
set style filename foreground green
set style function foreground blue
set style variable foreground green
