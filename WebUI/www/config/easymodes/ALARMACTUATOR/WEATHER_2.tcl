#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options_alarmactuator.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${alarm_on}"  


set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)    "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)      "Expertenprofil"

set PROFILE_1(SHORT_CT_OFFDELAY)   1
set PROFILE_1(SHORT_CT_ONDELAY)    1
set PROFILE_1(SHORT_CT_OFF)       1
set PROFILE_1(SHORT_CT_ON)       1
set PROFILE_1(SHORT_COND_VALUE_LO)  {0 range 0 - 255}
set PROFILE_1(SHORT_COND_VALUE_HI)  {0 range 0 - 255}
set PROFILE_1(SHORT_ONDELAY_TIME)  0
set PROFILE_1(SHORT_ON_TIME)    {120 300}  
set PROFILE_1(SHORT_OFFDELAY_TIME)  0
set PROFILE_1(SHORT_OFF_TIME)    111600
set PROFILE_1(SHORT_ON_TIME_MODE)  0
set PROFILE_1(SHORT_OFF_TIME_MODE)  0
set PROFILE_1(SHORT_ACTION_TYPE)  1
set PROFILE_1(SHORT_JT_OFF)      1
set PROFILE_1(SHORT_JT_ON)       2
set PROFILE_1(SHORT_JT_OFFDELAY)   2
set PROFILE_1(SHORT_JT_ONDELAY)    2
set PROFILE_1(UI_DESCRIPTION)  "Wenn die eingestellte Windgeschwindigkeit erreicht wird, schaltet der Alarm f&uuml;r die eingestellte Zeit ein."
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)  
set PROFILE_1(UI_HINT)  1


proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global dev_descr_sender dev_descr_receiver receiver_address
  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps      
  upvar $pps_descr    ps_descr

  # hier wird der gewaehlte Kancal der ASA ermittelt, Kanal 1 = Sirene - Kanal 2 = Blitzlicht
  set ch [string range $receiver_address [expr [string first ":" $receiver_address] +1] [string length $receiver_address]]  
  set manner(1) "siren"
  set manner(2) "flashlight"

  foreach pro [array names PROFILES_MAP] {
    upvar PROFILE_$pro PROFILE_$pro
  }
       
  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]
  
  #global SUBSETS
  set name "x"
  set i 1
  while {$name != ""} {
    upvar SUBSET_$i SUBSET_$i
    array set subset [array get SUBSET_$i]
    set name ""
    catch {set name $subset(NAME)}
    array_clear subset
    incr i
  }

#  die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
  set prn 0  
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

#1
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn\_s}&nbsp;\${actor_$ch}&nbsp;\${description_$prn\_e}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  incr pref; #1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
  option $manner($ch) 
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref;# 2
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"SHORT_COND_VALUE_LO\"></td></tr>"
  incr pref;# 3
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"SHORT_COND_VALUE_HI\"></td></tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "var stormLowerThresholdElm = jQuery(\"\[name='__STORM_LOWER_THRESHOLD'\]\").first();"
    append HTML_PARAMS(separate_1) "var stormUpperThresholdElm = jQuery(\"\[name='__STORM_UPPER_THRESHOLD'\]\").first();"

    # The Expert Mode is not active
    append HTML_PARAMS(separate_1) "if (stormUpperThresholdElm.length == 0) \{"
      append HTML_PARAMS(separate_1) "var stormUpperThresholdElm = jQuery(\"\[name='STORM_UPPER_THRESHOLD'\]\").first();"
      append HTML_PARAMS(separate_1) "var stormLowerThresholdElm = jQuery(\"\[name='STORM_LOWER_THRESHOLD'\]\").first();"
    append HTML_PARAMS(separate_1) "\}"

    append HTML_PARAMS(separate_1) "var condValLoElm1 = jQuery(\"#separate_receiver_1_2\");"
    append HTML_PARAMS(separate_1) "var condValHiElm1 = jQuery(\"#separate_receiver_1_3\");"
    append HTML_PARAMS(separate_1) "condValLoElm1.val(stormLowerThresholdElm.val());"
    append HTML_PARAMS(separate_1) "condValHiElm1.val(stormUpperThresholdElm.val());"
  append HTML_PARAMS(separate_1) "</script>"

}

constructor
