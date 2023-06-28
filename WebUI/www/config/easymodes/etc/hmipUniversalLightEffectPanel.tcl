#!/bin/tclsh

puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/ic_effects.js');</script>"
puts "<script type=\"text/javascript\">getLangInfo_Special('HmIP_DEVICES.txt');</script>"
puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/UNIVERSAL_LIGHT_EFFECT.js');</script>"

proc getSelectTime {mode effect subEffect} {
  set selectBox "<select id=\"$mode\_$effect\_$subEffect\" name=\"$mode\" style=\"width:150px;\" onchange=\"setEffectTime(this, '$mode', '$effect', '$subEffect');\">"
    if {$mode == "colorFadeInTime"} {
      append selectBox "<option value='0'>\${optionNotActive}</option>"
      append selectBox "<option value='1'>\${optionUnit1S}</option>"
      append selectBox "<option value='2'>\${optionUnit2S}</option>"
      append selectBox "<option value='3'>\${optionUnit4S}</option>"
      append selectBox "<option value='4'>\${optionUnit5S}</option>"
      append selectBox "<option value='5'>\${optionUnit30S}</option>"
      append selectBox "<option value='6'>\${optionUnit1M}</option>"
      append selectBox "<option value='7'>\${optionUnit2M}</option>"
    } elseif {$mode == "colorHoldTime"} {
      append selectBox "<option value='0'>\${optionNotActive}</option>"
      append selectBox "<option value='1'>\${optionUnit100MS}</option>"
      append selectBox "<option value='2'>\${optionUnit200MS}</option>"
      append selectBox "<option value='3'>\${optionUnit500MS}</option>"
      append selectBox "<option value='4'>\${optionUnit1S}</option>"
      append selectBox "<option value='5'>\${optionUnit2S}</option>"
      append selectBox "<option value='6'>\${optionUnit5S}</option>"
      append selectBox "<option value='7'>\${optionUnit10S}</option>"
    }
    append selectBox "<option value='10'>\${optionEnterValue}</option>"
  append selectBox "</select>"
  return $selectBox
}

proc getSatColorTempType {effect subEffect} {
  set selectBox "<select id=\"satColorTempType_$effect\_$subEffect\" style=\"width:100%\" onchange=\"setSatColorTempType(this, '$effect', '$subEffect')\">"
    append selectBox "<option value='0'>\${optionInactiv}</option>"
    append selectBox "<option value='1'>\${optionHueSaturation}</option>"
    append selectBox "<option value='2'>\${optionColorTemp}</option>"
  append selectBox "</select>"
  return $selectBox
}

proc getLevel {effect subEffect} {
  set selectBox "<select id=\"level_$effect\_$subEffect\" style=\"width:100%\" onchange=\"setEffectLevel(this, '$effect', '$subEffect')\">"
    append selectBox "<option value='0'> 0 %</option>"
    append selectBox "<option value='0.1'>10 %</option>"
    append selectBox "<option value='0.2'>20 %</option>"
    append selectBox "<option value='0.3'>30 %</option>"
    append selectBox "<option value='0.4'>40 %</option>"
    append selectBox "<option value='0.5'>50 %</option>"
    append selectBox "<option value='0.6'>60 %</option>"
    append selectBox "<option value='0.7'>70 %</option>"
    append selectBox "<option value='0.8'>80 %</option>"
    append selectBox "<option value='0.9'>90 %</option>"
    append selectBox "<option value='1'>100 %</option>"
    append selectBox "<option value='2'>\${optionEnterValue}</option>"

  append selectBox "</select>"
  return $selectBox
}

proc getSatColorTempValue {effect subEffect} {
  set inputElm "<div id=\"color_$effect\_$subEffect\" style=\"width: auto; background-color: rgb(255, 8, 255); border: thin solid black; cursor:pointer;\" class=\"alignCenter\" onclick=\"setSatColorTempValue(this, '$effect', '$subEffect')\">&nbsp;</div>"
  return $inputElm
}

proc getColorMode {effectNo val} {
  set selected0 ""
  set selected1 ""

  if {$val == 0} {
    set selcted0 "selected=true"
  } elseif {$val == 1} {
    set selected1 "selected=true"
  }

  set selectBox "<select style=\"width:100%\" value=\"$val\" onchange=\"setEffectColorMode(this.value, '$effectNo');\">"
    append selectBox "<option value='0' $selected0>\${optionCircle}</option>"
    append selectBox "<option value='1' $selected1>\${optionRandom}</option>"
  append selectBox "</select>"
  return $selectBox
}

proc getRepetitions {effectNo val} {
  set inputElm "<input type=\"text\" value=$val size=\"2\" class=\"alignCenter\" onchange=\"setEffectRepetitions(this, '$effectNo');\">"
  return $inputElm
}

proc getUniversalLightEffects {p descr} {

  global dev_descr

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  set chn 0

  set cssDivHeightA "style=\"height:19px;\""
  set cssDivHeightB "style=\"height:33px;\""

  set html "<tr><td colspan='3'><hr></td></tr>"

  append html "<tr>"
    append html "<td>"
      append html "\${effectPanel}"
    append html "</td>"
    append html "<td><input id=\"btnShowURLEffects\" type=\"button\" name=\"btnShowURLEffects\" onclick=\"jQuery('.j_effectPanel').toggle();scroll2Effect(this);\"></td>"
  append html "</tr>"

  for {set loopz 1} {$loopz <= 10} {incr loopz} {
    set subEffect 0
    set subEffectA 0
    # Header of the effect section
    append html "<tr class=\"j_effectPanel hidden\"><td colspan=\"6\"><div class=\"CLASS10400\"><hr></div></td></tr>"
    append html "<tr class=\"j_effectPanel hidden\"><td></td><td><div><b><span id=\"idEffect_$loopz\" class=\"UILink\" onclick=\"setEffectName(this, $loopz, '$dev_descr(ADDRESS)');\">Effect $loopz</span></b></div></td></tr>"

    append html "<script type=\"text/javascript\">"
      append html "var effectHeaderElm = jQuery(\"#idEffect_$loopz\");"
      append html "var effectName = getEffectName($loopz, '$dev_descr(ADDRESS)');"
      append html "effectHeaderElm.text(effectName);"
    append html "</script>"

    for {set loopx 1} {$loopx <= 2} {incr loopx} {
      if {$loopx == 1} {set padding "style='padding-right:0px;'"} else {set padding "style='padding-right:10px;'"}
      append html "<tr id=\"scrollEffectAnchor\" class=\"j_effectPanel hidden\">"
        append html "<td colspan=\"5\"><table>"

          append html "<tr>"
            for {set loopy 1} {$loopy <= 4} {incr loopy} {

              set effectNoA $loopz
              if {$effectNoA < 10} {set effectNoA "0$effectNoA"}

              incr subEffectA
              set subEffectNo 0$subEffectA

              append html "<td>"
                append html "<table>"

                  if {$loopx == 1} {
                    append html "<tr>"
                        if {$loopy == 1} {
                          append html "<td>"
                            append html "\${ColorMode}"
                          append html "</td>"
                        }
                        append html "<td>"
                          if {$loopy == 1} {
                            append html "<div>[getColorMode $effectNoA $ps($effectNoA\_EFFECT_COLOR_MODE)]</div>"
                          } else {
                            append html "<div $cssDivHeightA></div>"
                          }
                        append html "</td>"
                    append html "</tr>"
                    append html "<tr>"
                      append html "<td>"
                        if {$loopy == 1} {
                          append html "<div id=\"lblRepetitions_$effectNoA\" style=\"width:150px;\">\${Repetitions}</div>"
                        } else {
                          append html "<div $cssDivHeightB></div>"
                        }
                      append html "</td>"
                      if {$loopy == 1} {
                        append html "<td>"
                          append html "<div>[getRepetitions $effectNoA $ps($effectNoA\_EFFECT_REPETITIONS)]&nbsp;(0 - 63)</div>"
                        append html "</td>"
                      }
                    append html "</tr>"
                  } else {
                  # Placeholder
                    append html "<tr >"
                        append html "<td>"
                          if {$loopy == 1} {
                            append html "<div style=\"width:150px;\"></div>"
                          }
                        append html "</td>"
                    append html "</tr>"
                  }
                  append html "<tr>"
                    if {$loopy == 1} {
                      append html "<td $padding>\${ColorFadeInTime}</td>"
                    }
                    append html "<td>"
                      append html "<div>[getSelectTime colorFadeInTime $effectNoA $subEffectNo]</div>"
                    append html "</td>"
                  append html "</tr>"
                  append html "<tr>"
                    if {$loopy == 1} {
                      append html "<td>\${ColorHoldTime}</td>"
                    }
                    append html "<td>"
                      append html "<div>[getSelectTime colorHoldTime $effectNoA $subEffectNo]</div>"
                    append html "</td>"
                  append html "</tr>"
                  append html "<tr>"
                    if {$loopy == 1} {
                      append html "<td>\${HueSatTempType}</td>"
                    }
                    append html "<td>"
                      append html "<div>[getSatColorTempType $effectNoA $subEffectNo]</div>"
                    append html "</td>"
                  append html "</tr>"
                  append html "<tr>"
                    if {$loopy == 1} {
                      append html "<td>\${HueSatTempVal}</td>"
                    }
                    append html "<td>"
                      append html "<div>[getSatColorTempValue $effectNoA $subEffectNo]</div>"
                    append html "</td>"
                  append html "</tr>"

                  append html "<tr>"
                    if {$loopy == 1} {
                      append html "<td>\${ColorLevel}</td>"
                    }
                    append html "<td>"
                      append html "<div>[getLevel $effectNoA $subEffectNo]</div>"
                    append html "</td>"
                  append html "</tr>"
                append html "</table>"
              append html "</td>"
            }
          append html "</tr>"
        append html "</table></td>"
      append html "</tr>"

      # Invisible fields which are containing the actual values.
      append html "<tr class=\"hidden\">"
        append html "<td colspan=\"5\"><table><tr>"
          for {set loopy 1} {$loopy <= 4} {incr loopy} {
            set effectNo $loopz
            if {$effectNo < 10} {set effectNo "0$effectNo"}

            incr subEffect
            set subEffectNo 0$subEffect

            append html "<td>"
              append html "<table>"

                if {$loopx == 1} {
                  append html "<tr>"
                    append html "<td>"
                      if {$loopy == 1} {
                        append html "$loopz - ColorMode"
                      } else {
                        append html "<div $cssDivHeightA></div>"
                      }
                    append html "</td>"
                    append html "<td>"
                      if {$loopy == 1} {
                        incr prn
                        set param $effectNo\_EFFECT_COLOR_MODE
                        append html "<input id=\"separate_CHANNEL_0_$prn\" value=\"$ps($param)\" name=\"$param\" type=\"text\" size=\"8\">"
                      } else {
                        append html "<div $cssDivHeightA></div>"
                      }
                    append html "</td>"
                  append html "</tr>"
                  append html "<tr>"
                    append html "<td>"
                      if {$loopy == 1} {
                        append html "Repetitions"
                      } else {
                        append html "<div $cssDivHeightB></div>"
                      }
                    append html "</td>"
                    append html "<td>"
                      if {$loopy == 1} {
                        incr prn
                        set param $effectNo\_EFFECT_REPETITIONS
                        append html "<input id=\"separate_CHANNEL_0_$prn\" value=\"$ps($param)\" name=\"$param\" type=\"text\" size=\"8\">"
                      }  else {
                        append html "<div $cssDivHeightB></div>"
                      }
                    append html "</td>"
                  append html "</tr>"
                }

                append html "<tr>"
                  if {$loopy == 1} {
                    append html "<td>ColorFadeInTimeBase</td>"
                  }
                  append html "<td>"
                    incr prn
                    set param $effectNo\_EFFECT_$subEffectNo\_COLOR_FADE_IN_TIME_BASE
                    append html "<input id=\"separate_CHANNEL_0_$prn\" value=\"$ps($param)\" name=\"$param\" type=\"text\" size=\"8\">"
                  append html "</td>"
                append html "</tr>"

                append html "<tr>"
                  if {$loopy == 1} {
                    append html "<td>ColorFadeInTimeFactor</td>"
                  }
                  append html "<td>"
                    incr prn
                    set param $effectNo\_EFFECT_$subEffectNo\_COLOR_FADE_IN_TIME_FACTOR
                    append html "<input id=\"separate_CHANNEL_0_$prn\" value=\"$ps($param)\" name=\"$param\" type=\"text\" size=\"8\">"
                  append html "</td>"
                append html "</tr>"

                append html "<tr>"
                  if {$loopy == 1} {
                    append html "<td>ColorHoldTimeBase</td>"
                  }
                  append html "<td>"
                    incr prn
                    set param $effectNo\_EFFECT_$subEffectNo\_COLOR_HOLD_TIME_BASE
                    append html "<input id=\"separate_CHANNEL_0_$prn\" value=\"$ps($param)\" name=\"$param\" type=\"text\" size=\"8\">"
                  append html "</td>"
                append html "</tr>"

                append html "<tr>"
                  if {$loopy == 1} {
                    append html "<td>ColorHoldTimeFactor</td>"
                  }
                  append html "<td>"
                    incr prn
                    set param $effectNo\_EFFECT_$subEffectNo\_COLOR_HOLD_TIME_FACTOR
                    append html "<input id=\"separate_CHANNEL_0_$prn\" value=\"$ps($param)\" name=\"$param\" type=\"text\" size=\"8\">"
                  append html "</td>"
                append html "</tr>"

                append html "<tr>"
                  if {$loopy == 1} {
                    append html "<td>HueSatTempType</td>"
                  }
                  append html "<td>"
                    incr prn
                    set param $effectNo\_EFFECT_$subEffectNo\_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_TYPE
                    append html "<input id=\"separate_CHANNEL_0_$prn\" value=\"$ps($param)\" name=\"$param\" type=\"text\" size=\"8\">"
                  append html "</td>"
                append html "</tr>"

                append html "<tr>"
                  if {$loopy == 1} {
                    append html "<td>HueSatTempValue</td>"
                  }
                  append html "<td>"
                    incr prn
                    set param $effectNo\_EFFECT_$subEffectNo\_COLOR_HUE_SATURATION_COLOR_TEMPERATURE_VALUE
                    append html "<input id=\"separate_CHANNEL_0_$prn\" value=\"$ps($param)\" name=\"$param\" type=\"text\" size=\"8\">"
                  append html "</td>"
                append html "</tr>"

                append html "<tr>"
                  if {$loopy == 1} {
                    append html "<td>ColorLevel</td>"
                  }
                  append html "<td>"
                    incr prn
                    set param $effectNo\_EFFECT_$subEffectNo\_COLOR_LEVEL
                    append html "<input id=\"separate_CHANNEL_0_$prn\" value=\"$ps($param)\" name=\"$param\" type=\"text\" size=\"8\">"
                  append html "</td>"
                append html "</tr>"
              append html "</table>"
            append html "</td>"
          }
        append html "</tr></table></td>"
      append html "</tr>"
    }
  }

  append html "<script type=\"text/javascript\">"

    append html "scroll2Effect = function(elm) \{"
      append html "if (jQuery(\"#scrollEffectAnchor\").is(\":visible\")) \{"
        append html "jQuery(\"#btnShowURLEffects\").get(0).scrollIntoView(\{behavior:'smooth', block:'start'\});"
      append html "\} else \{"
        append html "var endOfView = jQuery(elm).parent().parent().parent().children(\"tr\").filter(\":visible\").first();"
        append html "jQuery(endOfView).get(0).scrollIntoView(\{behavior:'smooth', block:'start'\});"
      append html "\}"
    append html "\};"

    append html "arNewEffectName = \[\];"
    append html "initFadeInTime();"
    append html "initEffectLevel();"
    append html "initSatColorTempType();"
    append html "initSatColorTemp();"
    append html "initColorTemp();"

    append html "translateButtons('btnShowURLEffects');"

    # Extend the footer buttons
    append html " window.setTimeout(function() { "
     append html " var elm = jQuery('#footerButtonOK, #footerButtonTake'); "
     append html " elm.click(function() {storeEffectName('$dev_descr(ADDRESS)');}); "
    append html " },10); "

  append html "</script>"

  return $html
}