proc getUniversalLightReceiver {chn p descr} {

  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  puts "<script type=\"text/javascript\">getLangInfo_Special('VIRTUAL_HELP.txt');</script>"
  set specialID "[getSpecialID $special_input_id]"
  puts "<script type=\"text/javascript\">getLangInfo_Special('VIRTUAL_HELP.txt');</script>"


  # devMode 1 = PWM, 2 = TuneableWhite, 3 = RGB, 4 = RGBW
  set devMode $ps(UNIVERSAL_LIGHT_MAX_CAPABILITIES)

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
        #append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
        option RAW_0_100Percent
        append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]&nbsp;[getHelpIcon $param\_RGBW 450 75]</td>"
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