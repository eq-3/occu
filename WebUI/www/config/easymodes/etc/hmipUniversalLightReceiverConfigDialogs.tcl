proc getNoParametersToSet {} {
  set html "<tr><td name=\"noParamElm\" class=\"CLASS22003\"><div class=\"CLASS22004\">\${deviceAndChannelParamsLblNoParamsToSet}</div></td></tr>"
  # center content
  append html "<script type=\"text/javascript\">window.setTimeout(function(){jQuery(\"\[name='noParamElm'\]\").parent().parent().parent().width(\"100%\");},100);</script>"
  return $html
}

proc getUniversalLightReceiver {chn p descr} {

  global dev_descr

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  puts "<script type=\"text/javascript\">getLangInfo_Special('VIRTUAL_HELP.txt');</script>"
  set specialID "[getSpecialID $special_input_id]"
  puts "<script type=\"text/javascript\">getLangInfo_Special('VIRTUAL_HELP.txt');</script>"


  # devMode 1 = PWM, 2 = TuneableWhite, 3 = RGB, 4 = RGBW
  set devMode $ps(UNIVERSAL_LIGHT_MAX_CAPABILITIES)

  if {[string first "HmIP-LSC" $dev_descr(TYPE)] != -1} {
    set devMode 5
  }


  set prn 0

  if {[session_is_expert]} {
    set param "LOGIC_COMBINATION"
    if { [info exists ps($param)] == 1  } {
      incr prn
      append html "<tr>"
        append html "<td>\${stringTableLogicCombination}</td>"
        option LOGIC_COMBINATION
        append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
        append html "<td>&nbsp<input class=\"j_helpBtn\" id=\"virtual_help_button_$chn\" type=\"button\" value=\${help} onclick=\"VirtualChannel_help($chn);\"></td>"
      append html "</tr>"

      #### HELP
      append html "<tr><td colspan=\"2\">"
        append html "<table class=\"ProfileTbl\" id=\"virtual_ch_help_$chn\" style=\"display:none\">"
        append html "<tr><td>\${virtualHelpTxtDimmer}</td></tr>"
        append html "</table>"
      append html "</td></tr>"

      puts "<script type=\"text/javascript\">"
        puts "jQuery(\".j_helpBtn\").val(translateKey(\"helpBtnTxt\"));"
      puts "</script>"

      append html "[getHorizontalLine]"
    }
  }

  set param POWERUP_JUMPTARGET
  if { [info exists ps($param)] == 1  } {
    append html [getPowerUpSelectorUniversalLightReceiver $chn ps $special_input_id $devMode]
    append html "[getHorizontalLine]"
  }

  set param EVENT_DELAY_UNIT
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
    append html "<td>\${stringTableEventDelay}</td>"
    append html [getComboBox $chn $prn "$specialID" "eventDelay"]
    append html "</tr>"

    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param EVENT_DELAY_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${stringTableEventDelayValue}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOptionPanelA($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }

  set param EVENT_RANDOMTIME_UNIT
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
    append html "<td>\${stringTableRandomTime}</td>"
    append html [getComboBox $chn $prn "$specialID" "eventRandomTime"]
    append html "</tr>"

    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param EVENT_RANDOMTIME_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${stringTableRamdomTimeValue}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOptionPanelA($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }

    set param ON_MIN_LEVEL
    if { [info exists ps($param)] == 1  } {
      incr prn
      append html "<tr>"
        append html "<td>\${lblDimmerOnMinLevel}</td>"
        append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;%&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon $param\_RGBW 450 75]</td>"
        # option RAW_0_100Percent
        # append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]&nbsp;[getHelpIcon $param\_RGBW 450 75]</td>"
      append html "</tr>"
    }

set comment {
  set param FUSE_DELAY
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableDimmerFuseDelay}</td>"
    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon $param]</td>"
    append html "</tr>"
  }
}
set comment {
  set param OVERTEMP_LEVEL
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr name=\"expertParam\" class=\"hidden\">"
      append html "<td>\${stringTableDimmerOverTempLevel}</td>"
      append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon $param]</td>"
    append html "</tr>"
  }
}

  if {$devMode == 2} {
    append html "[getHorizontalLine]"
    set param HARDWARE_COLOR_TEMPERATURE_WARM_WHITE
    if { [info exists ps($param)] == 1 } {
      incr prn
      append html "<tr>"
        append html "<td>\${lblHardwareColorTemperatureWarmWhite}</td>"
        append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param 475 75]</td>"
      append html "</tr>"
    }

    set param HARDWARE_COLOR_TEMPERATURE_COLD_WHITE
    if { [info exists ps($param)] == 1 } {
      incr prn
      append html "<tr>"
        append html "<td>\${lblHardwareColorTemperatureColdWhite}</td>"
        append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon $param 475 75]</td>"
      append html "</tr>"
    }
  }
set comment { # not visible for the user (K.Beck)
    set param LIMITATION_FACTOR_R
    if { [info exists ps($param)] == 1 } {
      incr prn
      append html "<tr name=\"expertParam\" class=\"hidden\">"
        append html "<td>\${lblLimitationFactorR}</td>"
        append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param]</td>"
      append html "</tr>"
    }

    set param LIMITATION_FACTOR_G
    if { [info exists ps($param)] == 1 } {
      incr prn
      append html "<tr name=\"expertParam\" class=\"hidden\">"
        append html "<td>\${lblLimitationFactorG}</td>"
        append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param]</td>"
      append html "</tr>"
    }

    set param LIMITATION_FACTOR_B
    if { [info exists ps($param)] == 1 } {
      incr prn
      append html "<tr name=\"expertParam\" class=\"hidden\">"
        append html "<td>\${lblLimitationFactorB}</td>"
        append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param]</td>"
      append html "</tr>"
    }
}

set comment { # not visible for the user (K.Beck)
  if {$devMode == 2} {
      set param WHITE_VALUE_R
      if { [info exists ps($param)] == 1 } {
        incr prn
        append html "<tr name=\"expertParam\" class=\"hidden\">"
          append html "<td>\${lblWhiteValueR}</td>"
          append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param]</td>"
        append html "</tr>"
      }

      set param WHITE_VALUE_G
      if { [info exists ps($param)] == 1 } {
        incr prn
        append html "<tr name=\"expertParam\" class=\"hidden\">"
          append html "<td>\${lblWhiteValueG}</td>"
          append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param]</td>"
        append html "</tr>"
      }

      set param WHITE_VALUE_B
      if { [info exists ps($param)] == 1 } {
        incr prn
        append html "<tr name=\"expertParam\" class=\"hidden\">"
          append html "<td>\${lblWhiteValueB}</td>"
          append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param]</td>"
        append html "</tr>"
      }
  }
}
  return $html
}


proc getUniversalLightReceiverDali {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  puts "<script type=\"text/javascript\">getLangInfo_Special('VIRTUAL_HELP.txt');</script>"
  set specialID "[getSpecialID $special_input_id]"
  puts "<script type=\"text/javascript\">getLangInfo_Special('VIRTUAL_HELP.txt');</script>"

  set param DALI_ADDRESS
  # A channel with the DALI_ADDRESS 255 has nothing connected.
  if {(([info exists ps($param)] == 1) && ($ps($param) == 255)) || (([info exists ps(UNIVERSAL_LIGHT_MAX_CAPABILITIES)] == 1) && ($ps(UNIVERSAL_LIGHT_MAX_CAPABILITIES) == 5)) } {
    append html "[getNoParametersToSet]"
  } else {
    # devMode 0 - Switch, 1 = Dimmer 1Ch, 2 = TuneableWhite, 3 = RGB, 4 = RGBW
    set devMode $ps(UNIVERSAL_LIGHT_MAX_CAPABILITIES)
    set dali 1

    # append html "<tr><td><span class='attention'>UNIVERSAL_LIGHT_MAX_CAPABILITIES: $devMode</td></tr>"; # this is for development only

    set prn 0

    set param POWERUP_JUMPTARGET
    if { [info exists ps($param)] == 1  } {
      append html [getPowerUpSelectorUniversalLightReceiver $chn ps $special_input_id $devMode $dali]
      append html "[getHorizontalLine]"
    }

    set param EVENT_DELAY_UNIT
    if { [info exists ps($param)] == 1  } {
      incr prn
      append html "<tr>"
      append html "<td>\${stringTableEventDelay}</td>"
      append html [getComboBox $chn $prn "$specialID" "eventDelay"]
      append html "</tr>"

      append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

      incr prn
      set param EVENT_DELAY_VALUE
      append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
      append html "<td>\${stringTableEventDelayValue}</td>"

      append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

      append html "</tr>"
      append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
      append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOptionPanelA($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
    }

    set param EVENT_RANDOMTIME_UNIT
    if { [info exists ps($param)] == 1  } {
      incr prn
      append html "<tr>"
      append html "<td>\${stringTableRandomTime}</td>"
      append html [getComboBox $chn $prn "$specialID" "eventRandomTime"]
      append html "</tr>"

      append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

      incr prn
      set param EVENT_RANDOMTIME_VALUE
      append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
      append html "<td>\${stringTableRamdomTimeValue}</td>"

      append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

      append html "</tr>"
      append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
      append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOptionPanelA($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
    }

    if {$devMode != 0} {
        set param ON_MIN_LEVEL
        if { [info exists ps($param)] == 1  } {
          incr prn
          append html "<tr>"
            append html "<td>\${lblDimmerOnMinLevel}</td>"
            #append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
            option RAW_0_100Percent
            append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]&nbsp;[getHelpIcon $param\_RGBW 450 75]</td>"
          append html "</tr>"
        }
    }

    if {($devMode == 2) || ($devMode == 3)} {
      append html "[getHorizontalLine]"
      set param HARDWARE_COLOR_TEMPERATURE_WARM_WHITE
      if { [info exists ps($param)] == 1 } {
        incr prn
        append html "<tr>"
          append html "<td>\${lblHardwareColorTemperatureWarmWhite}</td>"
          append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param 475 75]</td>"
        append html "</tr>"
      }

      set param HARDWARE_COLOR_TEMPERATURE_COLD_WHITE
      if { [info exists ps($param)] == 1 } {
        incr prn
        append html "<tr>"
          append html "<td>\${lblHardwareColorTemperatureColdWhite}</td>"
          append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon $param 475 75]</td>"
        append html "</tr>"
      }
    }

    set hl 0 ;# horizhontal line already set?
    set param DALI_DT8_CONFIG_NUMBER_PRIMARY_COLORS
    if {[info exists ps($param)] == 1} {
      if {$ps(DALI_DT8_NUMBER_PRIMARY_COLORS) == 4}  {
        append html "[getHorizontalLine]"
        set hl 1
        incr prn
        append html "<tr>"
          array_clear options
          set options(3) "3 - \${optionRGB}"
          set options(4) "4 - \${optionRGBW}"
          append html "<td>\${lblNumberOfChannels}</td>"
          append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]&nbsp;[getHelpIcon $param\_RGBW 450 75]</td>"
          # this is for development only
          # append html "<td><span class='attention'>$param: $ps($param)</td>"
        append html "</tr>"
      } else {
        # this is for development only
        append html "[getHorizontalLine]"
        set hl 1
        # this is for development only
        # append html "<tr><td><span class='attention'>$param: $ps($param)</td></tr>"
     }
    }

    set param DALI_DT8_CONFIG_NUMBER_RGBWAF_COLORS
    if {[info exists ps($param)] == 1} {
      if {$ps(DALI_DT8_NUMBER_RGBWAF_COLORS) == 4}  {
        if {$hl == 0} {append html "[getHorizontalLine]"}
        incr prn
        append html "<tr>"
          array_clear options
          set options(3) "3 - \${optionRGB}"
          set options(4) "4 - \${optionRGBW}"
          append html "<td>\${lblNumberOfChannels}</td>"
          append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]&nbsp;[getHelpIcon $param\_RGBW 450 75]</td>"
          # this is for development only
          # append html "<td><span class='attention'>$param: $ps($param)</td>"
        append html "</tr>"
      } else {
        # this is for development only
        if {$hl == 0} {append html "[getHorizontalLine]"}
        # this is for development only
        # append html "<tr><td><span class='attention'>$param: $ps($param)</td></tr>"
      }
    }

      set param DALI_GROUP
      if { [info exists ps($param)] == 1 } {
        incr prn
        append html "<tr>"
            append html "<td>\${lblGroup}</td>"
            append html "<td>"
              append html "<table>"
                append html "<tr>"
                  for {set i 0} {$i <= 15} {incr i} {
                    append html "<td>"
                      append html "<label for='groupID_$chn\_$i' style='background-color:white; display:block; text-align:center;'>[expr {$i + 1}]</label>"
                      append html "<input id='groupID_$chn\_$i' type='checkbox' value='[expr {int(pow(2,$i))}]' name='$param\_$chn' onchange='setSelectedGroups(this.name, $chn, $prn);'/>"
                    append html "</td>"
                  }
                  append html "<td>[getHelpIcon $param 475 125]</td>"
                  append html "<td class='hidden'>[getTextField $param $ps($param) $chn $prn]</td>"
                append html "</tr>"
              append html "</table>"
            append html "</td>"
        append html "</tr>"

        # javascript to set the groups
        append html "<script type='text/javascript'>"
          append html "var valChnGroupSelector = parseInt(jQuery('\#separate_CHANNEL_$chn\_$prn').val()),"
          append html "arGrpChkBoxes = jQuery(\"\[name='DALI_GROUP_$chn'\]\");"
          append html "for (var loop = 0; loop <=15; loop++) \{"
            append html "if (isBitSet(valChnGroupSelector, loop)) \{"
              append html "jQuery(arGrpChkBoxes\[loop\]).prop('checked', true);"
            append html "\}"
          append html "\};"

          append html "setSelectedGroups = function(grpChkBox, chn, prn) {"
            append html "var arChkBoxes = jQuery(\"\[name=\" + grpChkBox+ \"\]\"),"
            append html "valChnGroupSelector = jQuery('\#separate_CHANNEL_'+chn+'_'+prn),"
            append html "grpVal = 0;"

            append html "jQuery.each(arChkBoxes, function(index, elm) {"
              append html "if (jQuery(elm).prop('checked')) \{"
                append html "grpVal += parseInt(jQuery(elm).val());"
              append html "\}"
            append html "});"

            append html "jQuery(valChnGroupSelector).val(grpVal);"

          append html "}"

        append html "</script>"
      }
      return $html
  }

}

proc getUniversalLightReceiverLSS {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  puts "<script type=\"text/javascript\">getLangInfo_Special('VIRTUAL_HELP.txt');</script>"
  set specialID "[getSpecialID $special_input_id]"
  puts "<script type=\"text/javascript\">getLangInfo_Special('VIRTUAL_HELP.txt');</script>"

  # UNIVERSAL_LIGHT_MAX_CAPABILITIES is always 0 with the HmIP-LSC which is the same as the UNIVERSAL_LIGHT_MAX_CAPABILITIES = 3 of the HmIP-DRG-DALI
  # Therefore we have to set devMode to 3
  # set devMode $ps(UNIVERSAL_LIGHT_MAX_CAPABILITIES)
  set devMode 3
  set dali 1

  # append html "<tr><td><span class='attention'>UNIVERSAL_LIGHT_MAX_CAPABILITIES: $devMode</td></tr>"; # this is for development only

  set prn 0

  set param POWERUP_JUMPTARGET
  if { [info exists ps($param)] == 1  } {
    append html [getPowerUpSelectorUniversalLightReceiver $chn ps $special_input_id $devMode $dali]
    append html "[getHorizontalLine]"
  }

  set param EVENT_DELAY_UNIT
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
    append html "<td>\${stringTableEventDelay}</td>"
    append html [getComboBox $chn $prn "$specialID" "eventDelay"]
    append html "</tr>"

    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param EVENT_DELAY_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${stringTableEventDelayValue}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOptionPanelA($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }

  set param EVENT_RANDOMTIME_UNIT
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
    append html "<td>\${stringTableRandomTime}</td>"
    append html [getComboBox $chn $prn "$specialID" "eventRandomTime"]
    append html "</tr>"

    append html [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param EVENT_RANDOMTIME_VALUE
    append html "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append html "<td>\${stringTableRamdomTimeValue}</td>"

    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append html "</tr>"
    append html "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append html "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOptionPanelA($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  }


  set param ON_MIN_LEVEL
  if { [info exists ps($param)] == 1  } {
    incr prn
    append html "<tr>"
      append html "<td>\${lblDimmerOnMinLevel}</td>"
      #append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
      option RAW_0_100Percent
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]&nbsp;[getHelpIcon $param\_RGBW 450 75]</td>"
    append html "</tr>"
  }

  append html "[getHorizontalLine]"
  set param HARDWARE_COLOR_TEMPERATURE_WARM_WHITE
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr>"
      append html "<td>\${lblHardwareColorTemperatureWarmWhite}</td>"
      append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param 475 75]</td>"
    append html "</tr>"
  }

  set param HARDWARE_COLOR_TEMPERATURE_COLD_WHITE
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr>"
      append html "<td>\${lblHardwareColorTemperatureColdWhite}</td>"
      append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon $param 475 75]</td>"
    append html "</tr>"
  }
  return $html
}