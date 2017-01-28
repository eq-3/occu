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

  set unit "noUnit"

  catch {set unit $param_descr(UNIT)}

  if {$unit == "100%"} {
    set min [format %.0f [expr $min * 100]]
    set max [format %.0f [expr $max * 100]]
  }

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

  if { [catch {set unit $param_descr(UNIT)}]} {
    set unit "<span class=\"attention\">missing unit</span>"
  }

  if {$unit == "100%"} {
    set unit "%"
  }

  if {$unit == "minutes"} {
   set unit "\${lblMinutes}"
  }

  if {($unit == "K") || ($unit == "??C") || ($unit == "°C")} {
    set unit "&#176;C"
  }

  if {$unit == "_Grad_"} {
    set unit "&#176;"
  }

  return "$unit"
}

proc getTextField {param value chn prn {extraparam ""}} {
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

proc getTextField100Percent {param value chn prn {extraparam ""}} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set minValue [format {%1.1f} $param_descr(MIN)]
  set maxValue [format {%1.1f} $param_descr(MAX)]

  set minValue [expr $minValue * 100]
  set maxValue [expr $maxValue * 100]

  set elemIdTmp 'separate_CHANNEL\_$chn\_$prn\_tmp'
  set elemId 'separate_CHANNEL\_$chn\_$prn'

  # Limit float to 2 decimal places
  if {[llength [split $value "."]] == 2} {
    set value [format {%1.2f} $value]
  }

  set s "<input id=$elemIdTmp type=\"text\" size=\"5\" value=[format %.0f [expr $value * 100]] name=$param\_tmp onblur="
  append s "\"ProofAndSetValue(this.id, this.id, $minValue, $maxValue, 1);"
  append s "jQuery('#separate_CHANNEL\_$chn\_$prn').val(this.value / 100);\">"

  append s "<input id=$elemId type=\"text\" size=\"5\" class=\"hidden\" value=$value name=$param>"
  return $s
}

proc getOptionBox {param options value chn prn {extraparam ""}} {
  upvar $options optionValues

  set s "<select id='separate_CHANNEL\_$chn\_$prn' name=$param $extraparam>"
  set select ""
  foreach val [lsort -real [array names optionValues]] {

     if {$val == $value} {
      set select "selected=\"selected\""
     } else {
      set select ""
     }

     append s "<option class=\"[extractParamFromTranslationKey $optionValues($val)]\" value=$val $select>$optionValues($val)</option>"
  }

  append s "</select>"

  return $s
}

proc getCheckBox {param value chn prn {extraparam ""}} {
  set checked ""
  if { $value } then { set checked "checked=\"checked\"" }
  set s "<input id='separate_CHANNEL\_$chn\_$prn' type='checkbox' $checked value='dummy' name=$param $extraparam/>"
  return $s
}

# This is necessary because the parameter CYCLIC_INFO_MSG is an int instead of a bool
# Here we are mapping the int (text field 0 - 255) to a checkbox (bool)
proc getCheckBoxCyclicInfoMsg {param value chn prn {extraparam ""}} {
  global psDescr
  upvar psDescr psDescr

  set s  "[getCheckBox '$param' $value $chn '$prn\_tmp' "onchange=\"setCyclicInfoMsg(this, '$chn', '$prn');\""]"
  append s  "<td class=\"hidden\">[getTextField $param $value $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append s "<script type=\"text/javascript\">"
    append s "setCyclicInfoMsg = function(elm, chn, prn) \{"
      append s " var value = (jQuery(elm).prop('checked')) ? 1 : 0; "
      # don`t use jQuery - the dirty flag will not be recognized
      append s " document.getElementById('separate_CHANNEL_' + chn + '_' + prn ).value = value; "
    append s "\};"
  append s "</script>"
  return $s
}

proc getButton {id btnTxt callBack} {
  set s "&nbsp<input id='$id' type=button onclick=$callBack>"
  # This translates the text of the button to the parameter btnTxt
  puts "<script type=\"text/javascript\">translateAttribute(\"#$id\", \"value\", $btnTxt);</script>"
  return $s
}

proc getHorizontalLine {} {
  return "<tr><td colspan=\"2\"><hr></td></tr>"
}

proc getHelpIcon {topic x y} {
  set ret "<img src=\"/ise/img/help.png\" style=\"cursor: pointer; width:18px; height:18px; position:relative; top:2px\" onclick=\"showParamHelp('$topic', '$x', '$y')\">"
  return $ret
}

proc _getParamDescrKey {param} {

  set lParam [lreplace [split $param "_"] 0 0]
  set _paramDescr ""
  foreach val $lParam {
    append _paramDescr "$val"
    append _paramDescr "_"
  }
  return [string trimright $_paramDescr "_"]
}

proc getTimeSelector {paramDescr p profile type prn special_input_id timebase optionValues} {
  
  # paramDescr        Text vor der Auswahlbox
  # p                 Paramset
  # profile           the profile (e. g. PROFILE_1)
  # type              delay delayShort timeOnOff timeOnOffShort (determines the kind of the optionbox)
  # prn               profile number
  # special_input_id  special_input_id
  # timebase          SHORT_ON_TIME
  # optionValues      Option values when entering a user specific value (Enter value)

  # Example
  # [getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]

  upvar $profile PROFILE
  upvar $p ps
  upvar pref pref
  upvar cur_profile cur_profile

  set timeBaseParam "$timebase\_BASE"
  set timeFactorParam "$timebase\_FACTOR"

  set paramBaseDescr [_getParamDescrKey $timeBaseParam]
  set paramFactorDescr [_getParamDescrKey $timeFactorParam]

  set javascriptDelay 100

  incr pref
  append html "<tr>"
  append html "<td>\${$paramDescr}</td>"
  append html [getComboBox $prn $pref $special_input_id $type] ;# hmip_helper
  append html "</tr>"

  append html "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${$paramBaseDescr}</td><td>"
  option $optionValues
  append html [get_ComboBox options $timeBaseParam separate_${special_input_id}_$prn\_$pref PROFILE $timeBaseParam]

  append html "</td></tr>"

  if {$prn == $cur_profile} {
    switch $type {
      delay {
        # setCurrentDelayOption
        append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayOption($prn, $pref, \"$special_input_id\");}, $javascriptDelay)</script>"
      }
      delayShort {
        # setCurrentDelayShortOption
        append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($prn, $pref, \"$special_input_id\");}, $javascriptDelay)</script>"
      }
      timeOnOff {
        # setCurrentTimeOption
        append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($prn, $pref, \"$special_input_id\");}, $javascriptDelay)</script>"
      }
      timeOnOffShort {
        # setCurrentTimeShortOption
        append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeShortOption($prn, $pref, \"$special_input_id\");}, $javascriptDelay)</script>"
      }
      rampOnOff {
        # setCurrentRampOption
        append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentRampOption($prn, $pref, \"$special_input_id\");}, $javascriptDelay)</script>"
      }

      switchingInterval {
        # setCurrentSwitchingIntervalOption
        append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentSwitchingIntervalOption($prn, $pref, \"$special_input_id\");}, $javascriptDelay)</script>"
      }

      switchingIntervalOnTime {
        # setCurrentSwitchingIntervalOnTimeOption
        append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentSwitchingIntervalOnTimeOption($prn, $pref, \"$special_input_id\");}, $javascriptDelay)</script>"
      }

      delay0To20M_step2M {
        # setDelay0to20M_step2MOption
        append html "<script type=\"text/javascript\">setTimeout(function() {setDelay0to20M_step2MOption($prn, $pref, \"$special_input_id\");}, $javascriptDelay)</script>"
      }

    }
  } else {
    switch $type {
      delay {
        # setCurrentDelayOption
        append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayOption($prn, $pref, \"$special_input_id\",[lindex $PROFILE($timeBaseParam) 0],[lindex $PROFILE($timeFactorParam) 0]);}, $javascriptDelay)</script>"
      }
      delayShort {
        # setCurrentDelayShortOption
        append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($prn, $pref, \"$special_input_id\",[lindex $PROFILE($timeBaseParam) 0],[lindex $PROFILE($timeFactorParam) 0]);}, $javascriptDelay)</script>"
      }
      timeOnOff {
        # setCurrentTimeOption
        append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($prn, $pref, \"$special_input_id\",[lindex $PROFILE($timeBaseParam) 0],[lindex $PROFILE($timeFactorParam) 0]);}, $javascriptDelay)</script>"
      }
      timeOnOffShort {
        # setCurrentTimeShortOption
        append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeShortOption($prn, $pref, \"$special_input_id\",[lindex $PROFILE($timeBaseParam) 0],[lindex $PROFILE($timeFactorParam) 0]);}, $javascriptDelay)</script>"
      }
      rampOnOff {
        # setCurrentRampOption
        append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentRampOption($prn, $pref, \"$special_input_id\",[lindex $PROFILE($timeBaseParam) 0],[lindex $PROFILE($timeFactorParam) 0]);}, $javascriptDelay)</script>"
      }

      switchingInterval {
        # setCurrentSwitchingIntervalOption
        append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentSwitchingIntervalOption($prn, $pref, \"$special_input_id\",[lindex $PROFILE($timeBaseParam) 0],[lindex $PROFILE($timeFactorParam) 0]);}, $javascriptDelay)</script>"
      }

      delay0To20M_step2M {
        # setCurrentSwitchingIntervalOnTimeOption
        append html "<script type=\"text/javascript\">setTimeout(function() {setDelay0to20M_step2MOption($prn, $pref, \"$special_input_id\",[lindex $PROFILE($timeBaseParam) 0],[lindex $PROFILE($timeFactorParam) 0]);}, $javascriptDelay)</script>"
      }
    }
  }
  incr pref
  append html "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${$paramFactorDescr}</td>"

  append html "<td>[get_InputElem $timeFactorParam separate_${special_input_id}_$prn\_$pref ps $timeFactorParam ]</td>"
  append html "</tr>"
  append html "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"

  return $html

}
