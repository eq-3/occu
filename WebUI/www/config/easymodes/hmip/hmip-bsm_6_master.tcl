#!/bin/tclsh

#Kanal-EasyMode!

source [file join /www/config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options_hmip.tcl]

set PROFILES_MAP(0)  "Experte"
set PROFILES_MAP(1)  "TheOneAndOnlyEasyMode"

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global env iface_url psDescr
  
  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    psDescr
  upvar PROFILE_1     PROFILE_1

  set chn [getChannel $special_input_id]
  set specialID "[getSpecialID $special_input_id]"

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"


    set prn 1
    set param CURRENTDETECTION_BEHAVIOR
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTableCurrentDetectionBehavior}</td>"
      array_clear option
      set option(0) "\${stringTableCurrentDetectionBehaviorActive}"
      set option(1) "\${stringTableCurrentDetectionBehaviorOutput1}"
      set option(2) "\${stringTableCurrentDetectionBehaviorOutput2}"
      append HTML_PARAMS(separate_1)  "<td>[getOptionBox '$param' option $ps($param) $chn $prn]</td>"
    append HTML_PARAMS(separate_1) "</tr>"


    incr prn
    set param "LOGIC_COMBINATION"
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTableLogicCombination}</td>"
      option LOGIC_COMBINATION
      append HTML_PARAMS(separate_1)  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
    append HTML_PARAMS(separate_1) "</tr>"


    append HTML_PARAMS(separate_1) "[getHorizontalLine]"

    incr prn
    set param POWERUP_JUMPTARGET
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTableDimmerPowerUpAction}</td>"
      option POWERUP_JUMPTARGET
      append HTML_PARAMS(separate_1)  "<td>[getOptionBox '$param' options $ps($param) $chn $prn]</td>"
    append HTML_PARAMS(separate_1) "</tr>"


    incr prn
    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1) "<td>\${stringTableOnDelay}</td>"
    append HTML_PARAMS(separate_1) [getComboBox $chn $prn "$specialID" "delayShort"]
    append HTML_PARAMS(separate_1) "</tr>"

    set param POWERUP_ONDELAY_UNIT
    append HTML_PARAMS(separate_1) [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]


    incr prn
    set param POWERUP_ONDELAY_VALUE
    append HTML_PARAMS(separate_1) "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append HTML_PARAMS(separate_1) "<td>\${stringTableOnDelayValue}</td>"

    append HTML_PARAMS(separate_1) "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"


    incr prn
    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1) "<td>\${stringTableOnTime}</td>"
    append HTML_PARAMS(separate_1) [getComboBox $chn $prn "$specialID" "timeOnOff"]
    append HTML_PARAMS(separate_1) "</tr>"

    set param POWERUP_ONTIME_UNIT
    append HTML_PARAMS(separate_1) [getTimeUnitComboBox $param $ps($param) $chn $prn $special_input_id]

    incr prn
    set param POWERUP_ONTIME_VALUE
    append HTML_PARAMS(separate_1) "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append HTML_PARAMS(separate_1) "<td>\${stringTableOnTimeValue}</td>"

    append HTML_PARAMS(separate_1) "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"



  append HTML_PARAMS(separate_1) "</table>"
}

constructor


