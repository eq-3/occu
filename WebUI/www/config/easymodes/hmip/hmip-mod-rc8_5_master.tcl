#!/bin/tclsh

source [file join /www/config/easymodes/em_common.tcl]
source [file join /www/config/easymodes/etc/hmipMOD-RC8.tcl]


proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global env iface_url psDescr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  set chn [getChannel $special_input_id]

  # array set paramSet [xmlrpc $iface_url($iface) getParamset [list string $address] [list string MASTER]]
  # puts "chn: $chn - channel operation mode: $paramSet(CHANNEL_OPERATION_MODE)<br/>"

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    switch $ps(CHANNEL_OPERATION_MODE) {
      0 {append HTML_PARAMS(separate_1) "[getInactiveHTML $chn ps psDescr]" }
      1 {append HTML_PARAMS(separate_1) "[getKeyHTML $chn ps psDescr]" }
      2 {append HTML_PARAMS(separate_1) "[getSwitchHTML $chn ps psDescr]" }
      3 {append HTML_PARAMS(separate_1) "[getBinaryHTML $chn ps psDescr]"}
    }
  append HTML_PARAMS(separate_1) "</table>"
  append HTML_PARAMS(separate_1) [getFooter $chn]
}

constructor

