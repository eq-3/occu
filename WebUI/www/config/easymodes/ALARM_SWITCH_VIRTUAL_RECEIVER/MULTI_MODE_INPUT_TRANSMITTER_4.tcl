#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${switch_on_off}"
set PROFILES_MAP(2)  "\${switch_on}"
set PROFILES_MAP(3)  "\${switch_off}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)    "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)      "Expertenprofil"

set PROFILE_1(LONG_COND_VALUE_HI) 150
set PROFILE_1(LONG_COND_VALUE_LO) 50
set PROFILE_1(LONG_CT_OFF) 0
set PROFILE_1(LONG_CT_OFFDELAY) 0
set PROFILE_1(LONG_CT_ON) 0
set PROFILE_1(LONG_CT_ONDELAY) 0
set PROFILE_1(LONG_JT_OFF) 1
set PROFILE_1(LONG_JT_OFFDELAY) 6
set PROFILE_1(LONG_JT_ON) 4
set PROFILE_1(LONG_JT_ONDELAY) 3
set PROFILE_1(LONG_MULTIEXECUTE) 0
set PROFILE_1(LONG_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(LONG_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(LONG_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_1(LONG_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_1(LONG_OFF_TIME_MODE) 0
set PROFILE_1(LONG_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(LONG_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(LONG_ON_TIME_BASE) {4 range 0 - 7}
set PROFILE_1(LONG_ON_TIME_FACTOR) {6 range 0 - 31}
set PROFILE_1(LONG_ON_TIME_MODE) 0
set PROFILE_1(LONG_PROFILE_ACTION_TYPE) {1 0}
set PROFILE_1(LONG_SIGNAL_SELECTION_ACOUSTIC) {1 range 0 - 17}
set PROFILE_1(LONG_SIGNAL_SELECTION_OPTICAL) {4 range 0 - 7}
set PROFILE_1(SHORT_COND_VALUE_HI) 150
set PROFILE_1(SHORT_COND_VALUE_LO) 50
set PROFILE_1(SHORT_CT_OFF) 0
set PROFILE_1(SHORT_CT_OFFDELAY) 0
set PROFILE_1(SHORT_CT_ON) 0
set PROFILE_1(SHORT_CT_ONDELAY) 0
set PROFILE_1(SHORT_JT_OFF) 1
set PROFILE_1(SHORT_JT_OFFDELAY) 6
set PROFILE_1(SHORT_JT_ON) 4
set PROFILE_1(SHORT_JT_ONDELAY) 3
set PROFILE_1(SHORT_MULTIEXECUTE) 0
set PROFILE_1(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_1(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_1(SHORT_OFF_TIME_MODE) 0
set PROFILE_1(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(SHORT_ON_TIME_BASE) {4 range 0 - 7}
set PROFILE_1(SHORT_ON_TIME_FACTOR) {6 range 0 - 31}
set PROFILE_1(SHORT_ON_TIME_MODE) 0
set PROFILE_1(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_1(SHORT_SIGNAL_SELECTION_ACOUSTIC) {1 range 0 - 17}
set PROFILE_1(SHORT_SIGNAL_SELECTION_OPTICAL) {4 range 0 - 4}
set PROFILE_1(UI_DESCRIPTION)  "Mit einem kurzen oder langen Tastendruck wird der Schalter f&uuml;r die eingestellte Zeit eingeschaltet. Ist eine Einschaltverz&ouml;gerungszeit eingestellt, so wird der Schalter erst nach Ablauf dieser Zeit eingeschaltet."
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1


set PROFILE_2(LONG_COND_VALUE_HI) 150
set PROFILE_2(LONG_COND_VALUE_LO) 50
set PROFILE_2(LONG_CT_OFF) 0
set PROFILE_2(LONG_CT_OFFDELAY) 0
set PROFILE_2(LONG_CT_ON) 0
set PROFILE_2(LONG_CT_ONDELAY) 0
set PROFILE_2(LONG_JT_OFF) 3
set PROFILE_2(LONG_JT_OFFDELAY) 3
set PROFILE_2(LONG_JT_ON) {1 3}
set PROFILE_2(LONG_JT_ONDELAY) 3
set PROFILE_2(LONG_MULTIEXECUTE) 0
set PROFILE_2(LONG_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(LONG_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(LONG_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_2(LONG_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_2(LONG_OFF_TIME_MODE) 0
set PROFILE_2(LONG_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(LONG_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(LONG_ON_TIME_BASE) {4 range 0 - 7}
set PROFILE_2(LONG_ON_TIME_FACTOR) {6 range 0 - 31}
set PROFILE_2(LONG_ON_TIME_MODE) 0
set PROFILE_2(LONG_PROFILE_ACTION_TYPE) {1 0}
set PROFILE_2(LONG_SIGNAL_SELECTION_ACOUSTIC) {1 range 0 - 17}
set PROFILE_2(LONG_SIGNAL_SELECTION_OPTICAL) {4 range 0 - 7}
set PROFILE_2(SHORT_COND_VALUE_HI) 150
set PROFILE_2(SHORT_COND_VALUE_LO) 50
set PROFILE_2(SHORT_CT_OFF) 0
set PROFILE_2(SHORT_CT_OFFDELAY) 0
set PROFILE_2(SHORT_CT_ON) 0
set PROFILE_2(SHORT_CT_ONDELAY) 0
set PROFILE_2(SHORT_JT_OFF) 3
set PROFILE_2(SHORT_JT_OFFDELAY) 3
set PROFILE_2(SHORT_JT_ON) {1 3}
set PROFILE_2(SHORT_JT_ONDELAY) 3
set PROFILE_2(SHORT_MULTIEXECUTE) 0
set PROFILE_2(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_2(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_2(SHORT_OFF_TIME_MODE) 0
set PROFILE_2(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(SHORT_ON_TIME_BASE) {4 range 0 - 7}
set PROFILE_2(SHORT_ON_TIME_FACTOR) {6 range 0 - 31}
set PROFILE_2(SHORT_ON_TIME_MODE) 0
set PROFILE_2(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_2(SHORT_SIGNAL_SELECTION_ACOUSTIC) {1 range 0 - 17}
set PROFILE_2(SHORT_SIGNAL_SELECTION_OPTICAL) {4 range 0 - 7}
set PROFILE_2(UI_DESCRIPTION)  ""
set PROFILE_2(UI_TEMPLATE)    $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2

#****************

set PROFILE_3(LONG_COND_VALUE_HI) 150
set PROFILE_3(LONG_COND_VALUE_LO) 50
set PROFILE_3(LONG_CT_OFF) 0
set PROFILE_3(LONG_CT_OFFDELAY) 0
set PROFILE_3(LONG_CT_ON) 0
set PROFILE_3(LONG_CT_ONDELAY) 0
set PROFILE_3(LONG_JT_OFF) 6
set PROFILE_3(LONG_JT_OFFDELAY) 6
set PROFILE_3(LONG_JT_ON) 4
set PROFILE_3(LONG_JT_ONDELAY) 6
set PROFILE_3(LONG_MULTIEXECUTE) 0
set PROFILE_3(LONG_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(LONG_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(LONG_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_3(LONG_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_3(LONG_OFF_TIME_MODE) 0
set PROFILE_3(LONG_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(LONG_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(LONG_ON_TIME_BASE) {4 range 0 - 7}
set PROFILE_3(LONG_ON_TIME_FACTOR) {6 range 0 - 31}
set PROFILE_3(LONG_ON_TIME_MODE) 0
set PROFILE_3(LONG_PROFILE_ACTION_TYPE) {1 0}
set PROFILE_3(LONG_SIGNAL_SELECTION_ACOUSTIC) {1 range 0 - 17}
set PROFILE_3(LONG_SIGNAL_SELECTION_OPTICAL) {4 range 0 - 7}
set PROFILE_3(SHORT_COND_VALUE_HI) 150
set PROFILE_3(SHORT_COND_VALUE_LO) 50
set PROFILE_3(SHORT_CT_OFF) 0
set PROFILE_3(SHORT_CT_OFFDELAY) 0
set PROFILE_3(SHORT_CT_ON) 0
set PROFILE_3(SHORT_CT_ONDELAY) 0
set PROFILE_3(SHORT_JT_OFF) 6
set PROFILE_3(SHORT_JT_OFFDELAY) 6
set PROFILE_3(SHORT_JT_ON) 4
set PROFILE_3(SHORT_JT_ONDELAY) 6
set PROFILE_3(SHORT_MULTIEXECUTE) 0
set PROFILE_3(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_3(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_3(SHORT_OFF_TIME_MODE) 0
set PROFILE_3(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(SHORT_ON_TIME_BASE) {4 range 0 - 7}
set PROFILE_3(SHORT_ON_TIME_FACTOR) {6 range 0 - 31}
set PROFILE_3(SHORT_ON_TIME_MODE) 0
set PROFILE_3(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_3(SHORT_SIGNAL_SELECTION_ACOUSTIC) {1 range 0 - 17}
set PROFILE_3(SHORT_SIGNAL_SELECTION_OPTICAL) {4 range 0 - 4}
set PROFILE_3(UI_DESCRIPTION)  ""
set PROFILE_3(UI_TEMPLATE)  $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3

proc getDescription {longAvailable prn} {
  if {$longAvailable} {
    return "\${description_$prn}"
  } else {
    return "\${description_noLong_$prn}"
  }
}

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

  set longKeypressAvailable [isLongKeypressAvailable $dev_descr_sender(PARENT_TYPE) $sender_address $url]

  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]
  
#  die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">getLangInfo('MULTI_MODE_INPUT_TRANSMITTER_4', '$dev_descr_receiver(TYPE)');</script>"
  puts "<script type=\"text/javascript\">getLangInfo_Special('HmIP_DEVICES.txt');</script>"

  set prn 0
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
  append HTML_PARAMS(separate_$prn) "</textarea></div>"


#1
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  #append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

    set pref 0
    # ONDELAY
    #append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

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

    if {$longKeypressAvailable} {
      # *** LONG KEYPRESS ***
      append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

      # Long key press activ/inactive
      append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn]

      # ONDELAY
      # append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id LONG_ONDELAY_TIME TIMEBASE_LONG]"

      # ON_TIME
      append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn alarmTimeMax10Min $prn $special_input_id LONG_ON_TIME TIMEBASE_LONG]"

    incr pref
    set param LONG_SIGNAL_SELECTION_ACOUSTIC
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
    set param LONG_SIGNAL_SELECTION_OPTICAL
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
  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"


#2
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  #append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

    set pref 0
    # ONDELAY
    append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

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

    # OFFDELAY
    # append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

    # OFF_TIME
    # append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

    if {$longKeypressAvailable} {
      # *** LONG KEYPRESS ***
      append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

      # Long key press activ/inactive
      append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn]

      # ONDELAY
      append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id LONG_ONDELAY_TIME TIMEBASE_LONG]"

      # ON_TIME
      append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn alarmTimeMax10Min $prn $special_input_id LONG_ON_TIME TIMEBASE_LONG]"

    incr pref
    set param LONG_SIGNAL_SELECTION_ACOUSTIC
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
    set param LONG_SIGNAL_SELECTION_OPTICAL
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
  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"


#3
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  #append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "[getDescription $longKeypressAvailable $prn]"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

    set pref 0
    # OFFDELAY
    append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

    # OFF_TIME
    append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

    if {$longKeypressAvailable} {
      # *** LONG KEYPRESS ***
      append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

      # Long key press activ/inactive
      append HTML_PARAMS(separate_$prn) [getDeactivateLongKeypress ps PROFILE_$prn separate_receiver $prn]

      # OFFDELAY
      append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id LONG_OFFDELAY_TIME TIMEBASE_LONG]"

      # OFF_TIME
      append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id LONG_OFF_TIME TIMEBASE_LONG]"
    }

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}

constructor
