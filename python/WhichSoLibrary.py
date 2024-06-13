import color
import gdb
import os

class WhichSoLibrary(gdb.Command):
    """Print library name that contains the given address"""

    #==========================================================================
    def __init__(self):
        super(WhichSoLibrary, self).__init__(
            "address-which-lib", gdb.COMMAND_RUNNING, gdb.COMPLETE_SYMBOL, True)

    #==========================================================================

    #==========================================================================
    def invoke(self, arg, from_tty):
        del from_tty

        if not arg:
            print("Provide a pointer")
            return

        pointer = gdb.parse_and_eval(arg.split()[0]);
        pointer = pointer.cast(gdb.lookup_type("void").pointer())
        #ref_value = pointer.referenced_value()
        ps = gdb.current_progspace()
        libpath = ps.solib_name(int(pointer))

        if libpath is None:
            print(color.RED + "Could not find library name")
            return

        libname = os.path.basename(libpath)
        print (color.GREEN + "Library name: " + color.END + libname)
        print (color.GREEN + "Library path: " + color.END + libpath)

WhichSoLibrary()
