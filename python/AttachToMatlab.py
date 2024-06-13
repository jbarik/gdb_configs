import os
import gdb        # type: ignore
import color
import getpass
import subprocess

def get_process_id(name):
    """Return process ids found for exact match"""

    username = getpass.getuser()
    child = subprocess.Popen(['pgrep', '-u', username,'-x', name], stdout=subprocess.PIPE, shell=False)
    response = child.communicate()[0]
    return [int(pid) for pid in response.split()]


class AttachToMatlab(gdb.Command):
    """Attach to MATLAB process """

    def __init__(self):
        super(AttachToMatlab, self).__init__("attachm", gdb.COMMAND_STACK)

    def invoke(self, arg, from_tty):
        del arg, from_tty

        matlab_pids = get_process_id('MATLAB')
        matlab_count = len(matlab_pids)
        if (matlab_count == 0):
            print("No MATLAB process to attach")
            return

        if (matlab_count == 1):
            print("Attaching to %d"%matlab_pids[0])
            gdb.execute("attach %d"%matlab_pids[0])
            return

        print("Multiple MATLABs detected")
        counter = 1;
        pwd = os.getcwd()
        for pid in matlab_pids:
            exe_info = '/proc/' + str(pid) + '/exe'
            if not os.path.exists(exe_info):
                print("%d : %d -> %s%s%s"%(counter, pid, color.LIGHT_RED, '[MATLAB] <defunct>', color.END))
                counter = counter +1
                continue


            # We are not interested in matlab lsp servers
            executable_path = os.readlink('/proc/' + str(pid) + '/exe')
            if 'initmatlabls' in open('/proc/' + str(pid) + '/cmdline').read():
                executable_path += color.LIGHT_RED + ' (lsp server)'

            if pwd in executable_path:
                print("%d : %d -> %s%s%s"%(counter, pid, color.GREEN, executable_path, color.END))
            else:
                print("%d : %d -> %s%s%s"%(counter, pid, color.BLUE, executable_path, color.END))

            counter = counter + 1;

        prompt = "Enter the index[1-%d] or 0 to skip: "%(counter)
        index = int(input(prompt))
        if(index != 0):
            gdb.execute("attach %d"%matlab_pids[index-1])
            return

        print("%sNot attaching to any MATLAB instance%s"%(color.LIGHT_RED, color.END))


