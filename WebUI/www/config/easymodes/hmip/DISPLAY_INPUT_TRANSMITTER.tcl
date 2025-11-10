#!/bin/tclsh


sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipWGDConfigDialog.tcl]
sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipWGDConfigDialogWired.tcl]
sourceOnce [file join /www/config/easymodes/em_common.tcl]


proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr dev_descr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  set chn [getChannel $special_input_id]

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

    # Check if the device is a HmIP(W)-WGD(-PL)
    if {([string first "HmIPW-WGD" $dev_descr(TYPE)] != -1)} {
      if {$chn == 41} {
        append HTML_PARAMS(separate_1) "[getNoParametersToSet]"
      } else {
        append HTML_PARAMS(separate_1) "[getDisplayInputTransmitterWired $chn ps psDescr]"
      }
    } elseif {[string first "HmIP-WGD" $dev_descr(TYPE)] != -1} {
      if {$chn == 41} {
        append HTML_PARAMS(separate_1) "[getNoParametersToSet]"
      } else {
        append HTML_PARAMS(separate_1) "[getDisplayInputTransmitter $chn ps psDescr]"
      }
    }
  append HTML_PARAMS(separate_1) "</table>"
}

constructor