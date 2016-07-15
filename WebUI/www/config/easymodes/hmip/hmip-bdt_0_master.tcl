#!/bin/tclsh

#Kanal-EasyMode!

# source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipDSTPanel.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipChannelConfigDialogs.tcl]
source [file join /www/config/easymodes/em_common.tcl]

#Namen der EasyModes tauchen nicht mehr auf. Der Durchgängkeit werden sie hier noch definiert.
set PROFILES_MAP(0)  "Experte"
set PROFILES_MAP(1)  "TheOneAndOnlyEasyMode"

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr
  
  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    psDescr
  upvar PROFILE_1     PROFILE_1

  set chn 0

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    set prn 1
    append HTML_PARAMS(separate_1) "[getMaintenance $chn ps psDescr]"

set comment {
    # Without a weekly program no DST
    incr prn
    append HTML_PARAMS(separate_1) "[getDSTPanel ps psDescr]"
}

  append HTML_PARAMS(separate_1) "</table>"

}

constructor
