import gdb # type: ignore
import color
from FrameLineChecker import FrameLineChecker


class ContinueTillLine(gdb.Command):
    """Continue stepping and finishing till we reach the given case insensitive function name"""

    #==========================================================================
    def __init__(self):
        super(ContinueTillLine, self).__init__("continue-till-line", gdb.COMMAND_RUNNING, gdb.COMPLETE_SYMBOL, True)

    #==========================================================================

    #==========================================================================
    def invoke(self, arg, from_tty):
        del from_tty

        if not arg:
            print("Provide line number in the function where you want to stop")
            return

        target_line_no = int(arg.split()[0])
        frame_checker = FrameLineChecker()
        counter = 0
        max_iter_count = 100

        while counter < max_iter_count :
            gdb.execute("next")
            if frame_checker.onTheSameFrameOnLine(target_line_no):
                return

            counter += 1

        print(color.RED + "Executed next 100 times(max limit)\n" + color.END)
