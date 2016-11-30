#!/bin/tclsh

source [file join /www/config/easymodes/em_common.tcl]

proc _getCheckBox {type param value prn} {
  set checked ""
  if { $value } then { set checked "checked=\"checked\"" }
  set s "<input id='separate_$type\_$prn' type='checkbox' $checked value='dummy' name=$param/>"
  return $s
}

proc _getMinValue {param} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set min [format {%1.1f} $param_descr(MIN)]

  # Limit float to 2 decimal places
  if {[llength [split $min "."]] == 2} {
    set min [format {%1.2f} $min]
  }

  return $min
}

proc _getMaxValue {param} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set max [format {%1.1f} $param_descr(MAX)]

  # Limit float to 2 decimal places
  if {[llength [split $max "."]] == 2} {
    set max [format {%1.2f} $max]
  }

  return $max
}

proc _getTextField {type param value prn} {
  set elemId 'separate_$type\_$prn'
  # Limit float to 2 decimal places
  if {[llength [split $value "."]] == 2} {
    set value [format {%1.2f} $value]
  }

  set s "<input id=$elemId type=\"text\" size=\"5\" value=$value name=$param>"
  return $s
}

proc _getUnit {param} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set unit $param_descr(UNIT)

  if {$unit == "minutes"} {
   set unit "\${lblMinutes}"
  }

  if {($unit == "K") || ($unit == "??C") || ($unit == "°C")} {
    set unit "&#176;C"
  }

  return "$unit"
}

proc _getMinMaxValueDescr {param} {
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

proc _getHelpIcon {topic x y} {
  set ret "<img src=\"/ise/img/help.png\" style=\"cursor: pointer; width:18px; height:18px; position:relative; top:2px\" onclick=\"showParamHelp('$topic', '$x', '$y')\">"
  return $ret
}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url
  
  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/CC.js');load_JSFunc('/config/easymodes/MASTER_LANG/HEATINGTHERMOSTATE_2ND_GEN.js');load_JSFunc('/config/easymodes/MASTER_LANG/HEATINGTHERMOSTATE_2ND_GEN_HELP.js');</script>"

  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    psDescr
  
  #upvar PROFILE_0     PROFILE_0
  upvar PROFILE_1     PROFILE_1

  set CHANNEL $special_input_id

  set hlpBoxWidth 450
  set hlpBoxHeight 160



  set prn 0

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

    # left
    incr prn
    set param TEMPERATURE_MINIMUM
    array_clear options
    set i 0
    for {set val [_getMinValue $param]} {$val <= [_getMaxValue $param]} {set val [expr $val + 0.5]} {
      set options($i) "$val &#176;C"
      incr i;
    }
    append HTML_PARAMS(separate_1) "<tr><td>\${stringTableTemperatureMinimum}</td>"
    append HTML_PARAMS(separate_1)  "<td>[get_ComboBox options $param tmp_$CHANNEL\_$prn ps $param onchange=setMinMaxTemp('tmp_$CHANNEL\_$prn','separate_$CHANNEL\_$prn')]</span> <span class='hidden'>[_getTextField $CHANNEL '$param' $ps($param) $prn]</span></td>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "setMinMaxTempOption('tmp_$CHANNEL\_$prn', 'separate_$CHANNEL\_$prn' );"
    append HTML_PARAMS(separate_1) "</script>"

    # right
    incr prn
    set param TEMPERATURE_MAXIMUM
    array_clear options
    set i 0
    for {set val [_getMinValue $param]} {$val <= [_getMaxValue $param]} {set val [expr $val + 0.5]} {
      set options($i) "$val &#176;C"
      incr i;
    }
    append HTML_PARAMS(separate_1) "<td>\${stringTableTemperatureMaximum}</td>"
    append HTML_PARAMS(separate_1)  "<td>[get_ComboBox options $param tmp_$CHANNEL\_$prn ps $param onchange=setMinMaxTemp('tmp_$CHANNEL\_$prn','separate_$CHANNEL\_$prn')]</span> <span class='hidden'>[_getTextField $CHANNEL '$param' $ps($param) $prn]</span></td>"
    append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "setMinMaxTempOption('tmp_$CHANNEL\_$prn', 'separate_$CHANNEL\_$prn' );"
    append HTML_PARAMS(separate_1) "</script>"
    append HTML_PARAMS(separate_1) "<tr>"


    append HTML_PARAMS(separate_1) "</table>"

    append HTML_PARAMS(separate_1) "<hr>"

    append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    incr prn
    set param TEMPERATURE_OFFSET
    array_clear options
    set i 0
    for {set val [_getMinValue $param]} {$val <= [_getMaxValue $param]} {set val [expr $val + 0.5]} {
      set options($val) "$val &#176;C"
      incr i;
    }
    append HTML_PARAMS(separate_1) "<td>\${stringTableTemperatureOffset}</td>"
    append HTML_PARAMS(separate_1) "<td>[get_ComboBox options $param separate_$CHANNEL\_$prn ps $param][_getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
    append HTML_PARAMS(separate_1) "</tr>"

    incr prn
    set param TEMPERATURE_WINDOW_OPEN
    append HTML_PARAMS(separate_1) "<tr><td>\${stringTableTemperatureFallWindowOpen}</td>"
    append HTML_PARAMS(separate_1)  "<td>[_getTextField $CHANNEL $param $ps($param) $prn]&nbsp;[_getUnit $param]&nbsp;[_getMinMaxValueDescr $param]<input id=\"comfortOld\" type=\"hidden\" value=\"$ps($param)\"></td>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
      append HTML_PARAMS(separate_1) "jQuery(\"#separate_$CHANNEL\_$prn\").bind(\"blur\",function() {ProofAndSetValue(this.id, this.id, [_getMinValue $param], [_getMaxValue $param], 1);});"
    append HTML_PARAMS(separate_1) "</script>"
    append HTML_PARAMS(separate_1) "</tr>"
  append HTML_PARAMS(separate_1) "</table>"
}

constructor
