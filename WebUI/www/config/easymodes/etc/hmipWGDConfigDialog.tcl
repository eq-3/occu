source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]


proc getMaintenance {chn p descr} {

  global dev_descr ch_descr env iface

  upvar $p ps
  upvar $descr psDescr
  upvar special_input_id special_input_id

  set prn 0
  set devType $dev_descr(TYPE)
  set isWGD_PL 0 ; # default = no _PL
  if {$devType == "HmIP-WGD-PL"} {set isWGD_PL 1}

  set cyclicInfo false

  set selected ""

  set specialID "[getSpecialID $special_input_id]"
  set html ""

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HmIPW_WGD.js'); load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-ParamHelp.js');</script>"
  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/WGD.js');</script>"

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

  # Check how many screens are available (WGD 6 or WGD-PL 11)
  set availableScreens 6 ; # default 6

  set param SCREEN_LAYOUT_PAGE_NUMBER_11
  if { [info exists ps($param)] == 1  } {
    set availableScreens 11
  }

  append html "<tr class='hidden'>"
    append html "<td></td>"
    append html "<td>"
      append html "<table>"
        append html "<tr>"
          append html "<td colspan='10'>"
            append html "<div style='width:75%'>"
              append html "\${SCREEN_MANAGEMENT}"
            append html "</div>"
          append html "</td>"
        append html "</tr>"
      append html "</table>"
    append html "</td>"
  append html "</tr>"

  append html "<tr class='hidden'>"
    append html "<td>"
      append html "tr Nachbar Screens KEY/LEVEL"
    append html "</td>"

    append html "<td>"
      append html "<table>"
          append html "<th colspan='2'>< Screen 0 ></th>"
          append html "<th colspan='2'>< Screen 1 ></th>"
          append html "<th colspan='2'>< Screen 2 ></th>"
          append html "<th colspan='2'>< Screen 3 ></th>"
          append html "<th colspan='2'>< Screen 4 ></th>"
          if {$isWGD_PL == 0 } {
            append html "<th colspan='2'>< Screen 5 ></th>"
          }
        append html "<tr>"
          if {$isWGD_PL == 0 } {set loopxMax 5} else {set loopxMax 4}
          for {set loopx 0} {$loopx <= $loopxMax} {incr loopx} {
            set loop [expr $loopx + 1]
            incr prn
            append html "<td>"
              append html "<select type='text' id='separate_CHANNEL_$chn\_$prn' name='SCREEN_LAYOUT_LEFT_NEIGHBOUR_$loop' value='$ps(SCREEN_LAYOUT_LEFT_NEIGHBOUR_$loop)'>"
              if {$availableScreens == 11} {set maxOption 10} else {set maxOption 5}
              append html "<option value='15'>15</option>"
              for {set option 0} {$option <= $maxOption} {incr option} {
                if {$option == $ps(SCREEN_LAYOUT_LEFT_NEIGHBOUR_$loop)} {set selected "selected='selected'"} else {set selected ""}
                append html "<option value='$option' $selected>$option</option>"
              }
              append html "</select>"
            append html "</td>"

            incr prn
            append html "<td>"
            append html "<select type='text' id='separate_CHANNEL_$chn\_$prn' name='SCREEN_LAYOUT_RIGHT_NEIGHBOUR_$loop' value='$ps(SCREEN_LAYOUT_RIGHT_NEIGHBOUR_$loop)'>"
              if {$availableScreens == 11} {set maxOption 10} else {set maxOption 5}
              for {set option 0} {$option <= $maxOption} {incr option} {
                if {$option == $ps(SCREEN_LAYOUT_RIGHT_NEIGHBOUR_$loop)} {set selected "selected='selected'"} else {set selected ""}
                append html "<option value='$option' $selected>$option</option>"
              }
            append html "</select>"
            append html "</td>"
          }
        append html "</tr>"
      append html "</table>"
    append html "</td>"
  append html "</tr>"

####
  append html "<tr class='hidden'>"
    append html "<td>Page Number</td>"
      append html "<td>"
        append html "<table><tr>"
          if {$isWGD_PL == 0 } {set loopMax 6} else {set loopMax 5}
          for {set loop 1} {$loop <= $loopMax} {incr loop} {
            incr prn
            append html "<td>"
              append html "<select id='separate_CHANNEL_$chn\_$prn' name='SCREEN_LAYOUT_PAGE_NUMBER_$loop' value='$ps(SCREEN_LAYOUT_PAGE_NUMBER_$loop)'>"
                if {$availableScreens == 11} {set maxOption 10} else {set maxOption 5}
                for {set option 0} {$option <= $maxOption} {incr option} {
                  if {$option == $ps(SCREEN_LAYOUT_PAGE_NUMBER_$loop)} {set selected "selected='selected'"} else {set selected ""}
                  append html "<option value='$option' $selected>$option</option>"
                }
              append html "</select>"
            append html "</td>"
            append html "<td><div style='width:56px;'></div></td>"
          }
        append html "</tr></table>"
      append html "</td>"
  append html "</tr>"

####
  if {$availableScreens == 11} {
    append html "<tr class='hidden'>"
      append html "<td>"
        append html "tr Nachbar Screens CLIMATE"
      append html "</td>"


      append html "<td>"
        append html "<table>"

          append html "<tr>"
            append html "<th colspan='2'>< Screen 5 ></th>"
            append html "<th colspan='2'>< Screen 6 ></th>"
            append html "<th colspan='2'>< Screen 7 ></th>"
            append html "<th colspan='2'>< Screen 8 ></th>"
            append html "<th colspan='2'>< Screen 9 ></th>"
            append html "<th colspan='2'>< Screen 10 ></th>"
          append html "</tr>"

          append html "<tr>"
            for {set loopx 5} {$loopx <= 10} {incr loopx} {
              set loop [expr $loopx + 1]
              incr prn
              append html "<td>"
                append html "<select type='text' id='separate_CHANNEL_$chn\_$prn' name='SCREEN_LAYOUT_LEFT_NEIGHBOUR_$loop' value='$ps(SCREEN_LAYOUT_LEFT_NEIGHBOUR_$loop)'>"
                  if {$availableScreens == 11} {set maxOption 10} else {set maxOption 5}
                  append html "<option value='15'>15</option>"
                  for {set option 0} {$option <= $maxOption} {incr option} {
                    if {$option == $ps(SCREEN_LAYOUT_LEFT_NEIGHBOUR_$loop)} {set selected "selected='selected'"} else {set selected ""}
                    append html "<option value='$option' $selected>$option</option>"
                  }
                append html "</select>"
              append html "</td>"
              incr prn
              append html "<td>"
                append html "<select type='text' id='separate_CHANNEL_$chn\_$prn' name='SCREEN_LAYOUT_RIGHT_NEIGHBOUR_$loop' value='$ps(SCREEN_LAYOUT_RIGHT_NEIGHBOUR_$loop)'>"
                  if {$availableScreens == 11} {set maxOption 10} else {set maxOption 5}
                  for {set option 0} {$option <= $maxOption} {incr option} {
                    if {$option == $ps(SCREEN_LAYOUT_RIGHT_NEIGHBOUR_$loop)} {set selected "selected='selected'"} else {set selected ""}
                    append html "<option value='$option' $selected>$option</option>"
                  }
                append html "</select>"
              append html "</td>"
            }
          append html "</tr>"

        append html "</table>"
      append html "</td>"
    append html "</tr>"

    #### Page Number
      append html "<tr class='hidden'>"
        append html "<td>Page Number</td>"
          append html "<td>"
            append html "<table><tr>"

              for {set loop 6} {$loop <= 11} {incr loop} {
                incr prn
                append html "<td>"
                  append html "<select id='separate_CHANNEL_$chn\_$prn' name='SCREEN_LAYOUT_PAGE_NUMBER_$loop' value='$ps(SCREEN_LAYOUT_PAGE_NUMBER_$loop)'>"
                    if {$availableScreens == 11} {set maxOption 10} else {set maxOption 5}
                    for {set option 0} {$option <= $maxOption} {incr option} {
                      if {$option == $ps(SCREEN_LAYOUT_PAGE_NUMBER_$loop)} {set selected "selected='selected'"} else {set selected ""}
                      append html "<option value='$option' $selected>$option</option>"
                    }
                  append html "</select>"
                append html "</td>"
                append html "<td><div style='width:56px;'></div></td>"
              }
            append html "</tr></table>"
          append html "</td>"
      append html "</tr>"

    ####

  }

  # append html "[getHorizontalLine]"
  # Screen Slider
  set sliderHeight "35px"
  set btnHeight "30px"
  set btnStyle "'background-color:lightgrey; height:$btnHeight; border: 1px solid; padding: 2px; text-align:center; cursor:move;'"


  append html "<tr>"
    append html "<td>"
      append html "\${lblScreenManagement}"
    append html "</td>"
    append html "<td>"
      append html "<table>"

        append html "<tr>"
            append html "<td colspan='$availableScreens' class='alignCenter'><div style='background-color:lightgrey; font-weight: bold;'>\${lblOrderOfScreens}</div></td>"
        append html "</tr>"

        # Sortable Screen Elements
        append html "<tr>"
          append html "<td>"
          if {$availableScreens == 6} {
              append html "<div id='dragScreen' style='background-color:lightgrey; display: grid; grid-template-columns: repeat(7, auto); grid-column-gap: 10px; height: $sliderHeight;position:relative;'>"
                for {set loop 0} {$loop <= 5} {incr loop} {
                  append html "<div value='$loop' name='sortScreen' style=$btnStyle><span name='lblScreen' style='font-weight: bold;'>Screen [expr $loop + 1]</span></div>"
                }
                append html "<div value='END' name='sortScreen' style=$btnStyle><span name='lblScreen'>|</span></div>"
              append html "</div>"
          } elseif {$availableScreens == 11} {
            append html "<div id='dragScreen' style='background-color:lightgrey; display: grid; grid-template-columns: repeat(12, auto); grid-column-gap: 10px; height: $sliderHeight;position:relative;'>"
              for {set loop 0} {$loop <= 10} {incr loop} {
                append html "<div value='$loop' name='sortScreen' style=$btnStyle><span name='lblScreen' style='font-weight: bold;'>Screen [expr $loop + 1]</span></div>"
              }
              append html "<div value='END' name='sortScreen' style=$btnStyle><span name='lblScreen'>|</span></div>"
            append html "</div>"
          }
          append html "</td>"
        append html "</tr>"

      append html "</table>"
    append html "</td>"
  append html "</tr>"

  #append html "<script type='text/javascript'>createDragDrop();</script>"
  append html "<script type='text/javascript'>"
    append html "createSortable($availableScreens, '$dev_descr(ADDRESS)');"

    # Extend the footer buttons
    append html " window.setTimeout(function() { "
     append html " var elm = jQuery('#footerButtonOK, #footerButtonTake'); "
     append html " elm.off('click').click(function() {storeSelectedScreenOrder('$dev_descr(ADDRESS)');}); "
    append html " },50); "


  append html "</script>"

  append html "[getHorizontalLine]"

  # SCREEN_LAYOUT_TILE_LAYOUT
  append html "<tr>"
    append html "<td>\${lblLayoutScreenTile}</td>"
    append html "<td><table>"
    append html "<tr>"
      if {$isWGD_PL == 0 } {set loopMax 6} else {set loopMax 5}
      for {set loop 1} {$loop <= $loopMax} {incr loop} {
        append html "<th>Screen $loop</th>"
      }
    append html "</tr>"

    append html "<tr>"
      if {$isWGD_PL == 0 } {set loopMax 6} else {set loopMax 5}
      for {set loop 1} {$loop <= $loopMax} {incr loop} {
        set param SCREEN_LAYOUT_TILE_LAYOUT_$loop
        incr prn
        array_clear options
        set options(0) "\${option1Tile}"
        if {$loop < $loopMax} {
          set options(1) "\${option2Tiles}"
          set options(2) "\${option4Tiles}"
        }
        append html "<td>"
          append html "[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]"
        append html "</td>"
      }
   append html "</tr></table></td>"
  append html "</tr>"

  if {$availableScreens == 11} {

  append html "<tr>"
    append html "<td>\${lblLayoutScreenClimateTile}</td>"
    append html "<td><table>"
    append html "<tr>"
      for {set loop 6} {$loop <= 11} {incr loop} {
        append html "<th>Screen $loop</th>"
      }
    append html "</tr>"

    append html "<tr>"
      for {set loop 6} {$loop <= 11} {incr loop} {
        set param SCREEN_LAYOUT_TILE_LAYOUT_$loop
        incr prn
        array_clear options
        set options(0) "\${option1Tile}"
        if {$loop < 11} {
          set options(1) "\${option2Tiles}"
        }
        append html "<td>"
          append html "[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]"
        append html "</td>"
      }
   append html "</tr></table></td>"
  append html "</tr>"
  }

  append html "[getHorizontalLine]"

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
    set options(5) "\${optionLangNL}"
    append html "<tr><td>\${lblLanguage}</td><td>"
    append html "[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]"
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
    array_clear options
    set options(0) "\${optionDeactivated}"
    set options(1) "\${optionUnit1S}"
    set options(2) "\${optionUnit2S}"
    set options(3) "\${optionUnit3S}"
    set options(5) "\${optionUnit5S}"
    set options(7) "\${optionUnit7S}"
    set options(10) "\${optionUnit10S}"
    set options(30) "\${optionUnit30S}"
    set options(60) "\${optionUnit1M}"
    set options(120) "\${optionUnit2M}"
    set options(180) "\${optionUnit3M}"
    set options(240) "\${optionUnit4M}"
    set options(255) "\${optionColorON}"
    append html "<tr>"
      append html "<td>\${lblDisplayOnTime}</td>"
      append html "<td>[get_ComboBox options $param separate_$special_input_id\_$prn ps $param]</td>"
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

  set param _ABORT_EVENT_SENDING_CHANNELS
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
     append html "<td colspan='2'  style='text-align:center;'><span class='attention'>Wird ausgeblendet</span> \${stringTableAbortEventSendingChannels}&nbsp;[getHelpIcon $param]</td>"
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
        append html  "<td class='hidden' style='padding-left:60px;'>[getTextField $param $ps($param) $chn $prn]&nbsp;<span class='attention'>(only visible for testing)</span></td>"
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
      set options(2) "\${optionShutter}"
      set options(3) "\${optionSwitchActor}"
      set options(4) "\${optionBlind}"
      set options(5) "\${optionShutterBlind}"
      set options(6) "\${optionHSV}"
      set options(7) "\${optionTW}"
      set options(8) "\${optionHSVTW}"
      set options(9) "\${optionAccessLockUnlock}"
      set options(10) "\${optionAccessDayNight}"
      set options(11) "\${optionAccessOpen}"

      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]&nbsp;[getHelpIcon $param\_A 550 500]</td>"
    append html "</tr>"
  }

  # Not desired according to discussion with PM and Developer.
  set param _CHANNEL_OPERATION_MODE
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
  # append html "[getHorizontalLine]"

  # Not desired according to discussion with PM and Developer.
  set param _DBL_PRESS_TIME
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableKeyDblPressTime}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  # Not desired according to discussion with PM and Developer.
  set param _LONG_PRESS_TIME
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableKeyLongPressTimeA}</td>"
      append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  # Not desired according to discussion with PM and Developer.
  set param _REPEATED_LONG_PRESS_TIMEOUT_UNIT
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


proc getDisplayThermostatInputTransmitter {chn p descr} {

  global dev_descr env

  upvar $p ps
  upvar $descr psDescr
  upvar special_input_id special_input_id

  set prn 0
  set devType $dev_descr(TYPE)
  set specialID "[getSpecialID $special_input_id]"
  set html ""

  set param MAIN_TEXT
  if { [info exists ps($param)] == 1  } {
    incr prn
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

proc getWeatherDisplayReceiver {chn p descr} {

  global dev_descr env

  upvar $p ps
  upvar $descr psDescr
  upvar special_input_id special_input_id

  set prn 0
  set devType $dev_descr(TYPE)
  set specialID "[getSpecialID $special_input_id]"
  set html ""

  set param BASE_IMAGE
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr>"
      append html "<td>\${lblBaseImage} 1</td>"
      append html "<td><table><tr>"
        append html "<td style='border: 1px solid black;'><div style='background-color:gray; padding:5px; cursor: pointer;' onclick='selectWGDIcon(\"$chn\",\"separate_$special_input_id\_$prn\",\"$ps($param)\", \"weather\");'><img id=\"image_$chn\" width='24' height='24' src=''></div></td>"
        # This textfield is necessary but should not be invisible.
        append html  "<td class='hidden' style='padding-left:60px;'>[getTextField $param $ps($param) $chn $prn]&nbsp;<span class='attention'>(only visible for testing)</span></td>"
      append html "</tr></table></td>"

      append html "<script type=\"text/javascript\">"
      append html "if (typeof imageCollection == 'undefined') {"
        append html "imageCollection = getWGDImageCollection('weather');"
      append html "}"
      append html "jQuery.each(imageCollection, function(index, val) {"
        append html "if (parseInt($ps($param)) == val\[1\]) {"
          append html "jQuery(\"\#image_$chn\").attr(\"src\", getWGDImagePath('weather') + val\[0\]);"
          append html "return false;" ;# return each loop
        append html "} else {"
          append html "jQuery(\"\#image_$chn\").attr(\"src\", getWGDImagePath('weather') + getWGDDefaultImage('weather'));"
        append html "}"
      append html "});"
      append html "</script>"

    append html "</tr>"
  }

  for {set loop 2} {$loop <= 8} {incr loop} {
    set param BASE_IMAGE_$loop
    if { [info exists ps($param)] == 1 } {
      incr prn
      append html "<tr>"
        append html "<td>\${lblBaseImage} $loop</td>"
        append html "<td><table><tr>"
          append html "<td style='border: 1px solid black;'><div style='background-color:gray; padding:5px; cursor: pointer;' onclick='selectWGDIcon(\"$chn\",\"separate_$special_input_id\_$prn\",\"$ps($param)\", \"weather\", $loop);'><img id=\"image_$loop\_$chn\" width='24' height='24' src=''></div></td>"
          # This textfield is necessary but should not be invisible.
          append html  "<td class='hidden' style='padding-left:60px;'>[getTextField $param $ps($param) $chn $prn]&nbsp;<span class='attention'>(only visible for testing)</span></td>"
        append html "</tr></table></td>"

        append html "<script type=\"text/javascript\">"
        append html "if (typeof imageCollection == 'undefined') {"
          append html "imageCollection = getWGDImageCollection('weather');"
        append html "}"
        append html "jQuery.each(imageCollection, function(index, val) {"
          append html "if (parseInt($ps($param)) == val\[1\]) {"
            append html "jQuery(\"\#image_$loop\_$chn\").attr(\"src\", getWGDImagePath('weather') + val\[0\]);"
            append html "return false;" ;# return each loop
          append html "} else {"
            append html "jQuery(\"\#image_$loop\_$chn\").attr(\"src\", getWGDImagePath('weather') + getWGDDefaultImage('weather'));"
          append html "}"
        append html "});"
        append html "</script>"

      append html "</tr>"
    }
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

proc getNoParametersToSet {} {
  set html "<tr><td name=\"noParamElm\" class=\"CLASS22003\"><div class=\"CLASS22004\">\${deviceAndChannelParamsLblNoParamsToSet}</div></td></tr>"
  # center content
  append html "<script type=\"text/javascript\">window.setTimeout(function(){jQuery(\"\[name='noParamElm'\]\").parent().parent().parent().width(\"100%\");},100);</script>"
  return $html
}