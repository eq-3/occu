#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]

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

proc getTextField {type param value inputId} {
  set elemId '$inputId'
  # Limit float to 2 decimal places
  if {[llength [split $value "."]] == 2} {
    set value [format {%1.2f} $value]
  }

  set s "<input id=$elemId type=\"text\" size=\"5\" value=$value name=$param/>"
  return $s
}

proc getComboBox {param prn special_input_id} {
	  global psDescr
	  upvar ps ps
	  set CHANNEL "CHANNEL"

	  array_clear options
    set options(0) "\${stringTableNotUsed}"
    set options($ps($param)) "\${optionEnterValue}"


      append s "<td>"
      append s "[get_ComboBox options $param option_${special_input_id}_$prn ps $param "onchange=\";document.getElementById('field_$prn').style.visibility=(this.selectedIndex < 1)?'hidden':'visible';document.getElementById('separate_CHANNEL_2_$prn').value=parseFloat(this.options\[this.selectedIndex\].value);\""]"
      append s "</td>"
      append s "<td><span id=\"field_$prn\">[getTextField $CHANNEL '$param' $ps($param) separate_${special_input_id}_$prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]</span></td>"
      append s "<script type=\"text/javascript\">"
        append s "if ($ps($param) > 0) {document.getElementById('option_CHANNEL_2_$prn').options\[1\].selected = true;document.getElementById('field_$prn').style.visibility='visible';} else {document.getElementById('option_CHANNEL_2_$prn').options\[0\].selected = true;document.getElementById('field_$prn').style.visibility='hidden';}"
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

  set CHANNEL "CHANNEL"

  array set psDescr [xmlrpc $iface_url($iface) getParamsetDescription [list string $address] [list string MASTER]]

	append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

      append HTML_PARAMS(separate_1) "<tr><td colspan='2'><b>\${PMSwChannel2Header}<b/><br/><br/></td></tr>"

      set prn 1
      set param AVERAGING
    	append HTML_PARAMS(separate_1) "<tr>"
    	  append HTML_PARAMS(separate_1) "<td>\${PMSwAveraging}</td>"
	      append HTML_PARAMS(separate_1) "<td>[getTextField $CHANNEL '$param' $ps($param) separate_${special_input_id}_$prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
	    append HTML_PARAMS(separate_1) "</tr>"

      append HTML_PARAMS(separate_1) "<tr><td colspan='2'><br/><br/>\${PMSwChannel2HintHeader}</td></tr>"

      incr prn
      set param TX_THRESHOLD_POWER
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1)  "<td>\${PMSwChannel2Hint_Power}</td>"
      append HTML_PARAMS(separate_1) [getComboBox $param $prn $special_input_id]
      append HTML_PARAMS(separate_1) "</tr>"

      incr prn
      set param TX_THRESHOLD_CURRENT
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1)  "<td>\${PMSwChannel2Hint_Current}</td>"
      append HTML_PARAMS(separate_1) [getComboBox $param $prn $special_input_id]
      append HTML_PARAMS(separate_1) "</tr>"

      incr prn
      set param TX_THRESHOLD_VOLTAGE
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1)  "<td>\${PMSwChannel2Hint_Voltage}</td>"
      append HTML_PARAMS(separate_1) [getComboBox $param $prn $special_input_id]
      append HTML_PARAMS(separate_1) "</tr>"

      incr prn
      set param TX_THRESHOLD_FREQUENCY
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1)  "<td>\${PMSwChannel2Hint_Frequency}</td>"
      append HTML_PARAMS(separate_1) [getComboBox $param $prn $special_input_id]
      append HTML_PARAMS(separate_1) "</tr>"

      append HTML_PARAMS(separate_1) "<tr><td>\${PMSwChannel2Hint_Footer}<br/><br/></td></tr>"

      incr prn
      set param TX_MINDELAY
    	append HTML_PARAMS(separate_1) "<tr>"
    	  append HTML_PARAMS(separate_1) "<td>\${PMSwChannel2MinDelay}</td>"
	      append HTML_PARAMS(separate_1) "<td>[getTextField $CHANNEL '$param' $ps($param) separate_${special_input_id}_$prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
	    append HTML_PARAMS(separate_1) "</tr>"

  append HTML_PARAMS(separate_1) "</table>"
}

constructor


