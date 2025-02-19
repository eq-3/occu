#!/bin/tclsh

sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipChannelConfigDialogs.tcl]
sourceOnce [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr dev_descr wgtChnMode
  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  set url $iface_url($iface)

  set chn [getChannel $special_input_id]
  set devType $dev_descr(TYPE)

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    append HTML_PARAMS(separate_1) "[getSwitchVirtualReceiver $chn ps psDescr]"
  append HTML_PARAMS(separate_1) "</table>"
}

constructor