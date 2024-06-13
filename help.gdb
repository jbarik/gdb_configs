# vim: set ft=gdb:
printf "%s*** sourcing %shelp.gdb \n",$L_Y,$L_G

define helpbreak
   echo b matl_get_param_with_err : getparam.cpp
   echo b doSetParam              : setparam.cpp
   echo b PrmDescSetValueInMx     : SLPrmDesc_sup.hpp

   echo b LibraryUpdateHelper::UpdateLibraryReferencesHelper : LibraryUpdateHelper.cpp
end
