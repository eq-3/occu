proc getMinValue {param} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set min [format {%1.1f} $param_descr(MIN)]
  return "$min"
}

proc getMaxValue {param} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set max [format {%1.1f} $param_descr(MAX)]
  return "$max"
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

proc getUnit {param} {
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

proc getTextField {param value chn prn} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set minValue [format {%1.1f} $param_descr(MIN)]
  set maxValue [format {%1.1f} $param_descr(MAX)]

  set elemId 'separate_CHANNEL\_$chn\_$prn'
  # Limit float to 2 decimal places
  if {[llength [split $value "."]] == 2} {
    set value [format {%1.2f} $value]
  }

  set s "<input id=$elemId type=\"text\" size=\"5\" value=$value name=$param onblur=\"ProofAndSetValue(this.id, this.id, $minValue, $maxValue, 1)\">"
  return $s
}

proc getCheckBox {param value chn prn} {
  set checked ""
  if { $value } then { set checked "checked=\"checked\"" }
  set s "<input id='separate_CHANNEL\_$chn\_$prn' type='checkbox' $checked value='dummy' name=$param/>"
  return $s
}

proc getHelpIcon {topic x y} {
  set ret "<img src=\"/ise/img/help.png\" style=\"cursor: pointer; width:18px; height:18px; position:relative; top:2px\" onclick=\"showParamHelp('$topic', '$x', '$y')\">"
  return $ret
}