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

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_PMSw.js')</script>"

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

    append HTML_PARAMS(separate_1) "<tr><td colspan='2'><b>\${energyMeterTransmitterHeader}<b/><br/><br/></td></tr>"

    #1
    set prn 1
    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1) "<td>\${stringTableEventDelay}</td>"
    append HTML_PARAMS(separate_1) [getComboBox $chn $prn "$specialID" "delayShort"]
    append HTML_PARAMS(separate_1) "</tr>"

    set param EVENT_DELAY_UNIT
    append HTML_PARAMS(separate_1) [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    #2
    incr prn
    set param EVENT_DELAY_VALUE
    append HTML_PARAMS(separate_1) "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append HTML_PARAMS(separate_1) "<td>\${stringTableEventDelayValue}</td>"

    append HTML_PARAMS(separate_1) "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

    #3
    incr prn
    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1) "<td>\${stringTableRandomTime}</td>"
    append HTML_PARAMS(separate_1) [getComboBox $chn $prn "$specialID" "delayShort"]
    append HTML_PARAMS(separate_1) "</tr>"

    set param EVENT_RANDOMTIME_UNIT
    append HTML_PARAMS(separate_1) [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    #4
    incr prn
    set param EVENT_RANDOMTIME_VALUE
    append HTML_PARAMS(separate_1) "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append HTML_PARAMS(separate_1) "<td>\${stringTableRamdomTimeValue}</td>"

    append HTML_PARAMS(separate_1) "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

    #5
    incr prn
    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1) "<td>\${stringTableTxMinDelay}</td>"
    append HTML_PARAMS(separate_1) [getComboBox $chn $prn "$specialID" "delayShort"]
    append HTML_PARAMS(separate_1) "</tr>"

    set param TX_MINDELAY_UNIT
    append HTML_PARAMS(separate_1) [getTimeUnitComboBoxShort $param $ps($param) $chn $prn $special_input_id]

    #6
    incr prn
    set param TX_MINDELAY_VALUE
    append HTML_PARAMS(separate_1) "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
    append HTML_PARAMS(separate_1) "<td>\${stringTableRamdomTimeValue}</td>"

    append HTML_PARAMS(separate_1) "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"

    append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

    append HTML_PARAMS(separate_1) [getHorizontalLine]

    #7
    incr prn
    set param AVERAGING
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTablePowerMeterAveraging}</td>"
      append HTML_PARAMS(separate_1) "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"


    append HTML_PARAMS(separate_1) "<tr><td colspan='2'><br/><br/>\${PMSwChannel2HintHeader}</td></tr>"
    #8
    incr prn
    set param TX_THRESHOLD_POWER
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1)  "<td>\${PMSwChannel2Hint_Power}</td>"
      array_clear option
      set option(0) "\${stringTableNotUsed}"
      set option(1) "\${optionEnterValue}"

      append prnTmp $prn _tmp

      append HTML_PARAMS(separate_1)  "<td>[getOptionBox '$param' option $ps($param) $chn $prnTmp "onchange=\"test(this, '$prn');\""]</td>"
      append HTML_PARAMS(separate_1) "<td><span id=\"field_$prn\">[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</span></td>"
    append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
      append HTML_PARAMS(separate_1) "if ($ps($param) > 0) {document.getElementById('separate_CHANNEL_7_$prnTmp').options\[1\].selected = true;document.getElementById('field_$prn').style.visibility='visible';} else {document.getElementById('separate_CHANNEL_7_$prnTmp').options\[0\].selected = true;document.getElementById('field_$prn').style.visibility='hidden';}"
    append HTML_PARAMS(separate_1) "</script>"

    #9
    incr prn
    set param TX_THRESHOLD_ENERGY
    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1)  "<td>\${PMSwChannel2Hint_Energy}</td>"
      array_clear option
      set option(0) "\${stringTableNotUsed}"
      set option(1) "\${optionEnterValue}"
      append prnTmp $prn _tmp
      append HTML_PARAMS(separate_1)  "<td>[getOptionBox '$param' option $ps($param) $chn $prnTmp "onchange=\"test(this, '$prn');\""]</td>"
      append HTML_PARAMS(separate_1) "<td><span id=\"field_$prn\">[getTextField $param $ps($param) $chn $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</span></td>"
    append HTML_PARAMS(separate_1) "</tr>"
      append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
        append HTML_PARAMS(separate_1) "if ($ps($param) > 0) {document.getElementById('separate_CHANNEL_7_$prnTmp').options\[1\].selected = true;document.getElementById('field_$prn').style.visibility='visible';} else {document.getElementById('separate_CHANNEL_7_$prnTmp').options\[0\].selected = true;document.getElementById('field_$prn').style.visibility='hidden';}"
      append HTML_PARAMS(separate_1) "</script>"

    append HTML_PARAMS(separate_1) "<tr><td>\${PMSwChannel2Hint_Footer}<br/><br/></td></tr>"



    append HTML_PARAMS(separate_1) "</table>"

    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "test = function(elm, prn) \{"
      append HTML_PARAMS(separate_1) "document.getElementById('field_' + prn).style.visibility=(elm.selectedIndex < 1)?'hidden':'visible';document.getElementById('separate_CHANNEL_7_' +prn).value=parseFloat(elm.options\[elm.selectedIndex\].value);"
    append HTML_PARAMS(separate_1) "\};"

    append HTML_PARAMS(separate_1) "</script>"

}

constructor
