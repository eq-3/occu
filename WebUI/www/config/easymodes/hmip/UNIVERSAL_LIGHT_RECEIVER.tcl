#!/bin/tclsh
sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipUniversalLightReceiverConfigDialogs.tcl]
sourceOnce [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global env iface_url psDescr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  set chn [getChannel $special_input_id]
  set devAddress [lindex [split $address :] 0]
  set maintenanceAdress "$devAddress:0"
  set url $iface_url($iface)

  array set dev_ps [xmlrpc $url getParamset $maintenanceAdress MASTER]
  set devMode $dev_ps(DEVICE_OPERATION_MODE); # 0 = RGBW, 1 = RGB, 2 = Tuneable White, 3 = PWM

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
  switch $devMode {
    0 {
      if {$chn == 1} {
        append HTML_PARAMS(separate_1) "[getUniversalLightReceiver $chn ps psDescr]"
      } else {
        append HTML_PARAMS(separate_1) "[getNoParametersToSet]"
      }
    }
    1 {
      if {$chn == 1} {
        append HTML_PARAMS(separate_1) "[getUniversalLightReceiver $chn ps psDescr]"
      } else {
        append HTML_PARAMS(separate_1) "[getNoParametersToSet]"
      }
    }
    2 {
      if {($chn == 1) || ($chn == 2)} {
        append HTML_PARAMS(separate_1) "[getUniversalLightReceiver $chn ps psDescr]"
      } else {
        append HTML_PARAMS(separate_1) "[getNoParametersToSet]"
      }
    }
    3 {
        append HTML_PARAMS(separate_1) "[getUniversalLightReceiver $chn ps psDescr]"
    }
  }
  append HTML_PARAMS(separate_1) "</table>"
}

constructor