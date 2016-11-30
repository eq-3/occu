#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${profileSettings}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)    "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)      "Expertenprofil"

set PROFILE_1(SHORT_COOLING_DISABLE) {1 0}
set PROFILE_1(SHORT_ECO_COOLING_TEMPERATURE) {23.0 range 0.0 - 30.0}
set PROFILE_1(SHORT_ECO_HEATING_TEMPERATURE) {19.0 range 0.0 - 30.0}
set PROFILE_1(SHORT_HEATING_CLOCK_FUNCTION) {1 0}
set PROFILE_1(SHORT_HEATING_DISABLE) {1 0}
set PROFILE_1(SHORT_FLOOR_HEATING_MODE) {0 range 0 - 4}
set PROFILE_1(SHORT_HUMIDITY_LIMIT_VALUE) {40 range 40 - 80}
set PROFILE_1(SHORT_MINIMAL_FLOOR_TEMPERATURE) {19.0 range 0.0 - 30.0}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global receiver_address dev_descr_sender dev_descr_receiver
  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    ps_descr

  set minTemp 5
  set maxTemp 30

  foreach pro [array names PROFILES_MAP] {
    upvar PROFILE_$pro PROFILE_$pro
  }

  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]

#  die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"

  set prn 0
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set pref 1
  set param SHORT_FLOOR_HEATING_MODE
  append HTML_PARAMS(separate_$prn) "<tr><td>\${heatingModeSelection}</td><td>"
  array_clear options
  set options(0) "\${optionFloorHeatingStandard}"
  set options(1) "\${optionFloorHeatingLowEnergy}"
  set options(2) "\${optionRadiator}"
  set options(3) "\${optionConvectorPassiv}"
  set options(4) "\${optionConvectorActive}"

  append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref
  set param SHORT_COOLING_DISABLE
  append HTML_PARAMS(separate_$prn) "<tr><td>\${coolingDisable}</td><td>"

  array_clear options
  set options(0) "\${optionDisabled}"
  set options(1) "\${optionEnabled}"

  append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref
  set param SHORT_HEATING_DISABLE
  append HTML_PARAMS(separate_$prn) "<tr><td>\${heatingDisable}</td><td>"

  array_clear options
  set options(0) "\${optionDisabled}"
  set options(1) "\${optionEnabled}"

  append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # **************
  append HTML_PARAMS(separate_$prn) "[getHorizontalLine]"
  incr pref
  set param SHORT_HEATING_CLOCK_FUNCTION
  append HTML_PARAMS(separate_$prn) "<tr><td>\${heatingClockFunction}</td><td>"

  array_clear options
  set options(0) "\${optionIgnore}"
  set options(1) "\${optionAccept}"

  append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref
  set param SHORT_ECO_COOLING_TEMPERATURE
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ecoCoolingTemperature}</td><td>"

  array_clear options
  for {set loop $minTemp} {$loop <= $maxTemp} {incr loop} {
    set options($loop) "$loop °C"
  }

  append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref
  set param SHORT_ECO_HEATING_TEMPERATURE
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ecoHeatingTemperature}</td><td>"

  array_clear options
  for {set loop $minTemp} {$loop <= $maxTemp} {incr loop} {
    set options($loop) "$loop °C"
  }

  append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  if {[hasSenderHumiditySensor]} {

    # **************
    append HTML_PARAMS(separate_$prn) "[getHorizontalLine]"
    incr pref
    set param SHORT_HUMIDITY_LIMIT_DISABLE
    append HTML_PARAMS(separate_$prn) "<tr><td>\${alarmWhenHumidityLimit}</td><td>"

    array_clear options
    set options(0) "\${optionDisabled}"
    set options(1) "\${optionEnabled}"

    append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param]
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    incr pref
    set param SHORT_HUMIDITY_LIMIT_VALUE
    append HTML_PARAMS(separate_$prn) "<tr><td>\${humidityLimitValue}</td><td>"

    array_clear options
    for {set loop 40} {$loop <= 80} {incr loop 5} {
      set options($loop) "$loop %"
    }

    append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param]
    append HTML_PARAMS(separate_$prn) "</td></tr>"
  }

  set comment {
    # This parameter is currently not supported
    incr pref
    set param SHORT_MINIMAL_FLOOR_TEMPERATURE
    append HTML_PARAMS(separate_$prn) "<tr><td>\${minimalFloorTemperatur}</td><td>"

    array_clear options
    for {set loop $minTemp} {$loop <= $maxTemp} {incr loop} {
      set options($loop) "$loop °C"
    }

    append HTML_PARAMS(separate_$prn) [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE_$prn $param]
    append HTML_PARAMS(separate_$prn) "</td></tr>"
  }

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}

constructor