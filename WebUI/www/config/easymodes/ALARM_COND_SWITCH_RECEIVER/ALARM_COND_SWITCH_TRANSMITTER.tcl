#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${switch_on}"


set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)    "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)      "Expertenprofil"

set PROFILE_1(SHORT_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_1(SHORT_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_1(SHORT_SIGNAL_SELECTION_ACOUSTIC) {1 range 0 - 17}
set PROFILE_1(SHORT_SIGNAL_SELECTION_OPTICAL) {4 range 0 - 7}

set PROFILE_1(UI_DESCRIPTION)  ""
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

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

    set pref 0

    # ON_TIME
    append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn alarmTimeMax10Min $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

    incr pref
    set param SHORT_SIGNAL_SELECTION_ACOUSTIC
    #append HTML_PARAMS(separate_$prn) "<tr><td>\${$param}</td><td>"
    append HTML_PARAMS(separate_$prn) "<tr><td>\${acousticalAlarm}</td><td>"
    array_clear options
    set options(0) "\${stringTableAlarmDisableAcousticSignal}"
    set options(1) "\${stringTableAlarmFrequencyRising}"
    set options(2) "\${stringTableAlarmFrequencyFalling}"
    set options(3) "\${stringTableAlarmFrequencyRisingAndFalling}"
    set options(4) "\${stringTableAlarmFrequencyAlternatingLowHigh}"
    set options(5) "\${stringTableAlarmFrequencyAlternatingLowMidHigh}"
    set options(6) "\${stringTableAlarmFrequencyHighOnOff}"
    set options(7) "\${stringTableAlarmFrequencyHighOnLongOff}"
    set options(8) "\${stringTableAlarmFrequencyLowOnOffHighonOff}"
    set options(9) "\${stringTableAlarmFrequencyLowOnLongOffHighOnLongOff}"
    set options(10) "\${stringTableAlarmLowBattery}"
    set options(11) "\${stringTableAlarmDisarmed}"
    set options(12) "\${stringTableAlarmInternallyArmed}"
    set options(13) "\${stringTableAlarmExternallyArmed}"
    set options(14) "\${stringTableAlarmDelayedInternallyArmed}"
    set options(15) "\${stringTableAlarmDelayedExternallyArmed}"
    set options(16) "\${stringTableAlarmEvent}"
    set options(17) "\${stringTableAlarmError}"
    append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param]
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    incr pref
    set param SHORT_SIGNAL_SELECTION_OPTICAL
    #append HTML_PARAMS(separate_$prn) "<tr><td>\${$param}</td><td>"
    append HTML_PARAMS(separate_$prn) "<tr><td>\${opticalAlarm}</td><td>"
    array_clear options
    set options(0) "\${stringTableAlarmDisableOpticalSignal}"
    set options(1) "\${stringTableAlarmBlinkingAlternatelyRepeating}"
    set options(2) "\${stringTableAlarmBlinkingBothRepeating}"
    set options(3) "\${stringTableAlarmDoubleFlashingRepeating}"
    set options(4) "\${stringTableAlarmFlashingBothRepeating}"
    set options(5) "\${stringTableAlarmConfirmingSignal0}"
    set options(6) "\${stringTableAlarmConfirmingSignal1}"
    set options(7) "\${stringTableAlarmConfirmingSignal2}"
    append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param]
    append HTML_PARAMS(separate_$prn) "</td></tr>"


  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

}

constructor
