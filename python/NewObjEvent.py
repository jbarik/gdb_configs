import gdb

def new_objfile_handler (event):

    #if (isinstance (event, gdb.NewObjFileEvent)):
    #    print ("event type: new_objfile")
    #if (event.new_objfile is not None):
    #    print ("new objfile name: %s" % (event.new_objfile.filename))
    #else:
    #    print ("new objfile is None")

    f = open("/home/jbarik/objfiles.txt", "a")
    f.write(event.new_objfile.filename)
    f.close()

class NewObjEvent (gdb.Command):
    """NewObj events."""
    def __init__ (self):
        gdb.Command.__init__ (self, "newobj-events", gdb.COMMAND_STACK)

    def invoke (self, arg, from_tty):
        del arg, from_tty

        gdb.events.new_objfile.connect (new_objfile_handler)
        print ("New ObjectFile Event tester registered.")

NewObjEvent ()
