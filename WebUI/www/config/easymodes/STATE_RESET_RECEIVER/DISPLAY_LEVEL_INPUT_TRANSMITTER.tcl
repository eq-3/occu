#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]


set PROFILES_MAP(0)  "\${no_profile}"
set PROFILES_MAP(1)  "\${no_profile}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)  "no"
set PROFILE_0(UI_TEMPLATE)  "no"

set PROFILE_1(UI_HINT)  1
set PROFILE_1(UI_DESCRIPTION)  "no"
set PROFILE_1(UI_TEMPLATE)  "no"

proc isDevHmIPW {device} {
  set result "false"
  if {[string first "HmIPW-" $device] == 0} {
    set result "true"
  }
  return $result
}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  
  global dev_descr_sender dev_descr_receiver iface_url
  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps      
  upvar $pps_descr    ps_descr
  upvar prn prn
  
  foreach pro [array names PROFILES_MAP] {
    upvar PROFILE_$pro PROFILE_$pro
  }


  puts "<script type=\"text/javascript\">getLangInfo('STATE_RESET_RECEIVER','STATE_RESET_RECEIVER');getLangInfo_Special('SPECIAL.txt')</script>"

  set prn 0
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn)  "\${hint_no_expert}<br/><br/>"
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

  incr prn
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn)  "\${hint_no_expert}<br/><br/>"


  set maintenance "[lindex [split $address :] 0]:0"
  array set dev_descr [xmlrpc $iface_url($iface) getParamset [list string $maintenance] MASTER]
  if {[info exists dev_descr(PERMANENT_FULL_RX)]} {
    if {$dev_descr_sender(PARENT) != $dev_descr_receiver(PARENT)} {
      append HTML_PARAMS(separate_$prn) "<div>\${hintPermanentFullRX}</div>"
      append HTML_PARAMS(separate_$prn) "<input type=\"button\" value=\"\${btnChnEdit}\" onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$maintenance', 'redirect_url': 'IC_SETPROFILES'});\" >"
    }
  }
  append HTML_PARAMS(separate_$prn) "</textarea></div>"


  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">window.setTimeout(function() {jQuery(\"#receiver_profiles\").prop(\"disabled\",true);}, 100)</script>"

}

constructor
