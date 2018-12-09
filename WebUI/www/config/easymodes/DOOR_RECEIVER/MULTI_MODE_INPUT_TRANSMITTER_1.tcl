#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]

set NOP 0
set OPEN 1
set STOP 2
set CLOSE 3
set PARTIAL_OPEN 4


set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${switch_open_close}"
set PROFILES_MAP(2)  "\${switch_open}"
set PROFILES_MAP(3)  "\${switch_close}"
set PROFILES_MAP(4)  "\${switch_stop}"
set PROFILES_MAP(5)  "\${switch_partialOpen}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)    "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)      "Expertenprofil"

set PROFILE_1(LONG_COND_VALUE_HI) 150
set PROFILE_1(LONG_COND_VALUE_LO) 50
set PROFILE_1(LONG_CT_OFF) 0
set PROFILE_1(LONG_CT_ON) 0
set PROFILE_1(LONG_CT_RAMPOFF) 0
set PROFILE_1(LONG_CT_RAMPON) 0
set PROFILE_1(LONG_JT_OFF) 1
set PROFILE_1(LONG_JT_ON) 3
set PROFILE_1(LONG_JT_RAMPOFF) 2
set PROFILE_1(LONG_JT_RAMPON) 2
set PROFILE_1(LONG_PROFILE_ACTION_TYPE) 1
set PROFILE_1(SHORT_COND_VALUE_HI) 150
set PROFILE_1(SHORT_COND_VALUE_LO) 50
set PROFILE_1(SHORT_CT_OFF) 0
set PROFILE_1(SHORT_CT_ON) 0
set PROFILE_1(SHORT_CT_RAMPOFF) 0
set PROFILE_1(SHORT_CT_RAMPON) 0
set PROFILE_1(SHORT_JT_OFF)     $OPEN
set PROFILE_1(SHORT_JT_ON)      $CLOSE
set PROFILE_1(SHORT_JT_RAMPOFF) $STOP
set PROFILE_1(SHORT_JT_RAMPON)  $STOP
set PROFILE_1(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_1(UI_DESCRIPTION)  ""
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

set PROFILE_2(LONG_COND_VALUE_HI) 150
set PROFILE_2(LONG_COND_VALUE_LO) 50
set PROFILE_2(LONG_CT_OFF) 0
set PROFILE_2(LONG_CT_ON) 0
set PROFILE_2(LONG_CT_RAMPOFF) 0
set PROFILE_2(LONG_CT_RAMPON) 0
set PROFILE_2(LONG_JT_OFF)      $OPEN
set PROFILE_2(LONG_JT_ON)       $OPEN
set PROFILE_2(LONG_JT_RAMPOFF)  $OPEN
set PROFILE_2(LONG_JT_RAMPON)   $OPEN
set PROFILE_2(LONG_PROFILE_ACTION_TYPE) 1
set PROFILE_2(SHORT_COND_VALUE_HI) 150
set PROFILE_2(SHORT_COND_VALUE_LO) 50
set PROFILE_2(SHORT_CT_OFF) 0
set PROFILE_2(SHORT_CT_ON) 0
set PROFILE_2(SHORT_CT_RAMPOFF) 0
set PROFILE_2(SHORT_CT_RAMPON) 0
set PROFILE_2(SHORT_JT_OFF)     $OPEN
set PROFILE_2(SHORT_JT_ON)      $OPEN
set PROFILE_2(SHORT_JT_RAMPOFF) $OPEN
set PROFILE_2(SHORT_JT_RAMPON)  $OPEN
set PROFILE_2(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_2(UI_DESCRIPTION)  ""
set PROFILE_2(UI_TEMPLATE)    $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2

set PROFILE_3(LONG_COND_VALUE_HI) 150
set PROFILE_3(LONG_COND_VALUE_LO) 50
set PROFILE_3(LONG_CT_OFF) 0
set PROFILE_3(LONG_CT_ON) 0
set PROFILE_3(LONG_CT_RAMPOFF) 0
set PROFILE_3(LONG_CT_RAMPON) 0
set PROFILE_3(LONG_JT_OFF)      $CLOSE
set PROFILE_3(LONG_JT_ON)       $CLOSE
set PROFILE_3(LONG_JT_RAMPOFF)  $CLOSE
set PROFILE_3(LONG_JT_RAMPON)   $CLOSE
set PROFILE_3(LONG_PROFILE_ACTION_TYPE) 1
set PROFILE_3(SHORT_COND_VALUE_HI) 150
set PROFILE_3(SHORT_COND_VALUE_LO) 50
set PROFILE_3(SHORT_CT_OFF) 0
set PROFILE_3(SHORT_CT_ON) 0
set PROFILE_3(SHORT_CT_RAMPOFF) 0
set PROFILE_3(SHORT_CT_RAMPON) 0
set PROFILE_3(SHORT_JT_OFF)     $CLOSE
set PROFILE_3(SHORT_JT_ON)      $CLOSE
set PROFILE_3(SHORT_JT_RAMPOFF) $CLOSE
set PROFILE_3(SHORT_JT_RAMPON)  $CLOSE
set PROFILE_3(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_3(UI_DESCRIPTION)  ""
set PROFILE_3(UI_TEMPLATE)    $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3

set PROFILE_4(LONG_COND_VALUE_HI) 150
set PROFILE_4(LONG_COND_VALUE_LO) 50
set PROFILE_4(LONG_CT_OFF) 0
set PROFILE_4(LONG_CT_ON) 0
set PROFILE_4(LONG_CT_RAMPOFF) 0
set PROFILE_4(LONG_CT_RAMPON) 0
set PROFILE_4(LONG_JT_OFF)      $STOP
set PROFILE_4(LONG_JT_ON)       $STOP
set PROFILE_4(LONG_JT_RAMPOFF)  $STOP
set PROFILE_4(LONG_JT_RAMPON)   $STOP
set PROFILE_4(LONG_PROFILE_ACTION_TYPE) 1
set PROFILE_4(SHORT_COND_VALUE_HI) 150
set PROFILE_4(SHORT_COND_VALUE_LO) 50
set PROFILE_4(SHORT_CT_OFF) 0
set PROFILE_4(SHORT_CT_ON) 0
set PROFILE_4(SHORT_CT_RAMPOFF) 0
set PROFILE_4(SHORT_CT_RAMPON) 0
set PROFILE_4(SHORT_JT_OFF)     $STOP
set PROFILE_4(SHORT_JT_ON)      $STOP
set PROFILE_4(SHORT_JT_RAMPOFF) $STOP
set PROFILE_4(SHORT_JT_RAMPON)  $STOP
set PROFILE_4(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_4(UI_DESCRIPTION)  ""
set PROFILE_4(UI_TEMPLATE)    $PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)  4


set PROFILE_5(LONG_COND_VALUE_HI) 150
set PROFILE_5(LONG_COND_VALUE_LO) 50
set PROFILE_5(LONG_CT_OFF) 0
set PROFILE_5(LONG_CT_ON) 0
set PROFILE_5(LONG_CT_RAMPOFF) 0
set PROFILE_5(LONG_CT_RAMPON) 0
set PROFILE_5(LONG_JT_OFF)      $PARTIAL_OPEN
set PROFILE_5(LONG_JT_ON)       $PARTIAL_OPEN
set PROFILE_5(LONG_JT_RAMPOFF)  $PARTIAL_OPEN
set PROFILE_5(LONG_JT_RAMPON)   $PARTIAL_OPEN
set PROFILE_5(LONG_PROFILE_ACTION_TYPE) 1
set PROFILE_5(SHORT_COND_VALUE_HI) 150
set PROFILE_5(SHORT_COND_VALUE_LO) 50
set PROFILE_5(SHORT_CT_OFF) 0
set PROFILE_5(SHORT_CT_ON) 0
set PROFILE_5(SHORT_CT_RAMPOFF) 0
set PROFILE_5(SHORT_CT_RAMPON) 0
set PROFILE_5(SHORT_JT_OFF)     $PARTIAL_OPEN
set PROFILE_5(SHORT_JT_ON)      $PARTIAL_OPEN
set PROFILE_5(SHORT_JT_RAMPOFF) $PARTIAL_OPEN
set PROFILE_5(SHORT_JT_RAMPON)  $PARTIAL_OPEN
set PROFILE_5(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_5(UI_DESCRIPTION)  ""
set PROFILE_5(UI_TEMPLATE)    $PROFILE_5(UI_DESCRIPTION)
set PROFILE_5(UI_HINT)  5

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global iface_url sender_address receiver_address dev_descr_sender dev_descr_receiver
  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps      
  upvar $pps_descr    ps_descr

  set url $iface_url($iface)

  foreach pro [array names PROFILES_MAP] {
    upvar PROFILE_$pro PROFILE_$pro
  }

  set parentType [string tolower $dev_descr_receiver(PARENT_TYPE)]
  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]
  
#  die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">getLangInfo('MULTI_MODE_INPUT_TRANSMITTER_1', '$dev_descr_receiver(TYPE)');</script>"
  # puts "<script type=\"text/javascript\">getLangInfo_Special('HmIP_DEVICES.txt');</script>"

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

}

constructor
