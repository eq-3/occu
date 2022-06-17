#!/bin/tclsh

sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipWeatherSensor.tcl]
sourceOnce [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  set chn [getChannel $special_input_id]

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    append HTML_PARAMS(separate_1) "[getCondSwitchTransmitterWindSpeed $chn ps psDescr]"
  append HTML_PARAMS(separate_1) "</table>"
}

constructor
