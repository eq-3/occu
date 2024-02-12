#!/bin/tclsh


sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipChannelConfigDialogs.tcl]
sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipDSTPanel.tcl]
sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipUniversalLightEffectPanel.tcl]
sourceOnce [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr dev_descr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  set chn 0

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

    set prn 1
    append HTML_PARAMS(separate_1) "[getMaintenance $chn ps psDescr $address]"

    incr prn
    append HTML_PARAMS(separate_1) "[getDSTPanel ps psDescr]"

    if {([string first "HmIP-DRG-DALI" $dev_descr(TYPE)] != -1)
    || ([string first "HmIP-RGBW" $dev_descr(TYPE)] != -1)
    || ([string first "HmIP-LSC" $dev_descr(TYPE)] != -1)

    } {
      append HTML_PARAMS(separate_1) [getUniversalLightEffects ps psDescr]
    }

  append HTML_PARAMS(separate_1) "</table>"

}

constructor
