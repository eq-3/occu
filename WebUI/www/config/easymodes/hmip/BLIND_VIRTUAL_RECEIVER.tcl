#!/bin/tclsh

#Kanal-EasyMode!

source [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr dev_descr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  set url $iface_url($iface)

  set chn [getChannel $special_input_id]

  # Determine the current channelMode
  set devMode [xmlrpc $url getMetadata [list string $address] channelMode]

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    if {[string equal $devMode blind] != 0} {
      append HTML_PARAMS(separate_1) "[getBlindVirtualReceiver $chn ps psDescr ]"
    } elseif {[string equal $devMode shutter] == 1} {
      append HTML_PARAMS(separate_1) "[getShutterVirtualReceiver $chn ps psDescr]"
    } else {
      append HTML_PARAMS(separate_1) "[getBlindVirtualReceiver $chn ps psDescr]"
    }

  append HTML_PARAMS(separate_1) "</table>"
}

constructor