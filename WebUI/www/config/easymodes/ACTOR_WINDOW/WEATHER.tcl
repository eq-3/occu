#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]

set PROFILES_MAP(0)   "\${expert}"
set PROFILES_MAP(1)   "\${closeWindowA}"
set PROFILES_MAP(2)   "\${openWindowA}"
set PROFILES_MAP(3)   "\${openWindowB}"
set PROFILES_MAP(4)   "\${no_action}"


set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION) "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)  "Expertenprofil"

# hier folgen die verschiedenen Profile
set PROFILE_1(SHORT_CT_RAMPOFF)     0
set PROFILE_1(SHORT_CT_RAMPON)      0
set PROFILE_1(SHORT_CT_OFFDELAY)    0
set PROFILE_1(SHORT_CT_ONDELAY)     0
set PROFILE_1(SHORT_CT_OFF)         0
set PROFILE_1(SHORT_CT_ON)          0
set PROFILE_1(SHORT_COND_VALUE_LO)  200
set PROFILE_1(SHORT_COND_VALUE_HI)  100
set PROFILE_1(SHORT_ON_TIME)        111600
set PROFILE_1(SHORT_OFF_TIME)       111600
set PROFILE_1(SHORT_ONDELAY_TIME)   0
set PROFILE_1(SHORT_OFFDELAY_TIME)  0
set PROFILE_1(SHORT_ON_TIME_MODE)   0
set PROFILE_1(SHORT_OFF_TIME_MODE)  0
set PROFILE_1(SHORT_ACTION_TYPE)    1
set PROFILE_1(SHORT_JT_OFF)         5
set PROFILE_1(SHORT_JT_ON)          5
set PROFILE_1(SHORT_JT_OFFDELAY)    5
set PROFILE_1(SHORT_JT_ONDELAY)     5
set PROFILE_1(SHORT_JT_RAMPOFF)     5
set PROFILE_1(SHORT_JT_RAMPON)      5
set PROFILE_1(SHORT_ON_LEVEL)       1.0
set PROFILE_1(UI_DESCRIPTION) ""
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1


set PROFILE_2(SHORT_CT_RAMPOFF)     2
set PROFILE_2(SHORT_CT_RAMPON)      2
set PROFILE_2(SHORT_CT_OFFDELAY)    2
set PROFILE_2(SHORT_CT_ONDELAY)     2
set PROFILE_2(SHORT_CT_OFF)         2
set PROFILE_2(SHORT_CT_ON)          2
set PROFILE_2(SHORT_COND_VALUE_LO)  200
set PROFILE_2(SHORT_COND_VALUE_HI)  100
set PROFILE_2(SHORT_ON_TIME)        111600
set PROFILE_2(SHORT_OFF_TIME)       111600
set PROFILE_2(SHORT_ONDELAY_TIME)   0
set PROFILE_2(SHORT_OFFDELAY_TIME)  0
set PROFILE_2(SHORT_ON_TIME_MODE)   0
set PROFILE_2(SHORT_OFF_TIME_MODE)  0
set PROFILE_2(SHORT_ACTION_TYPE)    1
set PROFILE_2(SHORT_JT_OFF)         1
set PROFILE_2(SHORT_JT_ON)          3
set PROFILE_2(SHORT_JT_OFFDELAY)    3
set PROFILE_2(SHORT_JT_ONDELAY)     1
set PROFILE_2(SHORT_JT_RAMPOFF)     3
set PROFILE_2(SHORT_JT_RAMPON)      3
set PROFILE_2(SHORT_ON_LEVEL)       1.0
set PROFILE_2(UI_DESCRIPTION) ""
set PROFILE_2(UI_TEMPLATE)    $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2

set PROFILE_3(SHORT_CT_RAMPOFF)     0
set PROFILE_3(SHORT_CT_RAMPON)      0
set PROFILE_3(SHORT_CT_OFFDELAY)    0
set PROFILE_3(SHORT_CT_ONDELAY)     0
set PROFILE_3(SHORT_CT_OFF)         0
set PROFILE_3(SHORT_CT_ON)          0
set PROFILE_3(SHORT_COND_VALUE_LO)  200
set PROFILE_3(SHORT_COND_VALUE_HI)  100
set PROFILE_3(SHORT_ON_TIME)        111600
set PROFILE_3(SHORT_OFF_TIME)       111600
set PROFILE_3(SHORT_ONDELAY_TIME)   0
set PROFILE_3(SHORT_OFFDELAY_TIME)  0
set PROFILE_3(SHORT_ON_TIME_MODE)   0
set PROFILE_3(SHORT_OFF_TIME_MODE)  0
set PROFILE_3(SHORT_ACTION_TYPE)    1
set PROFILE_3(SHORT_JT_OFF)         1
set PROFILE_3(SHORT_JT_ON)          2
set PROFILE_3(SHORT_JT_OFFDELAY)    3
set PROFILE_3(SHORT_JT_ONDELAY)     2
set PROFILE_3(SHORT_JT_RAMPOFF)     1
set PROFILE_3(SHORT_JT_RAMPON)      8
set PROFILE_3(SHORT_ON_LEVEL)       1.0
set PROFILE_3(UI_DESCRIPTION) ""
set PROFILE_3(UI_TEMPLATE)    $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3

set PROFILE_4(SHORT_ACTION_TYPE)    0
set PROFILE_4(UI_DESCRIPTION) ""
set PROFILE_4(UI_TEMPLATE)    $PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)  4

proc setWindowClose {} {
  global url receiver_address sender_address

  set command "{SHORT_CT_RAMPOFF {int 0}}
    {SHORT_CT_RAMPON {int 0}}
    {SHORT_CT_OFFDELAY {int 0}}
    {SHORT_CT_ONDELAY {int 0}}
    {SHORT_CT_OFF {int 0}}
    {SHORT_CT_ON {int 0}}

    {SHORT_JT_OFF {int 5}}
    {SHORT_JT_ON {int 5}}
    {SHORT_JT_OFFDELAY {int 5}}
    {SHORT_JT_ONDELAY {int 5}}
    {SHORT_JT_RAMPOFF {int 5}}
    {SHORT_JT_RAMPON {int 5}}"

  puts "[xmlrpc $url putParamset [list string $receiver_address] [list string $sender_address] [list struct $command]]"

  set ps(SHORT_CT_RAMPOFF) 0
  set ps(SHORT_CT_RAMPON) 0
  set ps(SHORT_CT_OFFDELAY) 0
  set ps(SHORT_CT_ONDELAY) 0
  set ps(SHORT_CT_OFF) 0
  set ps(SHORT_CT_ON) 0
  set ps(SHORT_JT_OFF) 5
  set ps(SHORT_JT_ON) 5
  set ps(SHORT_JT_OFFDELAY) 5
  set ps(SHORT_JT_ONDELAY) 5
  set ps(SHORT_JT_RAMPOFF) 5
  set ps(SHORT_JT_RAMPON) 5

}

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

  # setWindowClose

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
  append HTML_PARAMS(separate_$prn) "<tr><td>\${WINDOW_OPEN_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3
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

#4
	incr prn
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "</textarea></div>"

}

constructor
