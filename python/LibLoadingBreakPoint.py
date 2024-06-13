import gdb

# See set stop-on-solib-events
def new_objfile_handler (event):
    if (isinstance (event, gdb.NewObjFileEvent)):
        print ("event type: new_objfile")
    if (event.new_objfile is not None):
        print ("new objfile name: %s" % (event.new_objfile.filename))
    else:
        print ("new objfile is None")

# See set stop-on-solib-events 1
def stop_event_handler(event):
    if isinstance(event, gdb.StopEvent):
        print("printing the reason for stop")
    if isinstance (event, gdb.SignalEvent):
        print ("stop reason: signal")
        print ("stop signal: %s" % (event.stop_signal))

def new_inferior_handler(event):
    if isinstance(event, gdb.NewInferiorEvent):
        print("New inferior created/loaded")


class test_newobj_events (gdb.Command):
    """NewObj events."""
    def __init__ (self):
        gdb.Command.__init__ (self, "test_newobj_events", gdb.COMMAND_STACK)

    def invoke (self, arg, from_tty):
        del arg, from_tty
        #gdb.events.new_objfile.connect (new_objfile_handler)
        #gdb.events.stop.connect (stop_event_handler)
        gdb.events.new_inferior.connect(new_inferior_handler)
        print ("Event tester registered.")

test_newobj_events ()

#class LibLoadingBreakPoint(gdb.Breakpoint)
#    """Loads the library automatically and applies breakpoint """
#
#    __original_break_command__=''
#
#
#    def __init__(self, breakCommand):
#        super(LibLoadingBreakPoint, self).__init__()
#        # Create a temporary breakpoint
#        # get the library name of the
#        lib_name = libmwsl_lang_blocks
#
#    def stop (self):
#        gdb.Breakpoint(__original_break_command__, gdb.BP_BREAKPOINT)
