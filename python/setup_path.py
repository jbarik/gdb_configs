import sys
import os
dir_path = os.path.dirname(os.path.realpath(__file__))
sys.path.append(dir_path)

#if "WORKING_DIR" in os.environ:
#   src_path = os.environ['WORKING_DIR'] + '/.sbtools/sb-debug/source-path.gdbinit'
#   if os.path.isfile(src_path):
#      gdb.execute('source ' + src_path)
#end

