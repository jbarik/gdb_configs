#!/usr/bin/env python

import os
import gdb
import glob
from collections import defaultdict

def get_last_breakpoint():
    bps = gdb.breakpoints()
    if bps is None: raise gdb.GdbError('No breakpoints or watchpoints.')
    return bps[-1]

STOP_EVENT_REGISTER = defaultdict(set)
def register_callback_to_breakpoint_num(breakpoint_num, callback):
    STOP_EVENT_REGISTER[breakpoint_num].add(callback)

def is_pointer(value):
    type = value

    if isinstance(value, gdb.Value):
        type = value.type

    type = type.strip_typedefs()
    return type.code == gdb.TYPE_CODE_PTR
