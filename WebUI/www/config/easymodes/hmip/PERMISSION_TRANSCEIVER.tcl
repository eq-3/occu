#!/bin/tclsh

sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipChannelConfigDialogs.tcl]
sourceOnce [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global env iface_url psDescr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  set CHANNEL $special_input_id

  set prn 0

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

    set param POWERUP_JUMPTARGET
    if { [info exists ps($param)] == 1  } {
      incr prn
      array_clear options
      set options(0) "\${optionNotAllowed}"
      set options(2) "\${optionAllowed}"
      append HTML_PARAMS(separate_1) "<tr>"
        append HTML_PARAMS(separate_1) "<td>\${stringTablePowerUpAction}</td>"
        append HTML_PARAMS(separate_1) "<td>[get_ComboBox options $param separate_$CHANNEL\_$prn ps $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"
    } else {
      append HTML_PARAMS(separate_1) "[getNoParametersToSet]"
    }

  append HTML_PARAMS(separate_1) "</table>"
}

constructor
