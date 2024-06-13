import gdb

class AutoSymLoad(gdb.Command):
    """Given the name of a shared-lib, loads the symbols automatically when the library loads"""

    def __init__(self):
        super(AutoSymLoad, self).__init__("autoload-sym", gdb.COMMAND_STACK)

    def invoke(self, arg, from_tty):
        del from_tty

        if not arg:
            print("Provide the name of the library you want to load")
            return

        args = arg.split()
        commands = "command \nsilent\nshar " + str(args[0]) + "\ncontinue\nend"
        gdb.execute("tcatch load " + str(args[0]))
        gdb.execute(commands, True)
