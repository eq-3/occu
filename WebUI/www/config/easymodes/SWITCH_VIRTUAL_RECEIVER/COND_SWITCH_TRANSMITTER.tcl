#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1) "\${switch_toggle}"
set PROFILES_MAP(2)  "\${switch_on_off}"
set PROFILES_MAP(3) "\${change_signal}"

set VALUE_GE_LO 0
set VALUE_GE_HI 1
set VALUE_L_LO 2
set VALUE_L_HI 3
set VALUE_GE_LO_AND_L_HI 4
set VALUE_L_LO_OR_GE_HI 5


set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)    "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)      "Expertenprofil"

set PROFILE_1(SHORT_COND_VALUE_HI)  {100 range 0 - 255}
set PROFILE_1(SHORT_COND_VALUE_LO)  {50 range 0 - 255}
set PROFILE_1(SHORT_CT_OFF)      {0 range 0 - 5}
set PROFILE_1(SHORT_CT_OFFDELAY)  {0 range 0 - 5}
set PROFILE_1(SHORT_CT_ON)      {0 range 0 - 5}
set PROFILE_1(SHORT_CT_ONDELAY)    {0 range 0 - 5}
set PROFILE_1(SHORT_JT_OFF)       1
set PROFILE_1(SHORT_JT_OFFDELAY)  6
set PROFILE_1(SHORT_JT_ON)        4
set PROFILE_1(SHORT_JT_ONDELAY)   3
set PROFILE_1(SHORT_OFFDELAY_TIME_BASE)       {0 range 0 - 7}
set PROFILE_1(SHORT_OFFDELAY_TIME_FACTOR)     {0 range 0 - 31}
set PROFILE_1(SHORT_OFF_TIME_BASE)            {7 range 0 - 7}
set PROFILE_1(SHORT_OFF_TIME_FACTOR)          {31 range 0 - 31}
set PROFILE_1(SHORT_ONDELAY_TIME_BASE)        {0 range 0 - 7}
set PROFILE_1(SHORT_ONDELAY_TIME_FACTOR)      {0 range 0 - 31}
set PROFILE_1(SHORT_ON_TIME_BASE)             {7 range 0 - 7}
set PROFILE_1(SHORT_ON_TIME_FACTOR)           {31 range 0 - 31}
set PROFILE_1(SHORT_ON_TIME_MODE)             0
set PROFILE_1(SHORT_OFF_TIME_MODE)            0
set PROFILE_1(SHORT_PROFILE_ACTION_TYPE)      1
set PROFILE_1(UI_DESCRIPTION)  "Beim Öffnen toggelt wird der Schaltaktor in den entgegengesetzten Zustand versetzt."
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

set PROFILE_2(SHORT_COND_VALUE_HI)          {99 range 0 - 255}
set PROFILE_2(SHORT_COND_VALUE_LO)          {50 range 0 - 255}
set PROFILE_2(SHORT_CT_OFF)      {0 range 0 - 5}
set PROFILE_2(SHORT_CT_OFFDELAY)  {0 range 0 - 5}
set PROFILE_2(SHORT_CT_ON)      {0 range 0 - 5}
set PROFILE_2(SHORT_CT_ONDELAY)    {0 range 0 - 5}
set PROFILE_2(SHORT_JT_OFF)      {1 range 0 - 6}
set PROFILE_2(SHORT_JT_OFFDELAY)  {3 range 0 - 6}
set PROFILE_2(SHORT_JT_ON)      {4 range 1 - 6}
set PROFILE_2(SHORT_JT_ONDELAY)    {6 range 1 - 6}
set PROFILE_2(SHORT_OFFDELAY_TIME_BASE)       {0 range 0 - 7}
set PROFILE_2(SHORT_OFFDELAY_TIME_FACTOR)     {0 range 0 - 31}
set PROFILE_2(SHORT_OFF_TIME_BASE)            {7 range 0 - 7}
set PROFILE_2(SHORT_OFF_TIME_FACTOR)          {31 range 0 - 31}
set PROFILE_2(SHORT_ONDELAY_TIME_BASE)        {0 range 0 - 7}
set PROFILE_2(SHORT_ONDELAY_TIME_FACTOR)      {0 range 0 - 31}
set PROFILE_2(SHORT_ON_TIME_BASE)             {7 range 0 - 7}
set PROFILE_2(SHORT_ON_TIME_FACTOR)           {31 range 0 - 31}
set PROFILE_2(SHORT_ON_TIME_MODE)             0
set PROFILE_2(SHORT_OFF_TIME_MODE)            0
set PROFILE_2(SHORT_PROFILE_ACTION_TYPE)      1
set PROFILE_2(UI_DESCRIPTION)  "Beim &Ouml;ffnen des Schaltkontaktes wird der Schalter ein- und beim Schlie&szlig;en ausgeschaltet. Die Schaltzuordnung l&auml;sst sich auch umkehren."
set PROFILE_2(UI_TEMPLATE)    $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2

set PROFILE_3(SHORT_COND_VALUE_HI)          {100 range 0 - 255}
set PROFILE_3(SHORT_COND_VALUE_LO)          {50 range 0 - 255}
set PROFILE_3(SHORT_CT_OFF)                   {0 range 0 - 5}
set PROFILE_3(SHORT_CT_OFFDELAY)              {0 range 0 - 5}
set PROFILE_3(SHORT_CT_ON)                    {0 range 0 - 5}
set PROFILE_3(SHORT_CT_ONDELAY)               {0 range 0 - 5}
set PROFILE_3(SHORT_JT_OFF)                   1
set PROFILE_3(SHORT_JT_OFFDELAY)              3
set PROFILE_3(SHORT_JT_ON)                    0
set PROFILE_3(SHORT_JT_ONDELAY)               0
set PROFILE_3(SHORT_MULTIEXECUTE)             0
set PROFILE_3(SHORT_OFFDELAY_TIME_BASE)       0
set PROFILE_3(SHORT_OFFDELAY_TIME_FACTOR)     0
set PROFILE_3(SHORT_OFF_TIME_BASE)            {7 range 0 - 7}
set PROFILE_3(SHORT_OFF_TIME_FACTOR)          {31 range 0 - 31}
set PROFILE_3(SHORT_OFF_TIME_MODE)            0
set PROFILE_3(SHORT_ONDELAY_TIME_BASE)        {0 range 0 - 7}
set PROFILE_3(SHORT_ONDELAY_TIME_FACTOR)      {0 range 0 - 31}
set PROFILE_3(SHORT_ON_TIME_BASE)             {7 range 0 - 7}
set PROFILE_3(SHORT_ON_TIME_FACTOR)           {31 range 0 - 31}
set PROFILE_3(SHORT_ON_TIME_MODE)             0
set PROFILE_3(SHORT_PROFILE_ACTION_TYPE)      1
set PROFILE_3(UI_DESCRIPTION)  "Bei Erkennung des &Auml;nderungssignals wird der Schalter f&uuml;r eine bestimmte Zeit eingeschaltet."
set PROFILE_3(UI_TEMPLATE)    $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3

#set SUBSET_1(NAME)          "Oberer Grenzwert &uuml;berschritten - ein / Unterer Grenzwert unterschritten - aus"
set SUBSET_1(NAME)          "\${subset_1}"
set SUBSET_1(SUBSET_OPTION_VALUE)  1
set SUBSET_1(SHORT_CT_OFF)      1
set SUBSET_1(SHORT_CT_OFFDELAY)    1
set SUBSET_1(SHORT_CT_ON)      4
set SUBSET_1(SHORT_CT_ONDELAY)    4

#set SUBSET_2(NAME)          "Oberer Grenzwert &uuml;berschritten - aus / Unterer Grenzwert unterschritten - ein"
set SUBSET_2(NAME)          "\${subset_2}"
set SUBSET_2(SUBSET_OPTION_VALUE)  2
set SUBSET_2(SHORT_CT_OFF)      4
set SUBSET_2(SHORT_CT_OFFDELAY)    4
set SUBSET_2(SHORT_CT_ON)      1
set SUBSET_2(SHORT_CT_ONDELAY)    1

#set SUBSET_3(NAME)          "Oberer Grenzwert &uuml;berschritten"
set SUBSET_3(NAME)          "\${subset_3}"
set SUBSET_3(SUBSET_OPTION_VALUE)  3
set SUBSET_3(SHORT_CT_OFF)      1
set SUBSET_3(SHORT_CT_OFFDELAY)    1
set SUBSET_3(SHORT_CT_ON)      1
set SUBSET_3(SHORT_CT_ONDELAY)    1

#set SUBSET_4(NAME)          "Unterer Grenzwert unterschritten"
set SUBSET_4(NAME)          "\${subset_4}"
set SUBSET_4(SUBSET_OPTION_VALUE)  4
set SUBSET_4(SHORT_CT_OFF)      4
set SUBSET_4(SHORT_CT_OFFDELAY)    4
set SUBSET_4(SHORT_CT_ON)      4
set SUBSET_4(SHORT_CT_ONDELAY)    4


#set SUBSET_5(NAME)          "Unterer Grenzwert unter- / oberer Grenzwert &uuml;berschritten"
set SUBSET_5(NAME)          "\${subset_5}"
set SUBSET_5(SUBSET_OPTION_VALUE)  5
set SUBSET_5(SHORT_CT_OFF)      0
set SUBSET_5(SHORT_CT_OFFDELAY)    0
set SUBSET_5(SHORT_CT_ON)      0
set SUBSET_5(SHORT_CT_ONDELAY)    0

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global iface_url receiver_address dev_descr_sender dev_descr_receiver
  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    ps_descr

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

  catch {
    # Set SHORT_COND_VALUE_HI/LO to the value of the configuration parameters COND_TX_DECISION_ABOVE/BELOW
    array set sender_descrMaster [xmlrpc $iface_url($iface) getParamset [list string $dev_descr_sender(ADDRESS)] MASTER]
    set condTXDecisionAbove $sender_descrMaster(COND_TX_DECISION_ABOVE)
    set condTXDecisionBelow $sender_descrMaster(COND_TX_DECISION_BELOW)
    set decisionValues "
     {SHORT_COND_VALUE_HI {int $condTXDecisionAbove}}
     {SHORT_COND_VALUE_LO {int $condTXDecisionBelow}}"
    catch {puts "[xmlrpc $iface_url($iface) putParamset [list string $address] [list string $dev_descr_sender(ADDRESS)] [list struct $decisionValues]]"}
    set ps(SHORT_COND_VALUE_HI) $condTXDecisionAbove
    set ps(SHORT_COND_VALUE_LO) $condTXDecisionBelow
  }

#  die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
  puts "<script type=\"text/javascript\">getLangInfo_Special('HmIP_DEVICES.txt');</script>"

  set prn 0
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

#1
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "\${helpDecisionValAndThreshold}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${SENDER_CHANNEL_SETTINGS}</td>"
  append HTML_PARAMS(separate_$prn) "<td><input type=\"button\" value=\${btnEdit} onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$dev_descr_sender(ADDRESS)', 'redirect_url': 'IC_SETPROFILES'});\" ></td>"
  append HTML_PARAMS(separate_$prn)) "</tr>"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DECISION_VALUE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_3 SUBSET_4 SUBSET_5} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  catch {
    set scvl SHORT_COND_VALUE_LO
    incr pref
    append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\" ><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvl\" value=\"$condTXDecisionBelow\"/></tr></td>"

    set scvh SHORT_COND_VALUE_HI
    incr pref
    append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvh\" value=\"$condTXDecisionAbove\"/></tr></td>"
  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"



#2
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "\${helpDecisionValAndThreshold}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${SENDER_CHANNEL_SETTINGS}</td>"
  append HTML_PARAMS(separate_$prn) "<td><input type=\"button\" value=\${btnEdit} onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$dev_descr_sender(ADDRESS)', 'redirect_url': 'IC_SETPROFILES'});\" ></td>"
  append HTML_PARAMS(separate_$prn)) "</tr>"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DECISION_VALUE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  catch {
    set scvl SHORT_COND_VALUE_LO
    incr pref
    append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\" ><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvl\" value=\"$condTXDecisionBelow\"/></tr></td>"

    set scvh SHORT_COND_VALUE_HI
    incr pref
    append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvh\" value=\"$condTXDecisionAbove\"/></tr></td>"
  }

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "\${helpDecisionValAndThreshold}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${SENDER_CHANNEL_SETTINGS}</td>"
  append HTML_PARAMS(separate_$prn) "<td><input type=\"button\" value=\${btnEdit} onclick=\"WebUI.enter(DeviceConfigPage, {'iface': 'HmIP-RF','address': '$dev_descr_sender(ADDRESS)', 'redirect_url': 'IC_SETPROFILES'});\" ></td>"
  append HTML_PARAMS(separate_$prn)) "</tr>"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DECISION_VALUE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_3 SUBSET_4 SUBSET_5} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

   # ONDELAY
   append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

   # ON_TIME
   append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

set comment {
   # OFFDELAY
   append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

   # OFF_TIME
   append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"
}
  catch {
    set scvl SHORT_COND_VALUE_LO
    incr pref
    append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\" ><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvl\" value=\"$condTXDecisionBelow\"/></tr></td>"

    set scvh SHORT_COND_VALUE_HI
    incr pref
    append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvh\" value=\"$condTXDecisionAbove\"/></tr></td>"
  }
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}

constructor

