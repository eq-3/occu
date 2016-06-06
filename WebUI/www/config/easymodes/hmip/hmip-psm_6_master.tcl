#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]

proc getMinValue {param} {
  global psDescr
  array_clear param_descr
  set param [trimParam $param]
  array set param_descr $psDescr($param)
  set min [format {%1.1f} $param_descr(MIN)]
  return "$min"
}

proc getMaxValue {param} {
  global psDescr
  array_clear param_descr
  set param [trimParam $param]
  array set param_descr $psDescr($param)
  set max [format {%1.1f} $param_descr(MAX)]
  return "$max"
}

proc getUnit {psDescr param} {
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set unit $param_descr(UNIT)

  if {$unit == "minutes"} {
   set unit "\${lblMinutes}"
  }

  if {$unit == "K"} {
    set unit "&#176;C"
  }

  return "$unit"
}

proc getMinMaxValueDescr {psDescr param} {
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set min $param_descr(MIN)
  set max $param_descr(MAX)

  # Limit float to 2 decimal places
  if {[llength [split $min "."]] == 2} {
    set min [format {%1.2f} $min]
    set max [format {%1.2f} $max]
  }
  return "($min - $max)"
}

proc getDescription {param} {
  set result $param

  set desc(EVENT_DELAY_UNIT) "stringTableEventDelayUnit"
  set desc(EVENT_RANDOMTIME_UNIT) "stringTableEventRandomTimeUnit"
  set desc(TX_MINDELAY_UNIT) "stringTableTxMinDelayUnit"
  if {[catch {set result $desc($param)}]} {
   return $result
  }
  return $result
}

proc trimParam {param} {
  set s [string trimleft $param ']
  set s [string trimright $s ']
  return $s
}

proc getHorizontalLine {} {
  return "<tr><td colspan=\"2\"><hr></td></tr>"
}

proc getTimeUnitComboBox {param value chn prn special_input_id} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'
  #set s "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\">"

  set s "<tr id=\"timeBase_$chn\_$prn\" class=\"hidden\">"
    append s "<td>\${[getDescription $param]}</td>"
    append s "<td>"
      append s "<select id=$elemId name=$param>"
        append s "<option value='0'>\${optionUnit100MS}</option>"
        append s "<option value='1'>\${optionUnit1S}</option>"
        append s "<option value='2'>\${optionUnit5S}</option>"
        append s "<option value='3'>\${optionUnit10S}</option>"
        append s "<option value='4'>\${optionUnit1M}</option>"
        append s "<option value='5'>\${optionUnit5M}</option>"
        append s "<option value='6'>\${optionUnit10M}</option>"
        append s "<option value='7'>\${optionUnitH}</option>"
      append s "</select>"
    append s "</td>"
  append s "</tr>"
  append s "<script type=\"text/javascript\">"
    append s "jQuery($j_elemId).val('$value');"
  append s "</script>"
  return $s
}

proc getTextField {param value inputId} {
  set elemId '$inputId'
  # Limit float to 2 decimal places
  if {[llength [split $value "."]] == 2} {
    set value [format {%1.2f} $value]
  }
  set s "<input id=$elemId type=\"text\" size=\"5\" value=$value name=$param onblur=\"ProofAndSetValue(this.id, this.id, [getMinValue $param], [getMaxValue $param], 1)\"/>"
  return $s
}

proc _getComboBox {param prn special_input_id} {
    global psDescr
    upvar ps ps

    array_clear options
    set options(0) "\${stringTableNotUsed}"
    set options($ps($param)) "\${optionEnterValue}"


      append s "<td>"
      append s "[get_ComboBox options $param option_${special_input_id}_$prn ps $param "onchange=\"document.getElementById('field_$prn').style.visibility=(this.selectedIndex < 1)?'hidden':'visible';document.getElementById('separate_CHANNEL_6_$prn').value=parseFloat(this.options\[this.selectedIndex\].value);\""]"
      append s "</td>"
      append s "<td><span id=\"field_$prn\">[getTextField '$param' $ps($param) separate_${special_input_id}_$prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]</span></td>"
      append s "<script type=\"text/javascript\">"
        append s "if ($ps($param) > 0) {document.getElementById('option_CHANNEL_6_$prn').options\[1\].selected = true;document.getElementById('field_$prn').style.visibility='visible';} else {document.getElementById('option_CHANNEL_6_$prn').options\[0\].selected = true;document.getElementById('field_$prn').style.visibility='hidden';}"
      append s "</script>"
    return $s
}

catch {unset internalKey}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr

  #upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  #upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    ps_descr

  set specialID "[lindex [split $special_input_id _] 0]"

  set chn [lindex [split $special_input_id _] 1]

	puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_PMSw.js')</script>"


  array set psDescr [xmlrpc $iface_url($iface) getParamsetDescription [list string $address] [list string MASTER]]

    foreach val [array names psDescr] {
     #puts "$val: $psDescr($val)\n"
    }

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_1) "<tr><td colspan='2'><b>\${energyMeterTransmitterHeader}<b/><br/><br/></td></tr>"

    set prn 1
    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1) "<td>\${stringTableEventDelay}</td>"
    append HTML_PARAMS(separate_1) [getComboBox $chn $prn "$specialID" "delayShort"]
    append HTML_PARAMS(separate_1) "</tr>"

    set param EVENT_DELAY_UNIT
    append HTML_PARAMS(separate_1) [getTimeUnitComboBox $param $ps($param) $chn $prn $special_input_id]

    # 2
    incr prn
    set param EVENT_DELAY_VALUE
    append HTML_PARAMS(separate_1) "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
      append HTML_PARAMS(separate_1) "<td>\${stringTableEventDelayValue}</td>"
      append HTML_PARAMS(separate_1) "<td>[getTextField '$param' $ps($param) separate_${special_input_id}_$prn]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

    # 3
    incr prn
    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1) "<td>\${stringTableRandomTime}</td>"
    append HTML_PARAMS(separate_1) [getComboBox $chn $prn "$specialID" "timeOnOffShort"]
    append HTML_PARAMS(separate_1) "</tr>"

    set param EVENT_RANDOMTIME_UNIT
    append HTML_PARAMS(separate_1) [getTimeUnitComboBox $param $ps($param) $chn $prn $special_input_id]

    # 4
    incr prn
    set param EVENT_RANDOMTIME_VALUE
    append HTML_PARAMS(separate_1) "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
      append HTML_PARAMS(separate_1) "<td>\${stringTableRamdomTimeValue}</td>"
      append HTML_PARAMS(separate_1) "<td>[getTextField '$param' $ps($param) separate_${special_input_id}_$prn]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"


    # 5 Mindestverzoegerung
    incr prn
    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1) "<td>\${stringTableTxMinDelay}</td>"
    append HTML_PARAMS(separate_1) [getComboBox $chn $prn "$specialID" "timeOnOffShort"]
    append HTML_PARAMS(separate_1) "</tr>"

    set param TX_MINDELAY_UNIT
    append HTML_PARAMS(separate_1) [getTimeUnitComboBox $param $ps($param) $chn $prn $special_input_id]

    # 6
    incr prn
    set param TX_MINDELAY_VALUE
    append HTML_PARAMS(separate_1) "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
      append HTML_PARAMS(separate_1) "<td>\${stringTableTxMinDelayValue}</td>"
      append HTML_PARAMS(separate_1) "<td>[getTextField '$param' $ps($param) separate_${special_input_id}_$prn]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"

    append HTML_PARAMS(separate_1) [getHorizontalLine]

    #7
    incr prn
    set param AVERAGING
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${PMSwAveraging}</td>"
      append HTML_PARAMS(separate_1) "<td>[getTextField '$param' $ps($param) separate_${special_input_id}_$prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"

    append HTML_PARAMS(separate_1) "<tr><td colspan='2'><br/><br/>\${PMSwChannel2HintHeader}</td></tr>"
    #8
    incr prn
    set param TX_THRESHOLD_POWER
    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1)  "<td>\${PMSwChannel2Hint_Power}</td>"
    append HTML_PARAMS(separate_1) [_getComboBox $param $prn $special_input_id]
    append HTML_PARAMS(separate_1) "</tr>"

    #9
    incr prn
    set param TX_THRESHOLD_ENERGY
    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1)  "<td>\${PMSwChannel2Hint_Energy}</td>"
    append HTML_PARAMS(separate_1) [_getComboBox $param $prn $special_input_id]
    append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "<tr><td>\${PMSwChannel2Hint_Footer}<br/><br/></td></tr>"

  append HTML_PARAMS(separate_1) "</table>"
}

constructor


