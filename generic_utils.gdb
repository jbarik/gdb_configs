# vim: set ft=gdb:
#-------------------#
# gdb utilities     #
#-------------------#

printf "%s*** sourcing %sutil.gdb \n",$L_Y,$L_G
#===================================================================================
# Stop auto loading shared libraries. You'll see ??? in you bactrace. To see the
# symbols, fire the command "shar libname"
#
define autoload-enable
 set auto-solib-add on
end

define autoload-disable
   set auto-solib-add off
end
#===================================================================================

#===================================================================================
define psections
   maintenance info sections
end
define pprocmap
   info proc map
end
#===================================================================================

#===================================================================================
define thread-current
   printf "%sCurrent thread number: %s%d\n", $G,$E,$_thread
end
document thread-current
   Print current thread number
end
define thread-all-bt
    thread apply all bt
end
#===================================================================================

#===================================================================================
define pcs
   info symbol $pc
end
document pcs
   The next instruction that is going to be executed.
end
#===================================================================================

#===================================================================
define bt-xcomp
   set print frame-info short-location
   set print frame-arguments presence
end
document bt-xcomp
   Prints extra compact backtrace
   set print frame-info short-location
   set print frame-arguments presence
end
define bt-comp
   set print frame-info location
   set print frame-arguments presence
end
document bt-comp
   Prints compact backtrace
   set print frame-info location
   set print frame-arguments scalars
end
define bt-scomp
   set print frame-info location
   set print frame-arguments scalars
end
document bt-scomp
   Prints semi-compact backtrace
   set print frame-info location
   set print frame-arguments scalars
end
define bt-full
   set print frame-info location
   set print frame-arguments all
end
document bt-full
   Prints full blown backtrace
   set print address on
   set print frame-info location
   set print frame-arguments all
end
define bt-norm
   set print frame-info auto
   set print frame-arguments scalars
end

define bt-raw
   if $argc>0
      bt no-filters $arg0
   else
      bt no-filters
   end
end
document bt-raw
   Executes bt in raw format without any filters
end
define raw-bt
    bt-raw
end

define help-bt
   printf "%s bt-raw   : %sRaw bt without any filters\n",$L_G,$L_B
   printf "%s bt-full  : %sFor full blown backtrace\n",$L_G,$L_B
   printf "%s bt-comp  : %sFor compact backtrace\n",$L_G,$L_B
   printf "%s bt-xcomp : %sFor extra compact backtrace\n",$L_G,$L_B
   printf "%s bt-scomp : %sFor semi-compact backtrace\n\n",$L_G,$L_B
   printf "%s set print frame-arguments [all scalars none presence]\n",$L_G
   printf "%s set print famre-info [short-location location location-and-address source-line source-and-loation auto]\n%s",$L_G,$E
end
define bt-help
    help-bt
end
#==============================================================================

#==============================================================================
define vtable-pointer
   print /a (*(void **)$arg0)
end
document vtable-pointer
    Display the real class type(mangaled name) - through vtable
    usage : vtable-pointer object_ptr. See load-vtbl.
end

define vtable-content
   set var $count=1
   if $argc>1
      set var $count=$arg1
   end
   print /a (*(void ***)$arg0)[0]@$count
end

define vtable-load
   load-vtable-lib $arg0
end
document vtable-load
   Given a pointer(some class object), tries to load the object file that
   contains the vtable information.
end
#==============================================================================

#==============================================================================
define hwatch
    watch *((int*)$arg0)
end
document hwatch
    Given a pointer applies a read-write-watch
end
#==============================================================================

#==============================================================================
define tui-enable
    tui enable
end
define tui-disable
    tui disable
end
#==============================================================================

#==============================================================================
define bpl
    info breakpoints
end
document bpl
    List breakpoints
end

define bp
    set $SHOW_CONTEXT = 1
    break * $arg0
    end
document bp
    Set a breakpoint on address
    Usage : bp addr
end

define bpc
    clear $arg0
    end
document bpc
    Clear breakpoint at function/address
    Usage : bpc
end

define bpe
    if $argc>0
        enable $arg0
    end
    if $argc>1
        enable $arg1
    end
    if $argc>2
        enable $arg2
    end
    if $argc>3
        enable $arg3
    end
    if $argc>4
        enable $arg4
    end
    if $argc>5
        help bpe
    end
end
document bpe
    Enable breakpoint #
    Usage : bpe num1 num2 ...num5 (supports upto 5 breakpoints)
end

define bpd
    if $argc>0
        disable $arg0
    end
    if $argc>1
        disable $arg1
    end
    if $argc>2
        disable $arg2
    end
    if $argc>3
        disable $arg3
    end
    if $argc>4
        disable $arg4
    end
    if $argc>5
        disable $arg5
    end
    if $argc>6
        disable $arg6
    end
    if $argc>7
        help bpd
    end
end
document bpd
    Disable breakpoint #
    Usage : bpd num1 num2 ... num7 (supports upto 7 break points)
end

define bpt
    set $SHOW_CONTEXT = 1
    tbreak $arg0
end
document bpt
    Set a temporary breakpoint on address
    Usage : bpt addr
end

define bpm
    set $SHOW_CONTEXT = 1
    awatch $arg0
end
document bpm
    Set a read/write breakpoint on address
    Usage : bpm addr
end
#==============================================================================

define skf
   skip function $arg0
end
document skf
    Skip the given function while stepping
    Usage : bpm func_name_to_skip
end
#==============================================================================

#==============================================================================
define pustr
   set $var = 'debughelp'::ustr_to_str($arg0)
   printf "%s", $var._M_dataplus._M_p
end
document pustr
   Given a ustring object, prints it. If the string contains \n it prints a
   newline.
   Usage : pustr ustr-object
end

define pstr
   printf "%s", $arg0._M_dataplus._M_p
end
document pustr
   Given a string object, prints it. If the string contains \n it prints a
   newline.
   Usage : pustr ustr-object
end

define str-create
   p 'debughelp'::create_str($arg0)
end
document str-create
   Creates an std::string and retuns it
   Usage : createstr "example_string"
end

define ustr-create
   p 'debughelp'::create_ustr($arg0)
end
document ustr-create
   Creates an fl::ustring and retuns it
   Usage : createustr "example_string"
end
define slsv-create
    p 'debughelp'::create_slsvstring($arg0)
end
document slsv-create
   Creates an slsvString
   Usage : createslsv "example_string"
end

define help-str
   printf "%s pstr       : %sPrints string - newline for /\n\n",$G,$B
   printf "%s pustr      : %sPrints ustring - newline for /\n\n",$G,$B
   printf "%s createstr  : %sCreates a std::string obj given a char* value\n",$G,$B
   printf "%s createustr : %sCreates a fl::ustring obj given a char* value\n",$G,$B
   printf "%s createslsv : %sCreates a slsvString obj given a char* value\n",$G,$B
   printf "\n%s 'debughelp'::is_str_equal :\033[1;34m Can be used to compare to a std::string",$L_G
   printf "\n%s 'debughelp'::is_ustr_equal:\033[1;34m Can be used to compare to a fl::ustring\n",$L_G
end
#==============================================================================

#==============================================================================
define help-condition
   printf "%s cond n $_streq(str1, str2) /\n\n",$G,$B
   printf "%s cond n $_strlen(str1, str2) /\n\n",$G,$B
   printf "%s cond n $_regex(str, regx) /\n\n",$G,$B
   printf "%s cond n $_caller_is(name [,frame_number]) /\n\n",$G,$B
   printf "%s cond n $_caller_matches(regexp [,frame_number]) /\n\n",$G,$B
   printf "%s cond n $_any_caller_is(name [,frame_number]) /\n\n",$G,$B
   printf "%s cond n $_any_caller_matches(regexp [,frame_number]) /\n\n",$G,$B
   printf "\n%s 'debughelp'::is_str_equal :\033[1;34m Can be used to compare to a std::string",$L_G
   printf "\n%s 'debughelp'::is_ustr_equal:\033[1;34m Can be used to compare to a fl::ustring\n",$L_G
end
#==============================================================================

define true-get
    p 'debughelp'::get_true()
end
define false-get
    p 'debughelp'::get_false()
end
define nullptr-get
    p 'debughelp'::get_nullptr()
end
#==============================================================================
define pi-show-stack
   set python print-stack full
end
define pi-hide-stack
   set python print-stack message
end

define help-python
   printf "%s pi-show-stack : %sShows python stack if there is an error/\n",$G,$B
   printf "%s pi-hide-stack : %sHides python stack if there an error/\n\n",$G,$B
end
#==============================================================================

define p3dmtr
    set $matr=$arg0
    set $ibnd=$arg1
    set $jbnd=$arg2
    set $k=$arg3
    set $i=0
    set $j=0
    while $i<$ibnd
        while $j<$jbnd
            printf "%3.2f ", $matr[$i][$j++][$k]
        end
        set $i=++$i
        set $j=0
        printf "\n"
    end
end
document p3dmtr
    Print a 3d array in 2x2 form. Arguments are name_of_array maxi maxj k
    Usage : p3dmtr name_of_array maxi maxj k
end

define p2dmtr
    set $matr=$arg0
    set $ibnd=$arg1
    set $jbnd=$arg2
    set $i=0
    set $j=0
    while $i<$ibnd
        while $j<$jbnd
            printf "%3.2f ", $matr[$i][$j++]
        end
        set $i=++$i
        set $j=0
        printf "\n"
    end
end
document p2dmtr
    Print a 2d array in 2x2 form. Arguments are name_of_array maxi maxj
    Usage : p2dmtr name_of_array maxi maxj
end

#===================================================================
define seti
    set $ii=0
end
#===================================================================

#===================================================================
define parr
    if $argc<2
        help parr
    else
        set var $arr_iter=$arg0
        set var $counter=0

        while ($counter<$arg1)
            printf "Index(0 based) = %u ", $counter
            print $arr_iter[$counter]->$arg2 set var $counter=$counter+1 end end
        end
   end
end
document parr
    prints the value of a field of a pointer in an array
    Usage : parr  array_name  print_till_index  field_name
end
#===================================================================

#===================================================================
define pll1
    if $argc<1
        help pll1
    else
        set var $plist_iter=$arg0
        set var $counter=0

        while ($plist_iter)
            if $argc==1
                print *$plist_iter
            else
                if $argc==2
                   printf "Node number(0 based) : %u \n", $counter
                   printf "Node pointer : %u \n", $plist_iter
                   print $plist_iter->$arg1
                else
                   print $arg2 $plist_iter->$arg1
                end
            end

            set var $plist_iter=$plist_iter->next
            set var $counter=$counter+1
        end

        printf "No of elements in the list : %u \n", $counter

    end
end
document pll1
    prints a linked list (node should have next field)
    Usage1 : pll1  name_of_linked_list
    Usage2 : pll1  name_of_linked_list  name_of_field
end
#===================================================================

#===================================================================
define pll2
    if $argc<2
        help pll2
    else
        set var $plist_iter=$arg0
        set var $counter=0

        while ($plist_iter)
            if $argc==2
                print *$plist_iter
            else
                if $argc==3
                   printf "Node number(0 based) : %u \n", $counter
                   printf "Node pointer         : 0x%x \n", $plist_iter
                   printf "Value of field %u is :", $arg2
                   printf  $plist_iter->$arg2
               else
                   printf "Garbage"
               end
            end

            set var $plist_iter=$plist_iter->$arg1
            set var $counter=$counter+1
        end

        printf "No of elements in the list : %u \n", $counter
    end
end
document pll2
    prints a linked list
    Usage1 : pll2  name_of_linked_list  name_of_next_pointer_field
    Usage2 : pll2  name_of_linked_list  name_of_next_pointer_field  name_of_field
end
#===================================================================

#===================================================================
define pnptr1
    set var $plist_iter=$arg0
    set var $counter=$arg1
        while ($counter>0)
            set var $plist_iter=$plist_iter->next
            set var $counter=$counter-1
        end

    if $argc==2
        print $plist_iter
    else
        if $argc=3
            print $plist_iter->$arg2
        end
    end
end

document pnptr1
    prints the node pointer in a linked list (node should have next field)
    Usage1 : pnptr  name_of_linked_list  node_number
    Usage2 : pnptr  name_of_linked_list  node_number  field_name
end
#===================================================================

#===================================================================
define pnptr2
    set var $plist_iter=$arg0
    set var $counter=$arg1
        while ($counter>0)
            set var $plist_iter=$plist_iter->$arg1
            set var $counter=$counter-1
        end

    if $argc==3
        print $plist_iter
    else
        if $argc=4
            print $plist_iter->$arg2
        end
    end
end
document pnptr2
    prints the node pointer in a linked list (node should have next field)
    Usage1 : pnptr2  name_of_linked_list  name_of_next_pointer_field  node_number
    Usage2 : pnptr2  name_of_linked_list  name_of_next_pointer_field  node_number  field_name
end
#===================================================================

#===================================================================
define store
    if( $argc!=1)
        help store
    else
        set var $val=(void*)$arg0
        shell echo $val >> gdbstore
    end
end
document store
    Stores values in a file named gdbstore
    Usage : store variable
end
#===================================================================

#===================================================================
define multiwatch
    set var $counter=0
    set var $address=(int*)$arg0
    if $argc!=2
        help multiwatch
    else
        while ($counter<$arg1)

            watch * $address
            set var $counter=$counter+1
            set var $address=$address+1
        end
    end
end
document multiwatch
    Watches multiple chunks(sizeof(int))
    Usage : multiwatch start_address chunk_count
end
#===================================================================

#===================================================================
define pu1
    if( $argc!=1)
        help puni
    else
        x /hs $arg0._M_data()
    end
end
document pu1
    prints fl::ustring, supply the fl::ustring object as the argument
end
#===================================================================

# Define a "pu2" command to display PRUnichar * strings (100 chars max)
# Also allows an optional argument for how many chars to print as long as
# it's less than 100.
define unicode-print
  set $uni = $arg0
  if $argc == 2
    set $limit = $arg1
    if $limit > 100
      set $limit = 100
    end
  else
    set $limit = 100
  end
  # scratch array with space for 100 chars plus null terminator.  Make
  # sure to not use ' ' as the char so this copy/pastes well.
  set $scratch = "____________________________________________________________________________________________________"
  set $i = 0
  set $scratch_idx = 0
  while (*$uni && $i++ < $limit)
    if (*$uni < 0x80)
      set $scratch[$scratch_idx++] = *(char*)$uni++
    else
      if ($scratch_idx > 0)
        set $scratch[$scratch_idx] = '\0'
        print $scratch
        set $scratch_idx = 0
      end
      print /x *(short*)$uni++
    end
  end
  if ($scratch_idx > 0)
    set $scratch[$scratch_idx] = '\0'
    print $scratch
  end
end
document unicode-print
    prints fl::ustring, as argument supply the raw pointer you get from str.c_str()
    usage unicode-print str.c_str()
end
#===================================================================

#===================================================================
define cls
    set var $counter=15
    while ($counter>0)
        printf "\n"
        set var $counter = $counter-1
    end
end
document cls
    clears the screen
end
#===================================================================

#===================================================================
define ctf
   skip disable 1 2
   | continue-till-fcn $arg0 | /home/jbarik/.config/gdb/swallow-inputs
   skip enable 1 2
end
define ctf1
   skip disable 1 2
   continue-till-fcn $arg0
   skip enable 1 2
end
define ctf2
   continue-till-fcn2 $arg0
end
document ctf
   Continue till we hit the given function name(case insesitive partial name)
end
#===================================================================

#===================================================================
define ctl
   | continue-till-line $arg0 | /home/jbarik/.config/gdb/swallow-inputs
end
document ctl
   Continue till we hit the given line in the same fcn
end
#===================================================================

#===================================================================
define rs
   skip disable 1 2
   | real-step | /home/jbarik/.config/gdb/swallow-inputs
   skip enable 1 2
end
document rs
   Real step - keep stepping till we reach a mathworks(not 3rd party) function
end
#===================================================================

#===================================================================
define pp
   print-with-partial-name $arg0
end
document pp
   Given a string print the symbol containing that string in the context of
   the current function. It doesn't match arguments.
end
#===================================================================

#===================================================================
define pclib
   PrintCurrentLibName
end
document pclib
   Prints the current frame's library name
end
#===================================================================

#===================================================================
define hook-next
    cache-next-line-address
end

define cont-to-cached-addr
    tbreak *$cached_address
    c
end
define go-2-cached-addr
    cont-to-cached-addr
end
define return-2-cached-addr
    cont-to-cached-addr
end
#===================================================================

#===================================================================
define help-print
    echo "Bypass pretty printers: p /r var"
end
#===================================================================
