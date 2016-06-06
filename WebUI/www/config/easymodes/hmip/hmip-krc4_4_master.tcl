#!/bin/tclsh

#Kanal-EasyMode!

source [file join /www/config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]

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
    set param DBL_PRESS_TIME
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTableKeyDblPressTime}</td>"
      append HTML_PARAMS(separate_1) "<td>[get_InputElem DBL_PRESS_TIME separate_${special_input_id}_$prn ps DBL_PRESS_TIME ]</td>"
    append HTML_PARAMS(separate_1) "</tr>"

    # 2
    incr prn
    set param LONG_PRESS_TIME
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTableKeyLongPressTimeA}</td>"
      append HTML_PARAMS(separate_1) "<td>[get_InputElem LONG_PRESS_TIME separate_${special_input_id}_$prn ps LONG_PRESS_TIME ]</td>"
    append HTML_PARAMS(separate_1) "</tr>"

    #3
    incr prn
    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1) "<td>\${stringTableKeyLongPressTimeOut}</td>"
    append HTML_PARAMS(separate_1) [getComboBox $chn $prn "$specialID" "delayShort"]
    append HTML_PARAMS(separate_1) "</tr>"

    set param REPEATED_LONG_PRESS_TIMEOUT_UNIT
    append HTML_PARAMS(separate_1) [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    # 4
    incr prn
    set param REPEATED_LONG_PRESS_TIMEOUT_VALUE
    append HTML_PARAMS(separate_1) "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append HTML_PARAMS(separate_1) "<td>\${stringTableKeyLongPressTimeOutValue}</td>"

    append HTML_PARAMS(separate_1) "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

  append HTML_PARAMS(separate_1) "</table>"
}

constructor

