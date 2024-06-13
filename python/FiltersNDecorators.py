import re
import os
import gdb     # type: ignore
import color
from builtins import map
from gdb.FrameDecorator import FrameDecorator # type: ignore

# We are going to use these patterns to suppress MATLAB calls in the
# stack of frames
_matlab_lib_pattern = [r".*libmwmcos\.so$",
                       r".*libmwmlutil\.so$",
                       r".*libmwbridge\.so$",
                       r".*libmwm_interpreter\.so$",
                       r".*libmwlxeindexing\.so$",
                       r".*libmwmcos_impl\.so$",
                       r".*libmwm_dispatcher\.so$",
                       r".*libmwlxemainservices\.so$",
                       r".*libmwsimulink_builtinimpl\.so$",
                       r".*libmwbuiltin\.so$",
                       r".*mwsl_proxy_interface_builtinimpl\.so",
                       r".*libmwm_lxe\.so$",
                       r".*libmwmvm.*\.so$",
                       r".*libmwmVM.*\.so$",
                       r".*libmwiqm\.so$",
                       r".*libmwmcr\.so$"
                      ]
_matlab_lib_regex = re.compile('|'.join(_matlab_lib_pattern))

_fcn_name_pattern = ["^mwboost::.*",
                     "^std::.*"]
_fcn_name_regex = re.compile('|'.join(_fcn_name_pattern))

def matlab_lib_name_matcher(item):
    frame = item.inferior_frame()
    if (frame is None):
        return False

    lib_name = gdb.solib_name(frame.pc())
    if (lib_name is None):
        return False

    lib_name = os.path.basename(lib_name)
    if (_matlab_lib_regex.match(lib_name) is not None):
        return True
    else:
        return False


def boost_fcn_name_matcher(item):
    name = item.inferior_frame().name()
    if (name is None):
        return False

    return (_fcn_name_regex.match(name) is not None)
    #return (re.match("mwboost::", name) is not None) or (re.match("std::_",name) is not None)

# This idea is copied from:
# https://jefftrull.github.io/c++/gdb/python/2018/04/24/improved-backtrace.html
def Squasher(iterable, squashfn):
    """compress sub-sequences for which a predicate is true"""
    last = None              # we have to buffer 1 item
    for item in iterable:
        if squashfn(item):
            last = item
        else:
            if last is not None:
                yield last   # empty buffer this time
                last = None
            yield item       # resume un-squashed iteration
    if last is not None:
        yield last           # if we end in "squashed" mode


class FrameNameDecorator(FrameDecorator):
    def __init__(self, fObj):
        super(self.__class__, self).__init__(fObj)
        self.fObj = fObj

    def function(self):
        f = self.inferior_frame()
        lib_name = gdb.solib_name(f.pc())
        if (lib_name is not None):
            if (_matlab_lib_regex.match(lib_name) is not None):
                return color.PURPLE + 'MATLAB call(s)...' + color.END

        fcn_name = f.name()
        if (fcn_name is None):
            return color.LIGHT_RED + '?? Symbols Not available' + color.END

        #if (re.match("mwboost::", fcn_name) is not None):
        if (_fcn_name_regex.match(fcn_name) is not None):
            return color.PURPLE + 'mwboost or std call(s)...' + color.END

        return color.BLUE + fcn_name + color.END

    def address(self):
        return None

    def filename(self):
        f = self.inferior_frame()
        sym_tbl = f.find_sal().symtab
        file_name = None
        if (sym_tbl is None):
            file_name = gdb.solib_name(f.pc())
        else:
            file_name = sym_tbl.filename

        if (file_name is None):
            return None

        return color.GREEN + file_name + color.END

#class AddressStripperDecorator(FrameDecorator):
#    def __init__(self, fObj):
#        super(self.__class__, self).__init__(fObj)
#        self.fObj = fObj
#
#    def address(self):
#        return None
#
#    def filename(self):
#        f = self.inferior_frame()
#        sym_tbl = f.find_sal().symtab
#        func_name = ""
#        if (sym_tbl is None):
#            func_name = gdb.solib_name(f.pc())
#        else:
#            func_name = sym_tbl.filename
#
#        if (func_name is None):
#            return None
#
#        return _GREEN + func_name + _COLOR_END


class MathWorksFrameFilter():

    def __init__(self):
        # Frame filter attribute creation.
        #
        # 'name' is the name of the filter that GDB will display.
        #
        # 'priority' is the priority of the filter relative to other
        # filters.
        #
        # 'enabled' is a boolean that indicates whether this filter is
        # enabled and should be executed.

        self.name = "MathWorksFrameFilter"
        self.priority = 10
        self.enabled = True

        # Register this frame filter with the global frame_filters
        # dictionary.
        gdb.current_progspace().frame_filters[self.name] = self

    def filter(self, frame_iter):

        ufi = Squasher(frame_iter, boost_fcn_name_matcher)
        ufi = Squasher(ufi, matlab_lib_name_matcher)

        # Apply all the decorators. Instead of multiple decorators
        # we can squesh all the functionality into one decorator.
        #ufi = itertools.imap(AddressStripperDecorator, ufi)
        #ufi = itertools.map(FrameNameDecorator, ufi) #python2
        ufi = map(FrameNameDecorator, ufi) #python3

        return ufi


MathWorksFrameFilter()
