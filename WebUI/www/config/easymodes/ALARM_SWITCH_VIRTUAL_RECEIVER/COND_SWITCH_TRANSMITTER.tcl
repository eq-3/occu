#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
# source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/motionDetectorOnTimeHint.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${switch_on}"
set PROFILES_MAP(2)  "\${no_action}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)  "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)    "Expertenprofil"

# hier folgen die verschiedenen Profile

set PROFILE_1(SHORT_COND_VALUE_HI) {150 range 0 - 255}
set PROFILE_1(SHORT_COND_VALUE_LO) {50 range 0 - 255}
set PROFILE_1(SHORT_CT_OFF)        0
set PROFILE_1(SHORT_CT_OFFDELAY)   0
set PROFILE_1(SHORT_CT_ON)         0
set PROFILE_1(SHORT_CT_ONDELAY)    0
set PROFILE_1(SHORT_JT_OFF)       {1 3}
set PROFILE_1(SHORT_JT_OFFDELAY)  3
set PROFILE_1(SHORT_JT_ON)        3
set PROFILE_1(SHORT_JT_ONDELAY)   3
set PROFILE_1(SHORT_MULTIEXECUTE) {0 false}
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
set PROFILE_1(SHORT_SIGNAL_SELECTION_ACOUSTIC) {1 range 0 - 17}
set PROFILE_1(SHORT_SIGNAL_SELECTION_OPTICAL) {4 range 0 - 7}
set PROFILE_1(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_1(UI_DESCRIPTION)  ""
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

set PROFILE_2(SHORT_JT_OFF)       0
set PROFILE_2(SHORT_JT_ON)        0
set PROFILE_2(SHORT_JT_OFFDELAY)  0
set PROFILE_2(SHORT_JT_ONDELAY)   0
set PROFILE_2(UI_DESCRIPTION)  "Der Bewegungsmelder ist au&szlig;er Betrieb."
set PROFILE_2(UI_TEMPLATE)    $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2

# hier folgen die eventuellen Subsets

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global url receiver_address sender_address  dev_descr_sender dev_descr_receiver
  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    ps_descr

  foreach pro [array names PROFILES_MAP] {
    upvar PROFILE_$pro PROFILE_$pro
  }

  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]

set comment {
  if {($cur_profile == 1) && ($ps(SHORT_CT_OFF) != 2)} {
    set modifiedCondType  "{SHORT_CT_OFF {int 2}} {SHORT_CT_OFFDELAY {int 2}} {SHORT_CT_ON {int 2}} {SHORT_CT_ONDELAY {int 2}}"
    catch {puts "[xmlrpc $iface_url($iface) putParamset [list string $receiver_address] [list string $sender_address] [list struct $modifiedCondType]]"}
    set ps(SHORT_CT_OFF) 2
    set ps(SHORT_CT_OFFDELAY) 2
    set ps(SHORT_CT_ON) 2
    set ps(SHORT_CT_ONDELAY) 2
  }
}

set comment {
  if {($cur_profile == 1) && ($dev_descr_receiver(PARENT_TYPE) == "HmIP-WHS2")} {
    set modifiedCondType  "{SHORT_CT_OFFDELAY {int 0}} {SHORT_CT_ON {int 0}}"
    catch {puts "[xmlrpc $url putParamset [list string $receiver_address] [list string $sender_address] [list struct $modifiedCondType]]"}
    set ps(SHORT_CT_OFFDELAY) 0
    set ps(SHORT_CT_ON) 0
  }
}



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

#  die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
  puts "<script type=\"text/javascript\">getLangInfo_Special('HmIP_DEVICES.txt');</script>"

  set prn 0
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

#1  Alarm on
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set pref 0
  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn alarmTimeMax10Min $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  append HTML_PARAMS(separate_$prn) "<tr id='alarmHiddenValue_$prn\_[expr $pref - 1]' class='hidden'><td></td><td colspan='2'><span class='attention'>\${hintAlarmInvalidValue}</span></td></tr>"

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

    append HTML_PARAMS(separate_$prn) "[getHorizontalLine]"
    append HTML_PARAMS(separate_$prn) [getButtonChannelConfiguration helpBtnSenderConf]

#2
  incr prn
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

}

constructor