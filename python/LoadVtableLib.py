import color
import gdb
import os

class LoadVtableLib(gdb.Command):
    """Print symbol containing the given symbol name(case insensitive)"""

    #==========================================================================
    def __init__(self):
        super(LoadVtableLib, self).__init__(
            "load-vtable-lib", gdb.COMMAND_RUNNING, gdb.COMPLETE_SYMBOL, True)

    #==========================================================================

    #==========================================================================
    def invoke(self, arg, from_tty):
        del from_tty

        if not arg:
            print("Provide pointer")
            return

        pointer = gdb.parse_and_eval(arg.split()[0]);
        # x = (void**)0x13...
        double_pointer = pointer.cast(gdb.lookup_type("void").pointer().pointer())
        # Get vtable info *x
        ref_value = double_pointer.referenced_value()
        ps = gdb.current_progspace()
        libpath = ps.solib_name(int(ref_value))

        if libpath is None:
            print(color.RED + "Could not find library name")
            return

        print (color.GREEN + "Loading library: " + color.END + libpath)
        libname = os.path.basename(libpath)
        gdb.execute("shar " + libname)

