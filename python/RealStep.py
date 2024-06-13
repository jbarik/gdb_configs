import gdb
from FrameLineChecker import FrameLineChecker

#==========================================================================
def continue_till_mwfcn():

    frame_checker = FrameLineChecker()

    while not frame_checker.crossedLineOnTheFrame() :
        gdb.execute("step")
        fname = gdb.newest_frame().name()
        if fname is not None:
            if frame_checker.crossedLineOnTheFrame() or frame_checker.insideMWFunction():
                return
            continue

        # So fname is None, try to return to previous frame
        gdb.execute("finish")
#==========================================================================

#==========================================================================
class RealStep(gdb.Command):
    """Continue stepping till we reach a real function(not std::*, boost::* or 3rd party library function"""

    #==========================================================================
    def __init__(self):
        super(RealStep, self).__init__("real-step", gdb.COMMAND_RUNNING, gdb.COMPLETE_SYMBOL, True)
    #==========================================================================

    #==========================================================================
    def invoke(self, arg, from_tty):
        del arg, from_tty
        continue_till_mwfcn()

    #==========================================================================
#==========================================================================
