source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]


proc getMaintenance {chn p descr} {

  global dev_descr env

  upvar $p ps
  upvar $descr psDescr
  upvar special_input_id special_input_id

  set prn 0
  set devType $dev_descr(TYPE)

  set cyclicInfo false

  set specialID "[getSpecialID $special_input_id]"
  set html ""

  set CHANNEL $special_input_id

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HmIPW_WGD.js'); load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-ParamHelp.js');</script>"

  if {([string equal $devType "HmIP-CCU3"] == 1) || ([string equal $devType "RPI-RF-MOD"] == 1)} {
    append html "[getNoParametersToSet]"
    return $html
  }

  set param CYCLIC_INFO_MSG
  if { [info exists ps($param)] == 1  } {
    set cyclicInfo true
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableCyclicInfoMsg}</td>"
      append html  "<td>[getCheckBoxCyclicInfoMsg $param $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }

  set param CYCLIC_INFO_MSG_DIS
  if { [info exists ps($param)] == 1  } {
    set cyclicInfo true
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableCyclicInfoMsgDis}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param CYCLIC_INFO_MSG_DIS_UNCHANGED
  if { [info exists ps($param)] == 1  } {
    set cyclicInfo true
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableCyclicInfoMsgDisUnChanged}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  if {$cyclicInfo == "true"} {
    append html "[getHorizontalLine]"
  }

  set param LOCAL_RESET_DISABLED
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr name=\"expertParam\" class=\"hidden\">"
      append html "<td>\${stringTableLocalResetDisable}</td>"
      append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]&nbsp;[getHelpIcon $param]</td>"
    append html "</tr>"
  }

  set param ENABLE_ROUTING
  if { [info exists ps($param)] == 1} {
    incr prn
    append html "<tr>"
     append html "<td>\${stringTableEnableRouting}</td>"
     append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]&nbsp;[getHelpIcon $param]</td>"
    append html "</tr>"
  }

  append html "[getHorizontalLine]"

  set comment {

     # The parameters within this comment are currently not supported - this is for a later version.

    set param SCREEN_LAYOUT_PAGE_NUMBER_1
    if { [info exists ps($param)] == 1  } {
      incr prn

      # set min [expr {[expr int([getMinValue $param]) + 1]}] - activate this when optionNotActive is in use
      set min [expr {[expr int([getMinValue $param])]}]
      set max [expr {[expr int([getMaxValue $param])]}]
      array_clear options
      # set options(0) \${optionNotActive}
      for {set val $min} {$val <= $max} {incr val} {
          set options($val) "$val"
      }
      append html "<tr><td>\${lblScreenLayoutPageNumber1}</td><td>"
      append html "[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]&nbsp;[getHelpIcon $param]"
      append html "</td></tr>"
    }

    set param SCREEN_LAYOUT_PAGE_NUMBER_2
    if { [info exists ps($param)] == 1  } {
      incr prn

      # set min [expr {[expr int([getMinValue $param]) + 1]}] - activate this when optionNotActive is in use
      set min [expr {[expr int([getMinValue $param])]}]
      set max [expr {[expr int([getMaxValue $param])]}]
      array_clear options
      # set options(0) \${optionNotActive}
      for {set val $min} {$val <= $max} {incr val} {
          set options($val) "$val"
      }
      append html "<tr><td>\${lblScreenLayoutPageNumber2}</td><td>"
      append html "[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]&nbsp;[getHelpIcon $param]"
      append html "</td></tr>"
    }

    set param SCREEN_LAYOUT_PAGE_NUMBER_3
    if { [info exists ps($param)] == 1  } {
      incr prn

      # set min [expr {[expr int([getMinValue $param]) + 1]}] - activate this when optionNotActive is in use
      set min [expr {[expr int([getMinValue $param])]}]
      set max [expr {[expr int([getMaxValue $param])]}]
      array_clear options
      # set options(0) \${optionNotActive}
      for {set val $min} {$val <= $max} {incr val} {
          set options($val) "$val"
      }
      append html "<tr><td>\${lblScreenLayoutPageNumber3}</td><td>"
      append html "[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]&nbsp;[getHelpIcon $param]"
      append html "</td></tr>"
    }

    # RIGHT NEIGHBOUR
    set param SCREEN_LAYOUT_RIGHT_NEIGHBOUR_1
    if { [info exists ps($param)] == 1  } {
      incr prn

      # set min [expr {[expr int([getMinValue $param]) + 1]}] - activate this when optionNotActive is in use
      set min [expr {[expr int([getMinValue $param])]}]
      set max [expr {[expr int([getMaxValue $param])]}]
      array_clear options
      # set options(0) \${optionNotActive}
      for {set val $min} {$val <= $max} {incr val} {
          set options($val) "$val"
      }
      append html "<tr><td>\${lblScreenScreenLayoutRightNeighbour1}</td><td>"
      append html "[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]&nbsp;[getHelpIcon $param]"
      append html "</td></tr>"
    }

    set param SCREEN_LAYOUT_RIGHT_NEIGHBOUR_2
    if { [info exists ps($param)] == 1  } {
      incr prn

      # set min [expr {[expr int([getMinValue $param]) + 1]}] - activate this when optionNotActive is in use
      set min [expr {[expr int([getMinValue $param])]}]
      set max [expr {[expr int([getMaxValue $param])]}]
      array_clear options
      # set options(0) \${optionNotActive}
      for {set val $min} {$val <= $max} {incr val} {
          set options($val) "$val"
      }
      append html "<tr><td>\${lblScreenScreenLayoutRightNeighbour2}</td><td>"
      append html "[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]&nbsp;[getHelpIcon $param]"
      append html "</td></tr>"
    }

    set param SCREEN_LAYOUT_RIGHT_NEIGHBOUR_3
    if { [info exists ps($param)] == 1  } {
      incr prn

      # set min [expr {[expr int([getMinValue $param]) + 1]}] - activate this when optionNotActive is in use
      set min [expr {[expr int([getMinValue $param])]}]
      set max [expr {[expr int([getMaxValue $param])]}]
      array_clear options
      # set options(0) \${optionNotActive}
      for {set val $min} {$val <= $max} {incr val} {
          set options($val) "$val"
      }
      append html "<tr><td>\${lblScreenScreenLayoutRightNeighbour3}</td><td>"
      append html "[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]&nbsp;[getHelpIcon $param]"
      append html "</td></tr>"
    }

    # LEFT NEIGHBOUR
    set param SCREEN_LAYOUT_LEFT_NEIGHBOUR_1
    if { [info exists ps($param)] == 1  } {
      incr prn

      # set min [expr {[expr int([getMinValue $param]) + 1]}] - activate this when optionNotActive is in use
      set min [expr {[expr int([getMinValue $param])]}]
      set max [expr {[expr int([getMaxValue $param])]}]
      array_clear options
      # set options(0) \${optionNotActive}
      for {set val $min} {$val <= $max} {incr val} {
          set options($val) "$val"
      }
      append html "<tr><td>\${lblScreenScreenLayoutLeftNeighbour1}</td><td>"
      append html "[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]&nbsp;[getHelpIcon $param]"
      append html "</td></tr>"
    }

    set param SCREEN_LAYOUT_LEFT_NEIGHBOUR_2
    if { [info exists ps($param)] == 1  } {
      incr prn

      # set min [expr {[expr int([getMinValue $param]) + 1]}] - activate this when optionNotActive is in use
      set min [expr {[expr int([getMinValue $param])]}]
      set max [expr {[expr int([getMaxValue $param])]}]
      array_clear options
      # set options(0) \${optionNotActive}
      for {set val $min} {$val <= $max} {incr val} {
          set options($val) "$val"
      }
      append html "<tr><td>\${lblScreenScreenLayoutLeftNeighbour2}</td><td>"
      append html "[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]&nbsp;[getHelpIcon $param]"
      append html "</td></tr>"
    }

    set param SCREEN_LAYOUT_LEFT_NEIGHBOUR_3
    if { [info exists ps($param)] == 1  } {
      incr prn

      # set min [expr {[expr int([getMinValue $param]) + 1]}] - activate this when optionNotActive is in use
      set min [expr {[expr int([getMinValue $param])]}]
      set max [expr {[expr int([getMaxValue $param])]}]
      array_clear options
      # set options(0) \${optionNotActive}
      for {set val $min} {$val <= $max} {incr val} {
          set options($val) "$val"
      }
      append html "<tr><td>\${lblScreenScreenLayoutLeftNeighbour3}</td><td>"
      append html "[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]&nbsp;[getHelpIcon $param]"
      append html "</td></tr>"
    }
}
  # SCREEN_LAYOUT_TILE_LAYOUT

  set param SCREEN_LAYOUT_TILE_LAYOUT_1
  if { [info exists ps($param)] == 1  } {
    incr prn
    array_clear options
    set options(0) "\${option1Tile}"
    set options(1) "\${option2Tiles}"
    set options(2) "\${option4Tiles}"
    append html "<tr><td>\${lblLayoutScreenTile1}</td><td>"
    append html "[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]&nbsp;[getHelpIcon $param]"
    append html "</td></tr>"
  }

  set param SCREEN_LAYOUT_TILE_LAYOUT_2
  if { [info exists ps($param)] == 1  } {
    incr prn
    array_clear options
    set options(0) "\${option1Tile}"
    set options(1) "\${option2Tiles}"
    set options(2) "\${option4Tiles}"
    append html "<tr><td>\${lblLayoutScreenTile2}</td><td>"
    append html "[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]&nbsp;[getHelpIcon $param]"
    append html "</td></tr>"
  }

  set param SCREEN_LAYOUT_TILE_LAYOUT_3
  if { [info exists ps($param)] == 1  } {
    incr prn
    array_clear options
    set options(0) "\${option1Tile}"
    set options(1) "\${option2Tiles}"
    set options(2) "\${option4Tiles}"
    append html "<tr><td>\${lblLayoutScreenTile3}</td><td>"
    append html "[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]&nbsp;[getHelpIcon $param]"
    append html "</td></tr>"
  }

  # LANGUAGE
  set param LANGUAGE
  if { [info exists ps($param)] == 1  } {
    incr prn
    array_clear options
    set options(0) "\${optionLangEN}"
    set options(1) "\${optionLangDE}"
    set options(2) "\${optionLangFR}"
    set options(3) "\${optionLangES}"
    set options(4) "\${optionLangIT}"
    append html "<tr><td>\${lblLanguage}</td><td>"
    append html "[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]&nbsp;[getHelpIcon $param]"
    append html "</td></tr>"
  }

  set param DETECTION_RANGE
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${lblDetectionRange}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param BACKLIGHT_OFFSET
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${lblBacklightOffset}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param DISPLAY_ON_TIME
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${lblDisplayOnTime}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  if {[session_is_expert]} {
    append html "<script type=\"text/javascript\">"
      append html "jQuery(\"\[name='expertParam'\]\").show();"
    append html "</script>"
  }

  return $html
}

proc getDisplayInputTransmitter {chn p descr} {

  global dev_descr env

  upvar $p ps
  upvar $descr psDescr
  upvar special_input_id special_input_id

  set prn 0
  set devType $dev_descr(TYPE)
  set specialID "[getSpecialID $special_input_id]"
  set html ""
  set CHANNEL $special_input_id

  set param ABORT_EVENT_SENDING_CHANNELS
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
     append html "<td colspan='2'  style='text-align:center;'>\${stringTableAbortEventSendingChannels}&nbsp;[getHelpIcon $param]</td>"
    append html "</tr>"

    append html "<tr>"
    append html "<td style='width:30%;'>\${lblStopRunningLink}</td>"
    append html "<td colspan='2'><table>"
     append html "<tr id='hookAbortEventSendingChannels_1_$chn'/>"
     append html "<tr id='hookAbortEventSendingChannels_2_$chn'/>"
    append html "</table></td>"
    append html "</tr>"

    append html "[getHorizontalLine]"

    append html "<script type='text/javascript'>"
      append html "addAbortEventSendingChannels4WGD('$chn','$prn', '$dev_descr(ADDRESS)', $ps($param));"
    append html "</script>"
  }

  set param BASE_IMAGE
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr>"
      append html "<td>\${lblBaseImage}</td>"
      append html "<td><table><tr>"
        # append html "<td>[getButton btnImage_$chn 'IMAGE' selectWGDIcon(\"$chn\",\"separate_$special_input_id\_$prn\",\"$ps($param)\")]</td>"
        append html "<td style='border: 1px solid black;'><div style='background-color:gray; padding:5px; cursor: pointer;' onclick='selectWGDIcon(\"$chn\",\"separate_$special_input_id\_$prn\",\"$ps($param)\");'><img id=\"image_$chn\" width='24' height='24' src=''></div></td>"
        # This textfield is necessary but should be invisible.
        append html  "<td class='_hidden' style='padding-left:60px;'>[getTextField $param $ps($param) $chn $prn]&nbsp;<span class='attention'>(only visible for testing)</span></td>"
      append html "</tr></table></td>"

      append html "<script type=\"text/javascript\">"
      append html "if (typeof imageCollection == 'undefined') {"
        append html "imageCollection = getWGDImageCollection();"
      append html "}"
      append html "jQuery.each(imageCollection, function(index, val) {"
        append html "if (parseInt($ps($param)) == val\[1\]) {"
          append html "jQuery(\"\#image_$chn\").attr(\"src\", getWGDImagePath() + val\[0\]);"
          append html "return false;" ;# return each loop
        append html "} else {"
          append html "jQuery(\"\#image_$chn\").attr(\"src\", getWGDImagePath() + getWGDDefaultImage());"
        append html "}"
      append html "});"
      append html "</script>"

    append html "</tr>"
  }

  set param CONTROL_REPRESENTATION
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr>"
      append html "<td>\${lblControlRepresentation}</td>"
      array_clear options
      set options(0) "\${optionNone}"
      set options(1) "\${optionDimmActor}"
      set options(2) "\${optionShutterContact}"
      set options(3) "\${optionSwitchActor}"
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]&nbsp;[getHelpIcon $param]</td>"
    append html "</tr>"
  }

  set param CHANNEL_OPERATION_MODE
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr>"
      append html "<td>\${lblChannelOperationMode}</td>"
      array_clear options
      set options(0) "\${lblNotActiv}"
      set options(1) "\${optionKeyBehaviour}"
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]&nbsp;[getHelpIcon $param]</td>"
    append html "</tr>"
  }

  set param CONTROL_INTERPRETATION
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr>"
      append html "<td>\${lblControlInterpretation}</td>"
      array_clear options
      set options(0) "\${optionCloudLogic}"
      set options(1) "\${optionCCULogic}"
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]&nbsp;[getHelpIcon $param]</td>"
    append html "</tr>"
  }
  append html "[getHorizontalLine]"

  set param DBL_PRESS_TIME
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableKeyDblPressTime}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param LONG_PRESS_TIME
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableKeyLongPressTimeA}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param REPEATED_LONG_PRESS_TIMEOUT_UNIT
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
    append html "<td>\${stringTableKeyLongPressTimeOut}</td>"
    append html [getComboBox $chn $prn "$specialID" "timeOnOffShort"]
    append html "</tr>"

    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param REPEATED_LONG_PRESS_TIMEOUT_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${stringTableKeyLongPressTimeOutValue}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }

  set param MAIN_TEXT
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "[getHorizontalLine]"
    append html "<tr>"
      append html "<td>\${lblMainText}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }

  set param SUB_TEXT
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${lblSubText}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }

  return $html

}

proc getDisplayLevelInputTransmitter {chn p descr} {

  global dev_descr env

  upvar $p ps
  upvar $descr psDescr
  upvar special_input_id special_input_id

  set prn 0
  set devType $dev_descr(TYPE)
  set specialID "[getSpecialID $special_input_id]"
  set html ""
  set CHANNEL $special_input_id

  set param ABORT_EVENT_SENDING_CHANNELS
  if { [info exists ps($param)] == 1  } {
    incr prn

    append html "<tr>"
     append html "<td colspan='2'  style='text-align:center;'>\${stringTableAbortEventSendingChannels}&nbsp;[getHelpIcon $param]</td>"
    append html "</tr>"

    append html "<tr>"
    append html "<td style='width:30%;'>\${lblStopRunningLink}</td>"
    append html "<td colspan='2'><table>"
     append html "<tr id='hookAbortEventSendingChannels_1_$chn'/>"
     append html "<tr id='hookAbortEventSendingChannels_2_$chn'/>"
    append html "</table></td>"
    append html "</tr>"

    append html "[getHorizontalLine]"

    append html "<script type='text/javascript'>"
      append html "addAbortEventSendingChannels4WGD('$chn','$prn', '$dev_descr(ADDRESS)', $ps($param));"
    append html "</script>"
  }

  set param CHANNEL_OPERATION_MODE
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr>"
      append html "<td>\${lblChannelOperationMode}</td>"
      array_clear options
      set options(0) "\${lblNotActiv}"
      set options(1) "\${optionLevelKeyBehaviour}"
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]&nbsp;[getHelpIcon $param]</td>"
    append html "</tr>"
  }

  set param DBL_PRESS_TIME
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableKeyDblPressTime}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param LONG_PRESS_TIME
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableKeyLongPressTimeA}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param REPEATED_LONG_PRESS_TIMEOUT_UNIT
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
    append html "<td>\${stringTableKeyLongPressTimeOut}</td>"
    append html [getComboBox $chn $prn "$specialID" "timeOnOffShort"]
    append html "</tr>"

    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param REPEATED_LONG_PRESS_TIMEOUT_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${stringTableKeyLongPressTimeOutValue}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }

}