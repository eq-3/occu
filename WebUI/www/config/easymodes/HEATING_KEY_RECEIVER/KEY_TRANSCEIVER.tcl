#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${switch_temp}"
set PROFILES_MAP(2)  "\${switch_auto}"
set PROFILES_MAP(3)  "\${switch_manu}"
set PROFILES_MAP(4)  "\${switch_off}"
set PROFILES_MAP(5)  "\${switch_on}"
set PROFILES_MAP(6)  "\${boost_on_off}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)    "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)      "Expertenprofil"

set PROFILE_1(LONG_CONTROL_MODE_RC) 0
set PROFILE_1(LONG_DELTA_TEMPERATURE) 0.000000
set PROFILE_1(LONG_ON_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(LONG_ON_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(LONG_TEMPERATURE_RC) {17.0 range 5.0 - 30.0}
set PROFILE_1(SHORT_CONTROL_MODE_RC) 6
set PROFILE_1(SHORT_DELTA_TEMPERATURE) 0.000000
set PROFILE_1(SHORT_ON_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(SHORT_ON_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(SHORT_TEMPERATURE_RC) {17.0 range 5.0 - 30.0}
set PROFILE_1(UI_DESCRIPTION)  ""
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

set PROFILE_2(LONG_CONTROL_MODE_RC) 1
set PROFILE_2(LONG_DELTA_TEMPERATURE) 0.000000
set PROFILE_2(LONG_ON_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(LONG_ON_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(LONG_TEMPERATURE_RC) {17.0 range 5.0 - 30.0}
set PROFILE_2(SHORT_CONTROL_MODE_RC) 1
set PROFILE_2(SHORT_DELTA_TEMPERATURE) 0.000000
set PROFILE_2(SHORT_ON_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(SHORT_ON_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(SHORT_TEMPERATURE_RC) {17.0 range 5.0 - 30.0}
set PROFILE_2(UI_DESCRIPTION)  ""
set PROFILE_2(UI_TEMPLATE)    $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2

set PROFILE_3(LONG_CONTROL_MODE_RC) 4
set PROFILE_3(LONG_DELTA_TEMPERATURE) 0.000000
set PROFILE_3(LONG_ON_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(LONG_ON_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(LONG_TEMPERATURE_RC) {17.0 range 5.0 - 30.0}
set PROFILE_3(SHORT_CONTROL_MODE_RC) 4
set PROFILE_3(SHORT_DELTA_TEMPERATURE) 0.000000
set PROFILE_3(SHORT_ON_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_ON_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(SHORT_TEMPERATURE_RC) {17.0 range 5.0 - 30.0}
set PROFILE_3(UI_DESCRIPTION)  ""
set PROFILE_3(UI_TEMPLATE)    $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3

set PROFILE_4(LONG_CONTROL_MODE_RC) 10
set PROFILE_4(LONG_DELTA_TEMPERATURE) 0.000000
set PROFILE_4(LONG_ON_TIME_BASE) {0 range 0 - 7}
set PROFILE_4(LONG_ON_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_4(LONG_TEMPERATURE_RC) {17.0 range 5.0 - 30.0}
set PROFILE_4(SHORT_CONTROL_MODE_RC) 10
set PROFILE_4(SHORT_DELTA_TEMPERATURE) 0.000000
set PROFILE_4(SHORT_ON_TIME_BASE) {0 range 0 - 7}
set PROFILE_4(SHORT_ON_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_4(SHORT_TEMPERATURE_RC) {17.0 range 5.0 - 30.0}
set PROFILE_4(UI_DESCRIPTION)  ""
set PROFILE_4(UI_TEMPLATE)    $PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)  4

set PROFILE_5(LONG_CONTROL_MODE_RC) 9
set PROFILE_5(LONG_DELTA_TEMPERATURE) 0.000000
set PROFILE_5(LONG_ON_TIME_BASE) {0 range 0 - 7}
set PROFILE_5(LONG_ON_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_5(LONG_TEMPERATURE_RC) {17.0 range 5.0 - 30.0}
set PROFILE_5(SHORT_CONTROL_MODE_RC) 9
set PROFILE_5(SHORT_DELTA_TEMPERATURE) 0.000000
set PROFILE_5(SHORT_ON_TIME_BASE) {0 range 0 - 7}
set PROFILE_5(SHORT_ON_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_5(SHORT_TEMPERATURE_RC) {17.0 range 5.0 - 30.0}
set PROFILE_5(UI_DESCRIPTION)  ""
set PROFILE_5(UI_TEMPLATE)    $PROFILE_5(UI_DESCRIPTION)
set PROFILE_5(UI_HINT)  5

set PROFILE_6(LONG_CONTROL_MODE_RC) 8
set PROFILE_6(LONG_DELTA_TEMPERATURE) 0.000000
set PROFILE_6(LONG_ON_TIME_BASE) {0 range 0 - 7}
set PROFILE_6(LONG_ON_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_6(LONG_TEMPERATURE_RC) {17.0 range 5.0 - 30.0}
set PROFILE_6(SHORT_CONTROL_MODE_RC) 8
set PROFILE_6(SHORT_DELTA_TEMPERATURE) 0.000000
set PROFILE_6(SHORT_ON_TIME_BASE) {0 range 0 - 7}
set PROFILE_6(SHORT_ON_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_6(SHORT_TEMPERATURE_RC) {17.0 range 5.0 - 30.0}
set PROFILE_6(UI_DESCRIPTION)  ""
set PROFILE_6(UI_TEMPLATE)   $PROFILE_6(UI_DESCRIPTION)
set PROFILE_6(UI_HINT)  6


proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  
  global receiver_address dev_descr_sender dev_descr_receiver
  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps      
  upvar $pps_descr    ps_descr
  
  foreach pro [array names PROFILES_MAP] {
    upvar PROFILE_$pro PROFILE_$pro
  }
     
  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]
  
#  die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
  puts "<script type=\"text/javascript\">getLangInfo_Special('HmIP_DEVICES.txt');</script>"

  set prn 0
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

#1
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  # *** SHORT KEYPRESS ***

  set pref 0
  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${TEMPERATURE_RC}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_TEMPERATURE_RC separate_${special_input_id}_$prn\_$pref ps SHORT_TEMPERATURE_RC ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#2
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#4
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#5
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#6
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

}

constructor
