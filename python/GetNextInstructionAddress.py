import gdb # type: ignore
import re

class GetNextInstructionAddress(gdb.Command):
    """Gets the address of the next instruction"""

    #==========================================================================
    def __init__(self):
        super(GetNextInstructionAddress, self).__init__("address-next-instruction", gdb.COMMAND_RUNNING, gdb.COMPLETE_SYMBOL, True)
    #==========================================================================

    #==========================================================================
    def invoke(self, arg, from_tty):
        del arg, from_tty

        # The gdb output is going to be in the form of
        # We want to capture sart line number, end address and end line number
        # if start and end line numbers are same, we repeat with end address
        # The loop is to take care of the cases where there are multiple calls
        # as part of a single line.
        #
        # 'Line 33 of "ssref/SSRefComponentLoader.cpp" starts at address 0x7f5696ac9f6c
        # <_ZN4slsr20SSRefComponentLoader14getComponentBDEv+132 at ssref/SSRefComponentLoader.cpp:33>
        # and ends at 0x7f5696ac9f7b <_ZN4slsr20SSRefComponentLoader14getComponentBDEv+147 at ssref/SSRefComponentLoader.cpp:33>.\n'
        output = gdb.execute("info line *$pc", to_string=True)
        #pattern = r'ends at (0x\w+)'
        pattern = r'starts at address (0x[0-9a-f]+) (<.*>)'
        s_out = re.search(pattern, output)
        if s_out is None:
            return

        gs = s_out.groups() # type: ignore
        gdb.execute("print /x" + gs[0]);
    #==========================================================================
