import os
import gdb
import color

def move_to_nth_frame(frame_no):
    f = gdb.newest_frame()
    count = 0
    while(count < frame_no):
        f = f.older()
        count +=1

    return f

def load_libs_till_nth_frame(frame_no):

    f = gdb.newest_frame()
    count = 0
    while (f is not None and (count < frame_no) and f.is_valid()):
        lib_name = gdb.solib_name(f.pc())
        if (lib_name is None):
            # Try moving to the older frame
            f = f.older()
            if (f is None):
                print("\n" + color.RED + "No more frames to load" + color.END)
                return
            else:
                continue # continue to next iteration

        base_name = os.path.basename(lib_name)
        print(color.BLUE + str(count) + ":" + color.GREEN + " loading " + base_name + color.END)

        # Isn't there a python api to load the library?
        # Would be nice if we can find, if this library is already loaded
        gdb.execute("shar " + base_name)
        count +=1

        # loading the library, invalidates the frames. We need to again
        # get new frame iterator, and move to the right frame(count)
        f = move_to_nth_frame(count)

class LoadLibs (gdb.Command):
    """Loads the required libraries for the given number of frames"""

    def __init__(self):
        super(LoadLibs, self).__init__("load-libs", gdb.COMMAND_STACK)

    def invoke(self, arg, from_tty):
        del from_tty

        if not arg:
            print("Provide number of frames for which you want to load libraries")
            return

        args = arg.split()
        load_libs_till_nth_frame(int(args[0]))
