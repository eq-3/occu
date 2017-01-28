source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]

proc getMaintenance {chn p descr} {
  upvar $p ps
  upvar $descr psDescr
  upvar prn prn

  set html ""

  set param CYCLIC_INFO_MSG
  if { ! [catch {set tmp $ps($param)}]  } {
    append html "<tr>"
      append html "<td>\${stringTableCyclicInfoMsg}</td>"
      append html  "<td>[getCheckBoxCyclicInfoMsg $param $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }

  incr prn
  set param CYCLIC_INFO_MSG_DIS
  if { ! [catch {set tmp $ps($param)}]  } {
    append html "<tr>"
      append html "<td>\${stringTableCyclicInfoMsgDis}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  incr prn
  set param CYCLIC_INFO_MSG_DIS_UNCHANGED
  if { ! [catch {set tmp $ps($param)}]  } {
    append html "<tr>"
      append html "<td>\${stringTableCyclicInfoMsgDisUnChanged}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  incr prn
  set param LOCAL_RESET_DISABLED
  if { ! [catch {set tmp $ps($param)}]  } {
    append html "<tr>"
      append html "<td>\${stringTableLocalResetDisable}</td>"
      append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }

  set param GLOBAL_BUTTON_LOCK
  if { ! [catch {set tmp $ps($param)}]  } {
     incr prn
     append html "<tr>"
       append html "<td>\${stringTableGlobalButtonLock}</td>"
       append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]</td>"
     append html "</tr>"
  }

  set param ROUTER_MODULE_ENABLED
  if { ! [catch {set tmp $ps($param)}]  } {
     incr prn
     append html "<tr>"
       append html "<td>\${stringTableEnableRouting}</td>"
       append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]</td>"
     append html "</tr>"
  }

  return $html
}

proc getKeyTransceiver {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set html ""


  set param DBL_PRESS_TIME
  if { ! [catch {set tmp $ps($param)}]  } {
    append html "<tr>"
      append html "<td>\${stringTableKeyDblPressTime}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
    incr prn
  }

  set param LONG_PRESS_TIME
  if { ! [catch {set tmp $ps($param)}]  } {
    append html "<tr>"
      append html "<td>\${stringTableKeyLongPressTimeA}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]&nbsp;[]</td>"
    append html "</tr>"
    incr prn
  }

  set param REPEATED_LONG_PRESS_TIMEOUT_UNIT
  if { ! [catch {set tmp $ps($param)}]  } {
    append html "<tr>"
    append html "<td>\${stringTableKeyLongPressTimeOut}</td>"
    append html [getComboBox $chn $prn "$specialID" "delayShort"]
    append html "</tr>"

    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param REPEATED_LONG_PRESS_TIMEOUT_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${stringTableKeyLongPressTimeOutValue}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }
  return $html
}

proc getGenericInputTransmitter {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set html ""

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-FAL_MIOB.js');</script>"

  set param MIOB_DIN_CONFIG
  append html "<tr>"
    append html "<td>\${stringTableMiobDinConfig}</td>"
    option MIOB_DIN_CONFIG
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn "onchange=\"showHideKeyParams($chn);\""]</td>"
  append html "</tr>"

  incr prn
  append html "<tr>"
  append html "<td>\${stringTableEventDelay}</td>"
  append html [getComboBox $chn $prn "$specialID" "delayShort"]
  append html "</tr>"

  set param EVENT_DELAY_UNIT
  append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param EVENT_DELAY_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableEventDelayValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  incr prn
  set param DBL_PRESS_TIME
  append html "<tr class=\"hidden\" name=\"paramKey_$chn\">"
    append html "<td>\${stringTableKeyDblPressTime}</td>"
    append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn
  set param LONG_PRESS_TIME
  append html "<tr class=\"hidden\" name=\"paramKey_$chn\">"
    append html "<td>\${stringTableKeyLongPressTimeA}</td>"
    append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]&nbsp;[]</td>"
  append html "</tr>"

  incr prn
  append html "<tr class=\"hidden\" name=\"paramKey_$chn\">"
  append html "<td>\${stringTableKeyLongPressTimeOut}</td>"
  append html [getComboBox $chn $prn "$specialID" "delayShort"]
  append html "</tr>"

  set param REPEATED_LONG_PRESS_TIMEOUT_UNIT
  append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param REPEATED_LONG_PRESS_TIMEOUT_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableKeyLongPressTimeOutValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"

  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  append html "<script type=\"text/javascript\">"

    # This is necessary for the parameters of keys.
    # When the last value of the time select box is chosen (Enter value) then show additional elements to allow
    # the user to enter a time.
    append html "initKeyParams = function(chn) \{"
     append html "var timeSelectElm = jQuery(\"#timeDelay_\"+chn+\"_6\");"
     append html "var timeDelayVal = timeSelectElm.val();"
     append html "var valueForEnterUserVal = parseInt(jQuery(\"#\" +timeSelectElm.attr(\"id\") + \" option:last-child\").val());"

     append html "if (parseInt(timeDelayVal) == valueForEnterUserVal) \{"
       append html "jQuery(\"#timeBase_\"+chn+\"_6\").attr(\"name\",\"paramKey_\" + chn);"
       append html "jQuery(\"#timeFactor_\"+chn+\"_7\").attr(\"name\",\"paramKey_\" + chn);"
       append html "jQuery(\"#space_\"+chn+\"_7\").attr(\"name\",\"paramKey_\" + chn);"
     append html "\}"

    append html "\};"

    # Show the parameters for the configuration of the keys only when the mode TACTILE_SWITCH_INPUT is chosen
    append html "showHideKeyParams = function(chn) \{"
      append html "var arKeyParams = jQuery(\"\[name='paramKey_\" + chn +\"'\]\");"
      # append html "var selectedMode = parseInt(jQuery(\"#separate_CHANNEL_\" + chn + \"_1\").val());"
      # append html "if (selectedMode == 4) \{arKeyParams.show();\} else \{arKeyParams.hide();\}"

      append html "var optionClass = jQuery(\"#separate_CHANNEL_\" + chn + \"_1\ option:selected\").attr(\"class\");"
      append html "if (optionClass == \"TACTILE_SWITCH_INPUT\") \{arKeyParams.show();\} else \{arKeyParams.hide();\}"
    append html "\};"

    append html "setTimeout(function() {initKeyParams($chn);showHideKeyParams($chn);},200);"
  append html "</script>"

  return $html
}

proc getAnalogOutputTransceiver {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set html ""

  set param VOLTAGE_0
  append html "<tr>"
    append html "<td>\${stringTableVoltage0}</td>"
    append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]&nbsp;[]</td>"
  append html "</tr>"

  incr prn
  set param VOLTAGE_100
  append html "<tr>"
    append html "<td>\${stringTableVoltage100}</td>"
    append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]&nbsp;[]</td>"
  append html "</tr>"
}

proc getSwitchTransmitter {chn p descr} {
  
  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set html ""

  append html "<tr>"
  append html "<td>\${stringTableEventDelay}</td>"
  append html [getComboBox $chn $prn "$specialID" "delayShort"]
  append html "</tr>"

  set param EVENT_DELAY_UNIT
  append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param EVENT_DELAY_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableEventDelayValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  incr prn
  append html "<tr>"
  append html "<td>\${stringTableRandomTime}</td>"
  append html [getComboBox $chn $prn "$specialID" "delayShort"]
  append html "</tr>"

  set param EVENT_RANDOMTIME_UNIT
  append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param EVENT_RANDOMTIME_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableRamdomTimeValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  set param LED_DISABLE_CHANNELSTATE
  if { ! [catch {set tmp $ps($param)}]  } {
    # In older versions this parameter is not available
     incr prn
     append html "<tr>"
       append html "<td>\${stringTableLEDDisableChannelState}</td>"
       append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]</td>"
     append html "</tr>"
  }
  return $html
}

proc getDimmerTransmitter {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set html ""

  append html "<tr>"
  append html "<td>\${stringTableEventDelay}</td>"
  append html [getComboBox $chn $prn "$specialID" "delayShort"]
  append html "</tr>"

  set param EVENT_DELAY_UNIT
  append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param EVENT_DELAY_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableEventDelayValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  incr prn
  append html "<tr>"
  append html "<td>\${stringTableRandomTime}</td>"
  append html [getComboBox $chn $prn "$specialID" "delayShort"]
  append html "</tr>"
  set param EVENT_RANDOMTIME_UNIT
  append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param EVENT_RANDOMTIME_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableRamdomTimeValue}</td>"
  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  incr prn
  set param FUSE_DELAY
  append html "<tr>"
    append html "<td>\${stringTableDimmerFuseDelay}</td>"
  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn
  set param OVERTEMP_LEVEL
  append html "<tr>"
    append html "<td>\${stringTableDimmerOverTempLevel}</td>"
  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  return $html
}

proc getAlarmSwitchVirtualReceiver {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  puts "<script type=\"text/javascript\">getLangInfo_Special('VIRTUAL_HELP.txt');</script>"

  set specialID "[getSpecialID $special_input_id]"

  set html ""

set comment {
  # This parameter is not longer available
  set param "CURRENTDETECTION_BEHAVIOR"
  append html "<tr>"
    append html "<td>\${stringTableCurrentDetectionBehavior}</td>"
    option CURRENTDETECTION_BEHAVIOR
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
  append html "</tr>"
}

  # incr prn - activate this, when the paramater CURRENTDETECTION_BEHAVIOR is active
  set param "LOGIC_COMBINATION"
  append html "<tr>"
    append html "<td>\${stringTableLogicCombination}</td>"
    option LOGIC_COMBINATION
      append html "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
      append html "<td>&nbsp<input class=\"j_helpBtn\" id=\"virtual_help_button_$chn\" type=\"button\" value=\"Hilfe\" onclick=\"Virtual_DimmerChannel_help($chn);\"></td>"
  append html "</tr>"

set comment {
  # This parameters aren't reasonable for this device
  incr prn
  set param POWERUP_JUMPTARGET
  append html "<tr>"
    append html "<td>\${stringTableDimmerPowerUpAction}</td>"
    option POWERUP_JUMPTARGET
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
  append html "</tr>"  
  
  incr prn
  append html "<tr>"
  append html "<td>\${stringTableOnDelay}</td>"
  append html [getComboBox $chn $prn "$specialID" "delayShort"]
  append html "</tr>"
  
  set param POWERUP_ONDELAY_UNIT
  append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]
  
  
  incr prn
  set param POWERUP_ONDELAY_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableOnDelayValue}</td>"
  
  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
  
  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  incr prn
  append html "<tr>"
  append html "<td>\${stringTableOnTime}</td>"
  append html [getComboBox $chn $prn "$specialID" "timeOnOff"]
  append html "</tr>"

  set param POWERUP_ONTIME_UNIT
  append html [getTimeUnitComboBox $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param POWERUP_ONTIME_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableOnTimeValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

}

  #### HELP
  append html "<tr><td colspan=\"3\">"
    append html "<table class=\"ProfileTbl\" id=\"virtual_ch_help_$chn\" style=\"display:none\">"
    append html "<tr><td>\${virtualHelpTxt}</td></tr>"
    append html "</table>"
  append html "</td></tr>"

  puts "<script type=\"text/javascript\">"
    puts "jQuery(\".j_helpBtn\").val(translateKey(\"helpBtnTxt\"));"
  puts "</script>"

  return $html
}

proc getDimmerVirtualReceiver {chn p descr} {
  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set html ""

  if {[session_is_expert]} {
    set param "LOGIC_COMBINATION"
    append html "<tr>"
      append html "<td>\${stringTableLogicCombination}</td>"
      option LOGIC_COMBINATION
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
    append html "</tr>"

    append html "[getHorizontalLine]"
  }

  incr prn
  set param POWERUP_JUMPTARGET
  append html "<tr>"
    append html "<td>\${stringTableDimmerPowerUpAction}</td>"
    option POWERUP_JUMPTARGET
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
  append html "</tr>"


  incr prn
  append html "<tr>"
  append html "<td>\${stringTableOnDelay}</td>"
  append html [getComboBox $chn $prn "$specialID" "delayShort"]
  append html "</tr>"

  set param POWERUP_ONDELAY_UNIT
  append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]


  incr prn
  set param POWERUP_ONDELAY_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableOnDelayValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  incr prn
  append html "<tr>"
  append html "<td>\${stringTableOnTime}</td>"
  append html [getComboBox $chn $prn "$specialID" "timeOnOff"]
  append html "</tr>"

  set param POWERUP_ONTIME_UNIT
  append html [getTimeUnitComboBox $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param POWERUP_ONTIME_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableOnTimeValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  return $html
}

proc getHeatingClimateControlSwitchTransmitter {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set hlpBoxWidth 450
  set hlpBoxHeight 160

  set html ""

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HEATINGTHERMOSTATE_2ND_GEN.js');load_JSFunc('/config/easymodes/MASTER_LANG/HEATINGTHERMOSTATE_2ND_GEN_HELP.js');</script>"


  set param HEATING_COOLING
  append html "<tr>"
    append html "<td>\${stringTableHeatingCooling}</td>"
    array_clear options
    set options(0) "\${stringTableHeating}"
    set options(1) "\${stringTableCooling}"
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
  append html "</tr>"

  incr prn
  set param TWO_POINT_HYSTERESIS
  append html "<tr>"
    append html "<td>\${stringTableSwitchTransmitTwoPointHysteresis}</td>"
    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
  append html "</tr>"

  return $html
}

proc getSwitchVirtualReceiver {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set html ""

  set param CURRENTDETECTION_BEHAVIOR
  if { ! [catch {set tmp $ps($param)}]  } {
    append html "<tr>"
      append html "<td>\${stringTableCurrentDetectionBehavior}</td>"
      array_clear option
      set option(0) "\${stringTableCurrentDetectionBehaviorActive}"
      set option(1) "\${stringTableCurrentDetectionBehaviorOutput1}"
      set option(2) "\${stringTableCurrentDetectionBehaviorOutput2}"
      append html  "<td>[getOptionBox '$param' option $ps($param) $chn $prn]</td>"
    append html "</tr>"
    incr prn
  }

  if {[session_is_expert]} {
    set param "LOGIC_COMBINATION"
    append html "<tr>"
      append html "<td>\${stringTableLogicCombination}</td>"
      option LOGIC_COMBINATION
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
    append html "</tr>"


    append html "[getHorizontalLine]"
    incr prn
  }

  set param POWERUP_JUMPTARGET
  append html "<tr>"
    append html "<td>\${stringTableDimmerPowerUpAction}</td>"
    option POWERUP_JUMPTARGET
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
  append html "</tr>"
  
  
  incr prn
  append html "<tr>"
  append html "<td>\${stringTableOnDelay}</td>"
  append html [getComboBox $chn $prn "$specialID" "delayShort"]
  append html "</tr>"
  
  set param POWERUP_ONDELAY_UNIT
  append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]
  
  
  incr prn
  set param POWERUP_ONDELAY_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableOnDelayValue}</td>"
  
  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
  
  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  
  
  incr prn
  append html "<tr>"
  append html "<td>\${stringTableOnTime}</td>"
  append html [getComboBox $chn $prn "$specialID" "timeOnOff"]
  append html "</tr>"
  
  set param POWERUP_ONTIME_UNIT
  append html [getTimeUnitComboBox $param $ps($param) $chn $prn $special_input_id]
  
  incr prn
  set param POWERUP_ONTIME_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableOnTimeValue}</td>"
  
  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
  
  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  return $html
}

proc getEnergieMeterTransmitter {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set html ""

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_PMSw.js')</script>"

  append html "<tr><td colspan='2'><b>\${energyMeterTransmitterHeader}<b/><br/><br/></td></tr>"

  append html "<tr>"
  append html "<td>\${stringTableEventDelay}</td>"
  append html [getComboBox $chn $prn "$specialID" "delayShort"]
  append html "</tr>"

  set param EVENT_DELAY_UNIT
  append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param EVENT_DELAY_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableEventDelayValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  incr prn
  append html "<tr>"
  append html "<td>\${stringTableRandomTime}</td>"
  append html [getComboBox $chn $prn "$specialID" "delayShort"]
  append html "</tr>"

  set param EVENT_RANDOMTIME_UNIT
  append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param EVENT_RANDOMTIME_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableRamdomTimeValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  incr prn
  append html "<tr>"
  append html "<td>\${stringTableTxMinDelay}</td>"
  append html [getComboBox $chn $prn "$specialID" "delayShort"]
  append html "</tr>"

  set param TX_MINDELAY_UNIT
  append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param TX_MINDELAY_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableRamdomTimeValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  append html [getHorizontalLine]

  incr prn
  set param AVERAGING
  append html "<tr>"
    append html "<td>\${stringTablePowerMeterAveraging}</td>"
    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"


  append html "<tr><td colspan='2'><br/><br/>\${PMSwChannel2HintHeader}</td></tr>"

  incr prn
  set param TX_THRESHOLD_POWER
  append html "<tr>"
    append html  "<td>\${PMSwChannel2Hint_Power}</td>"
    array_clear option
    set option(0) "\${stringTableNotUsed}"
    set option(1) "\${optionEnterValue}"

    append prnTmp $prn _tmp

    append html  "<td>[getOptionBox '$param' option $ps($param) $chn $prnTmp "onchange=\"test(this, '$prn');\""]</td>"
    append html "<td><span id=\"field_$prn\">[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</span></td>"
  append html "</tr>"
  append html "<script type=\"text/javascript\">"
    append html "if ($ps($param) > 0) {document.getElementById('separate_CHANNEL_$chn\_$prnTmp').options\[1\].selected = true;document.getElementById('field_$prn').style.visibility='visible';} else {document.getElementById('separate_CHANNEL_$chn\_$prnTmp').options\[0\].selected = true;document.getElementById('field_$prn').style.visibility='hidden';}"
  append html "</script>"



  incr prn
  set param TX_THRESHOLD_ENERGY
  append html "<tr>"
  append html  "<td>\${PMSwChannel2Hint_Energy}</td>"
    array_clear option
    set option(0) "\${stringTableNotUsed}"
    set option(1) "\${optionEnterValue}"
    append prnTmp $prn _tmp
    append html  "<td>[getOptionBox '$param' option $ps($param) $chn $prnTmp "onchange=\"test(this, '$prn');\""]</td>"
    append html "<td><span id=\"field_$prn\">[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</span></td>"
  append html "</tr>"
    append html "<script type=\"text/javascript\">"
      append html "if ($ps($param) > 0) {document.getElementById('separate_CHANNEL_$chn\_$prnTmp').options\[1\].selected = true;document.getElementById('field_$prn').style.visibility='visible';} else {document.getElementById('separate_CHANNEL_$chn\_$prnTmp').options\[0\].selected = true;document.getElementById('field_$prn').style.visibility='hidden';}"
    append html "</script>"

  append html "<tr><td>\${PMSwChannel2Hint_Footer}<br/><br/></td></tr>"

  append html "<script type=\"text/javascript\">"
  append html "test = function(elm, prn) \{"
    append html "document.getElementById('field_' + prn).style.visibility=(elm.selectedIndex < 1)?'hidden':'visible';document.getElementById('separate_CHANNEL_$chn\_' +prn).value=parseFloat(elm.options\[elm.selectedIndex\].value);"
  append html "\};"

  append html "</script>"

  return $html
}

proc getCondSwitchTransmitter {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set html ""

  set param COND_TX_CYCLIC_ABOVE
  append html "<tr>"
    append html "<td>\${stringTableCondTxCyclicAbove}</td>"
    append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn;
  set param COND_TX_CYCLIC_BELOW
  append html "<tr>"
    append html "<td>\${stringTableCondTxCyclicBelow}</td>"
    append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn
  set param COND_TX_DECISION_ABOVE
  append html "<tr>"
    append html "<td>\${stringTableCondTxDecisionAbove}</td>"
    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn
  set param COND_TX_DECISION_BELOW
  append html "<tr>"
    append html "<td>\${stringTableCondTxDecisionBelow}</td>"
    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn;
  set param COND_TX_FALLING
  append html "<tr>"
    append html "<td>\${stringTableCondTxFalling}</td>"
    append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn;
  set param COND_TX_RISING
  append html "<tr>"
    append html "<td>\${stringTableCondTxRising}</td>"
    append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn
  set param COND_TX_THRESHOLD_HI
  append html "<tr>"
    append html "<td>\${stringTableCondThresholdHi}</td>"
   append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn
  set param COND_TX_THRESHOLD_LO
  append html "<tr>"
    append html "<td>\${stringTableCondThresholdLo}</td>"
    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn
  append html "<tr>"
  append html "<td>\${stringTableEventDelay}</td>"
  append html [getComboBox $chn $prn "$specialID" "delayShort"]
  append html "</tr>"

  set param EVENT_DELAY_UNIT
  append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param EVENT_DELAY_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableEventDelayValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  incr prn
  append html "<tr>"
  append html "<td>\${stringTableRandomTime}</td>"
  append html [getComboBox $chn $prn "$specialID" "delayShort"]
  append html "</tr>"

  set param EVENT_RANDOMTIME_UNIT
  append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param EVENT_RANDOMTIME_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableRamdomTimeValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

}

# ACCELERATION_TRANSCEIVER
# Introduced with the HmIP-SAM (1612)
proc getAccelerationTransceiver {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set html ""

  append html "<tr>"
  append html "<td>\${stringTableEventDelay}</td>"
  append html [getComboBox $chn $prn "$specialID" "delayShort"]
  append html "</tr>"

  set param EVENT_DELAY_UNIT
  append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param EVENT_DELAY_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableEventDelayValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  incr prn
  set param CHANNEL_OPERATION_MODE
  append html "<tr>"
    append html "<td>\${motionDetectorChannelOperationMode}</td>"
    array_clear options
    # not in use for HmIP-SAM set options(0) "\${motionDetectorChannelOperationModeOff}"
    set options(1) "\${motionDetectorChannelOperationModeAnyMotion}"
    set options(3) "\${motionDetectorChannelOperationModeFlat}"
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
  append html "</tr>"

set comment {
  # For the HmIP-SAM this parameter is alway 1 and not changeable
  incr prn
  set param EVENT_FILTER_NUMBER
  append html "<tr>"
    append html "<td>\${stringTableEventFilterNumber}</td>"
   append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"
}
  incr prn
  set param EVENT_FILTER_PERIOD
  append html "<tr>"
    append html "<td>\${motionDetectorFilterPeriod}</td>"
   append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn
  set param MSG_FOR_POS_A
  append html "<tr>"
    append html "<td>\${motionDetectorMessageMovement}</td>"
    array_clear options
    set options(0) "\${motionDetectorOptionNoMessage}"
    set options(1) "\${motionDetectorOptionNoMotion}"
    set options(2) "\${motionDetectorOptionMotion}"
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn
  set param MSG_FOR_POS_B
  append html "<tr>"
    append html "<td>\${motionDetectorMessageNoMovement}</td>"
    array_clear options
    set options(0) "\${motionDetectorOptionNoMessage}"
    set options(1) "\${motionDetectorOptionNoMotion}"
    set options(2) "\${motionDetectorOptionMotion}"
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn
  set param NOTIFICATION_SOUND_TYPE_HIGH_TO_LOW
  append html "<tr>"
    append html "<td>\${motionDetectorNotificationNoMovement}</td>"
    array_clear options
    set options(0) "\${stringTableSoundNoSound}"
    set options(1) "\${stringTableSoundShort}"
    set options(2) "\${stringTableSoundShortShort}"
    set options(3) "\${stringTableSoundLong}"
    set options(4) "\${stringTableSoundLongShort}"
    set options(5) "\${stringTableSoundLongLong}"
    set options(6) "\${stringTableSoundLongShortShort}"
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn
  set param NOTIFICATION_SOUND_TYPE_LOW_TO_HIGH
  append html "<tr>"
    append html "<td>\${motionDetectorNotificationMovement}</td>"
    array_clear options
    set options(0) "\${stringTableSoundNoSound}"
    set options(1) "\${stringTableSoundShort}"
    set options(2) "\${stringTableSoundShortShort}"
    set options(3) "\${stringTableSoundLong}"
    set options(4) "\${stringTableSoundLongShort}"
    set options(5) "\${stringTableSoundLongLong}"
    set options(6) "\${stringTableSoundLongShortShort}"
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
  append html "</tr>"

    incr prn
    set param SENSOR_SENSITIVITY
    append html "<tr>"
      append html "<td>\${motionDetectorSensorSensivity}</td>"
      array_clear options
      set options(0) "\${motionDetectorSensorRange16G}"
      set options(1) "\${motionDetectorSensorRange8G}"
      set options(2) "\${motionDetectorSensorRange4G}"
      set options(3) "\${motionDetectorSensorRange2G}"
      set options(4) "\${motionDetectorSensorRange2GPlusSens}"
      set options(5) "\${motionDetectorSensorRange2G2PlusSense}"
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
    append html "</tr>"

  incr prn
  set param TRIGGER_ANGLE
  append html "<tr>"
    append html "<td>\${motionDetectorTriggerAngle}</td>"
   append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

}

proc getClimateControlFloorDirectTransmitter {chn p descr} {
  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set html ""

  set hlpBoxWidth 450
  set hlpBoxHeight 100

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-FAL_MIOB.js');</script>"

  set param COOLING_DISABLE
  append html "<tr>"
    append html "<td>\${stringTableCoolingDisable}</td>"
    option OPTION_DISABLE_ENABLE
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn
  set param HEATING_DISABLE
  append html "<tr>"
    append html "<td>\${stringTableHeatingDisable}</td>"
    option OPTION_DISABLE_ENABLE
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn
  set param FLOOR_HEATING_MODE
  append html "<tr>"
    append html "<td>\${stringTableFloorHeatingMode}</td>"
    option FLOOR_HEATING_MODE
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn
  set param HEATING_MODE_SELECTION
  append html "<tr>"
    append html "<td>\${stringTableHeatingModeSelection}</td>"
    option HEATING_MODE_SELECTION
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn
  set param FROST_PROTECTION_TEMPERATURE
  append html "<tr>"
    append html "<td>\${stringTableFrostProtectionTemperature}</td>"
    append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn
  set param HEATING_VALVE_TYPE
  append html "<tr>"
    append html "<td>\${stringTableHeatingValveType}</td>"
    option HEATING_VALVE_TYPE
    append html  "<td>[getOptionBox $param options $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn
  set param HUMIDITY_LIMIT_DISABLE
  append html "<tr>"
    append html "<td>\${stringTableHumidityLimitDisable}</td>"
    option OPTION_DISABLE_ENABLE
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]&nbsp;[getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
  append html "</tr>"

  incr prn
  set param HUMIDITY_LIMIT_VALUE
  append html "<tr>"
    append html "<td>\${stringTableHumidityLimitValue}</td>"
    append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn
  set param MINIMAL_FLOOR_TEMPERATURE
  append html "<tr>"
    append html "<td>\${stringTableMinimalFloorTemperature}</td>"
    append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

#######################################################################################
  append html "[getHorizontalLine]"

  # SWITCHING_INTERVAL_BASE and INTERVAL_FACTOR

  incr prn
  append html "<tr>"
  append html "<td>\${lblDecalcificationInterval}</td>"
  append html [getComboBox $chn $prn "$specialID" "switchingInterval"]
  append html "</tr>"

  set param SWITCHING_INTERVAL_BASE
  append html [getTimeUnitComboBoxB $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param SWITCHING_INTERVAL_FACTOR
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableSwitchingIntervalValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentSwitchingIntervalOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  # END SWITCHING_INTERVAL_BASE and INTERVAL_FACTOR

  # ON_TIME_BASE and ON_TIME_FACTOR

  incr prn
  append html "<tr>"
  append html "<td>\${stringTableOnTime}</td>"
  append html [getComboBox $chn $prn "$specialID" "switchingIntervalOnTime"]
  append html "</tr>"

  set param ON_TIME_BASE
  append html [getTimeUnitComboBox $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param ON_TIME_FACTOR
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableOnTimeValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentSwitchingIntervalOnTimeOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  # END ON_TIME_BASE and ON_TIME_FACTOR
}

proc getNoParamatersToSet {} {
  return "<tr><td class=\"CLASS22003\"><div class=\"CLASS22004\">\${deviceAndChannelParamsLblNoParamsToSet}</div></td></tr>"
}