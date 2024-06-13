# vim: set ft=gdb:
#
#
# see the following headers for more info on apis
#     matrix/detail/mx_array_api.hpp
#     matrix/detail/noninlined/mx_array_api.hpp
#
# This file contains heper functions for gdb which help visualizing/inspecting
# mxArray data structure
#
# Before using the scripts in this file turn messageviewer off, otherwise
# the outputs from ipPrintArray() and omDisp() will go to message-viewer
#
#              slfeature('MessageViewer', off)
#
printf "%s*** sourcing %ssimulink_mxarray.gdb \n",$L_Y,$L_G,

#===================================================================
define helpmx
   printf "\n%s  pdumpmx       :%s Uses sl_services apis",$L_G,$L_B
   printf "\n%s  pdumpmxinstr  :%s Uses sl_services apis",$L_G,$L_B
   printf "\n%s  pdumpfullmx   :%s Uses sl_services apis",$L_G,$L_B
   printf "\n%s  pdumpfullmxinstr   :%s Uses sl_services apis",$L_G,$L_B
   printf "\n%s  pdumpstructmx      :%s Uses sl_services apis",$L_G,$L_B
   printf "\n%s  pdumpstructmxinstr :%s Uses sl_services apis",$L_G,$L_B
   printf "\n%s  pmx           :%s Old: Prints any mxarray*",$L_G,$L_B
   printf "\n%s  pcell         :%s Old: Prints the individual mxarray* in the cellarray",$L_G,$L_B
   printf "\n%s  pstruct       :%s Old: Prints array of structures",$L_G,$L_B
   printf "\n%s  pmx_array     :%s Old: Prints a range of mxArra* given mxArray**\n",$L_G,$L_B
end
#===================================================================
define mx-destroy
   call debughelp::deleteMxArray((void*)$arg0)
end
#===================================================================
define mx-old-print-2-str
   set var $print_to_file = 0
   set var $mx_info=debughelp::_getMxInfo((const void*)$arg0, $print_to_file)
   if ($mx_info)
      p *$mx_info
      call debughelp::deleteMxInfo($mx_info)
      printf "\n"
   else
      printf "Given mxArray is null\n"
   end
   printf "For struct, use - pstructmx mxArray* element_index\n"
end

define mx-old-print-2-file

   set $print_to_file = 1
   set var $mx_info=debughelp::_getMxInfo((const void*)$arg0, $print_to_file)
   if ($mx_info)
      p *$mx_info
      call debughelp::deleteMxInfo($mx_info)
      printf "\n"
   else
      printf "Given mxArray is null\n"
   end
   printf "For struct, use - pstructmx mxArray* element_index\n"
end

document mx-old-print-2-str
   Display mxArray. Works for mcos as well
   Usage pmx ptr_mxarray
end

define mx-print
   p 'debughelp'::dumpmx($arg0)
   printf "\n"
end
define mx-print-2-str
   set var $var = 'debughelp'::dumpmxInStr($arg0)
   printf "%s\n\n", $var._M_dataplus._M_p
end
define mx-print-full
   p 'debughelp'::dumpfullmx($arg0)
   printf "\n"
end
define mx-print-full-str
   set var $var = 'debughelp'::dumpfullmxInStr($arg0)
   printf "%s\n\n", $var._M_dataplus._M_p
end
define mx-print-struct
   p 'debughelp'::dumpstructmx($arg0)
   printf "\n"
end
define mx-print-struct-str
   set var $var = 'debughelp'::dumpstructmxInStr($arg0)
   printf "%s\n\n", $var._M_dataplus._M_p
end
define mx-send-2-debug-m
    call 'debughelp'::sendmx2debugmethod((mxArray*)$arg0)
end
#===================================================================

#===================================================================
define structmx
   set var $mx_struct_info='debughelp'::getMxStructElement($arg0,$arg1)
   if ($mx_struct_info)
      p *$mx_struct_info
      call 'debughelp'::deleteMxStructElement($mx_struct_info)
   end
end

define pstruct
   set var $mx_struct_info='debughelp'::getMxStructElement((::mxArray*)$arg0,$arg1)
   if ($mx_struct_info)
      p *$mx_struct_info
      call 'debughelp'::deleteMxStructElement($mx_struct_info)
   end
end
document pstruct
   Display an element of struct mxArray
   Usage: pstruct mxArray* element_index
end

#===================================================================
define pcell
   if $argc<1
      help pcell
   else
      set var $mx_cell_info='debughelp'::_getMxCellArrayInfo($arg0)
      if ($mx_cell_info)
         p *$mx_cell_info
         call 'debughelp'::deleteCellInfo($mx_cell_info)
      end
   end
   printf "\n%s MATLAB internally stores in column-major way. So for a matrix %sMxN",$G,$B
   printf "\n%s values appear: %s 1x1(idx=0), 2x1(idx=1),...Mx1(idx=M-1),1x2,2x2,...Mx2...MxN\n",$G,$B
end

document pcell
   Print the elements of a cellarray
   Usage : pcell mx_array_ptr
end
#===================================================================
