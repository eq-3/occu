#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]

set PROFILES_MAP(0)   "\${expert}"
set PROFILES_MAP(1)   "\${closeWindow}"
set PROFILES_MAP(2)   "\${openWindow}"
set PROFILES_MAP(3)   "\${toggleWindowA}"
set PROFILES_MAP(4)   "\${automaticWindow}"
set PROFILES_MAP(5)   "\${stopWindow}"
set PROFILES_MAP(6)   "\${windowAiring}"
set PROFILES_MAP(7)   "\${windowAiringTime}"
set PROFILES_MAP(8)   "\${windowPosition}"
set PROFILES_MAP(9)   "\${windowNaturalAiring}"
set PROFILES_MAP(10) 	"\${no_action}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION) "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)  "Expertenprofil"

# hier folgen die verschiedenen Profile
set PROFILE_1(SHORT_CT_RAMPOFF)     1
set PROFILE_1(SHORT_CT_RAMPON)      1
set PROFILE_1(SHORT_CT_OFFDELAY)    2
set PROFILE_1(SHORT_CT_ONDELAY)     1
set PROFILE_1(SHORT_CT_OFF)         2
set PROFILE_1(SHORT_CT_ON)          2
set PROFILE_1(SHORT_COND_VALUE_LO)  50
set PROFILE_1(SHORT_COND_VALUE_HI)  100
set PROFILE_1(SHORT_ON_TIME)        111600
set PROFILE_1(SHORT_OFF_TIME)       111600
set PROFILE_1(SHORT_ONDELAY_TIME)   0
set PROFILE_1(SHORT_OFFDELAY_TIME)  0
set PROFILE_1(SHORT_ON_TIME_MODE)   0
set PROFILE_1(SHORT_OFF_TIME_MODE)  0
set PROFILE_1(SHORT_MULTIEXECUTE)   0
set PROFILE_1(SHORT_ACTION_TYPE)    1
set PROFILE_1(SHORT_JT_OFF)         6
set PROFILE_1(SHORT_JT_ON)          4
set PROFILE_1(SHORT_JT_OFFDELAY)    5
set PROFILE_1(SHORT_JT_ONDELAY)     0
set PROFILE_1(SHORT_JT_RAMPOFF)     3
set PROFILE_1(SHORT_JT_RAMPON)      2
set PROFILE_1(SHORT_ON_LEVEL)       {1.0 range 0.0 - 1.0}
set PROFILE_1(UI_DESCRIPTION) ""
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

set PROFILE_2(SHORT_CT_RAMPOFF)     2
set PROFILE_2(SHORT_CT_RAMPON)      1
set PROFILE_2(SHORT_CT_OFFDELAY)    2
set PROFILE_2(SHORT_CT_ONDELAY)     1
set PROFILE_2(SHORT_CT_OFF)         2
set PROFILE_2(SHORT_CT_ON)          1
set PROFILE_2(SHORT_COND_VALUE_LO)  50
set PROFILE_2(SHORT_COND_VALUE_HI)  100
set PROFILE_2(SHORT_ON_TIME)        111600
set PROFILE_2(SHORT_OFF_TIME)       111600
set PROFILE_2(SHORT_ONDELAY_TIME)   0
set PROFILE_2(SHORT_OFFDELAY_TIME)  0
set PROFILE_2(SHORT_ON_TIME_MODE)   0
set PROFILE_2(SHORT_OFF_TIME_MODE)  0
set PROFILE_2(SHORT_MULTIEXECUTE)   0
set PROFILE_2(SHORT_ACTION_TYPE)    1
set PROFILE_2(SHORT_JT_OFF)         1
set PROFILE_2(SHORT_JT_ON)          2
set PROFILE_2(SHORT_JT_OFFDELAY)    3
set PROFILE_2(SHORT_JT_ONDELAY)     2
set PROFILE_2(SHORT_JT_RAMPOFF)     3
set PROFILE_2(SHORT_JT_RAMPON)      3
set PROFILE_2(SHORT_ON_LEVEL)       {1.0 range 0.0 - 1.0}
set PROFILE_2(UI_DESCRIPTION) ""
set PROFILE_2(UI_TEMPLATE)    $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2

set PROFILE_3(SHORT_CT_RAMPOFF)     0
set PROFILE_3(SHORT_CT_RAMPON)      2
set PROFILE_3(SHORT_CT_OFFDELAY)    0
set PROFILE_3(SHORT_CT_ONDELAY)     2
set PROFILE_3(SHORT_CT_OFF)         0
set PROFILE_3(SHORT_CT_ON)          2
set PROFILE_3(SHORT_COND_VALUE_LO)  50
set PROFILE_3(SHORT_COND_VALUE_HI)  {100 range 100 - 200}
set PROFILE_3(SHORT_ON_TIME)        111600
set PROFILE_3(SHORT_OFF_TIME)       111600
set PROFILE_3(SHORT_ONDELAY_TIME)   0
set PROFILE_3(SHORT_OFFDELAY_TIME)  0
set PROFILE_3(SHORT_ON_TIME_MODE)   0
set PROFILE_3(SHORT_OFF_TIME_MODE)  0
set PROFILE_3(SHORT_MULTIEXECUTE)   {0 1}
set PROFILE_3(SHORT_ACTION_TYPE)    1
set PROFILE_3(SHORT_JT_OFF)         1
set PROFILE_3(SHORT_JT_ON)          4
set PROFILE_3(SHORT_JT_OFFDELAY)    2
set PROFILE_3(SHORT_JT_ONDELAY)     4
set PROFILE_3(SHORT_JT_RAMPOFF)     2
set PROFILE_3(SHORT_JT_RAMPON)      4
set PROFILE_3(SHORT_ON_LEVEL)       {1.0 range 0.0 - 1.0}
set PROFILE_3(UI_DESCRIPTION) ""
set PROFILE_3(UI_TEMPLATE)    $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3

set PROFILE_4(SHORT_CT_RAMPOFF)     1
set PROFILE_4(SHORT_CT_RAMPON)      1
set PROFILE_4(SHORT_CT_OFFDELAY)    1
set PROFILE_4(SHORT_CT_ONDELAY)     1
set PROFILE_4(SHORT_CT_OFF)         1
set PROFILE_4(SHORT_CT_ON)          1
set PROFILE_4(SHORT_COND_VALUE_LO)  0
set PROFILE_4(SHORT_COND_VALUE_HI)  0
set PROFILE_4(SHORT_ON_TIME)        10
set PROFILE_4(SHORT_OFF_TIME)       111600
set PROFILE_4(SHORT_ONDELAY_TIME)   0
set PROFILE_4(SHORT_OFFDELAY_TIME)  0
set PROFILE_4(SHORT_ON_TIME_MODE)   0
set PROFILE_4(SHORT_OFF_TIME_MODE)  0
set PROFILE_4(SHORT_MULTIEXECUTE)   0
set PROFILE_4(SHORT_ACTION_TYPE)    1
set PROFILE_4(SHORT_JT_OFF)         2
set PROFILE_4(SHORT_JT_ON)          2
set PROFILE_4(SHORT_JT_OFFDELAY)    2
set PROFILE_4(SHORT_JT_ONDELAY)     2
set PROFILE_4(SHORT_JT_RAMPOFF)     2
set PROFILE_4(SHORT_JT_RAMPON)      2
set PROFILE_4(SHORT_ON_LEVEL)       {1.0 range 0.0 - 1.0}
set PROFILE_4(UI_DESCRIPTION) ""
set PROFILE_4(UI_TEMPLATE)    $PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)  4

set PROFILE_5(SHORT_CT_RAMPOFF)     0
set PROFILE_5(SHORT_CT_RAMPON)      0
set PROFILE_5(SHORT_CT_OFFDELAY)    2
set PROFILE_5(SHORT_CT_ONDELAY)     1
set PROFILE_5(SHORT_CT_OFF)         2
set PROFILE_5(SHORT_CT_ON)          1
set PROFILE_5(SHORT_COND_VALUE_LO)  0
set PROFILE_5(SHORT_COND_VALUE_HI)  0
set PROFILE_5(SHORT_ON_TIME)        111600
set PROFILE_5(SHORT_OFF_TIME)       111600
set PROFILE_5(SHORT_ONDELAY_TIME)   0
set PROFILE_5(SHORT_OFFDELAY_TIME)  0
set PROFILE_5(SHORT_ON_TIME_MODE)   0
set PROFILE_5(SHORT_OFF_TIME_MODE)  0
set PROFILE_6(SHORT_MULTIEXECUTE)   0
set PROFILE_5(SHORT_ACTION_TYPE)    1
set PROFILE_5(SHORT_JT_OFF)         0
set PROFILE_5(SHORT_JT_ON)          0
set PROFILE_5(SHORT_JT_OFFDELAY)    0
set PROFILE_5(SHORT_JT_ONDELAY)     0
set PROFILE_5(SHORT_JT_RAMPOFF)     6
set PROFILE_5(SHORT_JT_RAMPON)      3
set PROFILE_5(SHORT_ON_LEVEL)       1.0
set PROFILE_5(UI_DESCRIPTION) ""
set PROFILE_5(UI_TEMPLATE)    $PROFILE_5(UI_DESCRIPTION)
set PROFILE_5(UI_HINT)  5

set PROFILE_6(SHORT_CT_RAMPOFF)     3
set PROFILE_6(SHORT_CT_RAMPON)      1
set PROFILE_6(SHORT_CT_OFFDELAY)    3
set PROFILE_6(SHORT_CT_ONDELAY)     3
set PROFILE_6(SHORT_CT_OFF)         3
set PROFILE_6(SHORT_CT_ON)          3
set PROFILE_6(SHORT_COND_VALUE_LO)  50
set PROFILE_6(SHORT_COND_VALUE_HI)  100
set PROFILE_6(SHORT_ON_TIME)        111600
set PROFILE_6(SHORT_OFF_TIME)       111600
set PROFILE_6(SHORT_ONDELAY_TIME)   0
set PROFILE_6(SHORT_OFFDELAY_TIME)  0
set PROFILE_6(SHORT_ON_TIME_MODE)   0
set PROFILE_6(SHORT_OFF_TIME_MODE)  0
set PROFILE_6(SHORT_MULTIEXECUTE)   0
set PROFILE_6(SHORT_ACTION_TYPE)    1
set PROFILE_6(SHORT_JT_OFF)         1
set PROFILE_6(SHORT_JT_ON)          2
set PROFILE_6(SHORT_JT_OFFDELAY)    3
set PROFILE_6(SHORT_JT_ONDELAY)     2
set PROFILE_6(SHORT_JT_RAMPOFF)     6
set PROFILE_6(SHORT_JT_RAMPON)      3
set PROFILE_6(SHORT_ON_LEVEL)       {0.5 range 0.0 - 1.0}
set PROFILE_6(UI_DESCRIPTION) ""
set PROFILE_6(UI_TEMPLATE)    $PROFILE_6(UI_DESCRIPTION)
set PROFILE_6(UI_HINT)  6

set PROFILE_7(SHORT_CT_RAMPOFF)     3
set PROFILE_7(SHORT_CT_RAMPON)      1
set PROFILE_7(SHORT_CT_OFFDELAY)    3
set PROFILE_7(SHORT_CT_ONDELAY)     3
set PROFILE_7(SHORT_CT_OFF)         3
set PROFILE_7(SHORT_CT_ON)          3
set PROFILE_7(SHORT_COND_VALUE_LO)  50
set PROFILE_7(SHORT_COND_VALUE_HI)  100
set PROFILE_7(SHORT_ON_TIME)        1800
set PROFILE_7(SHORT_OFF_TIME)       111600
set PROFILE_7(SHORT_ONDELAY_TIME)   0
set PROFILE_7(SHORT_OFFDELAY_TIME)  0
set PROFILE_7(SHORT_ON_TIME_MODE)   0
set PROFILE_7(SHORT_OFF_TIME_MODE)  0
set PROFILE_7(SHORT_MULTIEXECUTE)   0
set PROFILE_7(SHORT_ACTION_TYPE)    1
set PROFILE_7(SHORT_JT_OFF)         1
set PROFILE_7(SHORT_JT_ON)          2
set PROFILE_7(SHORT_JT_OFFDELAY)    3
set PROFILE_7(SHORT_JT_ONDELAY)     2
set PROFILE_7(SHORT_JT_RAMPOFF)     6
set PROFILE_7(SHORT_JT_RAMPON)      3
set PROFILE_7(SHORT_ON_LEVEL)       {1.0 range 0.0 - 1.0}
set PROFILE_7(UI_DESCRIPTION) ""
set PROFILE_7(UI_TEMPLATE)    $PROFILE_7(UI_DESCRIPTION)
set PROFILE_7(UI_HINT)  7

set PROFILE_8(SHORT_CT_RAMPOFF)     3
set PROFILE_8(SHORT_CT_RAMPON)      1
set PROFILE_8(SHORT_CT_OFFDELAY)    3
set PROFILE_8(SHORT_CT_ONDELAY)     3
set PROFILE_8(SHORT_CT_OFF)         3
set PROFILE_8(SHORT_CT_ON)          3
set PROFILE_8(SHORT_COND_VALUE_LO)  50
set PROFILE_8(SHORT_COND_VALUE_HI)  100
set PROFILE_8(SHORT_ON_TIME)        111600
set PROFILE_8(SHORT_OFF_TIME)       111600
set PROFILE_8(SHORT_ONDELAY_TIME)   0
set PROFILE_8(SHORT_OFFDELAY_TIME)  0
set PROFILE_8(SHORT_ON_TIME_MODE)   0
set PROFILE_8(SHORT_OFF_TIME_MODE)  0
set PROFILE_8(SHORT_MULTIEXECUTE)   0
set PROFILE_8(SHORT_ACTION_TYPE)    1
set PROFILE_8(SHORT_JT_OFF)         1
set PROFILE_8(SHORT_JT_ON)          2
set PROFILE_8(SHORT_JT_OFFDELAY)    3
set PROFILE_8(SHORT_JT_ONDELAY)     2
set PROFILE_8(SHORT_JT_RAMPOFF)     6
set PROFILE_8(SHORT_JT_RAMPON)      3
set PROFILE_8(SHORT_ON_LEVEL)       {1.0 range 0 - 1.0}
set PROFILE_8(UI_DESCRIPTION) ""
set PROFILE_8(UI_TEMPLATE)    $PROFILE_8(UI_DESCRIPTION)
set PROFILE_8(UI_HINT)  8

set PROFILE_9(SHORT_CT_RAMPOFF)     3
set PROFILE_9(SHORT_CT_RAMPON)      1
set PROFILE_9(SHORT_CT_OFFDELAY)    3
set PROFILE_9(SHORT_CT_ONDELAY)     3
set PROFILE_9(SHORT_CT_OFF)         3
set PROFILE_9(SHORT_CT_ON)          3
set PROFILE_9(SHORT_COND_VALUE_LO)  50
set PROFILE_9(SHORT_COND_VALUE_HI)  100
set PROFILE_9(SHORT_ON_TIME)        111600
set PROFILE_9(SHORT_OFF_TIME)       111600
set PROFILE_9(SHORT_ONDELAY_TIME)   0
set PROFILE_9(SHORT_OFFDELAY_TIME)  0
set PROFILE_9(SHORT_ON_TIME_MODE)   0
set PROFILE_9(SHORT_OFF_TIME_MODE)  0
set PROFILE_9(SHORT_MULTIEXECUTE)   0
set PROFILE_9(SHORT_ACTION_TYPE)    1
set PROFILE_9(SHORT_JT_OFF)         1
set PROFILE_9(SHORT_JT_ON)          2
set PROFILE_9(SHORT_JT_OFFDELAY)    3
set PROFILE_9(SHORT_JT_ONDELAY)     2
set PROFILE_9(SHORT_JT_RAMPOFF)     6
set PROFILE_9(SHORT_JT_RAMPON)      3
set PROFILE_9(SHORT_ON_LEVEL)       {0.5 range 0.0 - 1.0}
set PROFILE_9(UI_DESCRIPTION) ""
set PROFILE_9(UI_TEMPLATE)    $PROFILE_9(UI_DESCRIPTION)
set PROFILE_9(UI_HINT)  9

set PROFILE_10(SHORT_ACTION_TYPE)    0
set PROFILE_10(UI_DESCRIPTION) ""
set PROFILE_10(UI_TEMPLATE)    $PROFILE_10(UI_DESCRIPTION)
set PROFILE_10(UI_HINT)  10

# hier folgen die eventuellen Subsets

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global dev_descr_sender dev_descr_receiver  
  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps      
  upvar $pps_descr    ps_descr
  
  foreach pro [array names PROFILES_MAP] {
    upvar PROFILE_$pro PROFILE_$pro
  }
      
  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]
  
  #global SUBSETS
  set name "x"
  set i 1
  while {$name != ""} {
    upvar SUBSET_$i SUBSET_$i
    array set subset [array get SUBSET_$i]
    set name ""
    catch {set name $subset(NAME)}
    array_clear subset
    incr i
  }
# feststellen, ob der Aktorkanal aktiv ist
  global url receiver_address 
  array set dev_descr [xmlrpc $url getParamset [list string $receiver_address] MASTER]
  set actor_off_hint ""
  set channel [lindex [split $address  ":"] 1]
  catch {
    if {$channel > 99} {
      if {[format {%5.3f} $dev_descr(LOGIC_COMBINATION)] == 0}  {
        set actor_off_hint "<div class=\"attention\">\${actor_nonactive}&nbsp;$receiver_address!</div>"
      } 
    }
  }
# die Texte der Platzhalter einlesen - VIRTUAL_DIMMER = DIMMER
#	die Texte der Platzhalter einlesen
	puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
  set prn 0
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

#1
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_TIME}</td><td>"
  option DELAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFFDELAY_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#2  
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
  option DELAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME  separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ONDELAY_TIME  "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${WINDOW_OPEN_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
  option DELAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME  separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ONDELAY_TIME  "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 3
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_TIME}</td><td>"
  option DELAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME  separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_OFFDELAY_TIME  "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFFDELAY_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#4
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  append HTML_PARAMS(separate_$prn) "<tr><td>\${WINDOW_OPEN_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#5
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

#6
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
  option DELAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME  separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ONDELAY_TIME  "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option WINDOW_OPEN_LEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL  separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ON_LEVEL ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#7
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  append HTML_PARAMS(separate_$prn) "<tr><td>\${WINDOW_OPEN_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
  option DELAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME  separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ONDELAY_TIME  "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  # incr pref ;# 3
  # append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  # option WINDOW_OPEN_LEVEL
  # append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL  separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ON_LEVEL ]
  # append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#8
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
  option DELAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME  separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ONDELAY_TIME  "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option WINDOW_OPEN_LEVEL_FREEVAL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL  separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ON_LEVEL  "onchange=\"ActivateFreePercent(\$('${special_input_id}_profiles'),$pref);\""]
  append HTML_PARAMs(separate_$prn) "<script type=\"text/javascript\">ActivateFreePercent(\$('${special_input_id}_profiles'),$pref);</script>"
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#9
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  append HTML_PARAMS(separate_$prn) "<tr><td>\${WINDOW_OPEN_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
  option DELAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME  separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ONDELAY_TIME  "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  incr pref ;# 3
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option WINDOW_OPEN_LEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL  separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ON_LEVEL ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#10
	incr prn
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "</textarea></div>"
}
constructor
