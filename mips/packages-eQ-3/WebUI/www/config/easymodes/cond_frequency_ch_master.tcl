#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/profile_cond_x_ch_master.tcl]

catch {unset internalKey}

#Namen der EasyModes tauchen nicht mehr auf. Der Durchgängkeit werden sie hier noch definiert.
set PROFILES_MAP(0)	"Experte"
set PROFILES_MAP(1)	"TheOneAndOnlyEasyMode"

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
	global iface_url psDescr MEASUREMENT_TYPE
	upvar PROFILES_MAP  PROFILES_MAP
	upvar HTML_PARAMS   HTML_PARAMS
	upvar PROFILE_PNAME PROFILE_PNAME
	upvar $pps          ps
	upvar $pps_descr    ps_descr

	#upvar PROFILE_0     PROFILE_0
	upvar PROFILE_1     PROFILE_1

	puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_PMSw.js')</script>"


  set chn [lindex [split $special_input_id _] 1]

  set MEASUREMENT_TYPE FREQUENCY
  set typeSelector j_frequency
  set selectBoxId frequencySelectId

	foreach pro [array names PROFILES_MAP] {
		upvar PROFILE_$pro PROFILE_$pro
	}
  foreach val [array names ps] {
    #exec echo "$val - $ps($val)" >> /tmp/psDescr.txt
  }
	array set psDescr [xmlrpc $iface_url($iface) getParamsetDescription [list string $address] [list string MASTER]]

	append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
      append HTML_PARAMS(separate_1) "<tr><td colspan='2'>"
        append HTML_PARAMS(separate_1) "<div><b>\${descriptionMeasurement$MEASUREMENT_TYPE}</b></div>"
      append HTML_PARAMS(separate_1) "</td></tr>"

      append HTML_PARAMS(separate_1) "<tr><td colspan='2'>"
        append HTML_PARAMS(separate_1) "<select id=\"$selectBoxId\" onchange=\"setMode(this, '$chn')\">"
          append HTML_PARAMS(separate_1) "<option value='0'>\${frequencyOptionExpert}</option>"
          append HTML_PARAMS(separate_1) "<option value='1'>\${frequencyOptionHi}</option>"
          append HTML_PARAMS(separate_1) "<option value='2'>\${frequencyOptionLo}</option>"
          append HTML_PARAMS(separate_1) "<option value='3'>\${frequencyOptionMasterSlave}</option>"
          append HTML_PARAMS(separate_1) "<option value='4'>\${xOptionNotInUse}</option>"
        append HTML_PARAMS(separate_1) "</select>"
      append HTML_PARAMS(separate_1) "</td></tr>"

      # Description
      append HTML_PARAMS(separate_1) "<tr><td colspan='2'>"
        append HTML_PARAMS(separate_1) "<div id='profileDescription$MEASUREMENT_TYPE'></div>"
      append HTML_PARAMS(separate_1) "</td></tr>"

      set expertParamSel "hidden $typeSelector j_expert"
      set upperValueSel "hidden $typeSelector j_expert j_upperVal"
      set lowerValueSel "hidden $typeSelector j_expert j_lowerVal"
      set upperTmpValue0Sel "hidden $typeSelector j_upperTmpVal0 j_tmp"
      set upperTmpValue1Sel "hidden $typeSelector j_upperTmpVal1 j_tmp"
      set lowerTmpValue0Sel "hidden $typeSelector j_lowerTmpVal0 j_tmp"
      set lowerTmpValue1Sel "hidden $typeSelector j_lowerTmpVal1 j_tmp"

      set prn 1
      set param COND_TX_THRESHOLD_HI_$MEASUREMENT_TYPE
      append HTML_PARAMS(separate_1) [getTextField $param $ps($param) $prn $special_input_id $upperValueSel]
        set param lowerVal_$MEASUREMENT_TYPE
        append HTML_PARAMS(separate_1) [getTextField $param  $ps(COND_TX_THRESHOLD_LO_$MEASUREMENT_TYPE) "$prn\_low" $special_input_id $upperTmpValue0Sel]


      incr prn
      set param COND_TX_THRESHOLD_LO_$MEASUREMENT_TYPE
      append HTML_PARAMS(separate_1) [getTextField $param $ps($param) $prn $special_input_id $lowerValueSel]
        set param upperVal_$MEASUREMENT_TYPE
        append HTML_PARAMS(separate_1) [getTextField $param  $ps(COND_TX_THRESHOLD_HI_$MEASUREMENT_TYPE) "$prn\_high" $special_input_id $lowerTmpValue1Sel]

      incr prn
      set param COND_TX_CYCLIC_ABOVE
      append HTML_PARAMS(separate_1) [getCheckBox $param $ps($param) $prn $special_input_id $expertParamSel]


      incr prn
      set param COND_TX_CYCLIC_BELOW
      append HTML_PARAMS(separate_1) [getCheckBox $param $ps($param) $prn $special_input_id $expertParamSel]

      incr prn
      set param COND_TX_DECISION_ABOVE
      append HTML_PARAMS(separate_1)  [getTextField $param $ps($param) $prn $special_input_id $expertParamSel]

      incr prn
      set param COND_TX_DECISION_BELOW
      append HTML_PARAMS(separate_1)  [getTextField $param $ps($param) $prn $special_input_id $expertParamSel]

      incr prn
      set param COND_TX_FALLING
      append HTML_PARAMS(separate_1) [getCheckBox $param $ps($param) $prn $special_input_id $expertParamSel]


      incr prn
      set param COND_TX_RISING
      append HTML_PARAMS(separate_1) [getCheckBox $param $ps($param) $prn $special_input_id $expertParamSel]

      incr prn
      set param LED_ONTIME
      append HTML_PARAMS(separate_1) [getTextField $param $ps($param) $prn $special_input_id $expertParamSel]

      incr prn
      set param TRANSMIT_TRY_MAX
      append HTML_PARAMS(separate_1) [getTextField $param $ps($param) $prn $special_input_id $expertParamSel]

  append HTML_PARAMS(separate_1) "</table>"

  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/MeasurementSwitch.js');"
    append HTML_PARAMS(separate_1) "var frequency = {}; jQuery.extend(frequency, measurementSwitch);"
    append HTML_PARAMS(separate_1) "frequency.init('$MEASUREMENT_TYPE');"
    append HTML_PARAMS(separate_1) "frequency.showActiveProfile('$chn');"
  append HTML_PARAMS(separate_1) "</script>"
}

constructor
