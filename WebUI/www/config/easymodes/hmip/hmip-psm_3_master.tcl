#!/bin/tclsh

source [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr dev_descr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  set chn [getChannel $special_input_id]
  # Firmware = x.y.z
  # devFwMajor = x
  set devFwMajor [expr [lindex [split $dev_descr(FIRMWARE) .] 0] * 1]

  if {$devFwMajor > 1} {
    append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
       set prn 1
       append HTML_PARAMS(separate_1) "[getSwitchVirtualReceiver $chn ps psDescr]";
    append HTML_PARAMS(separate_1) "</table>"
  } else {
    # Hide all parameters of this channel
    append HTML_PARAMS(separate_0) ""
    append HTML_PARAMS(separate_1) ""
  }
}
constructor