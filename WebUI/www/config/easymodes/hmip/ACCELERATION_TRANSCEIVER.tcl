#!/bin/tclsh
sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipChannelConfigDialogs.tcl]
sourceOnce [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global env iface_url psDescr dev_descr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/MOTION_DETECTOR.js');</script>"

  set chn [getChannel $special_input_id]

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    set prn 1
    if {([string first "HmIP-DLP" $dev_descr(TYPE)] == -1)} {
      append HTML_PARAMS(separate_1) "[getAccelerationTransceiver $chn ps psDescr $address]"
    } else {
      append HTML_PARAMS(separate_1) "[getAccelerationTransceiver_A $chn ps psDescr $address]"
    }

  append HTML_PARAMS(separate_1) "</table>"
}

constructor