#!/bin/tclsh

source [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global env iface_url psDescr
  
  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  set chn [getChannel $special_input_id]

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    set prn 1
    #append HTML_PARAMS(separate_1) "[getSwitchTransmitter $chn ps psDescr]"
    append HTML_PARAMS(separate_1) "[getNoParametersToSet]"
  append HTML_PARAMS(separate_1) "</table>"
}

constructor


  # Channel 1 of the ASIR is defined as a KEY_TRANSCEIVER but acts as a SABOTAGECONTACT with no paramaters to set.
  # Therefore we can't simlpy use the KEY_TRANSCEIVER.tcl but must use this file.