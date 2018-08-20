#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1) "\${switch_open_close}"
set PROFILES_MAP(2)  "\${switch_open}"
set PROFILES_MAP(3)  "\${switch_close}"
set PROFILES_MAP(4)  "\${switch_partialOpen}"

set NOP 0
set RAMP_ON 1
set ON 2
set RAMP_OFF 3
set PARTIAL_OPEN 4


set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)    "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)      "Expertenprofil"


set PROFILE_1(SHORT_COND_VALUE_HI) {200 range 0 - 255}
set PROFILE_1(SHORT_COND_VALUE_LO) {0 range 0 - 255}
set PROFILE_1(SHORT_CT_OFF) {0 1 4}
set PROFILE_1(SHORT_CT_ON) {0 1 4}
set PROFILE_1(SHORT_CT_RAMPOFF) {0 1 4}
set PROFILE_1(SHORT_CT_RAMPON) {0 1 4}
set PROFILE_1(SHORT_JT_OFF) $RAMP_ON
set PROFILE_1(SHORT_JT_ON) $RAMP_OFF
set PROFILE_1(SHORT_JT_RAMPOFF) $ON
set PROFILE_1(SHORT_JT_RAMPON) $ON
set PROFILE_1(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_1(UI_DESCRIPTION)  ""
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

set PROFILE_2(SHORT_COND_VALUE_HI) {200 range 0 - 255}
set PROFILE_2(SHORT_COND_VALUE_LO) {0 range 0 - 255}
set PROFILE_2(SHORT_CT_OFF) {0 1 4}
set PROFILE_2(SHORT_CT_ON) {0 1 4}
set PROFILE_2(SHORT_CT_RAMPOFF) {0 1 4}
set PROFILE_2(SHORT_CT_RAMPON) {0 1 4}
set PROFILE_2(SHORT_JT_OFF) $RAMP_ON
set PROFILE_2(SHORT_JT_ON) $RAMP_ON
set PROFILE_2(SHORT_JT_RAMPOFF) $RAMP_ON
set PROFILE_2(SHORT_JT_RAMPON) $RAMP_ON
set PROFILE_2(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_2(UI_DESCRIPTION)  ""
set PROFILE_2(UI_TEMPLATE)    $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2

set PROFILE_3(SHORT_COND_VALUE_HI) {200 range 0 - 255}
set PROFILE_3(SHORT_COND_VALUE_LO) {0 range 0 - 255}
set PROFILE_3(SHORT_CT_OFF) {0 1 4}
set PROFILE_3(SHORT_CT_ON) {0 1 4}
set PROFILE_3(SHORT_CT_RAMPOFF) {0 1 4}
set PROFILE_3(SHORT_CT_RAMPON) {0 1 4}
set PROFILE_3(SHORT_JT_OFF) $RAMP_OFF
set PROFILE_3(SHORT_JT_ON) $RAMP_OFF
set PROFILE_3(SHORT_JT_RAMPOFF) $RAMP_OFF
set PROFILE_3(SHORT_JT_RAMPON) $RAMP_OFF
set PROFILE_3(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_3(UI_DESCRIPTION)  ""
set PROFILE_3(UI_TEMPLATE)    $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3

set PROFILE_4(SHORT_COND_VALUE_HI) {200 range 0 - 255}
set PROFILE_4(SHORT_COND_VALUE_LO) {0 range 0 - 255}
set PROFILE_4(SHORT_CT_OFF) {0 1 4}
set PROFILE_4(SHORT_CT_ON) {0 1 4}
set PROFILE_4(SHORT_CT_RAMPOFF) {0 1 4}
set PROFILE_4(SHORT_CT_RAMPON) {0 1 4}
set PROFILE_4(SHORT_JT_OFF) $PARTIAL_OPEN
set PROFILE_4(SHORT_JT_ON) $PARTIAL_OPEN
set PROFILE_4(SHORT_JT_RAMPOFF) $PARTIAL_OPEN
set PROFILE_4(SHORT_JT_RAMPON) $PARTIAL_OPEN
set PROFILE_4(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_4(UI_DESCRIPTION)  ""
set PROFILE_4(UI_TEMPLATE)    $PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)  4

#set SUBSET_1(NAME)          "Unterer Grenzwert unterschritten / Oberer Grenzwert &uuml;berschritten"
set SUBSET_1(NAME)          "\${subset_1}"
set SUBSET_1(SUBSET_OPTION_VALUE)  1
set SUBSET_1(SHORT_CT_OFF)      0
set SUBSET_1(SHORT_CT_ON)       0
set SUBSET_1(SHORT_CT_RAMPON)   0
set SUBSET_1(SHORT_CT_RAMPOFF)  0

#set SUBSET_2(NAME)          "Oberer Grenzwert &uuml;berschritten"
set SUBSET_2(NAME)          "\${subset_2}"
set SUBSET_2(SUBSET_OPTION_VALUE)  2
set SUBSET_2(SHORT_CT_OFF)      1
set SUBSET_2(SHORT_CT_ON)       1
set SUBSET_2(SHORT_CT_RAMPON)   1
set SUBSET_2(SHORT_CT_RAMPOFF)  1

#set SUBSET_3(NAME)          "Unterer Grenzwert unterschritten"
set SUBSET_3(NAME)          "\${subset_3}"
set SUBSET_3(SUBSET_OPTION_VALUE)  3
set SUBSET_3(SHORT_CT_OFF)      4
set SUBSET_3(SHORT_CT_ON)       4
set SUBSET_3(SHORT_CT_RAMPON)   4
set SUBSET_3(SHORT_CT_RAMPOFF)  4

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global iface_url receiver_address dev_descr_sender dev_descr_receiver
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

  # Set SHORT_COND_VALUE_HI/LO to the value of the configuration parameters COND_TX_DECISION_ABOVE/BELOW
  array set sender_descrMaster [xmlrpc $iface_url($iface) getParamset [list string $dev_descr_sender(ADDRESS)] MASTER]
  set condTXDecisionAbove $sender_descrMaster(COND_TX_DECISION_ABOVE)
  set condTXDecisionBelow $sender_descrMaster(COND_TX_DECISION_BELOW)
  set decisionValues "
   {SHORT_COND_VALUE_HI {int $condTXDecisionAbove}}
   {SHORT_COND_VALUE_LO {int $condTXDecisionBelow}}"
  puts "[xmlrpc $iface_url($iface) putParamset [list string $address] [list string $dev_descr_sender(ADDRESS)] [list struct $decisionValues]]"
  set ps(SHORT_COND_VALUE_HI) $condTXDecisionAbove
  set ps(SHORT_COND_VALUE_LO) $condTXDecisionBelow


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
  append HTML_PARAMS(separate_$prn) "\${helpDecisionValAndThreshold}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${SENDER_CHANNEL_SETTINGS}</td>"
  append HTML_PARAMS(separate_$prn) "<td><input type=\"button\" value=\${btnEdit} onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$dev_descr_sender(ADDRESS)', 'redirect_url': 'IC_SETPROFILES'});\" ></td>"
  append HTML_PARAMS(separate_$prn)) "</tr>"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DECISION_VALUE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2 SUBSET_3} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  set scvl SHORT_COND_VALUE_LO
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\" ><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvl\" value=\"$condTXDecisionBelow\"/></tr></td>"

  set scvh SHORT_COND_VALUE_HI
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvh\" value=\"$condTXDecisionAbove\"/></tr></td>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"



#2
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "\${helpDecisionValAndThreshold}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${SENDER_CHANNEL_SETTINGS}</td>"
  append HTML_PARAMS(separate_$prn) "<td><input type=\"button\" value=\${btnEdit} onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$dev_descr_sender(ADDRESS)', 'redirect_url': 'IC_SETPROFILES'});\" ></td>"
  append HTML_PARAMS(separate_$prn)) "</tr>"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DECISION_VALUE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2 SUBSET_3} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  set scvl SHORT_COND_VALUE_LO
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\" ><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvl\" value=\"$condTXDecisionBelow\"/></tr></td>"

  set scvh SHORT_COND_VALUE_HI
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvh\" value=\"$condTXDecisionAbove\"/></tr></td>"


  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "\${helpDecisionValAndThreshold}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${SENDER_CHANNEL_SETTINGS}</td>"
  append HTML_PARAMS(separate_$prn) "<td><input type=\"button\" value=\${btnEdit} onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$dev_descr_sender(ADDRESS)', 'redirect_url': 'IC_SETPROFILES'});\" ></td>"
  append HTML_PARAMS(separate_$prn)) "</tr>"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DECISION_VALUE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2 SUBSET_3} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  set scvl SHORT_COND_VALUE_LO
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\" ><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvl\" value=\"$condTXDecisionBelow\"/></tr></td>"

  set scvh SHORT_COND_VALUE_HI
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvh\" value=\"$condTXDecisionAbove\"/></tr></td>"


  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#4
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "\${helpDecisionValAndThreshold}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${SENDER_CHANNEL_SETTINGS}</td>"
  append HTML_PARAMS(separate_$prn) "<td><input type=\"button\" value=\${btnEdit} onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$dev_descr_sender(ADDRESS)', 'redirect_url': 'IC_SETPROFILES'});\" ></td>"
  append HTML_PARAMS(separate_$prn)) "</tr>"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DECISION_VALUE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2 SUBSET_3} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  set scvl SHORT_COND_VALUE_LO
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\" ><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvl\" value=\"$condTXDecisionBelow\"/></tr></td>"

  set scvh SHORT_COND_VALUE_HI
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvh\" value=\"$condTXDecisionAbove\"/></tr></td>"


  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}

constructor

