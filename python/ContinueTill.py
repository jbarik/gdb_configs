import gdb # type: ignore
import color
import re
from FrameLineChecker import FrameLineChecker

#==========================================================================
class ContinueTillFcn(gdb.Command):
    """Continue stepping and finishing till we reach the given case insensitive function name"""

    #==========================================================================
    def __init__(self):
        super(ContinueTillFcn, self).__init__("continue-till-fcn", gdb.COMMAND_RUNNING, gdb.COMPLETE_SYMBOL, True)

    #==========================================================================

    #==========================================================================
    def invoke(self, argument, from_tty):
        del from_tty

        if not argument:
            print(color.RED + "Provide partial name of the fcn where you want to stop" + color.END)
            return

        target_fname  = argument.split()[0].lower() # partial function name we want to stop in
        frame_checker = FrameLineChecker()

        counter        = 0
        max_iter_count = 15

        while counter < max_iter_count:
            if counter > 0 and frame_checker.crossedLineOnTheFrame():
                return

            gdb.execute("step")
            frame = gdb.newest_frame()

            if (frame is not None):
                fname = frame.name()

                if (fname is not None):
                    if frame_checker.crossedLineOnTheFrame():
                        return # Could not step in and came back to the frame we started with

                    # The frame name might be in the form of:
                    #
                    # namespace1::namespace2::func_name<ns::abc>
                    #
                    # We want to compare with only 'func_name' strip <.*> as it may contain '::'
                    pattern = r"<.*>"
                    fname = re.sub(pattern, '', fname)

                    split_str = fname.rsplit('::', 1);
                    if len(split_str) == 2:
                        fname = split_str[1]

                    if target_fname in fname.lower():
                        return

            gdb.execute("finish")
            counter += 1
    #==========================================================================

#==========================================================================
class ContinueTillFcn2(gdb.Command):
    """Continue stepping and finishing till we reach the given case insensitive function name"""

    #==========================================================================
    def __init__(self):
        super(ContinueTillFcn2, self).__init__("continue-till-fcn2", gdb.COMMAND_RUNNING, gdb.COMPLETE_SYMBOL, True)

    #==========================================================================

    #==========================================================================
    def invoke(self, argument, from_tty):
        del from_tty

        if not argument:
            print("Provide partial name of the fcn where you want to stop")
            return

        target_fname = argument.split()[0].lower() # partial function name we want to stop in
        #start_end     = frame_checker.getStartAndEndAddressOfPC()
        #if start_end is None:
        #    print(color.RED + "Could not process the request" + color.END)
        #    return

        # Apply temporary breakpoint at the end address for safety, so that
        # execution doesn't cross the breakpoint
        #gdb.execute("tbreak *" + start_end[1])

        # Get the next 50 assembly instructions (is 50 reasonable?)
        instructions = gdb.execute("x/50i $pc", to_string=True);

        # In the assembly instructions, search for call to target-fcn name (case insensitive)
        #
        # It should be in the form of:
        # 0x7fa2d20 <function1(...)+15 at dir/file1.cpp:28>: call 0x7f080a3c2 <namespace1::targetFunc()@plt>
        #
        pattern = r'call.*(0x[0-9a-f]+).*<(.*' + target_fname + r'.*)>'
        s_out   = re.search(pattern, instructions, re.IGNORECASE)

        if s_out is None:
            print(color.RED + "No symbol found with name : " + color.END + target_fname)
            print(color.GREEN + "Library containing the symbol may not have been loaded" + color.END)
            return

        gs = s_out.groups()
        gdb.execute("tbreak *" + gs[0], to_string=True)
        gdb.execute("continue")


    #==========================================================================

#==========================================================================



#==========================================================================
class ContinueTillLine(gdb.Command):
    """Continue stepping and finishing till we reach the given case insensitive function name"""

    #==========================================================================
    def __init__(self):
        super(ContinueTillLine, self).__init__(
            "continue-till-line", gdb.COMMAND_RUNNING, gdb.COMPLETE_SYMBOL, True)

    #==========================================================================

    #==========================================================================
    def invoke(self, argument, from_tty):
        del from_tty

        if not argument:
            print("Provide line number in the function where you want to stop")
            return

        target_line_no = int(argument.split()[0])
        frame_checker  = FrameLineChecker()
        counter        = 0
        max_iter_count = 100

        while counter < max_iter_count :
            gdb.execute("next")

            if not frame_checker.onTheSameFrame():
                print(color.RED + "Exited the original frame\n" + color.END)
                return

            if frame_checker.onTheSameFrameOnLine(target_line_no):
                return

            counter += 1
    #==========================================================================

#==========================================================================
