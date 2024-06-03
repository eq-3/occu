proc getSelectEffectElement {p special_input_id param} {
  upvar $p PROFILE
  upvar prn prn
  upvar pref pref

  set html "<tr><td>{OUTPUT_BEHAVIOUR_effect}</td><td>"
  array_clear options
  set options(0) "\${effect0}"
  set options(1) "\${effect1}"
  set options(2) "\${effect2}"
  set options(3) "\${effect3}"
  set options(4) "\${effect4}"
  set options(5) "\${effect5}"
  set options(6) "\${effect6}"
  set options(7) "\${effect7}"
  append html [get_ComboBox options $param separate_${special_input_id}_$prn\_$pref PROFILE $param]
  append html "</td></tr>"
  return $html
}

proc getColorTempSlider {pps keyPress {onOff ""} {onlyOn_or_Off ""} {colorAB ""}}  {
  global url receiver_address dev_descr_receiver
  upvar $pps ps
  upvar prn prn
  upvar pref pref
  upvar showModeSelector displayModeSelector

  set _pref $pref
  set html ""

  array set dev_descr [xmlrpc $url getParamset [list string $receiver_address] MASTER]

  set maxCOLOR_TEMP $dev_descr(HARDWARE_COLOR_TEMPERATURE_COLD_WHITE)
  set valCT_Son $ps(SHORT_ON_COLOR_TEMPERATURE)
  set valCT_Lon $ps(LONG_ON_COLOR_TEMPERATURE)
  set valCT_Soff $ps(SHORT_OFF_COLOR_TEMPERATURE)
  set valCT_Loff $ps(LONG_OFF_COLOR_TEMPERATURE)

  set classModeSel ""

  if {$displayModeSelector == "false"} { set classModeSel class='hidden' }

    append html "<tr $classModeSel>"
      append html "<td>\${COLOR_TEMP_$onOff}</td>"
      append html "<td>"
        append html "<select id='selectOnColorTemp_$prn$onlyOn_or_Off' onchange='selectOnColorTemp(this.value, $prn, $pref, $valCT_Son, $valCT_Lon, $valCT_Soff, $valCT_Loff, $maxCOLOR_TEMP, \"$onlyOn_or_Off\")'>"

          if {(($onlyOn_or_Off == "") && ($valCT_Son == "10100")) || (($onlyOn_or_Off == "ON") && ($valCT_Son == "10100")) || (($onlyOn_or_Off == "OFF") && ($valCT_Soff == "10100"))} {
            set selectedLastVAl "selected='selected'"
            set selectedColorTemp ""
          } else {
            set selectedLastVAl ""
            set selectedColorTemp "selected='selected'"
          }
          if {[string equal $dev_descr_receiver(PARENT_TYPE) "HmIP-LSC"] != 1} {
            append html "<option value='lastValue' $selectedLastVAl>\${lastValue}</option>"
          }
          append html "<option value='setColorTemp' $selectedColorTemp>\${COLOR_TEMP}</option>"
        append html "</select>"
      append html "</td>"
    append html "</tr>"



  append html "<tr id='trColorTempSlider_$prn\_$pref' name='j_trColorTempSlider_$prn' class='_hidden'>"
    if {$displayModeSelector == "false"}  {
      append html "<td>\${COLOR_TEMP_$onOff}</td>"
    } else {
      append html "<td><span>\${COLOR_TEMP} $colorAB</span></td>"
    }

    append html "<td>"
      set sliderPref $pref
      append html "<div id='colorTempSlider_$prn\_$pref'></div>"
    append html "</td>"
    append html "<td>&nbsp;&nbsp;</td>"
    append html "<td>"
    if {$onlyOn_or_Off == ""} {
        append html "<input id='separate_receiver_$prn\_$pref' name='SHORT_ON_COLOR_TEMPERATURE' class='j_shortOnColorTemp_$prn' value='$ps(SHORT_ON_COLOR_TEMPERATURE)' size='4'>&nbsp;\${unitKelvin}"
        incr pref
        append html "<input id='separate_receiver_$prn\_$pref' name='LONG_ON_COLOR_TEMPERATURE' class='hidden j_longOnColorTemp_$prn' value='$ps(LONG_ON_COLOR_TEMPERATURE)' size='4'>"
        incr pref
        append html "<input id='separate_receiver_$prn\_$pref' name='SHORT_OFF_COLOR_TEMPERATURE' class='hidden j_shortOffColorTemp_$prn' value='$ps(SHORT_OFF_COLOR_TEMPERATURE)' size='4'>"
        incr pref
        append html "<input id='separate_receiver_$prn\_$pref' name='LONG_OFF_COLOR_TEMPERATURE' class='hidden j_longOffColorTemp_$prn' value='$ps(LONG_OFF_COLOR_TEMPERATURE)' size='4'>"
    } elseif {$onlyOn_or_Off == "ON"} {
        append html "<input id='separate_receiver_$prn\_$pref' name='SHORT_ON_COLOR_TEMPERATURE' class='j_shortOnColorTemp_$prn' value='$ps(SHORT_ON_COLOR_TEMPERATURE)' size='4'>&nbsp;\${unitKelvin}"
        incr pref
        append html "<input id='separate_receiver_$prn\_$pref' name='LONG_ON_COLOR_TEMPERATURE' class='hidden j_longOnColorTemp_$prn' value='$ps(LONG_ON_COLOR_TEMPERATURE)' size='4'>"
    } elseif {$onlyOn_or_Off == "OFF"} {
        append html "<input id='separate_receiver_$prn\_$pref' name='SHORT_OFF_COLOR_TEMPERATURE' class='j_shortOffColorTemp_$prn' value='$ps(SHORT_OFF_COLOR_TEMPERATURE)' size='4'>&nbsp;\${unitKelvin}"
        incr pref
        append html "<input id='separate_receiver_$prn\_$pref' name='LONG_OFF_COLOR_TEMPERATURE' class='hidden j_longOffColorTemp_$prn' value='$ps(LONG_OFF_COLOR_TEMPERATURE)' size='4'>"
    }
    append html "</td>"
  append html "</tr>"

  set displayModeSelector true

  append html "<script text/javascript>"
    append html "window.setTimeout(function() {"
      append html "getColorTempSlider($prn, $sliderPref, '$onlyOn_or_Off');"
      append html "jQuery('#selectOnColorTemp_$prn$onlyOn_or_Off').change();"
    append html "},20);"
  append html "</script>"


  return $html

}

proc getColorTempSliderMinMax {pps keyPress minMax {specialParam ""}} {
  upvar $pps ps
  upvar prn prn
  upvar pref pref

  set _pref $pref
  set html ""

  append html "<td>"
    append html "<div id='colorTempSliderMinMax_$prn\_$pref'></div>"
  append html "</td>"

  append html "<td>&nbsp;&nbsp;</td>"

  if {$keyPress == "SHORT_LONG"} {
     append html "<td class='_hidden'>"
      append html "<input id='separate_receiver_$prn\_$pref'  name='SHORT_DIM_$minMax\_COLOR_TEMPERATURE' class='j_shortDim$minMax\_$prn' value='$ps(SHORT_DIM_$minMax\_COLOR_TEMPERATURE)' size='4'>&nbsp;\${unitKelvin}"
    append html "</td>"

    incr pref
    append html "<td class='hidden'>"
      append html "<input id='separate_receiver_$prn\_$pref' name='LONG_DIM_$minMax\_COLOR_TEMPERATURE' class='j_longDim$minMax\_$prn' value='$ps(LONG_DIM_$minMax\_COLOR_TEMPERATURE)' size='4'>"
    append html "</td>"

    append html "<script text/javascript>"
      append html "window.setTimeout(function() {getColorTempSliderMinMax($prn, [expr $_pref], '$keyPress', '$minMax', '$specialParam');},50);"
    append html "</script>"

  } else {
    append html "<td class='_hidden'>"
      append html "<input id='separate_receiver_$prn\_$pref' name='$keyPress\_DIM_$minMax\_COLOR_TEMPERATURE' value='$ps($keyPress\_DIM_$minMax\_COLOR_TEMPERATURE)' size='4'>&nbsp;\${unitKelvin}"
    append html "</td>"

    append html "<script text/javascript>"
      append html "window.setTimeout(function() {getColorTempSliderMinMax($prn, $pref, '$keyPress', '$minMax', '$specialParam');},50);"
    append html "</script>"

  }



  return $html

}



