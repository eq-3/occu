#!/bin/tclsh


sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipClimateControlFloorHeatingConfigDialog.tcl]
sourceOnce [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr dev_descr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  append HTML_PARAMS(separate_1) "<table name=\"noParamAvailable\" class=\"ProfileTbl\">"

    set chn [getChannel $special_input_id]

    set Fw [getDevFirmware]

    # Firmware = x.y.z
    # devFwMajor = x
    set devFwMajor [expr [lindex [split $Fw .] 0] * 1]
    set devFwMinor [expr [lindex [split $Fw .] 1] * 1]

    # Fw. >= 1.6
      if {($devFwMajor == 1 && $devFwMinor > 5) || ($devFwMajor > 1)} {
      # show 1.6 channel CLIMATECONTROL_HEAT_DEMAND_PUMP_TRANSMITTER
      set prn 1
      append HTML_PARAMS(separate_1) "[getClimateControlHeatDemandPumpTransmitter $chn ps psDescr]"
    } else {
      # show no parameters available
      append HTML_PARAMS(separate_1) "[getNoParametersToSet]"
      append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">setTimeout(function() {jQuery(\"\[name='noParamAvailable'\]\").css(\"width\",\"100%\");},100);</script>"
    }
  append HTML_PARAMS(separate_1) "</table>"
}

constructor