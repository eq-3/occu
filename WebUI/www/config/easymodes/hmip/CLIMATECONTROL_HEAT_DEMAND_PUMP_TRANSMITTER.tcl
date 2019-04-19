#!/bin/tclsh

#Kanal-EasyMode!

source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipClimateControlFloorHeatingConfigDialog.tcl]
source [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr dev_descr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  append HTML_PARAMS(separate_1) "<table name=\"noParamAvailable\" class=\"ProfileTbl\">"

    set chn [getChannel $special_input_id]
    append HTML_PARAMS(separate_1) "[getClimateControlHeatDemandPumpTransmitter $chn ps psDescr]"

  append HTML_PARAMS(separate_1) "</table>"
}

constructor