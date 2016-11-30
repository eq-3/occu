source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipDSTPanel.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]

proc getMaintenanceFloorHeating {chn p descr} {
  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set html ""

	puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-FAL_MIOB.js');</script>"


  set param CYCLIC_INFO_MSG
  append html "<tr>"
    append html "<td>\${stringTableCyclicInfoMsg}</td>"
    append html  "<td>[getCheckBoxCyclicInfoMsg $param $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn
  set param CYCLIC_INFO_MSG_DIS
  append html "<tr>"
    append html "<td>\${stringTableCyclicInfoMsgDis}</td>"
    append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn
  set param CYCLIC_INFO_MSG_DIS_UNCHANGED
  append html "<tr>"
    append html "<td>\${stringTableCyclicInfoMsgDisUnChanged}</td>"
    append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn
  set param LOCAL_RESET_DISABLED
  append html "<tr>"
    append html "<td>\${stringTableLocalResetDisable}</td>"
    append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn
  append html "[getDSTPanel ps psDescr]"

  append html "[getHorizontalLine]"

  incr prn
  set param COOLING_EMERGENCY_PWM_SIGNAL
  append html "<tr>"
    append html "<td>\${lblCoolingEmergencyPWMSignal}</td>"
    append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;* 100[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn
  set param HEATING_EMERGENCY_PWM_SIGNAL
  append html "<tr>"
    append html "<td>\${lblHeatingEmergencyPWMSignal}</td>"
    append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;* 100[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn
  set param FROST_PROTECTION_TEMPERATURE
  append html "<tr>"
    append html "<td>\${lblFrostProtectionTemperature}</td>"
    append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn
  set param HEATING_LOAD_TYPE
  append html "<tr>"
    append html "<td>\${lblHeatingLoadType}</td>"
    option HEATING_LOAD_TYPE
    append html  "<td>[getOptionBox $param options $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn
  set param HEATING_PUMP_CONTROL
  append html "<tr>"
    append html "<td>\${lblHeatingPumpControl}</td>"
    option HEATING_PUMP_CONTROL
    append html  "<td>[getOptionBox $param options $ps($param) $chn $prn]</td>"
  append html "</tr>"

  incr prn
  set param HEATING_VALVE_TYPE
  append html "<tr>"
    append html "<td>\${lblHeatingValveType}</td>"
    option HEATING_VALVE_TYPE
    append html  "<td>[getOptionBox $param options $ps($param) $chn $prn]</td>"
  append html "</tr>"

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
