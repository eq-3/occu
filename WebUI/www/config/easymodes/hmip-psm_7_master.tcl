#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
# source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/profile_cond_x_ch_master.tcl]

catch {unset internalKey}

proc getDescription {param} {
  global MEASUREMENT_TYPE

  set result $param

   if {$param == "upperVal_$MEASUREMENT_TYPE"} {
        set param "UPPER_VAL"
   }

   if {$param == "lowerVal_$MEASUREMENT_TYPE"} {
        set param "LOWER_VAL"
   }

    if {$param == "COND_TX_THRESHOLD_HI_$MEASUREMENT_TYPE"} {
         set param "COND_TX_THRESHOLD_HI"
    }

    if {$param == "COND_TX_THRESHOLD_LO_$MEASUREMENT_TYPE"} {
         set param "COND_TX_THRESHOLD_LO"
    }

  set desc(COND_TX_CYCLIC_ABOVE) "stringTableCondTxCyclicAbove"
  set desc(COND_TX_CYCLIC_BELOW) "stringTableCondTxCyclicBelow"
  set desc(COND_TX_DECISION_ABOVE) "stringTableCondTxDecisionAbove"
  set desc(COND_TX_DECISION_BELOW) "stringTableCondTxDecisionBelow"
  set desc(COND_TX_FALLING) "stringTableCondTxFalling"
  set desc(COND_TX_RISING) "stringTableCondTxRising"
  set desc(COND_TX_THRESHOLD_HI) "stringTableCondThresholdHi"
  set desc(COND_TX_THRESHOLD_LO) "stringTableCondThresholdLo"
  set desc(UPPER_VAL) "stringTableUpperVal"
  set desc(LOWER_VAL) "stringTableLowerVal"
  set desc(EVENT_DELAY_UNIT) "stringTableEventDelayUnit"
  set desc(EVENT_DELAY_VALUE) "stringTableEventDelayValue"
  set desc(TRANSMIT_TRY_MAX) "stringTableTransmitTryMax"

  if {[catch {set result $desc($param)}]} {
   return $result
  }
  return $result
}

proc getThreshold {} {
  global ps MEASUREMENT_TYPE
  upvar ps psValues
  #return  [expr $psValues(COND_TX_THRESHOLD_HI_$MEASUREMENT_TYPE) - $psValues(COND_TX_THRESHOLD_LO_$MEASUREMENT_TYPE)]
}

# This wll be called by the function getUnit()
proc checkParam {param} {
  global MEASUREMENT_TYPE
  if {$param == "upperVal_$MEASUREMENT_TYPE" || $param == "lowerVal_$MEASUREMENT_TYPE"} {
    # Unit should be 'mW' - COND_TX_THRESHOLD_LO has the same unit
    return "COND_TX_THRESHOLD_HI"
  }
  return $param
}

proc getUnit {param} {
  global psDescr
  array_clear param_descr
  set param [checkParam $param]
  if {![catch {array set param_descr $psDescr($param)}]} {
    set unit ""
    catch {
      set unit $param_descr(UNIT)
    }
    return "$unit"
  }
  return ""
}

proc getMinMaxValueDescr {param} {
  global psDescr
  array_clear param_descr

  if {[string first "lowerVal" $param 0] != -1} {
    set param "COND_TX_THRESHOLD_LO"
  } elseif {[string first "upperVal" $param 0] != -1} {
    set param "COND_TX_THRESHOLD_HI"
  }

  if {![catch {array set param_descr $psDescr($param)}]} {
    set min $param_descr(MIN)
    set max $param_descr(MAX)

    # Limit float to 2 decimal places
         if {[llength [split $min "."]] == 2} {
           set min [format {%1.2f} $min]
           set max [format {%1.2f} $max]
         }
    return "($min - $max)"
  }
  return ""
}

proc getMinValue {param} {
  global psDescr
  set min ""
  array_clear param_descr
	if {![catch {array set param_descr $psDescr($param)}]} {
    set min $param_descr(MIN)
  }
  return $min
}

proc getMaxValue {param} {
  global psDescr
  set max ""
  array_clear param_descr
	if {![catch {array set param_descr $psDescr($param)}]} {
    set max $param_descr(MAX)
  }
  return $max
}

proc trimParam {param} {
  set s [string trimleft $param ']
  set s [string trimright $s ']
  return $s
}

proc getParamName {param} {
  set arrParameter [split $param _]
  if {[llength $arrParameter] == 2 && (([lindex $arrParameter 0] == "lowerVal") || ([lindex $arrParameter 0] == "upperVal"))} {
    set result [lindex $arrParameter 0]
  } else {
    set result $param
  }
  return $result
}

proc getTimeUnitComboBox {param value prn special_input_id class} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'
  set s "<tr>"
    append s "<td class='$class'>\${[getDescription $param]}</td>"
    append s "<td>"
      append s "<select id=$elemId name=$param class='j_power j_powerDelayUnit j_expert'>"
        append s "<option value='0'>\${optionUnit100MS}</option>"
        append s "<option value='1'>\${optionUnitS}</option>"
        append s "<option value='2'>\${optionUnitM}</option>"
        append s "<option value='3'>\${optionUnitH}</option>"
      append s "</select>"
    append s "</td>"
  append s "</tr>"
  append s "<script type=\"text/javascript\">"
    append s "jQuery($j_elemId).val('$value');"
  append s "</script>"
  return $s
}

proc getCheckBox {param value prn special_input_id class} {
  set checked ""
  if { $value } then { set checked "checked=\"checked\"" }
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set s "<tr>"
  append s "<td class='$class'>\${[getDescription $param]}</td>"
  append s "<td class='$class'><input id=$elemId type='checkbox' $checked value='dummy' name=$param></td>"
  append s "</tr>"
  return $s
}

proc getTextField {param value prn special_input_id class} {
  global psDescr
  upvar psDescr descr
  set param [trimParam $param]
  set paramName [getParamName $param]
  set elemId 'separate_$special_input_id\_$prn'

  # Limit float to 2 decimal places
  if {[llength [split $value "."]] == 2} {
    set value [format {%1.2f} $value]
  }
  set s "<tr>"
  set style ''
  if {([string first "COND_TX_THRESHOLD_" $param 0] != -1)} {
    #set style 'width:150px'
  }

  append s "<td class='$class' style=$style>\${[getDescription $param]}</td>"

   if {[string first "COND_TX_THRESHOLD_HI" $param 0] != -1  || [string first "COND_TX_THRESHOLD_LO" $param 0] != -1 } {
    append s "<td class='$class'><input id=$elemId type=\"text\" size=\"5\" value=$value name=$param onblur='setVal(this, \"POWER\")' >&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
   } else {
    if {[string first "lowerVal_" $param 0] != -1 || [string first "upperVal_" $param 0] != -1} {
      append s "<td class='$class'><input id=$elemId type=\"text\" size=\"5\" value=$value name=$param onblur='setVal(this, \"POWER\")'>&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    } else {
      append s "<td class='$class'><input id=$elemId type=\"text\" size=\"5\" value=$value name=$param onblur='ProofAndSetValue(this.id, this.id, [getMinValue $param], [getMaxValue $param], 1);'>&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    }
  }
  append s "</tr>"
  return $s
}


#Namen der EasyModes tauchen nicht mehr auf. Der Durchgängkeit werden sie hier noch definiert.
set PROFILES_MAP(0)	"Experte"
set PROFILES_MAP(1)	"TheOneAndOnlyEasyMode"

proc _set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
	global iface_url psDescr MEASUREMENT_TYPE
	upvar PROFILES_MAP  PROFILES_MAP
	upvar HTML_PARAMS   HTML_PARAMS
	upvar PROFILE_PNAME PROFILE_PNAME
	upvar $pps          ps
	upvar $pps_descr    ps_descr

	#upvar PROFILE_0     PROFILE_0
	upvar PROFILE_1     PROFILE_1

	puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_PMSw.js')</script>"


  set chn [lindex [split $special_input_id _] 1]

  set MEASUREMENT_TYPE POWER
  set typeSelector j_power
  set selectBoxId powerSelectId

	foreach pro [array names PROFILES_MAP] {
		upvar PROFILE_$pro PROFILE_$pro
	}
  foreach val [array names ps] {
    #exec echo "$val - $ps($val)" >> /tmp/psDescr.txt
  }
	array set psDescr [xmlrpc $iface_url($iface) getParamsetDescription [list string $address] [list string MASTER]]

	append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

      append HTML_PARAMS(separate_1) "<tr><td colspan='2'>"
        append HTML_PARAMS(separate_1) "<div><b>\${descriptionMeasurement$MEASUREMENT_TYPE}</b></div>"
      append HTML_PARAMS(separate_1) "</td></tr>"

      append HTML_PARAMS(separate_1) "<tr><td colspan='2'>"
        append HTML_PARAMS(separate_1) "<select id=\"$selectBoxId\" onchange=\"setMode(this, '$chn')\">"
          append HTML_PARAMS(separate_1) "<option value='0'>\${powerOptionExpert}</option>"
          append HTML_PARAMS(separate_1) "<option value='1'>\${powerOptionHi}</option>"
          append HTML_PARAMS(separate_1) "<option value='2'>\${powerOptionLo}</option>"
          append HTML_PARAMS(separate_1) "<option value='3'>\${powerOptionMasterSlave}</option>"
          append HTML_PARAMS(separate_1) "<option value='4'>\${xOptionNotInUse}</option>"
        append HTML_PARAMS(separate_1) "</select>"
      append HTML_PARAMS(separate_1) "</td></tr>"

      # Description
      append HTML_PARAMS(separate_1) "<tr><td colspan='2'>"
        append HTML_PARAMS(separate_1) "<div id='profileDescription$MEASUREMENT_TYPE'></div>"
      append HTML_PARAMS(separate_1) "</td></tr>"

      set expertParamSel "hidden $typeSelector j_expert"
      set upperValueSel "hidden $typeSelector j_expert j_upperVal"
      set lowerValueSel "hidden $typeSelector j_expert j_lowerVal"
      set upperTmpValue0Sel "hidden $typeSelector j_upperTmpVal0 j_tmp"
      set upperTmpValue1Sel "hidden $typeSelector j_upperTmpVal1 j_tmp"
      set lowerTmpValue0Sel "hidden $typeSelector j_lowerTmpVal0 j_tmp"
      set lowerTmpValue1Sel "hidden $typeSelector j_lowerTmpVal1 j_tmp"

      set prn 1
      set param COND_TX_THRESHOLD_HI
      append HTML_PARAMS(separate_1) [getTextField $param $ps($param) $prn $special_input_id $upperValueSel]
        set param lowerVal_$MEASUREMENT_TYPE
        append HTML_PARAMS(separate_1) [getTextField $param  $ps(COND_TX_THRESHOLD_LO) "$prn\_low" $special_input_id $upperTmpValue0Sel]

      incr prn
      set param COND_TX_THRESHOLD_LO
      append HTML_PARAMS(separate_1) [getTextField $param $ps($param) $prn $special_input_id $lowerValueSel]
        set param upperVal_$MEASUREMENT_TYPE
        append HTML_PARAMS(separate_1) [getTextField $param  $ps(COND_TX_THRESHOLD_HI) "$prn\_high" $special_input_id $lowerTmpValue1Sel]

      incr prn
      set param COND_TX_CYCLIC_ABOVE
      append HTML_PARAMS(separate_1) [getCheckBox $param $ps($param) $prn $special_input_id $expertParamSel]


      incr prn
      set param COND_TX_CYCLIC_BELOW
      append HTML_PARAMS(separate_1) [getCheckBox $param $ps($param) $prn $special_input_id $expertParamSel]

      incr prn
      set param COND_TX_DECISION_ABOVE
      append HTML_PARAMS(separate_1)  [getTextField $param $ps($param) $prn $special_input_id $expertParamSel]

      incr prn
      set param COND_TX_DECISION_BELOW
      append HTML_PARAMS(separate_1)  [getTextField $param $ps($param) $prn $special_input_id $expertParamSel]

      incr prn
      set param COND_TX_FALLING
      append HTML_PARAMS(separate_1) [getCheckBox $param $ps($param) $prn $special_input_id $expertParamSel]


      incr prn
      set param COND_TX_RISING
      append HTML_PARAMS(separate_1) [getCheckBox $param $ps($param) $prn $special_input_id $expertParamSel]

      incr prn
      set param EVENT_DELAY_UNIT
      append HTML_PARAMS(separate_1) [getTimeUnitComboBox $param $ps($param) $prn $special_input_id $expertParamSel]

      incr prn
      set param EVENT_DELAY_VALUE
      append HTML_PARAMS(separate_1) [getTextField $param $ps($param) $prn $special_input_id $expertParamSel]
      append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">jQuery('#separate_$special_input_id\_$prn').addClass('j_powerDelayVal');</script>"

  append HTML_PARAMS(separate_1) "</table>"

  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/MeasurementSwitch.js');"
    append HTML_PARAMS(separate_1) "var power = {}; jQuery.extend(power, measurementSwitch);"
    append HTML_PARAMS(separate_1) "power.init('$MEASUREMENT_TYPE');"
    append HTML_PARAMS(separate_1) "power.showActiveProfile('$chn');"
  append HTML_PARAMS(separate_1) "</script>"
}

# Channel 7 of the PSM has no functionality yet
proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  upvar HTML_PARAMS   HTML_PARAMS


  # Hide all parameters of this channel
  append HTML_PARAMS(separate_0) ""
  append HTML_PARAMS(separate_1) ""
}

constructor
