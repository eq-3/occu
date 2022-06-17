#!/bin/tclsh


sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipWeeklyProgramDevice.tcl]
sourceOnce [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global env iface_url psDescr dev_descr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  set devType $dev_descr(TYPE)

  set chn [getChannel $special_input_id]

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    set prn 1
    if {[string equal $devType HmIP-MOD-WD-VK] != 1} {
      append HTML_PARAMS(separate_1) "[getHmIPWeeklyProgram $address $chn ps psDescr 'dimmer']"
    } else {
     append HTML_PARAMS(separate_1) "[getHmIPWeeklyProgram $address $chn ps psDescr 'window']"
    }
  append HTML_PARAMS(separate_1) "</table>"
}

constructor