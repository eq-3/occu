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

proc getColorPicker {pps keyPress} {
  upvar $pps ps
  upvar prn prn
  upvar pref pref

  set _pref $pref
  set html ""

  set valHUE $ps($keyPress\_ON_HUE)
  set valSAT $ps($keyPress\_ON_SATURATION)

  if {$valHUE > 360} {set valHUE 361}

  append html "<tr>"
    append html "<td>\${ON_COLOR}</td>"
    append html "<td>"
      append html "<select id='selectOnColor_$prn' onchange='selectOnColor(this.value, $prn, $pref, $valHUE, $valSAT)'>"

        if {$valHUE == "361"} {
          set selectedLastVAl "selected='selected'"
          set selectedColor ""
        } else {
          set selectedLastVAl ""
          set selectedColor "selected='selected'"
       }

        append html "<option value='lastValue' $selectedLastVAl>\${lastValue}</option>"
        append html "<option value='setColor' $selectedColor>\${optionColorVal}</option>"
      append html "</select>"
    append html "</td>"
  append html "</tr>"

  append html "<tr id='trColorPicker_$prn\_$pref'>"
    append html "<td> </td>"
    append html "<td>"
      append html "<div id='anchorColorPicker_$prn\_$pref'></div>"
    append html "</td>"

    append html "<td>"
      append html "<table>"
        append html "<tr>"
          append html "<td>"
            append html "H"
          append html "</td>"
          append html "<td>"
            append html "<input id='separate_receiver_$prn\_$pref' name='SHORT_ON_HUE' class='alignCenter' value='$ps(SHORT_ON_HUE)' size='4'>"
            incr pref
            append html "<input id='separate_receiver_$prn\_$pref' name='SHORT_OFF_HUE' class='alignCenter hidden' value='$ps(SHORT_OFF_HUE)' size='4'>"
            incr pref
            append html "<input id='separate_receiver_$prn\_$pref' name='LONG_ON_HUE' class='alignCenter hidden' value='$ps(LONG_ON_HUE)' size='4'>"
            incr pref
            append html "<input id='separate_receiver_$prn\_$pref' name='LONG_OFF_HUE' class='alignCenter hidden' value='$ps(LONG_OFF_HUE)' size='4'>&nbsp;°"
          append html "</td>"
        append html "</tr>"

        append html "<tr>"
          append html "<td>"
            append html "S"
          append html "</td>"

          append html "<td>"
            incr pref
            append html "<input id='tmp_SHORT_ON_SATURATION_$prn\_$pref' class='alignCenter' value='[expr int([expr $ps(SHORT_ON_SATURATION) * 100])]' size='4'>"
            incr pref
            append html "<input id='tmp_SHORT_OFF_SATURATION_$prn\_$pref' class='alignCenter hidden' value='[expr int([expr $ps(SHORT_OFF_SATURATION) * 100])]' size='4'>"
            incr pref
            append html "<input id='tmp_LONG_ON_SATURATION_$prn\_$pref' class='alignCenter hidden' value='[expr int([expr $ps(LONG_ON_SATURATION) * 100])]' size='4'>"
            incr pref
            append html "<input id='tmp_LONG_OFF_SATURATION_$prn\_$pref' class='alignCenter hidden' value='[expr int([expr $ps(LONG_OFF_SATURATION) * 100])]' size='4'>"
          append html "</td>"

          append html "<td>"
            append html "%"
          append html "</td>"
          set pref [expr int([expr $pref - 3])]
          append html "<td class='hidden'>"
            append html "<input id='separate_receiver_$prn\_$pref' name='SHORT_ON_SATURATION' value='$ps(SHORT_ON_SATURATION)' size='4'>"
            incr pref
            append html "<input id='separate_receiver_$prn\_$pref' name='SHORT_OFF_SATURATION' value='$ps(SHORT_OFF_SATURATION)' size='4'>"
            incr pref
            append html "<input id='separate_receiver_$prn\_$pref' name='LONG_ON_SATURATION' value='$ps(LONG_ON_SATURATION)' size='4'>"
            incr pref
            append html "<input id='separate_receiver_$prn\_$pref' name='LONG_OFF_SATURATION' value='$ps(LONG_OFF_SATURATION)' size='4'>"
          append html "</td>"

        append html "</tr>"

        append html "<tr>"
          append html "<td></td>"
          append html "<td>"
            append html "<div id='selectedColor_$prn\_$pref' style='width:auto;'>&nbsp;</div>"
          append html "</td>"
        append html "</tr>"

      append html "</table>"
    append html "</td>"
  append html "</tr>"

  append html "<script text/javascript>"
    append html "window.setTimeout(function() {"
      append html "getHSV_ColorPicker($prn, $_pref);"
      append html "jQuery('#selectOnColor_$prn').change();"
    append html "},50);"
  append html "</script>"

  return $html

}

proc getHueSlider {pps onOff {sliderOn_sliderOff false} {colorAB ""}} {
  upvar $pps ps
  upvar prn prn
  upvar pref pref

  set _pref $pref
  set html ""

  set valHUE $ps(SHORT_$onOff\_HUE)
  if {$valHUE > 359} {set valHUE 359}



  append html "<tr id='trColorPicker_$prn\_$pref'>"
    if {$colorAB == ""} {
       append html "<td>\${$onOff\_LEVEL_COLOR_VALUE}</td>"
    } else {
      append html "<td>\${$colorAB\_LEVEL_COLOR_VALUE}</td>"
    }
    append html "<td>"
      append html "<div id='anchorColorHueSlider_$prn\_$pref'></div>"
    append html "</td>"

    append html "<td>"
      append html "H"
    append html "</td>"

    append html "<td>"
      append html "<input id='separate_receiver_$prn\_$pref' name='SHORT_$onOff\_HUE' class='alignCenter' value='$valHUE' size='4'>&nbsp;°"
    append html "</td>"
  append html "</tr>"

  append html "<tr>"
    append html "<td></td><td></td><td></td>"
    append html "<td>"
      append html "<div id='selectedColor_$prn\_$pref' style='width:70px;'>&nbsp;</div>"
    append html "</td>"
  append html "</tr>"


  # Custom handle for the slider
  append html "<svg class='hidden'>"
    append html "<defs>"
      append html "<g id='handle'>"
        append html "<rect x='0' y='-2' width='6' height='20' style='fill:rgb(255,255,255);stroke-width:2;stroke:rgb(0,0,0)'></rect>"
      append html "</g>"
    append html "</defs>"
  append html "</svg>"

  append html "<script text/javascript>"
    append html "window.setTimeout(function() {"
      append html "getColorHueSlider($prn, $_pref, '$onOff', $sliderOn_sliderOff);"
    append html "},50);"
  append html "</script>"

 return $html

}

