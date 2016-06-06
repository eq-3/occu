#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]

proc getMinValue {param} {
  global psDescr
  array_clear param_descr
  set param [trimParam $param]
  array set param_descr $psDescr($param)
  set min [format {%1.1f} $param_descr(MIN)]
  return "$min"
}

proc getMaxValue {param} {
  global psDescr
  array_clear param_descr
  set param [trimParam $param]
  array set param_descr $psDescr($param)
  set max [format {%1.1f} $param_descr(MAX)]
  return "$max"
}

proc getUnit {psDescr param} {
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set unit $param_descr(UNIT)

  if {$unit == "minutes"} {
   set unit "\${lblMinutes}"
  }

  if {$unit == "K"} {
    set unit "&#176;C"
  }

  return "$unit"
}

proc getMinMaxValueDescr {psDescr param} {
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

proc getDescription {param} {
  set result $param
  set desc(POWERUP_ONDELAY_UNIT) "stringTableOnDelayUnit"
  set desc(POWERUP_ONTIME_UNIT) "stringTableOnTimeUnit"
  if {[catch {set result $desc($param)}]} {
   return $result
  }
  return $result
}

proc trimParam {param} {
  set s [string trimleft $param ']
  set s [string trimright $s ']
  return $s
}

proc getHorizontalLine {} {
  return "<tr><td colspan=\"2\"><hr></td></tr>"
}

proc getTimeUnitComboBox {param value chn prn special_input_id} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'
  #set s "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\">"

  set s "<tr id=\"timeBase_$chn\_$prn\" class=\"hidden\">"
    append s "<td>\${[getDescription $param]}</td>"
    append s "<td>"
      append s "<select id=$elemId name=$param>"
        append s "<option value='0'>\${optionUnit100MS}</option>"
        append s "<option value='1'>\${optionUnit1S}</option>"
        append s "<option value='2'>\${optionUnit5S}</option>"
        append s "<option value='3'>\${optionUnit10S}</option>"
        append s "<option value='4'>\${optionUnit1M}</option>"
        append s "<option value='5'>\${optionUnit5M}</option>"
        append s "<option value='6'>\${optionUnit10M}</option>"
        append s "<option value='7'>\${optionUnitH}</option>"
      append s "</select>"
    append s "</td>"
  append s "</tr>"
  append s "<script type=\"text/javascript\">"
    append s "jQuery($j_elemId).val('$value');"
  append s "</script>"
  return $s
}



proc getTextField {param value inputId} {
  set elemId '$inputId'
  # Limit float to 2 decimal places
  if {[llength [split $value "."]] == 2} {
    set value [format {%1.2f} $value]
  }
  set s "<input id=$elemId type=\"text\" size=\"5\" value=$value name=$param onblur=\"ProofAndSetValue(this.id, this.id, [getMinValue $param], [getMaxValue $param], 1)\"/>"
  return $s
}

proc getComboBoxJumpTarget {param value inputId} {
    global psDescr
    set elemId $inputId
    set j_elemId "#"
    append j_elemId $inputId

      append s "<td>"
        append s "<select id=$elemId name=$param>"
          append s "<option value=\"0\">\${stringTableNotUsed}</option>"
          append s "<option value=\"1\">\${optionOnWithDelay}</option>"
          append s "<option value=\"2\">\${optionOnWithoutDelay}</option>"
        append s "</select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"
        append s "var value = parseInt($value);"
        append s "if (value > 2) value = 0;"
        append s "jQuery(\'$j_elemId\').val(value);"
      append s "</script>"
    return $s
}

catch {unset internalKey}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr

  #upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  #upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    ps_descr

  set specialID "[lindex [split $special_input_id _] 0]"

  set chn [lindex [split $special_input_id _] 1]

  array set psDescr [xmlrpc $iface_url($iface) getParamsetDescription [list string $address] [list string MASTER]]

    foreach val [array names psDescr] {
     #puts "$val: $psDescr($val)\n"
    }

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\" align=\"center\">"

set comment {
      set prn 1
      set param LOGIC_COMBINATION
      append HTML_PARAMS(separate_1) "<tr>"
        append HTML_PARAMS(separate_1) "<td>\${stringTableLogicCombination}</td>"
        append HTML_PARAMS(separate_1) "<td>[getTextField '$param' $ps($param) separate_${special_input_id}_$prn]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"
}
set comment {
      set prn 1
      set param POWERUP_JUMPTARGET
      append HTML_PARAMS(separate_1) "<tr>"
        append HTML_PARAMS(separate_1) "<td>\${stringTableDimmerPowerUpAction}</td>"
        append HTML_PARAMS(separate_1) "[getComboBoxJumpTarget '$param' $ps($param) separate_${special_input_id}_$prn]"
      append HTML_PARAMS(separate_1) "</tr>"

      # 2
      incr prn
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTableOnDelay}</td>"
      append HTML_PARAMS(separate_1) [getComboBox $chn $prn "$specialID" "delay"]
      append HTML_PARAMS(separate_1) "</tr>"

      set param POWERUP_ONDELAY_UNIT
      append HTML_PARAMS(separate_1) [getTimeUnitComboBox $param $ps($param) $chn $prn $special_input_id]

      # 3
      incr prn
      set param POWERUP_ONDELAY_VALUE
      append HTML_PARAMS(separate_1) "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
        append HTML_PARAMS(separate_1) "<td>\${stringTableOnDelayValue}</td>"
        append HTML_PARAMS(separate_1) "<td>[getTextField '$param' $ps($param) separate_${special_input_id}_$prn]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"
      append HTML_PARAMS(separate_1) "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
      append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

      # 4
      incr prn
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTableOnTime}</td>"
      append HTML_PARAMS(separate_1) [getComboBox $chn $prn "$specialID" "timeOnOff"]
      append HTML_PARAMS(separate_1) "</tr>"

      set param POWERUP_ONTIME_UNIT
      append HTML_PARAMS(separate_1) [getTimeUnitComboBox $param $ps($param) $chn $prn $special_input_id]

      # 5
      incr prn
      set param POWERUP_ONTIME_VALUE
      append HTML_PARAMS(separate_1) "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
        append HTML_PARAMS(separate_1) "<td>\${stringTableOnTimeValue}</td>"
        append HTML_PARAMS(separate_1) "<td>[getTextField '$param' $ps($param) separate_${special_input_id}_$prn]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"
      append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
}
      append HTML_PARAMS(separate_1) "<tr><td class=\"CLASS22003\">\${deviceAndChannelParamsLblNoParamsToSet}</td></tr>"

  append HTML_PARAMS(separate_1) "</table>"
}

constructor


