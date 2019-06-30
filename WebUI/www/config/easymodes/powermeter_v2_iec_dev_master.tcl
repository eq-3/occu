#!/bin/tclsh
#Kanal-EasyMode!
source [file join /www/config/easymodes/em_common.tcl]

set PROFILES_MAP(0)  "Experte"
set PROFILES_MAP(1)  "TheOneAndOnlyEasyMode"

proc getHelpIcon {topic x y} {
  set ret "<img src=\"/ise/img/help.png\" style=\"cursor: pointer; width:18px; height:18px; position:relative; top:2px\" onclick=\"showParamHelp('$topic', '$x', '$y')\">"
  return $ret
}

proc getCheckBox {param value prn} {
  set checked ""
  if { $value } then { set checked "checked=\"checked\"" }
  set s "<input id='separate_DEVICE_$prn' type='checkbox' $checked value='dummy' name=$param/>"
  return $s
}

proc getComboBox {arOptions prn param val} {
  upvar $arOptions options

  set s "<select id=\"separate_DEVICE\_$prn\" name=$param>"
  foreach value [lsort -real [array names options]] {
    set selected ""
    if {$value == $val} {set selected "selected=\"selected\""}
    append s "<option value=$value $selected>$options($value)</option>"
  }
  append s "</select>"
  return $s
}

proc getMinMaxValueDescr {param} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set min $param_descr(MIN)
  set max $param_descr(MAX)

  # Limit float to 2 decimal places
  if {[llength [split $min "."]] == 2} {
    set min [format {%1.2f} $min]
    set max [format {%1.2f} $max]
  }
  return "($min - $max)"
}

proc getTextField {prn param val} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set minValue [format {%1.1f} $param_descr(MIN)]
  set maxValue [format {%1.1f} $param_descr(MAX)]

  set elemId 'separate_DEVICE\_$prn'
  # Limit float to 2 decimal places
  if {[llength [split $val "."]] == 2} {
    set val [format {%1.2f} $val]
  }

  set s "<input id=$elemId type=\"text\" size=\"5\" value=\"$val\" name=\"$param\" onblur=\"ProofAndSetValue(this.id, this.id, $minValue, $maxValue, 1)\">"
  return $s
}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global iface_url psDescr

  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps

  set hlpBoxWidth 450
  set hlpBoxHeight 160

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_TX_WM.js');load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_TX_WM_HELP.js')</script>"

  array set psDescr [xmlrpc $iface_url($iface) getParamsetDescription [list string $address] [list string MASTER]]

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
  set prn 1
  set param LOCAL_RESET_DISABLE
  append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1) "<td>\${stringTableLocalResetDisable}</td>"
    append HTML_PARAMS(separate_1) "<td>"
     append HTML_PARAMS(separate_1) "[getCheckBox '$param' $ps($param) $prn]"
    append HTML_PARAMS(separate_1) "</td>"
  append HTML_PARAMS(separate_1) "</tr>"

  incr prn
  set param DZG_COMPATIBILITY_MODE
  append HTML_PARAMS(separate_1) "<tr class=\"j_IECSensor\">"
    append HTML_PARAMS(separate_1) "<td>\${stringTableDZGCompatibilityMode}</td>"
    append HTML_PARAMS(separate_1) "<td>"
     append HTML_PARAMS(separate_1) "[getCheckBox '$param' $ps($param) $prn]"
    append HTML_PARAMS(separate_1) "</td>"
  append HTML_PARAMS(separate_1) "</tr>"

  incr prn
  set param BAUDRATE
  append HTML_PARAMS(separate_1) "<tr class=\"j_IECSensor\">"
    array_clear options
    set options(0) "\${optionBaud300}"
    set options(1) "\${optionBaud600}"
    set options(2) "\${optionBaud1200}"
    set options(3) "\${optionBaud2400}"
    set options(4) "\${optionBaud4800}"
    set options(5) "\${optionBaud9600}"
    set options(6) "\${optionBaud19200}"
    append HTML_PARAMS(separate_1) "<td>\${PowerMeterBaudRate}</td>"
    append HTML_PARAMS(separate_1) "<td>[getComboBox options $prn '$param' $ps($param)]</td>"
  append HTML_PARAMS(separate_1) "</tr>"

  incr prn
  set param SERIAL_FORMAT
  append HTML_PARAMS(separate_1) "<tr class=\"j_IECSensor\">"
    array_clear options
    set options(0) "\${PowerMeterSerialFormatOption0}"
    set options(1) "\${PowerMeterSerialFormatOption1}"
    set options(2) "\${PowerMeterSerialFormatOption2}"
    set options(3) "\${PowerMeterSerialFormatOption3}"
    append HTML_PARAMS(separate_1) "<td>\${PowerMeterSerialFormat}</td>"
    append HTML_PARAMS(separate_1) "<td>[getComboBox options $prn '$param' $ps($param)][getHelpIcon $param\_V2 $hlpBoxWidth $hlpBoxHeight]</td>"
  append HTML_PARAMS(separate_1) "</tr>"

  incr prn
  set param METER_POWERMODE
  append HTML_PARAMS(separate_1) "<tr class=\"j_IECSensor\">"
    array_clear options
    set options(0) "\${PowerMeterPowerModeOptionMains}"
    set options(1) "\${PowerMeterPowerModeOptionBattery}"
    append HTML_PARAMS(separate_1) "<td>\${PowerMeterPowerMode}</td>"
    append HTML_PARAMS(separate_1) "<td>[getComboBox options $prn '$param' $ps($param)]</td>"
  append HTML_PARAMS(separate_1) "</tr>"

  incr prn
  set param METER_PROTOCOLMODE
  append HTML_PARAMS(separate_1) "<tr class=\"j_IECSensor\">"
    array_clear options
    set options(0) "\${PowerMeterProtocolModeModeOptionA}"
    set options(1) "\${PowerMeterProtocolModeModeOptionB}"
    set options(2) "\${PowerMeterProtocolModeModeOptionC}"
    set options(3) "\${PowerMeterProtocolModeModeOptionD}"
    set options(4) "\${PowerMeterProtocolModeModeOptionSML}"
    append HTML_PARAMS(separate_1) "<td>\${PowerMeterProtocolMode}</td>"
    append HTML_PARAMS(separate_1) "<td>[getComboBox options $prn '$param' $ps($param)]</td>"
  append HTML_PARAMS(separate_1) "</tr>"

  incr prn
  set param SAMPLES_PER_CYCLE
  append HTML_PARAMS(separate_1) "<tr class=\"j_IECSensor\">"
    append HTML_PARAMS(separate_1) "<td>\${PowerMeterSamplesPerCycle}</td>"
    append HTML_PARAMS(separate_1) "<td>[getTextField $prn $param $ps($param)]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
  append HTML_PARAMS(separate_1) "</tr>"

  append HTML_PARAMS(separate_1) "</table>"

}
constructor
