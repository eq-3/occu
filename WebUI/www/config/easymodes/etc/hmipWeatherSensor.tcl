source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipChannelConfigDialogs.tcl]

proc getCondSwitchTransmitterWindSpeed {chn p descr} {
  upvar $p ps
  upvar $descr psDescr
  upvar special_input_id special_input_id

  set prn 0
  set html ""

  set chn [getChannel $special_input_id]

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_PMSw.js');load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-Weather.js');</script>"

  set param CHANNEL_OPERATION_MODE
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condSwitchTransmitterWindSpeedChannelOperationMode}</td>"
      array_clear options
      set options(0) "\${condSwitchTransmitterWindSpeedChannelOperationModeWindGustDirect}"
      set options(1) "\${condSwitchTransmitterWindSpeedChannelOperationModeWindGustForecast}"
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn "onchange=\"setFilterSelect(this.value, $chn, $prn);\""]</td>"
    append html "</tr>"
  }

  set param FILTER_SELECT
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condSwitchTransmitterWindSpeedFilterSelect}</td>"
      array_clear options
      set options(0) "\${optionSwitchTransmitterWindSpeedFilterSelectCurrentValue}"
      set options(1) "\${optionSwitchTransmitterWindSpeedFilterSelectMinValue}"
      set options(2) "\${optionSwitchTransmitterWindSpeedFilterSelectMaxValue}"
      set options(3) "\${optionSwitchTransmitterWindSpeedFilterSelectAverageValue}"
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }

  set param COND_TX_DECISION_ABOVE
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condTxDecisionWindAbove}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon COND_TX_DECISION_ABOVE_BELOW]</td>"
    append html "</tr>"
  }

  set param COND_TX_DECISION_BELOW
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condTxDecisionWindBelow}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon COND_TX_DECISION_ABOVE_BELOW]</td>"
    append html "</tr>"
  }

  set param COND_TX_THRESHOLD_HI
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condThresholdWindHi}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param COND_TX_THRESHOLD_LO
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condThresholdWindLo}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  append html "<script type=\"text/javascript\">"
    append html " setFilterSelect = function(value, chn, prn) { "
      append html " console.log(\"value: \" + value + \" - prn: \" + prn);"
      append html " var filterSelectElm = jQuery(\"#\separate_CHANNEL_\"+parseInt(chn)+\"_\" + (parseInt(prn) + 1)); "
      append html " if (parseInt(value) == 1) { "
        append html "filterSelectElm.val(3).prop(\"disabled\", true);"
      append html " } else { "
        append html "filterSelectElm.prop(\"disabled\", false);"
      append html " } "
    append html "}"
  append html "</script>"
  return $html
}

proc getCondSwitchTransmitterTemperature {chn p descr} {
  global dev_descr
  upvar $p ps
  upvar $descr psDescr
  upvar special_input_id special_input_id

  set chn [getChannel $special_input_id]
  set specialID "[getSpecialID $special_input_id]"

  set helpDlgWidth 450
  set helpDlgHeight 170

  set prn 0
  set html ""

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_PMSw.js');load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-Weather.js');</script>"

  set param COND_TX_FALLING
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableCondTxFallingTemp}</td>"
      append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]&nbsp;[getHelpIcon $param\_Temp $helpDlgWidth $helpDlgHeight]</td>"
    append html "</tr>"
  }

  set param COND_TX_CYCLIC_BELOW
    if { [info exists ps($param)] == 1 } {
      incr prn;
      append html "<tr>"
        append html "<td>&nbsp;&nbsp;\${stringTableSendSwitchCommandCyclically}</td>"
        append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]</td>"
      append html "</tr>"
      append html [getHorizontalLine]

      append html "<script type=\"text/javascript\">"
        append html "var condTxFallingRisingElm = jQuery('#separate_$specialID\_$chn\_[expr $prn - 1]');"
        append html "var condTxCyclicBelowAboveElm = jQuery('#separate_$specialID\_$chn\_$prn');"

        append html "if (condTxCyclicBelowAboveElm.is(':checked')) \{"
          append html "condTxFallingRisingElm.prop('disabled', true);"
        append html "\}"

        append html "condTxCyclicBelowAboveElm.click(function() \{"
          append html "var elmIsChecked = jQuery(this).is(':checked');"
          append html "if (elmIsChecked) \{"
            append html "condTxFallingRisingElm.prop('checked', true).prop('disabled',true);"
          append html "\} else \{"
            append html "condTxFallingRisingElm.prop('disabled',false);"
          append html "\}"
        append html "\});"
      append html "</script>"
    }

  set param COND_TX_RISING
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableCondTxRisingTemp}</td>"
      append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]&nbsp;[getHelpIcon $param\_Temp  $helpDlgWidth $helpDlgHeight]</td>"
    append html "</tr>"
  }

  set param COND_TX_CYCLIC_ABOVE
  if { [info exists ps($param)] == 1 } {
    incr prn;
    append html "<tr>"
      append html "<td>&nbsp;&nbsp;\${stringTableSendSwitchCommandCyclically}</td>"
      append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]</td>"
      append html [getHorizontalLine]
    append html "</tr>"

      append html "<script type=\"text/javascript\">"
        append html "var condTxFallingRisingElm = jQuery('#separate_$specialID\_$chn\_[expr $prn - 1]');"
        append html "var condTxCyclicBelowAboveElm = jQuery('#separate_$specialID\_$chn\_$prn');"

        append html "if (condTxCyclicBelowAboveElm.is(':checked')) \{"
          append html "condTxFallingRisingElm.prop('disabled', true);"
        append html "\}"

        append html "condTxCyclicBelowAboveElm.click(function() \{"
        append html "var elmIsChecked = jQuery(this).is(':checked');"
        append html "if (elmIsChecked) \{"
          append html "condTxFallingRisingElm.prop('checked', true).prop('disabled',true);"
        append html "\} else \{"
          append html "condTxFallingRisingElm.prop('disabled',false);"
        append html "\}"
        append html "\});"
      append html "</script>"

  }



  set param COND_TX_DECISION_ABOVE
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condTxDecisionTempAbove}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon COND_TX_DECISION_ABOVE_BELOW]</td>"
    append html "</tr>"
  }

  set param COND_TX_DECISION_BELOW
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condTxDecisionTempBelow}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon COND_TX_DECISION_ABOVE_BELOW]</td>"
    append html "</tr>"
  }

  set param COND_TX_THRESHOLD_HI
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condThresholdTempHi}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param COND_TX_THRESHOLD_LO
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condThresholdTempLo}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }


  set param TEMPERATURE_OFFSET
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      set comment {
        array_clear options
        set i 0
        for {set val -12.8} {$val <= 12.7} {set val [expr $val + 0.1]} {
          set options($val) "$val &#176;C"
          incr i;
        }
      }
      append html "<td>\${stringTableTemperatureOffset}</td>"
      # append html "<td>[get_ComboBox options $param separate_$specialID\_$chn\_$prn ps $param]&nbsp;[getHelpIcon $param] <span class=\"attention\">Help not yet available</span></td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon $param\_STE2]</td>"

    append html "</tr>"
  }

  set param TX_MINDELAY_UNIT
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
    append html "<td>\${stringTableTxMinDelay}</td>"
    append html [getComboBox $chn $prn "$specialID" "txMinDelay"]
    append html "</tr>"

    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param TX_MINDELAY_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${stringTableTxMinDelayValue}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOptionPanelA($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }

  return $html
}

proc getCondSwitchTransmitterHumidity {chn p descr} {
  upvar $p ps
  upvar $descr psDescr
  upvar special_input_id special_input_id

  set prn 0
  set html ""

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_PMSw.js');load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-Weather.js');</script>"

  set param COND_TX_DECISION_ABOVE
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condTxDecisionHumidityAbove}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon COND_TX_DECISION_ABOVE_BELOW]</td>"
    append html "</tr>"
  }

  set param COND_TX_DECISION_BELOW
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condTxDecisionHumidityBelow}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon COND_TX_DECISION_ABOVE_BELOW]</td>"
    append html "</tr>"
  }

  set param COND_TX_THRESHOLD_HI
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condThresholdHumidityHi}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param COND_TX_THRESHOLD_LO
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condThresholdHumidityLo}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }
  return $html

  return $html
}

proc getCondSwitchTransmitterBrightness {chn p descr} {
  upvar $p ps
  upvar $descr psDescr
  upvar special_input_id special_input_id

  set prn 0
  set html ""

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_PMSw.js');load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-Weather.js');</script>"



  set bckColor "silver"
  append html "<tr>"
    append html "<td colspan='2' style=\"text-align:center; background-color:$bckColor\">\${sunshineThreshold}</td>"
  append html "</tr>"

  # Bestimmt zusammen mit dem nächsten Parameter, ab welchem LUX-Wert Sonnenschein angenommen wird.
  # Wert = VAL * 10 ^ EXP
  set param BRIGHTNESS_THRESHOLD_VAL
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${brightnessThresholdVAL}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param BRIGHTNESS_THRESHOLD_EXP
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${brightnessThresholdEXP}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  append html "<tr>"
    append html "<td colspan='2' style=\"text-align:center; background-color:$bckColor\">\${calculation} \${brightnessThresholdVAL} * 10<sup>\${brightnessThresholdEXP}</sup> * 0.1</td>"
  append html "</tr>"

  append html "[getHorizontalLine]"

  set param COND_TX_DECISION_ABOVE
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condTxDecisionBrightnessAbove}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon COND_TX_DECISION_ABOVE_BELOW]</td>"
    append html "</tr>"
  }

  set param COND_TX_DECISION_BELOW
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condTxDecisionBrightnessBelow}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon COND_TX_DECISION_ABOVE_BELOW]</td>"
    append html "</tr>"
  }

  set param COND_TX_THRESHOLD_HI
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condThresholdBrightnessHi}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param COND_TX_THRESHOLD_LO
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condThresholdBrightnessLo}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }
  return $html

  return $html
}

proc getCondSwitchTransmitterRainQuantity {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar special_input_id special_input_id

  set prn 0
  set specialID "[getSpecialID $special_input_id]"

  set html ""

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_PMSw.js');load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-Weather.js');</script>"
  set param COND_TX_DECISION_ABOVE
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condTxDecisionRainQuantityAbove}</td>"
      append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon COND_TX_DECISION_ABOVE_BELOW]</td>"
    append html "</tr>"
  }

  set param COND_TX_THRESHOLD_HI
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condThresholdRainQuantity}</td>"
      append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param EVENT_TIMEOUT_BASE
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
    append html "<td>\${eventTimeoutRainCounter}</td>"
    append html [getComboBox $chn $prn "$specialID" "timeMin_10_15_20_25_30"]
    append html "</tr>"

    #param = EVENT_TIMEOUT_BASE
    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param EVENT_TIMEOUT_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${eventTimeoutValueRainCounter}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeMin_10_15_20_25_30Option($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }

  return $html

}

proc getCondSwitchTransmitterRainDrop {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar special_input_id special_input_id

  set prn 0
  set specialID "[getSpecialID $special_input_id]"

  set html ""

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_PMSw.js');load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-Weather.js');</script>"

  set param COND_TX_DECISION_ABOVE
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableCondTxDecisionRainDetected}</td>"
      append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon COND_TX_DECISION_ABOVE_BELOW]</td>"
    append html "</tr>"
  }

  set param COND_TX_DECISION_BELOW
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableCondTxDecisionNoRainDetected}</td>"
      append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon COND_TX_DECISION_ABOVE_BELOW]</td>"
    append html "</tr>"
  }

  set param EVENT_TIMEOUT_BASE
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
    append html "<td>\${eventTimeoutRainDrop}</td>"
    append html [getComboBox $chn $prn "$specialID" "timeMin_10_15_20_25_30"]
    append html "</tr>"

    #param = EVENT_TIMEOUT_BASE
    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param EVENT_TIMEOUT_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${eventTimeoutValueRainDrop}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeMin_10_15_20_25_30Option($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }

  return $html
}

proc getCondSwitchTransmitterWindDirection {chn p descr} {
  upvar $p ps
  upvar $descr psDescr
  upvar special_input_id special_input_id

  set prn 0
  set html ""

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_PMSw.js');load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-Weather.js');</script>"

  set param COND_TX_DECISION_ABOVE
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condTxDecisionWindDirectionAbove}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon COND_TX_DECISION_ABOVE_BELOW]</td>"
    append html "</tr>"
  }

  set param COND_TX_DECISION_BELOW
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condTxDecisionWindDirectionBelow}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon COND_TX_DECISION_ABOVE_BELOW]</td>"
    append html "</tr>"
  }

  set param COND_TX_THRESHOLD_HI
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condThresholdWindDirectionHi}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param COND_TX_THRESHOLD_LO
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condThresholdWindDirectionLo}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }
  return $html

  return $html
}

proc getCondSwitchTransmitterParticulateMatter {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar special_input_id special_input_id

  set prn 0
  set html ""

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_PMSw.js');load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-Weather.js');</script>"

  set param COND_TX_DECISION_ABOVE
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condTxDecisionParticulateMatterAbove}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon COND_TX_DECISION_ABOVE_BELOW]</td>"
    append html "</tr>"
  }

  set param COND_TX_DECISION_BELOW
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condTxDecisionParticulateMatterBelow}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon COND_TX_DECISION_ABOVE_BELOW]</td>"
    append html "</tr>"
  }

  set param COND_TX_THRESHOLD_HI
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condThresholdParticulateMatterHi}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param COND_TX_THRESHOLD_LO
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${condThresholdParticulateMatterLo}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }
  return $html

  return $html
}

proc getTempHumidityParticulateMatterTransmitter {chn p descr address} {

 upvar $p ps
 upvar $descr psDescr
 upvar special_input_id special_input_id

 set specialID "[getSpecialID $special_input_id]"

 set prn 0
 set html ""

 puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/AirQuality.js'); load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_PMSw.js');load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-Weather.js');</script>"

  set param INTERVAL_UNIT
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
    append html "<td>\${autoSensorCleaning}</td>"
    append html "[getComboBox $chn $prn $specialID autoInterval]"
    append html "</tr>"

    append html [getTimeUnitComboBoxC $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param INTERVAL_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${stringTableLevel}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentAutoIntervalOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

    append html "<tr>"
      append html "<td>"
        append html "$\{lblLocationA\}"
      append html "</td>"

      append html "<td>"
        append html "<select id='modeAirQuality' onchange='selectAQI(this.value, \"$address\");'>"
          append html "<option value='Europe'>Europa</option>"
          append html "<option value='USA'>USA</option>"
        append html "</select>"
        append html "&nbsp;[getHelpIcon AQI_MODE 450 80]"
      append html "</td>"

      append html "<script type='text/javascript'>"
         append html "setCurrentAQIMode(\"$address\");"
       append html "</script>"

  }

  return $html

}