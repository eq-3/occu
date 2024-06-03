proc getSelectBoxTime {channel param mode prn} {
  #upvar prn prn
  upvar ps ps

  set prn1 $prn
  incr prn1

  set listParam [split $param  "_"]
  set lblParam "lbl_";
  append lblParam [string tolower "[lindex $listParam 2]_[lindex $listParam 3]_[lindex $listParam 4]"]

  set html "<tr>"
    append html "<td>\${$lblParam}</td>"
    append html "<td>"
      append html "<select id=\"$mode\_$prn\" name=\"$mode\_$prn\" style=\"width:150px;\" onchange=\"setValues(this.value, $prn);\">"
        if {$mode == "colorFadeTime" || $mode == "colorHoldTime"} {
          append html "<option class='sel00' value='0'>\${optionNotActive}</option>"
          append html "<option class='sel11' value='1'>\${optionUnit1S}</option>"
          append html "<option class='sel21' value='2'>\${optionUnit2S}</option>"
          append html "<option class='sel41' value='3'>\${optionUnit4S}</option>"
          append html "<option class='sel51' value='4'>\${optionUnit5S}</option>"
          append html "<option class='sel301' value='5'>\${optionUnit30S}</option>"
          append html "<option class='sel14' value='6'>\${optionUnit1M}</option>"
          append html "<option class='sel24' value='7'>\${optionUnit2M}</option>"
        } elseif {$mode == "*****"} {
          append html "<option value='0'>\${optionNotActive}</option>"
          append html "<option value='1'>\${optionUnit100MS}</option>"
          append html "<option value='2'>\${optionUnit200MS}</option>"
          append html "<option value='3'>\${optionUnit500MS}</option>"
          append html "<option value='4'>\${optionUnit1S}</option>"
          append html "<option value='5'>\${optionUnit2S}</option>"
          append html "<option value='6'>\${optionUnit5S}</option>"
          append html "<option value='7'>\${optionUnit10S}</option>"
        }
      #  append html "<option class='selEnterVal' value='EnterValue'>\${optionEnterValue}</option>"
      append html "</select>"
    append html "</td>"
  append html "</tr>"

  append html "<tr name='trFactorBase_$prn' class='hidden'>"
    append html "<td>FACTOR</td>"
    append html "<td><input id='separate_$channel\_$prn' name='$param\_FACTOR' class='j_effectFactor\_$prn' type='text' value=$ps($param\_FACTOR)></td>"
  append html "</tr>"

  append html "<tr name='trFactorBase_$prn' class='hidden'>"
    append html "<td>BASE</td>"
    append html "<td>"
      append html "<select id='separate_$channel\_$prn1' name='$param\_BASE' class='j_effectBase\_$prn1' style=\"width:150px;\" value=$ps($param\_BASE)>"
        append html "<option value='0' class='BASE_100_MS'>\${optionUnit100MS}</option>"
        append html "<option value='1' class='BASE_1_S'>\${optionUnit1S}</option>"
        append html "<option value='2' class='BASE_5_S'>\${optionUnit5S}</option>"
        append html "<option value='3' class='BASE_10_S'>\${optionUnit10S}</option>"
        append html "<option value='4' class='BASE_1_M'>\${optionUnit1M}</option>"
        append html "<option value='5' class='BASE_5_M'>\${optionUnit5M}</option>"
        append html "<option value='6' class='BASE_10_M'>\${optionUnit10M}</option>"
        append html "<option value='7' class='BASE_1_H'>\${optionUnit1H}</option>"
      append html "</select>"
    append html "</td>"
  append html "</tr>"

  append html "<script type='text/javascript'>"

    append html "var _presetSel = jQuery(\"#$mode\_$prn\"),"
    append html "factorElm = jQuery('.j_effectFactor\_$prn').first(),"
    append html "baseElm = jQuery('.j_effectBase\_$prn1').first(),"
    append html "mode = '$mode';"

    append html "factorElm.val($ps($param\_FACTOR));"
    append html "baseElm.val($ps($param\_BASE));"

    # Select the current time
    append html "var classSel = 'sel$ps($param\_FACTOR)$ps($param\_BASE)',"
    append html "presetSelBoxOptionElm = jQuery(\"#$mode\_$prn  option\[class=\"+classSel+\"\]\"),"
    append html "presetSelBoxOptionEnterValElm = jQuery(\"#$mode\_$prn option\[class='selEnterVal'\]\"),"
    append html "trFactorBaseElm = jQuery(\"\[name='trFactorBase_$prn'\]\");"

    append html "if (presetSelBoxOptionElm.length != 0) {"
      append html "presetSelBoxOptionElm.attr(\"selected\", \"selected\");"
    append html "} else {"
      append html "presetSelBoxOptionEnterValElm.attr(\"selected\", \"selected\");"
      append html "trFactorBaseElm.show();"
    append html "}"
    # End Select current time

    append html "setValues = function(val, prn) {"
      append html "var prn1 = parseInt(prn) + 1,"
      append html "trFactorBaseElm = jQuery(\"\[name='trFactorBase_\" + prn +\"'\]\"),"
      append html "factorElm = jQuery('.j_effectFactor_' + prn).first(),"
      append html "baseElm = jQuery('.j_effectBase_' + prn1).first(),"
      append html "mode = '$mode';"

      append html "var arFactorValue = \[0,1,2,4,5,30,1,2\],"

      # 0 = 100 ms, 1 = 1 sec, 2 = 5 sec, 3 = 10 sec, 4 = 1 min, 5 = 5 min, 6 = 10 min, 7 = 1h
      append html "arBaseValue =\[0,1,1,1,1,1,4,4\];"

      append html "if ((mode == 'colorFadeTime') || (mode == 'colorHoldTime')) {"

      # When 'Enter Value' is selected, the default will be 5 seconds = factor 5, base 1
      append html "if (val == 'EnterValue') {"
        append html "factorElm.val(5).change();"
        append html "baseElm.val(1).change();"
        append html "trFactorBaseElm.show();"
      append html "} else {"
        append html "trFactorBaseElm.hide();"
        append html "factorElm.val(arFactorValue\[val\]).change();"
        append html "baseElm.val(arBaseValue\[val\]).change();"
      append html "}"

      append html "} else if (mode == '*****') {"
        append html "console.log('*****');"
      append html "}"

    append html "}"



  append html "</script>"

  return $html
}

proc getColorLevel {param chn prn OnOff} {
  upvar ps ps

  set lblParam "lbl_"
  append lblParam [string tolower $OnOff\_Level]

  set html "<tr id='trOnLevel_$prn'>"
  append html "<td>\${$lblParam}</td>"
  array_clear options
  option RAW_0_100Percent_1
  append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
  append html "</tr>"

  return $html
}

# ******************

proc getColorPicker {param OnOff} {
  upvar ps ps
 # upvar prn prn
  upvar prn pref

  set lblParam "lbl_"
  append lblParam [string tolower $OnOff\_COLOR]

  set prn 1

  set _pref $pref
  set html ""

#  set valHUE $ps($param)

  append html "<tr>"
    append html "<td>\${$lblParam}</td>"
    append html "<td>"
      append html "<div id='bckGndElm_$pref' style='width:auto; cursor:pointer;' onclick='setColorHCCT(this, $prn, $pref, \"$param\");' >&nbsp;</div>"
    append html "</td>"
    append html "<td>"
      append html "<input id='separate_CHANNEL_$prn\_$pref' name='$param' class='alignCenter hidden' value='$ps($param)' size='4'>"
    append html "</td>"
  append html "</tr>"

  append html "<script text/javascript>"
    append html "window.setTimeout(function() {"
      append html "initColorHCCT($pref, '$param');"
    append html "},50);"
  append html "</script>"

  return $html

}


# ******************

proc getHeatingControlEffects {chn} {

  upvar prn prn
  upvar CHANNEL CHANNEL
  upvar ps ps

  append html "<tr><td colspan='2'><hr></td></tr>"
  # append html "<tr><td class='alignCenter'><b><u>\${titleHeatingClimateControlTransEffect}</u></b></td></tr>"

append html "<tr>"
  append html "<td>"
    append html "<table>"

              append html "<tr>"
                append html "<td>"
                  append html "<table>"
                    append html "<tr><td colspan='2' class='alignCenter'><b><u>\${HCCTransEffectAdaption}</u></b></td></tr>"
                    incr prn
                    # ColorSelector ADAPTION OFF
                    append html "[getSelectBoxTime $CHANNEL EFFECT_ADAPTION_FADE_OUT_TIME colorFadeTime $prn]"

                    incr prn 2
                    append html "[getSelectBoxTime $CHANNEL EFFECT_ADAPTION_OFF_HOLD_TIME colorHoldTime $prn]"

                    incr prn 2
                    append html "[getColorPicker EFFECT_ADAPTION_OFF_HUE_SAT_VALUE OFF]"

                    incr prn
                    append html "[getColorLevel EFFECT_ADAPTION_OFF_LEVEL $chn $prn OFF]"

                    # ColorSelector ADAPTION ON

                    append html "<tr><td><hr></td></tr>"

                    incr prn
                    append html "[getSelectBoxTime $CHANNEL EFFECT_ADAPTION_FADE_IN_TIME colorFadeTime $prn]"

                    incr prn 2
                    append html "[getSelectBoxTime $CHANNEL EFFECT_ADAPTION_ON_HOLD_TIME colorHoldTime $prn]"

                    incr prn 2
                    append html "[getColorPicker EFFECT_ADAPTION_ON_HUE_SAT_VALUE ON]"

                    incr prn
                    append html "[getColorLevel EFFECT_ADAPTION_ON_LEVEL $chn $prn ON]"
                  append html "</table>"
                append html "</td>"

                append html "<td>"
                  append html "<table>"
                    append html "<tr><td colspan='2' class='alignCenter'><b><u>\${HCCTransEffectBoost}</u></b></td>"

                    # ColorSelector BOOST OFF
                    append html "[getSelectBoxTime $CHANNEL EFFECT_BOOST_FADE_OUT_TIME colorFadeTime $prn]"

                    incr prn 2
                    append html "[getSelectBoxTime $CHANNEL EFFECT_BOOST_OFF_HOLD_TIME colorHoldTime $prn]"

                    incr prn 2
                    append html "[getColorPicker EFFECT_BOOST_OFF_HUE_SAT_VALUE OFF]"

                    incr prn
                    append html "[getColorLevel EFFECT_BOOST_OFF_LEVEL $chn $prn OFF]"

                    # ColorSelector BOOST ON

                    append html "<tr><td><hr></td></tr>"

                    incr prn
                    append html "[getSelectBoxTime $CHANNEL EFFECT_BOOST_FADE_IN_TIME colorFadeTime $prn]"

                    incr prn 2
                    append html "[getSelectBoxTime $CHANNEL EFFECT_BOOST_ON_HOLD_TIME colorHoldTime $prn]"

                    incr prn 2
                    append html "[getColorPicker EFFECT_BOOST_ON_HUE_SAT_VALUE ON]"

                    incr prn
                    append html "[getColorLevel EFFECT_BOOST_ON_LEVEL $chn $prn ON]"
                  append html "</table>"
                append html "</td>"
              append html "</tr>"


    append html "</table>"
  append html "</td>"
append html "</tr>"



  return $html
}