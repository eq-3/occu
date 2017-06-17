source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]

proc getMaintenance {chn p descr} {
  upvar $p ps
  upvar $descr psDescr
  upvar prn prn

  set hlpBoxWidth 500
  set hlpBoxHeight 150

  set html ""

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-ParamHelp.js');</script>"


  set param CYCLIC_INFO_MSG
  if { ! [catch {set tmp $ps($param)}]  } {
    append html "<tr>"
      append html "<td>\${stringTableCyclicInfoMsg}</td>"
      append html  "<td>[getCheckBoxCyclicInfoMsg $param $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }

  set param CYCLIC_INFO_MSG_DIS
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableCyclicInfoMsgDis}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param CYCLIC_INFO_MSG_DIS_UNCHANGED
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableCyclicInfoMsgDisUnChanged}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param LOW_BAT_LIMIT
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableBatteryLowBatLimit}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param LOCAL_RESET_DISABLED
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
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
       append html "<td>\${stringTableRouterModuleEnabled}</td>"
       append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
     append html "</tr>"
  }

  set param ENABLE_ROUTING
  if { ! [catch {set tmp $ps($param)}]  } {
     incr prn
     append html "<tr>"
       append html "<td>\${stringTableEnableRouting}</td>"
       append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
     append html "</tr>"
  }



  set param LATITUDE
  if { ! [catch {set tmp $ps($param)}]  } {

   # append html "<tr>"
   #   append html "<td>\${lblPositionFixing}</td>"
   #   append html "<td>"
   #     append html "<input type=\"button\" name=\"btnPositionFixing\" onclick=\"alert('Set Position');\">"
   #   append html "</td>"
   # append html "</tr>"

    incr prn
    append html "<tr name='positionFixing'>"
     append html "<td>\${lblLocation} - \${dialogSettingsTimePositionLblLatitude}</td>"
    append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"

    set param LONGITUDE
    incr prn
    append html "<tr name='positionFixing'>"
     append html "<td>\${lblLocation} - \${dialogSettingsTimePositionLblLongtitude}</td>"
    append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
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

  return $html
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

proc getBlindTransmitter {chn p descr address} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set parent [lindex [split $address :] 0]

  set hlpBoxWidth 450
  set hlpBoxHeight 160

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-ParamHelp.js');load_JSFunc('/config/easymodes/js/BlindAutoCalibration.js')</script>"

  puts "<div id=\"page_$parent\" class=\"hidden\">$parent</div>"

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

  set param CHANGE_OVER_DELAY
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableBlindChangeOverDelay}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
  }

  set param REFERENCE_RUN_COUNTER
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableBlindRefRunCounter}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  append html "[getHorizontalLine]"

  # AUTOCALIBRATION
  append html "<tr id=\"autoCalibrationPanel_$parent\" class =\"hidden\">"
    append html "<td>\${stringTableSelfCalibrationStart}</td>"
    append html "<td id='tdBtnBlindAutoCalibration_$parent'><input name='btnBlindAutoCalibration' onclick='autoCalib\[\"$parent\"\].triggerAutoCalibration()' value='Auto Calibration' type='button'>[getHelpIcon HELP_BLIND_AUTOCALIBRATION $hlpBoxWidth $hlpBoxHeight]</td>"
    append html "<td id='tdBlindStopCalibration_$parent' class=\"hidden\"><input name='btnBlindStopCalibration' onclick='autoCalib\[\"$parent\"\].stopAutoCalibration()' value='Stop Calibration' type='button'></td>"
  append html "</tr>"

  append html "<tr id=\"autoCalibrationActive_$parent\" class=\"hidden\">"
    append html "<td>\${lblAutoCalibrationActiv}</td>"
    append html "<td><div><img src='/ise/img/anim_bargraph.gif'></div></td>"
  append html "</tr>"

  append html "<script type=\"text/javascript\">autoCalib = {}; autoCalib\[\"$parent\"\] = new AutoCalibrateBlind(\"$address\"); autoCalib\['$parent'\].initAutoCalibration();</script>"

  # /AUTOCALIBRATION

  incr prn
  append html "<tr>"
  append html "<td>\${stringTableBlindRunnintTimeBottomTop}</td>"
  append html [getComboBox $chn $prn "$specialID" "blindRunningTime"]
  append html "</tr>"

  set param REFERENCE_RUNNING_TIME_BOTTOM_TOP_UNIT
  append html [getTimeUnit10ms_100ms_1s_10s $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param REFERENCE_RUNNING_TIME_BOTTOM_TOP_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableTimeBottomTopValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentBlindRunningTimeOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"


  incr prn
  append html "<tr>"
  append html "<td>\${stringTableBlindRunningTimeTopBottom}</td>"
  append html [getComboBox $chn $prn "$specialID" "blindRunningTime"]
  append html "</tr>"

  set param REFERENCE_RUNNING_TIME_TOP_BOTTOM_UNIT
  append html [getTimeUnit10ms_100ms_1s_10s $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param REFERENCE_RUNNING_TIME_TOP_BOTTOM_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableTimeBottomTopValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentBlindRunningTimeOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  incr prn
  append html "<tr>"
  append html "<td>\${stringTableJalousieRunningTimeSlats}</td>"
  append html [getComboBox $chn $prn "$specialID" "slatRunningTime"]
  append html "</tr>"

  set param REFERENCE_RUNNING_TIME_SLATS_UNIT
  append html [getTimeUnit10ms_100ms_1s_10s $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param REFERENCE_RUNNING_TIME_SLATS_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableTimeSlatsValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentSlatRunningTimeOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  return $html
}

proc getShutterTransmitter {chn p descr address} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set parent [lindex [split $address :] 0]

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-ParamHelp.js');load_JSFunc('/config/easymodes/js/BlindAutoCalibration.js')</script>"

  puts "<div id=\"page_$parent\" class=\"hidden\">$parent</div>"

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

  set param CHANGE_OVER_DELAY
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableBlindChangeOverDelay}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
  }

  set param REFERENCE_RUN_COUNTER
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableBlindRefRunCounter}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  append html "[getHorizontalLine]"

  # AUTOCALIBRATION

  append html "<tr id=\"autoCalibrationPanel_$parent\" class =\"hidden\">"
    append html "<td>\${stringTableSelfCalibrationStart}</td>"
    append html "<td id='tdBtnBlindAutoCalibration_$parent'><input name='btnBlindAutoCalibration' onclick='autoCalib\[\"$parent\"\].triggerAutoCalibration()' value='Auto Calibration' type='button'></td>"
    append html "<td id='tdBlindStopCalibration_$parent' class=\"hidden\"><input name='btnBlindStopCalibration' onclick='autoCalib\[\"$parent\"\].stopAutoCalibration()' value='Stop Calibration' type='button'></td>"
  append html "</tr>"

  append html "<tr id=\"autoCalibrationActive_$parent\" class=\"hidden\">"
    append html "<td>\${lblAutoCalibrationActiv}</td>"
    append html "<td><div><img src='/ise/img/anim_bargraph.gif'></div></td>"
  append html "</tr>"

  append html "<script type=\"text/javascript\">autoCalib = {}; autoCalib\[\"$parent\"\] = new AutoCalibrateBlind(\"$address\"); autoCalib\['$parent'\].initAutoCalibration();</script>"

  # /AUTOCALIBRATION


  incr prn
  append html "<tr>"
  append html "<td>\${stringTableBlindRunnintTimeBottomTop}</td>"
  append html [getComboBox $chn $prn "$specialID" "blindRunningTime"]
  append html "</tr>"

  set param REFERENCE_RUNNING_TIME_BOTTOM_TOP_UNIT
  append html [getTimeUnit10ms_100ms_1s_10s $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param REFERENCE_RUNNING_TIME_BOTTOM_TOP_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableTimeBottomTopValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentBlindRunningTimeOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"


  incr prn
  append html "<tr>"
  append html "<td>\${stringTableBlindRunningTimeTopBottom}</td>"
  append html [getComboBox $chn $prn "$specialID" "blindRunningTime"]
  append html "</tr>"

  set param REFERENCE_RUNNING_TIME_TOP_BOTTOM_UNIT
  append html [getTimeUnit10ms_100ms_1s_10s $param $ps($param) $chn $prn $special_input_id]

  incr prn
  set param REFERENCE_RUNNING_TIME_TOP_BOTTOM_VALUE
  append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
  append html "<td>\${stringTableTimeBottomTopValue}</td>"

  append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

  append html "</tr>"
  append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
  append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentBlindRunningTimeOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

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

  puts "<script type=\"text/javascript\">getLangInfo_Special('VIRTUAL_HELP.txt');</script>"

  set specialID "[getSpecialID $special_input_id]"

  set html ""

  if {[session_is_expert]} {
    set param "LOGIC_COMBINATION"
    append html "<tr>"
      append html "<td>\${stringTableLogicCombination}</td>"
      option LOGIC_COMBINATION
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
      append html "<td>&nbsp<input class=\"j_helpBtn\" id=\"virtual_help_button_$chn\" type=\"button\" value=\"Hilfe\" onclick=\"Virtual_DimmerChannel_help($chn);\"></td>"

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

proc getBlindVirtualReceiver {chn p descr} {
  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set html ""

  if {[session_is_expert]} {
    set param "LOGIC_COMBINATION"
    if { ! [catch {set tmp $ps($param)}]  } {
      append html "<tr>"
        append html "<td>\${stringTableLogicCombinationBlind}</td>"
        option LOGIC_COMBINATION
        append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
      append html "</tr>"
      incr prn
      set param "LOGIC_COMBINATION_2"
      append html "<tr>"
        append html "<td>\${stringTableLogicCombinationSlat}</td>"
        option LOGIC_COMBINATION
        append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
      append html "</tr>"
      append html "[getHorizontalLine]"
    }
  }

  set param POSITION_SAVE_TIME
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTablePositionSaveTime}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param POWERUP_JUMPTARGET
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableDimmerPowerUpAction}</td>"
      option POWERUP_JUMPTARGET_BLIND_OnOff
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }

  set param POWERUP_ONDELAY_UNIT
  if { ! [catch {set tmp $ps($param)}]  } {

    append html "[getHorizontalLine]"

    incr prn
    append html "<tr>"
    append html "<td>\${stringTableBlindLevelOnDelay}</td>"
    append html [getComboBox $chn $prn "$specialID" "delayShort"]
    append html "</tr>"

    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]


    incr prn
    set param POWERUP_ONDELAY_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${stringTableOnDelayValue}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }

  ## hier hin
  set param POWERUP_ON_LEVEL
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableBlindLevelUp}</td>"
      option BLIND_LEVEL
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }

  set param POWERUP_ON_LEVEL_2
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableJalousieSlatsLevelUp}</td>"
      option BLIND_LEVEL_2
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }

  set param POWERUP_OFFDELAY_UNIT
  if { ! [catch {set tmp $ps($param)}]  } {

    append html "[getHorizontalLine]"

    incr prn
    append html "<tr>"
    append html "<td>\${stringTableBlindLevelOffDelay}</td>"
    append html [getComboBox $chn $prn "$specialID" "delayShort"]
    append html "</tr>"

    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param POWERUP_OFFDELAY_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${stringTableOffDelayValue}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }

  set param POWERUP_OFF_LEVEL
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableBlindLevelDown}</td>"
      option BLIND_LEVEL
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }

  set param POWERUP_OFF_LEVEL_2
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableJalousieSlatsLevelDown}</td>"
      option BLIND_LEVEL_2
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }

  return $html
}

proc getShutterVirtualReceiver {chn p descr} {
  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set html ""

  if {[session_is_expert]} {
    set param "LOGIC_COMBINATION"
    if { ! [catch {set tmp $ps($param)}]  } {
      append html "<tr>"
        append html "<td>\${stringTableLogicCombination}</td>"
        option LOGIC_COMBINATION
        append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
      append html "</tr>"
      append html "[getHorizontalLine]"
    }
  }

  set param POWERUP_JUMPTARGET
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableDimmerPowerUpAction}</td>"
      option POWERUP_JUMPTARGET_BLIND_OnOff
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }

  set param POWERUP_ONDELAY_UNIT
  if { ! [catch {set tmp $ps($param)}]  } {

    append html "[getHorizontalLine]"

    incr prn
    append html "<tr>"
    append html "<td>\${stringTableBlindLevelOnDelay}</td>"
    append html [getComboBox $chn $prn "$specialID" "delayShort"]
    append html "</tr>"

    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]


    incr prn
    set param POWERUP_ONDELAY_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${stringTableOnDelayValue}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }

  set param POWERUP_ON_LEVEL
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableBlindLevelUp}</td>"
      option BLIND_LEVEL
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }



  set param POWERUP_OFFDELAY_UNIT
  if { ! [catch {set tmp $ps($param)}]  } {

    append html "[getHorizontalLine]"

    incr prn
    append html "<tr>"
    append html "<td>\${stringTableBlindLevelOffDelay}</td>"
    append html [getComboBox $chn $prn "$specialID" "delayShort"]
    append html "</tr>"

    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]


    incr prn
    set param POWERUP_OFFDELAY_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${stringTableOnDelayValue}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }

  set param POWERUP_OFF_LEVEL
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableBlindLevelDown}</td>"
      option BLIND_LEVEL
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }

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

proc getHeatingClimateControlTransceiver {chn p descr address {extraparam ""}} {
  global iface
  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set weeklyPrograms 6

  if {[string compare $extraparam 'only3WeeklyProgramms'] == 0} {
    set weeklyPrograms 3
  }

  set html ""

    set CHANNEL $special_input_id

    set hlpBoxWidth 500
    set hlpBoxHeight 200


    puts "<script type=\"text/javascript\">"
      puts "ShowActiveWeeklyProgram = function(activePrg) {"
        puts " for (var i = 1; i <= $weeklyPrograms; i++) {"
          puts "jQuery('#P' + i + '_Timeouts_Area').hide();"
        puts " }"
        puts " jQuery('#P' + activePrg + '_Timeouts_Area').show();"
      puts "};"

      puts "setDisplayMode = function(elem) {"
        puts "var mode = jQuery(elem).val();"
        puts "modeElem = jQuery(\".j_showHumidity\");"
        puts "if (mode == 0) {"
          puts "jQuery(modeElem).show();"
        puts "} else {jQuery(modeElem).hide();}"
      puts "};"
    puts "</script>"

    set prn 0

    set param WEEK_PROGRAM_POINTER
    append html "<table class=\"ProfileTbl\">"
      append html "<tr>"
        append html "<td class='hidden'><input type='text' id='separate_$CHANNEL\_$prn' name='$param'></td>"
      append html "</tr>"

      # left
      append html "<tr>"
        append html "<td name=\"_expertParam\" class=\"_hidden\">\${stringTableWeekProgramToEdit}</td>"
        append html "<td name=\"_expertParam\" class=\"_hidden\">"
          append html "<select id=\"editProgram\" onchange=\"ShowActiveWeeklyProgram(parseInt(\$(this).value)+1);\">"
            append html "<option value='0'>\${stringTableWeekProgram1}</option>"
            append html "<option value='1'>\${stringTableWeekProgram2}</option>"
            append html "<option value='2'>\${stringTableWeekProgram3}</option>"
            if {$weeklyPrograms > 3} {
              append html "<option value='3'>\${stringTableWeekProgram4}</option>"
              append html "<option value='4'>\${stringTableWeekProgram5}</option>"
              append html "<option value='5'>\${stringTableWeekProgram6}</option>"
            }
        append html "</select>[getHelpIcon $param [expr $hlpBoxWidth * 0.8] [expr $hlpBoxHeight / 2]]"
        append html "</td>"
      append html "</tr>"
    append html "</table>"


  ## Create the weekly Programs ##

    for {set loop 1} {$loop <=$weeklyPrograms} {incr loop} {
      set pNr "P$loop";
      append html "<div id=\"$pNr\_Timeouts_Area\" style=\"display:none\">"
      foreach day {SATURDAY SUNDAY MONDAY TUESDAY WEDNESDAY THURSDAY FRIDAY} {
        append html "<div id=\"$pNr\_temp_prof_$day\"></div>"
      }
      append html "</div>"

      append html "<script type=\"text/javascript\">"
      append html "$pNr\_tom = new TimeoutManager('$iface', '$address', false, '$pNr\_');"
      foreach day {SATURDAY SUNDAY MONDAY TUESDAY WEDNESDAY THURSDAY FRIDAY} {

        for {set i 1} {$i <= 13} {incr i} {

          set timeout     $ps($pNr\_ENDTIME_${day}_$i)
          set temperature $ps($pNr\_TEMPERATURE_${day}_$i)
          append html "$pNr\_tom.setTemp('$day', $timeout, $temperature);"

          if {$timeout == 1440} then {
            break;
          }
        }

        append html "$pNr\_tom.setDivname('$day', '$pNr\_temp_prof_$day');"
        append html "$pNr\_tom.writeDay('$day');"
      }
      append html "</script>"
    }

    append html "<script type=\"text/javascript\">ShowActiveWeeklyProgram(1);</script>"

    append html "<hr>"

    # *************** #
    
    append html "<table class=\"ProfileTbl\">"
      # left

      set param SHOW_SET_TEMPERATURE
      if { ! [catch {set tmp $ps($param)}]  } {
        incr prn
        array_clear options
        set options(0) "\${stringTableClimateControlRegDisplayTempInfoActualTemp}"
        set options(1) "\${stringTableClimateControlRegDisplayTempInfoSetPoint}"

        append html "<tr>"
          append html "<td name=\"_expertParam\" class=\"_hidden\">\${stringTableClimateControlRegDisplayTempInfo}</td>"
          append html "<td name=\"_expertParam\" class=\"_hidden\">[get_ComboBox options $param separate_$CHANNEL\_$prn ps $param onchange=\"setDisplayMode(this)\"]</td>"

          # right
          set param SHOW_HUMIDITY
          incr prn
          array_clear options
          set options(0) "\${stringTableClimateControlRegDisplayTempHumT}"
          set options(1) "\${stringTableClimateControlRegDisplayTempHumTH}"
          append html "<td name=\"_expertParam\" class=\"hidden j_showHumidity\">\${stringTableClimateControlRegDisplayTempHum}</td>"
          append html "<td name=\"_expertParam\" class=\"hidden j_showHumidity\">[get_ComboBox options $param separate_$CHANNEL\_$prn ps $param]</td>"
        append html "</tr>"
      }

      # left
      set param BUTTON_RESPONSE_WITHOUT_BACKLIGHT
      if { ! [catch {set tmp $ps($param)}]  } {
        incr prn
        append html "<tr>"
        append html "<td name=\"expertParam\" class=\"hidden\">\${stringTableButtonResponseWithoutBacklight}</td>"
        append html "<td name=\"expertParam\" class=\"hidden\">"
        # append html "[_getCheckBox $CHANNEL '$param' $ps($param) $prn]"
        append html  "[getCheckBox '$param' $ps($param) $chn $prn]"
        append html "</td>"
        append html "</tr>"
      }

    append html "</table>"

    append html "<hr>"
    
    append html "<table class=\"ProfileTbl\">"

      set param TEMPERATURE_LOWERING_COOLING
      if { ! [catch {set tmp $ps($param)}]  } {
        # left
        incr prn
        append html "<tr><td>\${ecoCoolingTemperature}</td>"
        # append html  "<td>[_getTextField $CHANNEL $param $ps($param) $prn]&nbsp;[_getUnit $param]&nbsp;[_getMinMaxValueDescr $param]<input id=\"comfortOld\" type=\"hidden\" value=\"$ps($param)\"></td>"
        append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]<input id=\"comfortOld\" type=\"hidden\" value=\"$ps($param)\"</td>"

        append html "<script type=\"text/javascript\">"
          append html "jQuery(\"#separate_$CHANNEL\_$prn\").bind(\"blur\",function() {ProofAndSetValue(this.id, this.id, [getMinValue $param], [getMaxValue $param], 1);isEcoLTComfort(this.name);});"
        append html "</script>"

        # right
        incr prn
        set param TEMPERATURE_LOWERING
        append html "<td>\${ecoHeatingTemperature}</td>"
        # append html  "<td>[_getTextField $CHANNEL $param $ps($param) $prn]&nbsp;[_getUnit $param]&nbsp;[_getMinMaxValueDescr $param]<input id=\"ecoOld\" type=\"hidden\" value=\"$ps($param)\"></td>"
        append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

        append html "<script type=\"text/javascript\">"
          append html "jQuery(\"#separate_$CHANNEL\_$prn\").bind(\"blur\",function() {ProofAndSetValue(this.id, this.id, [getMinValue $param], [getMaxValue $param], 1);isEcoLTComfort(this.name);});"
        append html "</script>"
        append html "</tr>"

        append html "<tr id=\"errorRow\" class=\"hidden\"> <td></td> <td colspan=\"2\"><span id=\"errorComfort\" class=\"attention\"></span></td> <td colspan=\"2\"><span id=\"errorEco\" class=\"attention\"></span></td> </tr>"
      }

      # left
      incr prn
      set param TEMPERATURE_MINIMUM
      array_clear options
      set i 0
      for {set val [getMinValue $param]} {$val <= [getMaxValue $param]} {set val [expr $val + 0.5]} {
        set options($i) "$val &#176;C"
        incr i;
      }
      append html "<tr><td>\${stringTableTemperatureMinimum}</td>"
      append html  "<td>[get_ComboBox options $param tmp_$CHANNEL\_$prn ps $param onchange=setMinMaxTemp('tmp_$CHANNEL\_$prn','separate_$CHANNEL\_$prn')]</span> <span class='hidden'>[getTextField $param $ps($param) $chn $prn]</span></td>"
      append html "<script type=\"text/javascript\">"
      append html "setMinMaxTempOption('tmp_$CHANNEL\_$prn', 'separate_$CHANNEL\_$prn' );"
      append html "</script>"

      # right
      incr prn
      set param TEMPERATURE_MAXIMUM
      array_clear options
      set i 0
      for {set val [getMinValue $param]} {$val <= [getMaxValue $param]} {set val [expr $val + 0.5]} {
        set options($i) "$val &#176;C"
        incr i;
      }
      append html "<td>\${stringTableTemperatureMaximum}</td>"
      append html  "<td>[get_ComboBox options $param tmp_$CHANNEL\_$prn ps $param onchange=setMinMaxTemp('tmp_$CHANNEL\_$prn','separate_$CHANNEL\_$prn')]</span> <span class='hidden'>[getTextField $param $ps($param) $chn $prn]</span></td>"
      append html "</tr>"
      append html "<script type=\"text/javascript\">"
      append html "setMinMaxTempOption('tmp_$CHANNEL\_$prn', 'separate_$CHANNEL\_$prn' );"
      append html "</script>"
      append html "<tr>"

      set param MIN_MAX_VALUE_NOT_RELEVANT_FOR_MANU_MODE
      if { ! [catch {set tmp $ps($param)}]  } {
        # In older versions this parameter is not available
        incr prn
        append html "<tr>"
        append html "<td name=\"expertParam\" class=\"hidden\">\${stringTableMinMaxNotRelevantForManuMode}</td>"
        append html "<td name=\"expertParam\" class=\"hidden\">"
        append html  "[getCheckBox '$param' $ps($param) $chn $prn]"
        append html "</td>"
        append html "</tr>"
      }

      set param DURATION_5MIN
      if { ! [catch {set tmp $ps($param)}]  } {
        # In older versions this parameter is not available
        incr prn
        append html "<tr name=\"expertParam\" class=\"hidden\">"
          append html "<td>\${stringTableDuration5Min}</td>"
          append html "<td colspan=\"2\" >[getTextField $param $ps($param) $chn $prn]&nbsp;x&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"

          append html "<script type=\"text/javascript\">"
            append html "jQuery(\"#separate_$CHANNEL\_$prn\").bind(\"blur\",function() {ProofAndSetValue(this.id, this.id, [getMinValue $param], [getMaxValue $param], 1);});"
          append html "</script>"

        append html "</tr>"
      }

    append html "</table>"

    append html "<hr>"

    append html "<table class=\"ProfileTbl\">"
    # left
    incr prn
    set param TEMPERATURE_OFFSET
    array_clear options
    set i 0
    for {set val -3.5} {$val <= 3.5} {set val [expr $val + 0.5]} {
      set options($val) "$val &#176;C"
      incr i;
    }
    append html "<td>\${stringTableTemperatureOffset}</td>"
    append html "<td>[get_ComboBox options $param separate_$CHANNEL\_$prn ps $param][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
    append html "</tr>"

    #left
    set param TEMPERATURE_WINDOW_OPEN
    if { ! [catch {set tmp $ps($param)}]  } {
      incr prn
      append html "<tr><td>\${stringTableTemperatureFallWindowOpen}</td>"
        append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]<input id=\"comfortOld\" type=\"hidden\" value=\"$ps($param)\"</td>"

        append html "<script type=\"text/javascript\">"
          append html "jQuery(\"#separate_$CHANNEL\_$prn\").bind(\"blur\",function() {ProofAndSetValue(this.id, this.id, [getMinValue $param], [getMaxValue $param], 1);isEcoLTComfort(this.name);});"
        append html "</script>"
      append html "</tr>"
    }
  append html "</table>"

  append html "<hr>"

  append html "<table class=\"ProfileTbl\">"
    # left
    incr prn
    set param BOOST_TIME_PERIOD
    array_clear options
    set i 0
    for {set val 0} {$val <= 30} {incr val 5} {
        set options($val) "$val min"
      incr i;
    }
    append html "<tr><td>\${stringTableBoostTimePeriod}</td>"
      append html "<td>[get_ComboBox options $param separate_$CHANNEL\_$prn ps $param][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
    append html "</tr>"
  append html "</table>"

    
  if {[session_is_expert]} {
    append html "<script type=\"text/javascript\">"
      append html "jQuery(\"\[name='expertParam'\]\").show();"
      append html "setDisplayMode(jQuery(\"\[name='SHOW_SET_TEMPERATURE'\]\").first());"
    append html "</script>"
  } else {
    append html "<script type=\"text/javascript\">"
      append html "jQuery(\"\[name='expertParam'\]\").hide();"
    append html "</script>"
  }
  append html "<script type=\"text/javascript\">setDisplayMode(jQuery(\"\[name='SHOW_SET_TEMPERATURE'\]\").first());</script>"

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
  
  return $html
}

# ACCELERATION_TRANSCEIVER
# Introduced with the HmIP-SAM (1612)
proc getAccelerationTransceiver {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set operationMode $ps(CHANNEL_OPERATION_MODE)

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
    set options(2) "\${motionDetectorChannelOperationModeFlat}"
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn onchange=\"changeParamDescription(this.value)\"]</td>"

    append html "<script type=\"text/javascript\">"
      append html "changeParamDescription = function(value) {"
        append html "jQuery(\"\[name='motion'\]\").html(translateKey(\"motionDetectorOptionMotion_\"+value));"
        append html "jQuery(\"\[name='noMotion'\]\").html(translateKey(\"motionDetectorOptionNoMotion_\"+value));"
        append html "jQuery(\"\[name='messageMovement'\]\").html(translateKey(\"motionDetectorMessageMovement_\"+value));"
        append html "jQuery(\"\[name='messageNoMovement'\]\").html(translateKey(\"motionDetectorMessageNoMovement_\"+value));"
        append html "jQuery(\"\[name='NotiMovement'\]\").html(translateKey(\"motionDetectorNotificationMovement_\"+value));"
        append html "jQuery(\"\[name='NotiNoMovement'\]\").html(translateKey(\"motionDetectorNotificationNoMovement_\"+value));"
      append html "};"
    append html "</script>"

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
    append html "<td>\${motionDetectorMessageMovement_$operationMode}</td>"
    array_clear options
    set options(0) "\${motionDetectorOptionNoMessage}"
    set options(1) "\${motionDetectorOptionNoMotion_$operationMode}"
    set options(2) "\${motionDetectorOptionMotion_$operationMode}"
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn
  set param MSG_FOR_POS_B
  append html "<tr>"
    append html "<td>\${motionDetectorMessageNoMovement_$operationMode}</td>"
    array_clear options
    set options(0) "\${motionDetectorOptionNoMessage}"
    set options(1) "\${motionDetectorOptionNoMotion_$operationMode}"
    set options(2) "\${motionDetectorOptionMotion_$operationMode}"
    append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn
  set param NOTIFICATION_SOUND_TYPE_LOW_TO_HIGH
  append html "<tr>"
    append html "<td>\${motionDetectorNotificationMovement_$operationMode}</td>"
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
  set param NOTIFICATION_SOUND_TYPE_HIGH_TO_LOW
  append html "<tr>"
    append html "<td>\${motionDetectorNotificationNoMovement_$operationMode}</td>"
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

  return $html
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
  
  return $html
}


proc getShutterContactTransceiver {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set CHANNEL $special_input_id

  set html ""

  set param EVENT_DELAY_UNIT
  if { ! [catch {set tmp $ps($param)}]  } {
    append html "<tr>"
    append html "<td>\${stringTableEventDelay}</td>"
    append html [getComboBox $chn $prn "$specialID" "delayShort"]
    append html "</tr>"

    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param EVENT_DELAY_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${stringTableEventDelayValue}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }


  set param MSG_FOR_POS_A
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr><td>"
      array_clear options
      set options(0) "\${stringTableShutterContactMsgPosA2}"
      set options(1) "\${stringTableShutterContactMsgPosA1}"
      set options(2) "\${stringTableShutterContactMsgPosA3}"
      append html "<tr><td>\${stringTableShutterContactHmIPMsgPosA0}</td><td>"
      append html [get_ComboBox options $param separate_$CHANNEL\_$prn ps $param]
    append html "</td></tr>"
  }

  set param MSG_FOR_POS_B
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr><td>"
      array_clear options
      set options(0) "\${stringTableShutterContactMsgPosA2}"
      set options(1) "\${stringTableShutterContactMsgPosA1}"
      set options(2) "\${stringTableShutterContactMsgPosA3}"
      append html "<tr><td>\${stringTableShutterContactHmIPMsgPosB0}</td><td>"
      append html [get_ComboBox options $param separate_$CHANNEL\_$prn ps $param]
    append html "</td></tr>"
  }
  
  return $html
}

proc getPassageDetector {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"
  set CHANNEL $special_input_id

  set html ""

  set param ATC_MODE
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      array_clear options
      set options(0) "\${optionInactiv}"
      set options(1) "\${optionActiv}"
      append html "<td>\${stringTableATCMode}</td>"
      append html "<td>[get_ComboBox options $param separate_$CHANNEL\_$prn ps $param onchange=\"setATCAdatptionInterval()\"]</td>"
    append html "</tr>"
  }

  set param ATC_ADAPTION_INTERVAL
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      array_clear options
      set options(0) "\${optionUnit15M}"
      set options(1) "\${optionUnit30M}"
      set options(2) "\${optionUnit60M}"
      set options(3) "\${optionUnit120M}"
      append html "<td name=\"paramATCAdaptionInterval\" class=\"hidden\">\${stringTableATCAdaptionInterval}</td>"
      append html "<td name=\"paramATCAdaptionInterval\" class=\"hidden\">[get_ComboBox options $param separate_$CHANNEL\_$prn ps $param]</td>"
    append html "</tr>"

    append html "[getHorizontalLine "name=\"paramATCAdaptionInterval\" class=\"hidden\""]"

    append html "<script type=\"text/javascript\">"
      append html "window.setTimeout(function() {"
        append html "setATCAdatptionInterval = function() {"
          append html "var elmATCMode = jQuery(\"\[name='ATC_MODE'\]\");"
          append html "var elmATCInterval = jQuery(\"\[name='paramATCAdaptionInterval'\]\");"
          append html "if (elmATCMode.val() == 1) {elmATCInterval.show();} else {elmATCInterval.hide();}"
        append html "};"

        append html "setATCAdatptionInterval();"
      append html "},100);"
    append html "</script>"
  }

  set param EVENT_BLINDTIME_BASE
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
    append html "<td>\${stringTableEventBlindTime}</td>"
    append html [getComboBox $chn $prn "$specialID" "delayShort"]
    append html "</tr>"

    # param = EVENT_BLINDTIME_BASE
    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param EVENT_BLINDTIME_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${stringTableBlindTimeValue}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }

  set param EVENT_TIMEOUT_BASE
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
    append html "<td>\${stringTableEventTimeout}</td>"
    append html [getComboBox $chn $prn "$specialID" "delayShort"]
    append html "</tr>"

    #param = EVENT_TIMEOUT_BASE
    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param EVENT_TIMEOUT_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${stringTableEventTimeoutValue}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }

  set param LED_DISABLE_CHANNELSTATE
  if { ! [catch {set tmp $ps($param)}]  } {
     incr prn
     append html "<tr>"
       append html "<td>\${stringTableLEDDisableChannelState}</td>"
       append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]</td>"
     append html "</tr>"
  }

  set param SENSOR_SENSITIVITY
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableSensorSensivity}</td>"
      option RAW_0_100Percent
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }
  return $html
}

proc getPassageDetectorDirectionTransmitter {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"
  set CHANNEL $special_input_id

  set html ""

  set lblPassageDetection "\${stringTablePassageDetectionLeft}"

  if { ! [catch {set tmp $ps(COND_TX_DECISION_BELOW)}]  } {
    set lblPassageDetection "\${stringTablePassageDetectionRight}"
  }

  set param CHANNEL_OPERATION_MODE
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr><td>"
      array_clear options
      set options(0) "\${optionInactiv}"
      set options(1) "\${optionActiv}"
      append html "<tr><td>$lblPassageDetection</td><td>"
      append html [get_ComboBox options $param separate_$CHANNEL\_$prn ps $param onchange=\"showDecisionValue(this.value,$chn)\"]
    append html "</tr></td>"
  }

  set param COND_TX_DECISION_ABOVE
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr id=\"decisionVal_$chn\" class=\"hidden\">"
      append html "<td>\${stringTableCondValuePassageDetectionLeft}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param COND_TX_DECISION_BELOW
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr id=\"decisionVal_$chn\" class=\"hidden\">"
      append html "<td>\${stringTableCondValuePassageDetectionRight}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  append html "<script type=\"text/javascript\">"
    append html "showDecisionValue = function(value, chn) {"
      append html "var decisionValElm = jQuery(\"#decisionVal_\"+chn);"
      append html "if (value == 0) {"
        append html "decisionValElm.hide();"
      append html "} else {"
        append html "decisionValElm.show();"
      append html "}"
    append html "};"
    append html "showDecisionValue(jQuery(\"#separate_$CHANNEL\_$prn\").val(), $chn);"
  append html "</script>"

  return $html
}

proc getPassageDetectorCounterTransmitter {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"
  set CHANNEL $special_input_id

  set html ""

  set param CHANNEL_OPERATION_MODE
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr><td>"
      array_clear options
      set options(0) "\${optionInactiv}"
      set options(1) "\${optionPassageCounterDetectionLR}"
      set options(2) "\${optionPassageCounterDetectionL}"
      set options(3) "\${optionPassageCounterDetectionR}"
      set options(4) "\${optionPassageCounterDeltaLR}"
      set options(5) "\${optionPassageCounterDeltaL}"
      set options(6) "\${optionPassageCounterDeltaR}"
      append html "<tr><td>\${stringTablePassageDetectorCounterTransmitterChannelOperationMode}</td><td>"
      append html [get_ComboBox options $param separate_$CHANNEL\_$prn ps $param _onchange=\"showOpModesValues(this.value,$chn)\"]
    append html "</tr></td>"
  }

  set param COND_TX_DECISION_ABOVE
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr id=\"condTxDecisionAbove_$chn\" class=\"_hidden\">"
      append html "<td>\${stringTableCondTxDecisionAbove}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param COND_TX_DECISION_BELOW
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr id=\"condTxDecisionBelow_$chn\" class=\"_hidden\">"
      append html "<td>\${stringTableCondTxDecisionBelow}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param COND_TX_THRESHOLD_HI
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr id=\"condTxThresholdHi_$chn\" class=\"_hidden\">"
      append html "<td>\${stringTableCondThresholdHi}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param COND_TX_THRESHOLD_LO
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr id=\"condTxThresholdLo_$chn\" class=\"_hidden\">"
      append html "<td>\${stringTableCondThresholdLo}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  append html "<script type=\"text/javascript\">"
    append html "showOpModesValues = function(value, chn) {"
      append html "var opModeElems = jQuery(\"\[name='chnOpMode_\"+chn +\"'\]\");"
      append html "var condTxDecisionAboveElm = jQuery(\"#condTxDecisionAbove_\"+chn),"
      append html "condTxDecisionBelowElm = jQuery(\"#condTxDecisionBelow_\"+chn),"
      append html "condTxThresholdHiElm = jQuery(\"#condTxThresholdHi_\"+chn),"
      append html "condTxThresholdLoElm = jQuery(\"#condTxThresholdLo_\"+chn);"

      append html "condTxDecisionAboveElm.hide();"
      append html "condTxDecisionBelowElm.hide();"
      append html "condTxThresholdHiElm.hide();"
      append html "condTxThresholdLoElm.hide();"

      append html "switch (parseInt(value)) {"
        append html "case 1: {"
          append html "condTxDecisionAboveElm.show();"
          append html "condTxDecisionBelowElm.show();"
          append html "break;"
        append html "}"
        append html "case 2: {"
          append html "condTxDecisionAboveElm.show();"
          append html "break;"
        append html "}"
        append html "case 3: {"
          append html "condTxDecisionBelowElm.show();"
          append html "break;"
        append html "}"
        append html "case 4: {"
          append html "condTxThresholdHiElm.show();"
          append html "condTxThresholdLoElm.show();"
          append html "break;"
        append html "}"
        append html "case 5: {"
          append html "condTxThresholdHiElm.show();"
          append html "break;"
        append html "}"
        append html "case 6: {"
          append html "condTxThresholdLoElm.show();"
          append html "break;"
        append html "}"
      append html "}"

    append html "};"
   # append html "showOpModesValues(jQuery(\"#separate_$CHANNEL\_1\").val(), $chn);"
  append html "</script>"

  return $html
}

proc getNoParamatersToSet {} {
  return "<tr><td class=\"CLASS22003\"><div class=\"CLASS22004\">\${deviceAndChannelParamsLblNoParamsToSet}</div></td></tr>"
}