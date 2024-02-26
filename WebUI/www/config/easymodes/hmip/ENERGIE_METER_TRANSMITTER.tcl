#!/bin/tclsh

sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipChannelConfigDialogs.tcl]
sourceOnce [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global env iface_url psDescr dev_descr

  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  set url $iface_url($iface)
  set devType $dev_descr(TYPE)
  set chn [getChannel $special_input_id]

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    set prn 0
    if {[string equal $devType HmIP-ESI] == 1} {
      if {$chn == 1} {
        append HTML_PARAMS(separate_1) "[getEnergieMeterTransmitterESI $chn ps psDescr $address]"
      } else {
        set chnDescr(CHANNEL_OPERATION_MODE) -1
        catch {array set chnDescr [xmlrpc $url getParamset [list string $dev_descr(ADDRESS):1] [list string MASTER]]}

        # make it possible to enter the startvalue of the channel and show the OBIS String
        append HTML_PARAMS(separate_1) "[getEnergieMeterTransmitterESIStartValue $chn ps psDescr $address $chnDescr(CHANNEL_OPERATION_MODE)]"
      }

    } else {
      append HTML_PARAMS(separate_1) "[getEnergieMeterTransmitter $chn ps psDescr]"
    }
  append HTML_PARAMS(separate_1) "</table>"
}
constructor
