import gdb # type: ignore
import color

def search_n_print_in_block(block, frame, partialName):

    this_symbol = None;
    for symbol in block:
        if symbol.name == "this":
            this_symbol = symbol

        if  partialName in symbol.name.lower():
            print(color.GREEN + "\n" + symbol.name + ":\n" + color.END)
            gdb.execute("p " + symbol.name)
            return True

    if (this_symbol is not None):
        flds = this_symbol.value(frame).dereference().type.fields()
        for fld in flds:
            if partialName in fld.name.lower():
                print(color.GREEN + "\nthis->" + fld.name + ":\n" + color.END)
                gdb.execute("p this->" + fld.name)
                return True
    return False


class PrintSymbolWithPartialName(gdb.Command):
    """Print symbol containing the given symbol name(case insensitive)"""

    #==========================================================================
    def __init__(self):
        super(PrintSymbolWithPartialName, self).__init__(
            "print-with-partial-name", gdb.COMMAND_RUNNING, gdb.COMPLETE_SYMBOL, True)
    #==========================================================================

    #==========================================================================
    def invoke(self, arg, from_tty):
        del from_tty

        if not arg:
            print("Provide partial name of the symbol you want to print")
            return

        partial_name = arg.split()[0].lower();
        sf = gdb.selected_frame()
        fb = gdb.Frame.block(sf)
        count = 0
        while fb is not None:
            if search_n_print_in_block(fb, sf, partial_name):
                return
            fb = fb.superblock
            count += 1

            if count == 10:
                break

        print(color.RED + "No matching symbol found(Tried 10 scopes)\n" + color.END)
        #gdb.lookup_symbol('symbol_name', b)
