#!/bin/tclsh

source [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global env iface_url psDescr dev_descr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  set chn [getChannel $special_input_id]

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

    if {[string first "HmIP-ASIR" $dev_descr(TYPE)] == -1} {
      append HTML_PARAMS(separate_1) "[getKeyTransceiver $chn ps psDescr]"
    } else {
      # The sabotage contact of an ASIR claims to be a KEY_TRANSCEIVER but has no paramaters to set
      append HTML_PARAMS(separate_1) "[getNoParametersToSet]"
    }

  append HTML_PARAMS(separate_1) "</table>"
}

constructor