import gdb  # type: ignore
import re

class FrameLineChecker(object):
    """Class to help find out, if we are on the same frame, line etc."""

    m_ignore_file_patterns = [r".*/mathworks/hub/3rdparty/.*",
                              r".*/mathworks-hub/3rdparty/.*",
                              r".*/3p/sources/.*",
                              r".*/gcc.*/libstdc.*",
                              r".*slsv_scoped_ptr\.hpp$"]
    m_ignore_files_regex = re.compile('|'.join(m_ignore_file_patterns))

    #==========================================================================
    def __init__(self):
        f = gdb.newest_frame()
        self.m_frame_name = f.name()
        self.m_line_no = f.find_sal().line
    #==========================================================================

    #==========================================================================
    def onTheSameFrameOnLine(self, lineNo):
        f = gdb.newest_frame()
        f_name = f.name()
        if f_name is None:
            return False

        if self.m_frame_name == f_name:
            return (lineNo == f.find_sal().line)

        return False
    #==========================================================================

    #==========================================================================
    def onTheSameFrameSameLine(self):
        f = gdb.newest_frame()
        f_name = f.name()
        if f_name is None:
            return False

        if self.m_frame_name == f_name:
            return (self.m_line_no == f.find_sal().line)

        return False
    #==========================================================================

    #==========================================================================
    def onTheSameFrame(self):
        f = gdb.newest_frame()
        f_name = f.name()
        if f_name is None:
            return False

        if self.m_frame_name == f_name:
            return True

        return False
    #==========================================================================

    #==========================================================================
    def crossedLineOnTheFrame(self):
        f = gdb.newest_frame()
        f_name = f.name()
        if f_name is None:
            return False

        if self.m_frame_name != f_name:
            return False

        line = f.find_sal().line
        if line > self.m_line_no:
            return True

        return False
    #==========================================================================
    
    #==========================================================================
    def printCurrentLineAndFrame(self):

        f = gdb.newest_frame()
        if f is None:
            print('frame is None');
            return

        f_name = f.name()
        if f_name is None:
            print('frame name is none')
            return

        print('frame name: ' + f_name);

        line = f.find_sal().line
        print(line)

    #==========================================================================

    #==========================================================================
    def insideMWFunction(self):
        f = gdb.newest_frame()
        if f.name() is None:
            return False

        sym_tab = f.find_sal().symtab
        if sym_tab is None:
            return False

        file_name = sym_tab.fullname()
        #if FrameLineChecker.m_3rd_party_file_pattern in file_name:
        #    return False
        if FrameLineChecker.m_ignore_files_regex.match(file_name) is not None:
            return False

        return True
    #==========================================================================

    #==========================================================================
    def getStartAndEndAddressOfPC(self):

        output  = gdb.execute("info line *$pc", to_string=True)
        pattern = r'starts at address (0x[0-9a-f]+).*and ends at.*(0x[0-9a-f]+)'
        s_out   = re.search(pattern, output)

        if s_out is None:
            return

        return s_out.groups()


    #==========================================================================

