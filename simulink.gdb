# vim: set ft=gdb:
#-----------------------------------------------------------------------------#
# This file contains gdb utility settings/methods specific to simulink        #
#                                                                             #
#-----------------------------------------------------------------------------#
printf "%s*** sourcing %ssimulink.gdb \n",$L_Y, $L_G

define load-ls
   printf "loading %slibexpat, sl_loadsave\n",$L_G
   shar libexpat.so
   shar libmwsl_loadsave.so
end

define load-sf
   printf "loading %slibmwstateflow.so, libmwsfdi_datamodel.so\n",$L_G
   shar libmwstateflow.so
   shar libmwsfdi_datamodel.so
end

define load-editor
   printf "loading %slibmwm3i.so\n",$L_G
   shar libmwm3i.so
   printf "loading %slibmwglee.so\n",$L_G
   shar libmwglee.so
   printf "loading %slibmwglue2.so\n",$L_G
   shar libmwglue2.so
   printf "loading %slibmwdastudio.so\n",$L_G
   shar libmwdastudio.so
   printf "loading %slibmwsl_editor.so\n",$L_G
   shar libmwsl_editor.so
   printf "loading %slibmwglee_util.so\n",$L_G
   shar libmwglee_util.so
   printf "loading %sglue2_datamodel.so\n",$L_G
   shar glue2_datamodel.so
   printf "loading %slibmwsl_datamodel.so\n",$L_G
   shar libmwsl_datamodel.so
end

define load-min
   printf "loading %slibmwsl_services.so\n",$L_G
   shar libmwsl_services.so
   shar libmwscl_string
   printf "loading %slibmwsimulink.so\n",$L_G
   shar libmwsimulink.so
   # libmwsl_utility for printing mstack
   # libmwmcr for mnDebugRuntimeFault
   # libmwm_lxe to skip a file
   printf "loading %slibmwcr.so, libmwsl_utility\n",$L_G
   shar libmwmcr
   shar libmwsl_utility.so
   shar libmwm_lxe.so

   # libmwsl_engin for assertion_func(sl_engin/RTWCGInitContext.cpp)
   # libmwcg_ir for cg_assert
   # libstdc++ so that we can catch throw. A pending breakpoint
   # for throw crashes gdb
   printf "loading %slibc, libstdc++, libmwcg_ir.so, libmwcpp11compat.so\n",$L_G
   shar libc.so
   shar libstdc++.so
   shar libmwcg_ir.so
   shar libmwcpp11compat.so

   # to call inFullKeyboardFcn
   shar libmwm_interpreter.so
end

define load-codegen
   printf "loading %slibmwslcg_tlc.so\n",$L_G
   shar libmwslcg_tlc.so
   printf "loading %slibmwslcg_impl.so\n",$L_G
   shar libmwslcg_impl
   printf "loading %slibmwsl_compile.so\n",$L_G
   shar libmwsl_compile
   printf "loading %slibmwslcg_rls.so\n",$L_G
   shar libmwslcg_rls.so
   printf "loading %slibmwshared_code_manager.so\n",$L_G
   shar libmwshared_code_manager
   printf "loading %slibmwslcg.so, libmwrtwcg.so\n",$L_G
   shar libmwslcg.so
   shar libmwrtwcg.so
end

define load-test
   printf "loading %slibmwsimharness\n",$L_G
   shar libmwsimharness
end

define load-eng

   printf "loading %slibmwsimulink.so\n",$L_G
   shar libmwsimulink.so
   printf "loading %slibmwsl_services.so\n",$L_G
   shar libmwsl_services.so
   shar libmwscl_string
   printf "loading %slibmwsl_libraries.so\n",$L_G
   shar libmwsl_libraries.so
   printf "loading %slibmwsimulink_sid.so\n",$L_G
   shar simulink_sid
   printf "loading %slibmwSimulinkBlock.so\n",$L_G
   shar libmwSimulinkBlock.so
   printf "loading %slibmwsl_prm_engine.so\n",$L_G
   shar libmwsl_prm_engine.so
   printf "loading %slibmwsl_lang_blocks.so\n",$L_G
   shar libmwsl_lang_blocks.so
   printf "loading %slibmwsl_engine_classes.so\n",$L_G
   shar libmwsl_engine_classes.so
   printf "loading %slibmwsl_prm_descriptor.so\n",$L_G
   shar libmwsl_prm_descriptor.so
   printf "loading %slibmwsl_graphical_classes.so\n",$L_G
   shar libmwsl_graphical_classes.so

   # libmwsl_utility for printing mstack
   # libmwmcr for mnDebugRuntimeFault
   printf "loading %sfl, cr, udd, udd_mi, sl_utility, sl_datamodel\n",$L_G
   shar libmwfl
   shar libmwmcr
   shar libmwudd.so
   shar libmwm_lxe.so
   shar libmwudd_mi.so
   shar libmwsl_utility.so
   shar libmwsl_datamodel.so

   # to call inFullKeyboardFcn
   shar libmwm_interpreter.so

   # libmwsl_engin for assertion_func(sl_engin/RTWCGInitContext.cpp)
   # libmwcg_ir for cg_assert
   # libstdc++ so that we can catch throw. A pending breakpoint
   # for throw crashes gdb
   printf "loading %slibc, libstdc++, libmwcg_ir.so, libmwcpp11compat.so\n",$L_G
   shar libc.so
   shar libXt.so
   shar libgcc_s.so
   shar libstdc++.so
   shar libmwcg_ir.so
   shar libmwcpp11compat.so
end

define auto-load-eng
  # gdb requires libstdc++.so to be able to run "catch throw"
  sb-auto-load-libs libc.so
  sb-auto-load-libs libXt.so
  sb-auto-load-libs libgcc_s.so
  sb-auto-load-libs libstdc++.so
  sb-auto-load-libs libmwcg_ir.so
  sb-auto-load-libs libmwcpp11compat.so

  # libmwsl_utility for printing mstack
  # libmwmcr, libmwfl for mnDebugRuntimeFault
  sb-auto-load-libs libmwfl
  sb-auto-load-libs libmwmcr
  sb-auto-load-libs libmwudd.so
  sb-auto-load-libs libmwudd_mi.so
  sb-auto-load-libs libmwsl_utility.so
  sb-auto-load-libs libmwsl_datamodel.so
  sb-auto-load-libs libmwm_interpreter.so

  # libraries I work on:
  sb-auto-load-libs simulink_sid
  sb-auto-load-libs libmwsl_mask.so
  sb-auto-load-libs libmwsimulink.so
  sb-auto-load-libs libmwsl_services.so
  sb-auto-load-libs libmwscl_string.so
  sb-auto-load-libs libmwsl_libraries.so
  sb-auto-load-libs libmwSimulinkBlock.so
  sb-auto-load-libs libmwsl_prm_engine.so
  sb-auto-load-libs libmwsl_lang_blocks.so
  sb-auto-load-libs libmwsl_engine_classes.so
  sb-auto-load-libs libmwsl_prm_descriptor.so
  sb-auto-load-libs libmwsl_graphical_classes.so

  dont-repeat
end

define auto-load-min
  sb-auto-load-libs libc.so
  sb-auto-load-libs libXt.so
  sb-auto-load-libs libgcc_s.so
  sb-auto-load-libs libstdc++.so
  sb-auto-load-libs libmwcg_ir.so
  sb-auto-load-libs libmwcpp11compat.so

  # libmwsl_utility for printing mstack
  # libmwmcr, libmwfl for mnDebugRuntimeFault
  sb-auto-load-libs libmwfl
  sb-auto-load-libs libmwmcr
end

define auto-load-codegen
   sb-auto-load-libs libmwslcg.so
   sb-auto-load-libs libmwslcg_tlc.so
   sb-auto-load-libs libmwslcg_impl
   sb-auto-load-libs libmwsl_compile
   sb-auto-load-libs libmwslcg_rls.so
   sb-auto-load-libs  libmwshared_code_manager
   dont-repeat
end
#===================================================================================
define breakgetparam
   b PrmDescGetValueInMx
end
define breaksetparam
end
#===================================================================================
define pid
    #shell ps -eaf | grep mvox
    printf "\n"
    shell pidof MATLAB
    printf "\n"
end
document pid
    show process id of MATLAB
end

define phist
    show commands
end
document phist
    Show history of last commands
end
#===================================================================

#===================================================================
#slsvGetCurrentMATLABStack() can also be used
define mstack-info
   #set var $var = getDebugMStack()
   #printf "%sLoad sl_utility if getDebugMstack not found\n", $L_G
   set var $var = 'debughelp'::getMatlabCallStack()
   printf "%s", $var._M_dataplus._M_p
end
document mstack-info
   Display MATLAB stack
   Usage : pmstack
end
#===================================================================

#===================================================================
define slsv-print
   if $argc<1
      help pslsv
   else
      print $arg0.fString->lcp_str()
   end
end
document slsv-print
    Display the charcater string inside slsvstring
    usage : pslsv reference_to_slsvstring
end
#===================================================================

#===================================================================
define mcos-cls-id
   p 'debughelp'::getmcosClassInfo($arg0)
end
document mcos-cls-id
    prints the class name given a reference to COSClassID/COSPackageID/COSPorpID etc.
    Usage : mcos-cls-id reference_to_COS*ID
end
#===================================================================

#===================================================================
define simobj-info
    if $IsClassPointer($arg0)
        p 'debughelp::_getSimObjInfo'($arg0)
    else
        p 'debughelp'::_getSimObjInfo((const void*)$arg0)
    end
end
document simobj-info
   Prints usesful info about a simulink object
   Usage : simobj-info SLSVMWObjectBase_ptr
end
#===================================================================

#===================================================================
define handle-2-obj
   call 'SLRootObjectBase::fromHandle'((double)$arg0)
end
document handle-2-obj
   Converts an handle to SLSVMWObjectBase*
end

define handle-2-block
   call 'SLBlock::Handle2Block'((double)$arg0(double), false)
end
document handle-2-block
   Converts an handle to SLBlock*
end
#===================================================================

#===================================================================

define gcb
   p 'debughelp::getCurrentBlock'()
end
document gcb
   Prints current block pointer
   Usage : gcb
end

define block-current
   p 'debughelp'::getCurrentBlock()
end

define block-info
    if $IsClassPointer($arg0)
        p 'debughelp'::getBlockInfo($arg0)
        # p ((BlockInfo)(*)(const SLBlock*) 'debughelp::getBlockInfo')($arg0)
    else
        p 'debughelp'::_getBlockInfo((const void*)$arg0)
    end
end
document block-info
    Displays detailed block informations
    Usage : pblkinfo block_ptr
end

define block-short-info
    if $IsClassPointer($arg0)
        p 'debughelp'::getShortBlockInfo($arg0)
    else
        p 'debughelp'::_getShortBlockInfo((const void*)$arg0)
    end
end
document block-short-info
    Displays short info about the given block pointer
    Usage : block-short-info block_ptr
end

define block-location
   p $arg0->graphical.location
end
document block-location
   Displays location of block
   Usage : pblocklocation block_ptr
end

define block-sid-space
  p 'debughelp'::_getBlockSIDSpace((const void*)$arg0)
end
document block-sid-space
   Prints the sidspace pointer of a given block. It prints the sidspace,
   the block belongs to.
   Usage : pblksidspace block_ptr
end

define block-state
    if $IsClassPointer($arg0)
        p 'debughelp'::getBlockStateInfo($arg0)
    else
        p 'debughelp'::_getBlockStateInfo((const void*)$arg0)
    end
end
document block-state
   Prints different states the block is undergoing.
end

define block-port-info
    if $IsClassPointer($arg0)
        p 'debughelp'::getBlockPortInfo($arg0)
    else
        p 'debughelp'::_getBlockPortInfo((void*)$arg0)
    end
end
document block-port-info
   Displays port informations about a block
   Usage: pblockportinfo block_ptr
end

define sid-space-owner
    p $arg0->fContainer
end
document block-sid-space
   Prints the owner(typically slGraph*) pointer of a given sid-space
   Usage : block-sid-space sid-space-ptr
end

define sid-need-own-space
    p SIDServicePolicy<SLRootObjectBase, slGraph>::needOwnSIDSpace((const SLRootObjectBase*)$arg0)
end

define block-from-path
    p 'debughelp'::getBlockFromPath($arg0);
end
#===================================================================

#===================================================================
define comp-block-info
    if $IsClassPointer($arg0)
        p 'debughelp'::_getCompBlockInfo($arg0)
    else
        p 'debughelp'::_getCompBlockInfo($arg0)
    end
end

define comp-callgraph
    if $IsClassPointer($arg0)
        p 'debughelp'::getCallGraphNodeInfo($arg0)
    else
        p 'debughelp'::_getCallGraphNodeInfo((const void*)$arg0)
    end
end
document comp-callgraph
    Usage comp-callgraph compCallGraph*
          comp-callgraph SlFcnCallMgr::SlCallGraphNode*
end
define comp-bd-info
    block-short-info $arg0->getSubsystemBlock()
end
#===================================================================

#===================================================================
define path-to-block
    p 'debughelp'::getBlockFromPath($arg0);
end

define path-to-obj
    p 'debughelp'::getObjFromPath($arg0);
end
define obj-from-path
    p 'debughelp'::getObjFromPath($arg0);
end
#===================================================================

#===================================================================
define sid-find
  p 'debughelp'::findSID($arg0)
end
define sid-from-obj
  p 'debughelp'::_getFullSIDString((const void*)$arg0)
end
document sid-from-obj
   Prints the sidnumber of a block/annotation given the SLSVMWObjectBase*
   Usage : sid-from-obj block_ptr/annotation_ptr
end

define sid-space-block
  p 'debughelp'::_getBlockSIDSpace((const void*)$arg0)
end
document sid-space-block
   Prints the sidspace pointer of a given block. It prints the sidspace,
   the block belongs to.
   Usage : pblksidspace block_ptr
end

define sid-space-graph
  p 'debughelp'::_getGraphSIDSpace((const void*)$arg0)
end
document sid-space-graph
   Prints the sidspace of a graph. If the graph has a sidspace, it prints
   that sidspace, else it prints the sidspace of nearest owner-sidspace
   Usage : graph-sidspace graph_ptr
end

define sid-table-from-space
   set var $sid_space=(SIDSpaceType*)$arg0
   set var $table_info='debughelp'::_getSIDTableInfo((const void*)($sid_space->fHashTable))
   if ($table_info)
      p *$table_info
   end
   call 'debughelp'::deleteHashTableInfo($table_info)
end
document sid-table-from-space
   Displays sid-numbers and SLSVMWObjectBase* stored in sid-hash-table.
   You can get sid-hash-table-pointer from sid-space-ptr->fHashTable
   Usage : psidtableinfo sid-space-pointer
end

define sid-table-dump
   call 'debughelp'::dumpSidTable($arg0->fHashTable)
   printf "See ~/sid_table.info"
end
document sid-table-dump
   Used to dump a sid-hash-table info into a file.
   Usage : pdumpsidtable sid-space-ptr.
           Use graph-sidspace to get sid-space-ptr
end
#===================================================================

#===================================================================
define port-info
    if $IsClassPointer($arg0)
        p 'debughelp'::getPortInfo($arg0)
    else
        p 'debughelp'::_getPortInfo((void*)$arg0)
    end
    echo slSegment*\n
end
document port-info
   Displays port information
   Usage : port-info port_ptr
end

define port-location
   p ((slPort*)$arg0)->location
end
document port-location
   Display location of a port
   Usage : port-location port_ptr
end

define port-of-block
   set var $block_port_info='debughelp'::_getBlockPortInfo((void*)$arg0)
   if ($block_port_info)
      p *$block_port_info
   end
   call 'debughelp'::deleteBlockPortInfo($block_port_info)
end
#===================================================================

#===================================================================
define void-2-bd
   p ((SLRootBD*)$arg0)
end
document void-2-bd
   Casts a raw pointer to SLRootBD*
end
define void-2-block
   p ((SLBlock*)$arg0)
end
document void-2-block
   Casts a raw pointer to SLBlock*
end

define void-2-port
   p ((slPort*)$arg0)
end
define void-2-segment
   p ((slSegment*)$arg0)
end

define void-2-graph
   p ((slGraph*)$arg0)
end
document void-2-graph
   Casts a raw pointer to graph pointer
end
#===================================================================

#===================================================================
define gcs
   p 'debughelp'::getCurrentGraph()
end
document gcs
   Prints current graph pointer
   Usage : gcs
end

define graph-scratch-graphs
   p 'debughelp'::getScratchGraphInfo()
end
document graph-scratch-graphs
   Prints all the scratch graph pointers.
end

define graph-info
    if $IsClassPointer($arg0)
        p 'debughelp'::getGraphInfo($arg0)
    else
        p 'debughelp'::_getGraphInfo((const void*)$arg0)
    end
end
document graph-info
    Displays Simulink graph informations
    Usage : pgraphinfo graph_ptr
end

define graph-sid-space
    if $IsClassPointer($arg0)
        p 'debughelp'::getGraphSIDSpace($arg0)
    else
        p 'debughelp'::_getGraphSIDSpace((const void*)$arg0)
    end
end
document graph-sid-space
   Prints the sidspace of a graph. If the graph has a sidspace, it prints
   that sidspace, else it prints the sidspace of nearest owner-sidspace
   Usage : graph-sidspace graph_ptr
end

define graph-dump-top-level
    if $IsClassPointer($arg0)
        call 'debughelp'::dumpGraph($arg0)
    else
        call 'debughelp'::_dumpGraph((void*)$arg0)
    end
   !echo '~/graf_first_level.info' | xclip -in -selection clipboard
   !echo '~/graf_first_level.info' | xclip -in -selection primary
   printf "See ~/graf_first_level.info(path copied to primary and clipboard selection)\n"
end
document graph-dump-top-level
   Prints all the block names and pointers in a graph.It doesn't dive
   into subsystems. See dumpfullgraph/pdumpfullgraph.
   Usage : pdumpgraph graph_ptr
end

define graph-dump-all
   if $IsClassPointer($arg0)
        call 'debughelp'::dumpCompleteGraph($arg0)
   else
        call 'debughelp'::_dumpCompleteGraph((const void*)$arg0)
   end
   printf "See ~/graf_complete.info\n"
   !echo '~/graf_complete.info' | xclip -in -selection clipboard
   !echo '~/graf_complete.info' | xclip -in -selection primary
end
document graph-dump-all
   Prints all the block names and pointers in a graph. It dives into subsystems
   and prints the child blocks. See dumpgraph/pdumpgraph.
   Usage : pdumpfullgraph graph_ptr
end
#===================================================================

#===================================================================
define bd-loaded
   p 'debughelp'::getBdSetInfo()
   printf "\nInfo\nvector< pair< SLRootBD*, Name>>\n"
end
document bd-loaded
   Display the pointer and name of all loaded blockdiagrams
   Usage : pbdset
end

define bd-dump
    if $IsClassPointer($arg0)
        call 'debughelp'::dumpCompleteBD($arg0)
    else
        call 'debughelp'::_dumpCompleteBD((const void*)$arg0)
    end
   printf "See ~/graf_complete.info\n"
   !echo '~/graf_complete.info' | xclip -in -selection clipboard
   !echo '~/graf_complete.info' | xclip -in -selection primary
end
document bd-dump
   Prints all the block names and pointers in a bd. It dives into subsystems
   and prints the child blocks. See graph-dump-*
   Usage : pdumpfullgraph graph_ptr
end

define bd-info
    if $IsClassPointer($arg0)
        p 'debughelp'::getBDInfo($arg0)
    else
        p 'debughelp'::_getBDInfo((const void*)$arg0)
    end
end

define bd-short-info
    if $IsClassPointer($arg0)
        p 'debughelp'::getShortBDInfo($arg0)
    else
        p 'debughelp'::_getShortBDInfo((void*)$arg0)
    end
end

document bd-info
    Dist
    plays Simulink Block Diagram informations
    Usage: pbdinfo bd_ptr
end

define bd-dirty-ignorecount
   p 'slBlockDiagramEditParams'::get((::SLRootBD*)$arg0)->fDirtyManager->get()->fPackageDirtyIgnoreCount
end
document bd-dirty-ignorecount
   Count of objects that have suppressed dirtyness of a bd
   Usage: pdirtyignorecount bd_ptr
end

define bd-signals
   if $IsClassPointer($arg0)
        p ($arg0)->getInstrumentedSignals()
   else
        p ((SLRootBD*)$arg0)->getInstrumentedSignals()
   end
   echo \nUse pdumpmx command to visualize the result\n
end
document bd-signals
    Displays Instrumented signal information of a block diagram
    Usage : pbdsig bd_ptr
end
#===================================================================

#===================================================================
define mask-info
    if $IsClassPointer($arg0)
        p 'debughelp::getMaskInfo'($arg0)
    else
        p 'debughelp::_getMaskInfo'((void*)$arg0)
    end
end
document mask-info
    Displays Simulink Mask informations
    Usage : pmaskinfo slmask_ptr
end

define mask-state
    if $IsClassPointer($arg0)
         p 'debughelp::getMaskState'($arg0)
    else
        p 'debughelp::_getMaskState'((const void*)$arg0)
    end
end
document mask-state
    Displays Simulink Mask states
    Usage : pmaskstate slmask_ptr
end

define mask-static-info
   p SLMaskStaticInfo::Instance()
end

document mask-static-info
   Prints the SLMaskStaticInfo instance
   Usage : pmaskstaticinfo
end
#===================================================================

#===================================================================
define wsinfo
   set var $ws_info='debughelp'::getWorkspaceInfo($arg0)
   if ($ws_info)
      p *$ws_info
   end
   echo \n\033[1;32m After you are done examining mxArray data using pdumpmx: \033[0m
   echo \n\033[1;32m call 'debughelp'::deleteWorkspaceInfo($ws_info) \033[0m\n
end
define ws-info
    if $IsClassPointer($arg0)
        set var $ws_info='debughelp'::getWorkspaceInfo($arg0)
    else
        set var $ws_info='debughelp'::_getWorkspaceInfo((void*)$arg0)
    end
   if ($ws_info)
      p *$ws_info
   end
   echo \n\033[1;32m After you are done examining mxArray data using pdumpmx: \033[0m
   echo \n\033[1;32m call 'debughelp'::deleteWorkspaceInfo($ws_info) \033[0m\n
end
document ws-info
   Given a workspace pointer, prints variables in the worksapce
   Usage: pwsinfo workspace_ptr
end

define ws-base-info
   set var $ws_info='debughelp'::getBaseWorkspaceInfo()
   if ($ws_info)
      p *$ws_info
   end
   echo \n\033[1;32m After you are done examining mxArray data using pdumpmx: \033[0m
   echo \n\033[1;32m use command delwsinfo \033[0m\n
end
document ws-base-info
   Prints the variables present in the base workspace
end

define delwsinfo
  call 'debughelp'::deleteWorkspaceInfo($ws_info)
end

# see m_interpreter/inWorkspaceAPI.hpp
define ws-var-info
   if $argc<2
      help ws-var-info
   else
      set var $ws=(::inWorkSpace_tag*)$arg0
      p inGetValueFromWS($ws, $arg1)
   end
end
document ws-var-info
   Prints information about a matlab workspace
   Usage : pvarinfo workspace_ptr(inWorkSpace_tag*) var_name
end

define ws-mask-info
   set var $msk=(::SLMask*)$arg0
   set var $ws=$msk->mWorkSpaceWrapper
   set var $varlist=$ws->varList

   printf "\n"
   printf "Simulink WS   : 0x%x (::SlMaskWS*) $ws\n", $ws
   printf "Variable list : 0x%x (::SlVarList*) $varlist\n", $varlist
   printf "Variable Map  : \n"
   p $varlist->varMap

   printf "Matlab WS\n"
   p $msk->mWorkSpace
   echo \n\033[1;32mUse pvarinfo ws_ptr param_name to see value in mxArray* format\033[0m\n
end
document ws-mask-info
   Prints the mask workspace(simulink workspace not matlab) info
   Usage : pmwsinfo mask_ptr
end

define ws-slws-info
   set var $ws=(::SlWorkspace*)$arg0
   set var $varlist=$ws->varList

   printf "\n"
   printf "Variable list : 0x%x (::SlVarList*) $varlist\n", $varlist
   printf "Variable Map  : \n"
   p $varlist->varMap
   printf "\n"
end
document ws-slws-info
   Prints the workspace info for SlWorkspace
   Usage : pslwsinfo slworkspace_ptr
end
#===================================================================

#===================================================================
define param-all-from-dlg
    if $IsClassPointer($arg0)
        set var $param_info='debughelp'::getParamInfo($arg0)
    else
        set var $param_info='debughelp'::_getParamInfo((void*)$arg0)
    end
   if ($param_info)
      p *$param_info
   end
   call 'debughelp'::deleteParamInfo($param_info)
end
document param-all-from-dlg
   prints the parameters on a slDialogInfo
   Usage : pdlgparaminfo ptr_slDialogInfo
end

define param-nth-from-dlg
    if $IsClassPointer($arg0)
        set var $param_info='debughelp'::getNthParamInfo($arg0, $arg1)
    else
        set var $param_info='debughelp'::_getNthParamInfo((void*)$arg0, $arg1)
    end

   if ($param_info)
      p *$param_info
   end
   call 'debughelp'::deleteParamInfo($param_info)
end
document param-nth-from-dlg
   prints the nth (0 based index) parameters on a slDialogInfo
   Usage : pnthparaminfo ptr_slDialogInfo param_index
end

define param-value
    if $IsClassPointer($arg0)
        p 'debughelp'::getParameterValue($arg0, $arg1, true)
    else
        p 'debughelp'::_getParameterValue((void*)$arg0, (void*)$arg1, true)
    end
   echo Use pmx to view the value of mxArray\n
   echo Use destroymx to delete this mxArray after inspection\n
end
document param-value
   prints the value value of a parameter in mxArray format
   Usage : param-info prmdesc_ptr owner_ptr(mostly block) use_open_dialog(true/false)
end

define gettrue
   p 'debughelp'::get_true()
end
define getfalse
   p 'debughelp'::get_false()
end
#===================================================================

#===================================================================
define pslvarinfo
   set var $var=(::SlVariable*)$arg0
   printf "Use $var to see the info\n"
   p *$var
end
document pslvarinfo
   Prints info of a SlVariable
   Usage : pslvarinfo slvariable_ptr
end
#===================================================================

#===================================================================
define lib-block-info
    if $IsClassPointer($arg0)
        p 'debughelp'::getLibInfo($arg0)
    else
        p 'debughelp'::_getLibInfo((void*)$arg0)
    end
end
document lib-block-info
   Displays Library info of a block(library link)
   Usage : plibinfo block_ptr
end
define block-lib-info
    lib-block-info $arg0
end

define linkinfo
end
define lib-link-info
    if $IsClassPointer($arg0)
        p 'debughelp'::getLibraryLinkInfo($arg0)
    else
        p 'debughelp'::_getLibraryLinkInfo((void*)$arg0)
    end
    printf "To see link data : p $##.link_data\n"
    printf "To see instance data : p *((ModelFileParameter*)($##.m_parameters[index]))\n"
    printf "To see instance data : p *((ModelFileParameter*)(0x....))\n"
end
document lib-link-info
   Displays info related to LinkInfo data structure
   Usage : lib-link-info LinkInfo_ptr
end

define lib-instance-info
    if $IsClassPointer($arg0)
        p 'debughelp'::getInstanceData($arg0)
    else
        p 'debughelp'::_getInstanceData((void*)$arg0)
    end
end
document lib-instance-info
   Displays info related to instance data in LinkInfo data structure
   Usage : lib-instance-info LinkInfo_ptr
end
#===================================================================

#===================================================================
define time-in-str
   p 'debughelp::getTimeInString'($arg0)
   printf "TimeStampZero is default constructed boost::posix_time::ptime == not_a_date_time\n"
   printf "TimestampForceUpdate is boost::posix_time::ptime(1) == 1970-Jan-01 00:00:00\n"
   printf "ptime_obj.is_not_a_date_time() return true/false\n"
end
document time-in-str
   Help print time(BlockMTimeType, or slsFileMTimeType)
   Usage: time-in-str time_type_value_not_pointer
end
#===================================================================

#===================================================================
define diagnostic-info
    p 'debughelp'::getDiagInfo($arg0)
    printf "Use p debughelp::getDiagnosticMessage(diag, n)\n"
    printf "to get nth diagnostic message\n"
    printf "Use p debughelp::getDiagnosticID(diag,n)\n"
    printf "to get nth dianostic's id\n"
end
document diagnostic-info
    Print a slsvDiagnostic's content
    Usage : diagnostic-info slsvDiagnostic(not pointer)
end
#===================================================================

#===================================================================
define udi-info
    if $IsClassPointer($arg0)
        p 'debughelp::getUDInterfaceInfo'($arg0)
    else
        p 'debughelp::_getUDInterfaceInfo'((void*)$arg0)
    end
    echo Use psimobjinfo on fThisObject(::SLSVMWObjectBase* member of UDInterface*)\n
end
document udi-info
   Pretty Print a UDD Interface object.
end
#===================================================================

#===================================================================
define setinfo
   p 'debughelp'::getSetInfo($arg0)
end
define set-info
   p 'debughelp'::_getSetInfo((void*)$arg0)
end
document set-info
   Prints a Set* as std::vector<void*>
end
#===================================================================

#===================================================================
#===================================================================

#===================================================================
define ssref-lock-info
   p 'slsr::SREditingManager'::getInstance()
   printf "std::unorded_map< bd_name(slsvString), master_graph(slGraph*) >\n"
end

define ssref-active-blocks
   p 'slsr::ActiveSRRepository'::getInstance()
   printf "std::unorded_map< ssref_block_graph(slGraph*), bd_name(slsvString) >\n"
end

define ssref-clear-ssref
   call 'slsr::ActiveSRRepository'::getInstance().clearSSRefGraph(((slGraph*)$arg0))
end

define ssref-clear-all-ssrefs
   call 'slsr::ActiveSRRepository'::getInstance().clearAll()
end

define unittestinfo
   p 'debughelp'::getUnitTestInfo($arg0)
end
define ssref-unittest-info
   p 'debughelp'::_getUnitTestInfo((const void*)$arg0)
end
document ssref-unittest-info
   Display slsr::UnitTestInfo stored for a block diagram
   Usage: unittestinfo bd_ptr
end

define ssref-cs-info
   p 'debughelp'::_getChecksumDetails((const void*)$arg0)
end
document ssref-cs-info
   Displays checksum info for a subsystem block
   Usage : checksuminfo ss_ptr
end

define checksum-compute-n-dump
    p 'debughelp'::computeAndSendSignatureToMFile((const SubsystemBlock*)$arg0)
end
document checksum-compute-n-dump
   Given a SubsystemBlock*, compute the signature and send it to debugMxFromCpp.m file.
   Usage : checksum-compute-n-dump ss_ptr
end

define checksum-dump
    #p 'debughelp'::sendComputedSignatureToMFile((SubsystemBlock*)$arg0, (bdCompInfo*)$arg1)
    p 'debughelp'::sendComputedSignatureToMFile((SubsystemBlock*)$arg0)
end
document checksum-dump
   Given a SubsystemBlock*, dump the signature and send it to debugMxFromCpp.m file.
   The checksums must be already computed before calling this method
   Usage : checksum-dump SubsystemBlock* bdCompInfo*
end
#===================================================================

#===================================================================
define cdata-dump
   p DumpCData($arg0, $arg1)
   printf "Use sbviewslcdata file_name to view the dumped data\n"
end
document cdata-dump
   Used to dump compile data of a block diagram.
   Usage: cdata-dump compbd "abcd",  where compbd is SLCompBD* and "abcd" is the file name
end
#===================================================================

#===================================================================
define sf-objs
   set $sf_objs=SF::object
   set $sf_class=SF::class_array
   printf "\nGlobal sf obj ptr    : 0x%x (SF::ObjectHeader*) $sf_objs", $sf_objs
   printf "\nGlobal class array ptr : 0x%x (SF::ClassStruct*) $sf_class", $sf_class
   printf "\nPool capacity       : %d", SF::pool_capacity
   printf "\nObj count in pool    : %d", SF::number_of_objects_in_pool
   printf "\nLast handle assigned : %d\n", SF::last_handle_assigned
   printf "\nisa chart: 0-(SF::DB_machine*), 1-(SF::DB_chart*), 2-(TARGET_OBJECT)"
   printf "\n3 - (SF::DB_instance*), 4-(STATE_OBJECT), 5-(TRANSITION_OBJECT)"
   printf "\n6 - (JUNCTION_OBJECT), 7-(EVENT_OBJECT), 8-(DATA_OBJECT)"
   printf "\n9 - (LINKCHART_OBJECT), 10-(NOTE_OBJECT), 11-(WORMHOLE_OBJECT)"
   printf "\n\nsee matlab/toolbox/stateflow/src/stateflow/fsm/auto/fsmdbdb.hpp for more details."
   printf "\nparent in ObjectHeader is the machine-id\n"
end
#===================================================================

#===================================================================
define cs-rec-2-value
   # sl_utility/checksum/slChecksumRec.hpp
   slGetChecksumValue($arg0)
end
document cs-rec-2-value
   Converts slChecksumRec to 4 integer values
end

define cs-ss-info
    if $IsClassPointer($arg0)
        p 'debughelp'::getChecksumDetails($arg0)
    else
        p 'debughelp'::_getChecksumDetails((const void*)$arg0)
    end
end
document cs-ss-info
    Gets checksum details of a given subsystem block
    Usage: cs-ss-info subsystem_ptr
end

define help-cs
    printf "\n%scs-rec-2-value converts checksumRec to checksumvalue", $L_G
    printf "\n%ssschecksuminfo gets checksum details given a subsystem", $L_G
end
#===================================================================

#===================================================================
define iter-info
   printf "Current block: %x\n", $arg0.m_iterator_impl->m_current_block
   printf "Graph pointer: %x\n", $arg0.m_iterator_impl->m_graph
   printf "Block type   : %d\n", $arg0.m_iterator_impl->m_active_container
end
document iter-info
   Given an block iterator prints some internal infos about it.
end
#===================================================================

#===================================================================
define getrenderer
   call 'SimulinkRenderer::ActiveRenderer'::getInstance()->getActiveRendererPtr ()
end
define block-m3i-info
   p $arg0.getFullPathName()
   p 'SLM3I::getSlBlock'($arg0)
end
document block-m3i-info
   Prints the block path, given a SLM3I::Block object
   Usage: block-m3i-info block_obj (make sure to load sl_editor module)
end
#===================================================================

#===================================================================
define break-wsassign
   b InAssignInDesiredWS_MLCommand::operator()
end
document break-wsassign
   Sets break point when someone tries to assign a variable in a
   workspace. The code is in slsverror_creation_util.
end

define break-slsvthrow
   b slsvThrowIExceptionFromDiagnostic
end
document break-slsvthrow
   Sets break point in the func that tries to throw a slsv-diagnostic
end

define break-slsvwarn
   b slsvReportAsWarning
end
document break-slsvwarn
   Sets break point in the func that tries to report warning
end

define break-cond-str
    cond $arg0 $_streq($arg1._M_dataplus._M_p, $arg2)
end
document break-cond-str
    Applies a conditional breakpoint if the given variable(std::str) matches
    a string.
    Usage: break-cond-str 5 str_var "param1"
           Will stop at 5th breakpoint if str_var is equal to "param1"
end

#define cond-str-equal
#    break-cond-str $arg0 $arg1 $arg2
#end
#
#document cond-str-equal
#    Applies a conditional breakpoint if the given variable(std::str) matches
#    a string.
#    Usage: break-cond-str 5 str_var "param1"
#           Will stop at 5th breakpoint if str_var is equal to "param1"
#end

define watch-addr
    watch *((int*)$arg0)
end
define watch-ptr-var
    watch *((int*)&$arg0)
end

define help-break
   printf "\n%s break-wsassign  :%s Breakpoint on trying to assign a value in a ws",$L_G,$L_B
   printf "\n%s break-slsvwarn  :%s Breakpoint on slsvReportAsWarning",$L_G,$L_B
   printf "\n%s break-slsvthrow :%s Breakpoint on slsvthrow\n\n",$L_G,$L_B

   echo b matl_get_param_with_err : getparam.cpp\n
   echo b doSetParam              : setparam.cpp\n
   echo b PrmDescSetValueInMx     : SLPrmDesc_sup.hpp\n
   echo b LibraryUpdateHelper::UpdateLibraryReferencesHelper : LibraryUpdateHelper.cpp\n
   echo b [where] if \$_streq(x, "hello")\n
   echo b [where] if \$_streq(std_str._M_dataplus._M_p, "hello")\n
   echo cond [bp_no] \$_streq(x, "hello")\n
   echo cond [bp_no] \$_streq(std_str._M_dataplus._M_p, "hello")\n
   echo cond [bp_no] \$_caller_is(name[, number_of_frames])\n
   echo cond [bp_no] \$_any_caller_is(name[, number_of_frames])\n
   echo cond [bp_no] \$_any_caller_matches("function1")\n\n
end
define break-help
    help-break
end
#===================================================================

#===================================================================
define cpp-2-matlab
  call inFullKeyboardFcn(0,(mxArray_tag**)0,0,(mxArray_tag**)0)
end
document cpp-2-matlab
   Shows matlab prompt. (shar libmwm_interpreter.so)
end
define cpp-2-debug-m
    call 'debughelp'::goToMATLABdebugMethod()
end
#===================================================================

#===================================================================
define run-unit
    run -gtest-filter=$arg0
end
document run-unit
   runs a particular unit test (e.g. run-unit "MyUnitTest.MyTestPoint")
end
#===================================================================

#===================================================================================
define help-all
   printf "\n%s help-udi      :%s UDI related help",$L_G,$L_B
   printf "\n%s help-general  :%s Gdb generic help",$L_G,$L_B
   printf "\n%s help-handle   :%s Handle related help",$L_G,$L_B
   printf "\n%s help-signal   :%s Signal related help",$L_G,$L_B
   printf "\n%s help-block    :%s Simulink block related help",$L_G,$L_B
   printf "\n%s help-ssref    :%s Subsystem reference related help",$L_G,$L_B
   printf "\n%s help-param    :%s Block paremter related help",$L_G,$L_B
   printf "\n%s help-mask     :%s Mask related help",$L_G,$L_B
   printf "\n%s help-graph    :%s Graph realted help",$L_G,$L_B
   printf "\n%s help-break    :%s Simulink related help",$L_G,$L_B
   printf "\n%s help-port     :%s Block port related help",$L_G,$L_B
   printf "\n%s help-lib      :%s Library related help",$L_G,$L_B
   printf "\n%s help-comp     :%s Compilation related help",$L_G,$L_B
   printf "\n%s pset-info     :%s Print legacy Set* info in vector format",$L_G,$L_B
   printf "\n%s help-str      :%s String utility help",$L_G,$L_B
   printf "\n%s help-sim      :%s Simulink related help",$L_G,$L_B
   printf "\n%s help-sid      :%s Sid related help",$L_G,$L_B
   printf "\n%s help-bt       :%s Backtrace related help",$L_G,$L_B
   printf "\n%s help-sf       :%s Simulink related help",$L_G,$L_B
   printf "\n%s help-ws       :%s MATLAB/Simulink workspace help",$L_G,$L_B
   printf "\n"
end

define help-general
   printf "\n%s pid            :%s Print pid of MATLAB process",$L_G,$L_B
   printf "\n%s phist          :%s Print history of commands",$L_G,$L_B
   printf "\n%s attachm        :%s Attach gdb to MATLAB process",$L_G,$L_B
   printf "\n%s help-bt        :%s Show help for back trace settings",$L_G,$L_B
   printf "\n%s vtable-load    :%s Loads *.so containing vtable given obj pointer",$L_G,$L_B
   printf "\n%s vtable-pointer :%s Print classinfo from vptr",$L_G,$L_B
   printf "\n%s vtable-content :%s Print contents of vtable given obj pointer vptr",$L_G,$L_B
   printf "\n%s load-min       :%s Loads minimum set of libraries",$L_G,$L_B
   printf "\n%s load-ls        :%s Loads libraries related to load-save code",$L_G,$L_B
   printf "\n%s load-editor    :%s Loads libraries related to editor code",$L_G,$L_B
   printf "\n"
end

define help-matlab
   printf "\n%s mstack-info   :%s Print MATLAB Stack",$L_G,$L_B
   printf "\n%s mcos-cls-id   :%s Print class id of an mcos object",$L_G,$L_B
   printf "\n%s cpp-2-matlab  :%s Control goes to MATLAB",$L_G,$L_B
   printf "\n%s cpp-2-debug-m :%s Control stops in a debug-MATLAB file",$L_G,$L_B
   printf "\n"
end

define help-sim
   printf "\n%s time-in-str   :%s Print BlockMTimeType/slsFileMtime in a readable format",$L_G,$L_B
   printf "\n%s bd-loaded     :%s Print global list of loaded block diagrams",$L_G,$L_B
   printf "\n%s bd-info       :%s Print info about a block diagram",$L_G,$L_B
   printf "\n%s udi-info      :%s Print UDD class info, given a UDD interface object",$L_G,$L_B
   printf "\n%s set-info      :%s Print legacy Set* info in vector format",$L_G,$L_B
   printf "\n%s simobj-info   :%s Print generic info about SLSVMWObjectBase type objet",$L_G,$L_B
   printf "\n%s path-to-block :%s Convert a char* path to SLBlock*",$L_G,$L_B
   printf "\n%s path-to-obj   :%s Convert a char* path to simobject",$L_G,$L_B
   printf "\n%s obj-from-path :%s Convert a char* path to simobject",$L_G,$L_B
   printf "\n%s diagnostic-info :%s Input=slsvDiangostic object, prints the message",$L_G,$L_B
   printf "\n"
end

define help-ssref
   printf "\n%s ssref-print-lock     :%s Print subsystem reference locks",$L_G,$L_B
   printf "\n%s ssref-print-ssrefs   :%s Print active subsystem reference blocks",$L_G,$L_B
   printf "\n%s ssref-clear-ssref    :%s Clear given graph pointer from the repository",$L_G,$L_B
   printf "\n%s ssref-clear-allssrefs:%s Clear all active subsystem reference blocks from the repository",$L_G,$L_B
   printf "\n"
end

define help-block
   printf "\n%s gcb              :%s Print current block pointer(gcb)",$L_G,$L_B
   printf "\n%s gcbh             :%s Print current block handle",$L_G,$L_B
   printf "\n%s block-info       :%s Print detailed info about block pointer",$L_G,$L_B
   printf "\n%s block-lib-info   :%s Print lirary related info of the block",$L_G,$L_B
   printf "\n%s block-m3i-info   :%s Print info about SLM3I block",$L_G,$L_B
   printf "\n%s block-location   :%s Print location of the block",$L_G,$L_B
   printf "\n%s block-port-info  :%s Print info about ports of a given block",$L_G,$L_B
   printf "\n%s block-short-info :%s Print short info about block pointer",$L_G,$L_B
   printf "\n"
end

define help-graph
   printf "\n%s gcs             :%s Print current graph pointer(gcs)",$L_G,$L_B
   printf "\n%s graph-scratch   :%s Print all the scratch graph pointers",$L_G,$L_B
   printf "\n%s graph-info      :%s Print detailed info about a slGraph",$L_G,$L_B
   printf "\n%s graph-dump-all  :%s Print all block's(dives recursively) info to a file",$L_G,$L_B
   printf "\n%s graph-sid-space      :%s Print sidspace of a graph, given a graph pointer",$L_G,$L_B
   printf "\n%s graph-dump-top-level :%s Print all top level block's info to a file",$L_G,$L_B
   printf "\n"
end

define help-port
   printf "\n%s port-info       :%s Print info about a slPort given sPort*",$L_G,$L_B
   printf "\n%s port-location   :%s Print location of a slPort given sPort*",$L_G,$L_B
   printf "\n%s port-of-block   :%s Print info about ports of a given SLBlock*",$L_G,$L_B
   printf "\n%s block-port-info :%s Print info about ports of a given block",$L_G,$L_B
   printf "\n"
end

define help-handle
   printf "\n%s handle-2-obj   :%s Convert handle to SLSVMWObjectBase*",$L_G,$L_B
   printf "\n%s handle-2-block :%s Convert handle to SLBlock*",$L_G,$L_B
   printf "\n"
end

define help-mask
   printf "\n%s mask-info        :%s Prints general info about mask",$L_G,$L_B
   printf "\n%s mask-state       :%s Prints states of a mask",$L_G,$L_B
   printf "\n%s mask-static-info :%s Prints static info of a mask",$L_G,$L_B
   printf "\n"
end

define help-ws
   printf "\n%s ws-base-info :%s Prints all the vars in base workspace",$L_G,$L_B
   printf "\n%s ws-info      :%s Prints all the vars in a matlab workspace",$L_G,$L_B
   printf "\n%s ws-mask-info :%s Input=SLMask* : prints simulink workspace(not matlab workspace) info",$L_G,$L_B
   printf "\n%s ws-var-info  :%s Prints value of a variable in a workspace",$L_G,$L_B
   printf "\n%s ws-slws-info :%s Input=SlWorkspace*, prints its info",$L_G,$L_B
   printf "\n%s pslvarinfo   :%s Input=SlVariable*, prints its info",$L_G,$L_B
   printf "\n"
end

define help-lib
   printf "\n%s lib-block-info :%s Input=SLBlock*, prints library link info",$L_G,$L_B
   printf "\n%s lib-link-info  :%s Input=Linkinfo*. Use plibinfo to get LinkInfo*",$L_G,$L_B
   printf "\n"
end

define help-param
   printf "\n%s param-all-from-dlg :%s Print parameter's info on a dialoginfo",$L_G,$L_B
   printf "\n%s param-nth-from-dlg :%s Print nth parameter's info on a dialoginfo",$L_G,$L_B
   printf "\n%s param-value        :%s Print a parameter's value in mxArray",$L_G,$L_B
   printf "\n"
end

define help-sid
   printf "\n%s sid-find             :%s Given a sid string(std::string) find the object",$L_G,$L_B
   printf "\n%s sid-from-obj         :%s Print the full-sid of an object(SLRootObjectBase*)",$L_G,$L_B
   printf "\n%s sid-space-block      :%s Print sidspace of a block, given a block pointer",$L_G,$L_B
   printf "\n%s sid-space-graph      :%s Print sidspace of a graph, given a graph pointer",$L_G,$L_B
   printf "\n%s sid-table-from-space :%s Print internal sid table of a sidspace",$L_G,$L_B
   printf "\n"
end

define help-sf
   printf "\n%s psfobjs :%s Print Global stateflow object infos",$L_G,$L_B
   printf "\n"
end

define help-comp
   printf "\n%s cdata-dump      :%s Dump compile data of SLCompBD",$L_G,$L_B
   printf "\n%s comp-block-info :%s Show block info given a SLCompBlock* ",$L_G,$L_B
   printf "\n%s comp-callgraph  :%s Given a SlCallGraphNode* show associated blocks",$L_G,$L_B
   printf "\n%s comp-bd-info    :%s Given a bdCompInfo* show which block it belongs to",$L_G,$L_B
   printf "\n"
end

define help-signal
   printf "\n%s bd-signals :%s Get all the instrumented signals of a bd\n",$L_G,$L_B
end

define help-udi
   printf "\n%s pudiinfo :%s Print info about a UDInterface object\n",$L_G,$L_B
end

define help-harness
    printf "\n%sbdinfo returns a pointer to harness-manager", $L_G
    printf "\nharness_mgr->getHarnessByName(slsvString_name)", $L_G
    printf "\nharness->getHarnessBD() // Pointer to the harness BD", $L_G
    printf "\nharness->getSystemBD() // Pointer to the owner-bd of the harness", $L_G
    printf "\nharness->getCUTForActiveHarness() // Pointer to the CUT block", $L_G
    printf "\nharness->isActive() // Pointer to the CUT block", $L_G
    printf "\nTo load module: load-test", $L_G
   printf "\n"
end

define help-unittest
   printf "\n%s r --gtest_filter=\"MySuite.MyTest\" to run only \"TEST(MySuite, MyTest)\" ", $L_G
   printf "\n"
end
#===================================================================================

