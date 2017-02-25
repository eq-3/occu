#!/bin/tclsh
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipChannelConfigDialogs.tcl]
source [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global env iface_url psDescr dev_descr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/CC.js');load_JSFunc('/config/easymodes/MASTER_LANG/HEATINGTHERMOSTATE_2ND_GEN.js');load_JSFunc('/config/easymodes/MASTER_LANG/HEATINGTHERMOSTATE_2ND_GEN_HELP.js');</script>"

  set chn [getChannel $special_input_id]

  set prn 1

  # Firmware = x.y.z
  # devFwMajor = x
  set devFwMajor [expr [lindex [split $dev_descr(FIRMWARE) .] 0] * 1]
  set devFwMinor [expr [lindex [split $dev_descr(FIRMWARE) .] 1] * 1]

  if {($devFwMajor == 1 && $devFwMinor > 5) || ($devFwMajor > 1)} {
    append HTML_PARAMS(separate_1) "[getHeatingClimateControlTransceiver $chn ps psDescr $address]"
  } else {
    append HTML_PARAMS(separate_1) "[getHeatingClimateControlTransceiver $chn ps psDescr $address 'only3WeeklyProgramms']"
  }
}

constructor