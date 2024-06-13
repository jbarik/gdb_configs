import os
import gdb
import color

class PrintCurrentLibName(gdb.Command):
    """Print Current frame's library name """

    def __init__(self):
        super(PrintCurrentLibName, self).__init__("pcurrlib", gdb.COMMAND_STACK)

    def invoke(self, arg, from_tty):
        del arg, from_tty

        f = gdb.selected_frame()
        if (f is not None):
            lib_name = gdb.solib_name(f.pc())
            if (lib_name is not None):
                base_name = os.path.basename(lib_name)
                print ("\n" + "Lib name : " + color.GREEN + base_name + color.END)
                print ("Full path: " + color.GREEN + lib_name + color.END)
            else:
                print (color.RED + "\nCould not find library name" + color.END)
