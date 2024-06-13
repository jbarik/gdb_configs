
import gdb # type: ignore

def search_n_return_full_sym_name_in_block(block, frame, partialName):

    this_symbol = None;
    for symbol in block:
        if symbol.name == "this":
            this_symbol = symbol

        if  partialName in symbol.name.lower():
            return symbol.name

    if (this_symbol is not None):
        flds = this_symbol.value(frame).dereference().type.fields()
        for fld in flds:
            if partialName in fld.name.lower():
                return fld.name

    return None


class ExecuteCommandWithPartialName(gdb.Command):
    """Given a command and a partial symbol name(case insensitive) finds the first match and executes the command with full symbol name"""

    #==========================================================================
    def __init__(self):
        super(ExecuteCommandWithPartialName, self).__init__(
            "ex-command-with-sym-name", gdb.COMMAND_USER, gdb.COMPLETE_SYMBOL, True)
    #==========================================================================

    #==========================================================================
    def invoke(self, arg, from_tty):
        del from_tty

        if not arg:
            print("Provide command name and partial name of the symbol")
            return

        args = arg.split()
        command = args[0]
        partial_name = args[1].lower()

        sf = gdb.selected_frame()
        fb = gdb.Frame.block(sf)

        count = 0
        while fb is not None:
            full_sym_name = search_n_return_full_sym_name_in_block(fb, sf, partial_name)
            if full_sym_name is not None:
                print("Symbol name :" + full_sym_name)
                gdb.execute(command + " " + full_sym_name, True)
                break

            fb = fb.superblock
            count += 1

            if count == 10:
                print("Could not find any symbol")
                break

    #==========================================================================
