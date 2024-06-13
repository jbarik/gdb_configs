import gdb

def log_objfiles(ofile=None):
    if not ofile:
        return

    name = ofile.new_objfile.filename
    print("objfile: %r" % name)
    gdb.execute('info sharedlibrary')


gdb.events.new_objfile.connect(log_objfiles)
