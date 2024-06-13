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


class CompleteSymbolName(gdb.Command):
    """Given a partial symbol name(case insensitive) finds the first match and returns the full symbol name"""

    #==========================================================================
    def __init__(self):
        super(CompleteSymbolName, self).__init__(
            "complete-sym-name", gdb.COMMAND_USER, gdb.COMPLETE_SYMBOL, True)
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
        full_sym_name = ""
        while fb is not None:
            full_sym_name = search_n_return_full_sym_name_in_block(fb, sf, partial_name)
            if full_sym_name is not None:
                gdb.execute('set $sym_name=' + full_sym_name)
                break

            fb = fb.superblock
            count += 1

            if count == 10:
                gdb.execute('set $sym_name=');
                break
    #==========================================================================
