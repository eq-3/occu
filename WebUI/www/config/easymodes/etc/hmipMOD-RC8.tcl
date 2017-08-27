proc getHeader {chn} {
    upvar ps ps
    upvar prn prn

    set result ""

    set param CHANNEL_OPERATION_MODE
    if { ! [catch {set tmp $ps($param)}]  } {
     incr prn
     append result "<tr>"
      append result "<td style=\"min-width:240px\">\${stringTableKeyTransceiverChannelOperationMode}</td>"
      set options(0) \${stringTableKeyInactive}
      set options(1) \${stringTableKeyTransceiverChannelOperationModeKeyBehavior}
      set options(2) \${stringTableKeyTransceiverChannelOperationModeSwitchBehavior}
      set options(3) \${stringTableKeyTransceiverChannelOperationModeBinaryBehavior}
      append result  "<td>[getOptionBox '$param' options $ps($param) $chn $prn "onchange=\"showHint($chn,$ps($param) ,this.value);\""]</td>"
     append result "</tr>"
  }
 
  set param LED_DISABLE_CHANNELSTATE
  if { ! [catch {set tmp $ps($param)}]  } {
     incr prn
     append result "<tr name=\"modrc8_$chn\">"
       append result "<td>\${stringTableLEDDisableChannelState}</td>"
       append result  "<td>[getCheckBox '$param' $ps($param) $chn $prn]</td>"
     append result "</tr>"
  }

  append result "<script type=\"text/javascript\">"
    append result "showHint = function(chn,origVal ,val) \{"
      append result "var chnElm = jQuery(\"\[name='modrc8_\"+chn+\"'\]\");"
      append result "var hintElm = jQuery(\"#hint_\" + chn);"

      append result "if (parseInt(origVal) == parseInt(val)) \{"
        append result "chnElm.show();"
        append result "hintElm.hide();"
      append result "\} else \{"
       append result "chnElm.hide();"
       append result "hintElm.show();"
      append result "\}"
    append result "\}"
  append result "</script>"

  return $result
}

proc getFooter {chn} {
  return "<div id=\"hint_$chn\" class=\"hidden attention\" style=\"padding:2px;\">\${remoteModeEM8SpecialValHint}</div>"
}

proc getInactiveHTML {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"

  set html ""

  set prn 0

  append html [getHeader $chn]
  return $html
}

proc getKeyHTML {chn p descr} {
  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"
  set html ""

  set prn 0
  append html [getHeader $chn]

  set param DBL_PRESS_TIME
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr name=\"modrc8_$chn\">"
      append html "<td>\${stringTableKeyDblPressTime}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
    incr prn
  }

  set param LONG_PRESS_TIME
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr name=\"modrc8_$chn\">"
      append html "<td>\${stringTableKeyLongPressTimeA}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]&nbsp;[]</td>"
    append html "</tr>"
  }

  set param REPEATED_LONG_PRESS_TIMEOUT_UNIT
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
    append html "<tr name=\"modrc8_$chn\">"
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

proc getSwitchHTML {chn p descr} {
  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"
  set html ""

  set prn 0
  append html [getHeader $chn]
  return $html
}

proc getBinaryHTML {chn p descr} {
  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set specialID "[getSpecialID $special_input_id]"
  set html ""
  set prn 0

  append html [getHeader $chn]

  set param MSG_FOR_POS_A
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
      array_clear options
      set options(0) "\${stringTableShutterContactMsgPosA2}"
      set options(1) "\${stringTableShutterContactMsgPosA1}"
      set options(2) "\${stringTableShutterContactMsgPosA3}"
      append html "<tr name=\"modrc8_$chn\"><td>\${stringTableShutterContactHmIPMsgPosA0}<td>"
      append html [get_ComboBox options $param separate_$special_input_id\_$prn ps $param]
    append html "</td></tr>"
  }

  set param MSG_FOR_POS_B
  if { ! [catch {set tmp $ps($param)}]  } {
    incr prn
      array_clear options
      set options(0) "\${stringTableShutterContactMsgPosA2}"
      set options(1) "\${stringTableShutterContactMsgPosA1}"
      set options(2) "\${stringTableShutterContactMsgPosA3}"
      append html "<tr name=\"modrc8_$chn\"><td>\${stringTableShutterContactHmIPMsgPosB0}</td><td>"
      append html [get_ComboBox options $param separate_$special_input_id\_$prn ps $param]
    append html "</td></tr>"
  }
  return $html
}