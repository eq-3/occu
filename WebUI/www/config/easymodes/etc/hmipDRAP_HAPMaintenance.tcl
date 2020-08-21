#!/bin/tclsh

proc getDRAP_HAPMaintenance {chn p descr} {
  global dev_descr
  upvar $p ps
  upvar $descr psDescr
  upvar prn prn
  upvar special_input_id special_input_id

  set CHANNEL $special_input_id

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HmIP-ParamHelp.js');</script>"

  set specialID "[getSpecialID $special_input_id]"

  set html ""

  set hlpBoxWidth 450
  set hlpBoxHeight 80

  # append html "[getHorizontalLine]"

   #append html "<tr><td colspan=\"3\"><div class=\"CLASS06336\">$dev_descr(TYPE) PARAMETERS</div></td></tr>"

set comment {
  # Please note: tcl has a problem with http:// in url string
  set param UPDATE_SERVER_URL
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr>"
     append html "<td>tr UPDATE_SERVER_URL</td>"
     append html "<td>"
        append html "<table><tr>"
          # append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
          append html  "<td>[getTextField $param $ps($param) $chn $prn]</td>"
          # append html  "<td>$ps($param) - $chn - $prn</td>"

       append html "</tr></table>"
     append html "<td>"
    append html "</tr>"
  }
}

  set param BACKLIGHT_ON_TIME
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableDisplayLightingDuration}</td>"
    append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  set param SIGNAL_BRIGHTNESS
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr>"
      append html "<td>\${stringTableBrightnessVisKey}</td>"
      option RAW_0_100Percent_1
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
    append html "</tr>"
  }

set comment {
  # For the user not visible
  set param _SUPPORTING_WIRED_OPERATION_MODE
  if { [info exists ps($param)] == 1 } {
    incr prn;
    append html "<tr>"
     append html "<td>tr SUPPORTING_WIRED_OPERATION_MODE</td>"
     append html "<td>"
        append html "<table><tr>"
          append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]&nbsp;[getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
       append html "</tr></table>"
     append html "<td>"
    append html "</tr>"
  }
}
  set param SUPPLY_CURRENT
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr>"
     append html "<td>\${drapMaxCurrentBus}</td>"
     append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]&nbsp;[getHelpIcon drapHelpMaxCurrentBus $hlpBoxWidth $hlpBoxHeight]</td>"
    append html "</tr>"
  }

  set param BUS_MODE
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr>"
      append html "<td>\${drapBusConfig}</td>"
      array_clear options
      set options(0) "\${optionRingMode}"
      set options(1) "\${optionTwoSeparateBusSystems}"
      append html  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]&nbsp;[getHelpIcon drapHelpBusConfig $hlpBoxWidth $hlpBoxHeight]</td>"
    append html "</tr>"
  }

  set param OVERTEMP_LEVEL
  if { [info exists ps($param)] == 1 } {
    incr prn
    append html "<tr name=\"expertParam\" class=\"hidden\">"
      append html "<td>\${stringTableDimmerOverTempLevel}</td>"
      append html "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append html "</tr>"
  }

  if {[session_is_expert]} {
    append html "<script type=\"text/javascript\">"
      append html "jQuery(\"\[name='expertParam'\]\").show();"
    append html "</script>"
  }

  return $html
}