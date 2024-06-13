import gdb # type: ignore
import color

class SwitchToSimulinkThread(gdb.Command):
    """Switch to the main interpreter thread where simulink is running"""

    def __init__(self):
        super(SwitchToSimulinkThread, self).__init__("switch2-sim", gdb.COMMAND_STACK)

    def invoke(self, arg, from_tty):
        del arg, from_tty

        inferiors = gdb.inferiors()
        for inferior in inferiors:
            print("%sIterating threads and testing %s(int)utIsSignalThread()"%(color.GREEN, color.YELLOW))
            for thread in reversed(inferior.threads()):

                if (not thread.is_valid()):
                        continue

                th_name = thread.name
                print(color.YELLOW, end="")
                print(thread.num, end=", ")
                if (th_name is not None) and ("MCR 0 interpret" not in th_name):
                    continue

                # Change to our threads context
                thread.switch()
                is_signal_thread = gdb.parse_and_eval('(int)utIsSignalThread()')
                if (is_signal_thread == 1):
                    print("\n%sFound!! Switched to simulink thread:%s %d"%(color.GREEN, color.YELLOW, thread.num))
                    return
        print("\n%sNo thread returned 1 on calling %sutIsSignalThread()"%(color.GREEN, color.YELLOW))

