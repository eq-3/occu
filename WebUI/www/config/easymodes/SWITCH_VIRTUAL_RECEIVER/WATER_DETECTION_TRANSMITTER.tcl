#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${switch_toggle}"
set PROFILES_MAP(2)  "\${switch_on}"
set PROFILES_MAP(3)  "\${switch_off}"
set PROFILES_MAP(4)  "\${no_action}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)  "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)    "Expertenprofil"

# hier folgen die verschiedenen Profile

set PROFILE_1(SHORT_COND_VALUE_HI) {150 range 0 - 255}
set PROFILE_1(SHORT_COND_VALUE_LO) {50 range 0 - 255}
set PROFILE_1(SHORT_CT_OFF) {0 1 2 4}
set PROFILE_1(SHORT_CT_OFFDELAY) {0 1 2 4}
set PROFILE_1(SHORT_CT_ON) {0 1 2 4}
set PROFILE_1(SHORT_CT_ONDELAY) {0 1 2 4}
set PROFILE_1(SHORT_JT_OFF) {1 3}
set PROFILE_1(SHORT_JT_OFFDELAY) 6
set PROFILE_1(SHORT_JT_ON) {4 6}
set PROFILE_1(SHORT_JT_ONDELAY) 3
set PROFILE_1(SHORT_MULTIEXECUTE) {0 false}
set PROFILE_1(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_1(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_1(SHORT_OFF_TIME_MODE) 0
set PROFILE_1(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_1(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_1(SHORT_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_1(SHORT_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_1(SHORT_ON_TIME_MODE) 0
set PROFILE_1(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_1(UI_DESCRIPTION)  "Beim Ausl&ouml;sen des Sensors wird der Schalter mindestens f&uuml;r die eingestellte Zeit eingeschaltet. Ist eine Einschaltverz&ouml;gerungszeit eingestellt, so wird der Schalter erst nach Ablauf dieser Zeit eingeschaltet.<br /> "
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1


set PROFILE_2(SHORT_COND_VALUE_HI) {150 range 0 - 255}
set PROFILE_2(SHORT_COND_VALUE_LO) {50 range 0 - 255}
set PROFILE_2(SHORT_CT_OFF) {0 1 2 4}
set PROFILE_2(SHORT_CT_OFFDELAY) {0 1 2 4}
set PROFILE_2(SHORT_CT_ON) {0 1 2 4}
set PROFILE_2(SHORT_CT_ONDELAY) {0 1 2 4}
set PROFILE_2(SHORT_JT_OFF) 1
set PROFILE_2(SHORT_JT_OFFDELAY) 3
set PROFILE_2(SHORT_JT_ON) 3
set PROFILE_2(SHORT_JT_ONDELAY) 3
set PROFILE_2(SHORT_MULTIEXECUTE) {0 false}
set PROFILE_2(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_2(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_2(SHORT_OFF_TIME_MODE) 0
set PROFILE_2(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_2(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_2(SHORT_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_2(SHORT_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_2(SHORT_ON_TIME_MODE) 0
set PROFILE_2(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_2(UI_DESCRIPTION)  "Beim Ausl&ouml;sen des Sensors wird der Schalter mindestens f&uuml;r die eingestellte Zeit ohne Verz&ouml;gerung eingeschaltet.<br />"
set PROFILE_2(UI_TEMPLATE)    $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2

set PROFILE_3(SHORT_COND_VALUE_HI) {150 range 0 - 255}
set PROFILE_3(SHORT_COND_VALUE_LO) {50 range 0 - 255}
set PROFILE_3(SHORT_CT_OFF) {0 1 2 4}
set PROFILE_3(SHORT_CT_OFFDELAY) {0 1 2 4}
set PROFILE_3(SHORT_CT_ON) {0 1 2 4}
set PROFILE_3(SHORT_CT_ONDELAY) {0 1 2 4}
set PROFILE_3(SHORT_JT_OFF) 0
set PROFILE_3(SHORT_JT_OFFDELAY) 4
set PROFILE_3(SHORT_JT_ON) 4
set PROFILE_3(SHORT_JT_ONDELAY) 6
set PROFILE_3(SHORT_MULTIEXECUTE) {0 false}
set PROFILE_3(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_3(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_3(SHORT_OFF_TIME_MODE) 0
set PROFILE_3(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(SHORT_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_3(SHORT_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_3(SHORT_ON_TIME_MODE) 0
set PROFILE_3(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_3(UI_DESCRIPTION)  "Beim Ausl&ouml;sen des Sensors wird der Schalter mindestens f&uuml;r die eingestellte Zeit ohne Verz&ouml;gerung eingeschaltet.<br />"
set PROFILE_3(UI_TEMPLATE)    $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3

set PROFILE_4(SHORT_JT_OFF)      0
set PROFILE_4(SHORT_JT_ON)      0
set PROFILE_4(SHORT_JT_OFFDELAY)  0
set PROFILE_4(SHORT_JT_ONDELAY)    0
set PROFILE_4(UI_DESCRIPTION)  "Der Bewegungsmelder ist au&szlig;er Betrieb."
set PROFILE_4(UI_TEMPLATE)    $PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)  4

# hier folgen die eventuellen Subsets

# "humidity"
set SUBSET_1(NAME)          "\${subset_1}"
set SUBSET_1(SUBSET_OPTION_VALUE)  1
set SUBSET_1(SHORT_CT_OFF)      4
set SUBSET_1(SHORT_CT_OFFDELAY) 4
set SUBSET_1(SHORT_CT_ON)       4
set SUBSET_1(SHORT_CT_ONDELAY)  4

# "water"
set SUBSET_2(NAME)          "\${subset_2}"
set SUBSET_2(SUBSET_OPTION_VALUE)  2
set SUBSET_2(SHORT_CT_OFF)      1
set SUBSET_2(SHORT_CT_OFFDELAY) 1
set SUBSET_2(SHORT_CT_ON)       1
set SUBSET_2(SHORT_CT_ONDELAY)  1

# "humidity OR water"
set SUBSET_3(NAME)          "\${subset_3}"
set SUBSET_3(SUBSET_OPTION_VALUE)  3
set SUBSET_3(SHORT_CT_OFF)      0
set SUBSET_3(SHORT_CT_OFFDELAY) 0
set SUBSET_3(SHORT_CT_ON)       0
set SUBSET_3(SHORT_CT_ONDELAY)  0

# "absolutely dry"
set SUBSET_4(NAME)          "\${subset_4}"
set SUBSET_4(SUBSET_OPTION_VALUE)  4
set SUBSET_4(SHORT_CT_OFF)      2
set SUBSET_4(SHORT_CT_OFFDELAY) 2
set SUBSET_4(SHORT_CT_ON)       2
set SUBSET_4(SHORT_CT_ONDELAY)  2

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global url receiver_address sender_address  dev_descr_sender dev_descr_receiver
  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps      
  upvar $pps_descr    ps_descr
  
  
  # set sender_addr $sender_address
  # puts "<input type=\"hidden\" id=\"dev_descr_sender_tmp\" value=\"$dev_descr_sender(TYPE)-$sender_addr\">"

  # array set dev_ps [xmlrpc $url getParamset $sender_address MASTER]
  
  # set  min_interval 4

  foreach pro [array names PROFILES_MAP] {
    upvar PROFILE_$pro PROFILE_$pro
  }
  
  
  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]

  if {($cur_profile == 1) && ($dev_descr_receiver(PARENT_TYPE) == "HmIP-WHS2")} {
    set modifiedCondType  "{SHORT_CT_OFFDELAY {int 0}} {SHORT_CT_ON {int 0}}"
    catch {puts "[xmlrpc $url putParamset [list string $receiver_address] [list string $sender_address] [list struct $modifiedCondType]]"}
    set ps(SHORT_CT_OFFDELAY) 0
    set ps(SHORT_CT_ON) 0
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

#1 Switch TOGGLE
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${switchMode}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2 SUBSET_3 SUBSET_4} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

  #2  Schalter EIN
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${switchMode}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2 SUBSET_3 SUBSET_4} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

  #3  Schalter AUS
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${switchMode}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2 SUBSET_3 SUBSET_4} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # AFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#4
  incr prn
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

}

constructor
