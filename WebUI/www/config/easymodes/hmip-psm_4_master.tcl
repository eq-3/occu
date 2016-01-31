#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  upvar HTML_PARAMS   HTML_PARAMS


  # Hide all parameters of this channel
  append HTML_PARAMS(separate_0) ""
  append HTML_PARAMS(separate_1) ""
}

constructor
