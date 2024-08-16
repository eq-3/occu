#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1) "\${switch_toggle}"
set PROFILES_MAP(2)  "\${switch_on}"
set PROFILES_MAP(3) "\${switch_off}"
set PROFILES_MAP(4)  "\${no_action}"



set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)    "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)      "Expertenprofil"

set PROFILE_1(SHORT_COND_VALUE_HI)  {100 range 0 - 255}
set PROFILE_1(SHORT_COND_VALUE_LO)  {50 range 0 - 255}
set PROFILE_1(SHORT_CT_OFF)      {0 range 0 - 5}
set PROFILE_1(SHORT_CT_OFFDELAY)  {0 range 0 - 5}
set PROFILE_1(SHORT_CT_ON)      {0 range 0 - 5}
set PROFILE_1(SHORT_CT_ONDELAY)    {0 range 0 - 5}
set PROFILE_1(SHORT_JT_OFF)       {1 3}
set PROFILE_1(SHORT_JT_OFFDELAY)  6
set PROFILE_1(SHORT_JT_ON)        {4 6}
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
set PROFILE_2(SHORT_CT_OFF)      0
set PROFILE_2(SHORT_CT_OFFDELAY)  0
set PROFILE_2(SHORT_CT_ON)      0
set PROFILE_2(SHORT_CT_ONDELAY)    0
set PROFILE_2(SHORT_JT_OFF)       {1 3}
set PROFILE_2(SHORT_JT_OFFDELAY)  3
set PROFILE_2(SHORT_JT_ON)        3
set PROFILE_2(SHORT_JT_ONDELAY)   3
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

set PROFILE_3(SHORT_COND_VALUE_HI)          {99 range 0 - 255}
set PROFILE_3(SHORT_COND_VALUE_LO)          {50 range 0 - 255}
set PROFILE_3(SHORT_CT_OFF)      0
set PROFILE_3(SHORT_CT_OFFDELAY)  0
set PROFILE_3(SHORT_CT_ON)      0
set PROFILE_3(SHORT_CT_ONDELAY)    0
set PROFILE_3(SHORT_JT_OFF)       6
set PROFILE_3(SHORT_JT_OFFDELAY)  6
set PROFILE_3(SHORT_JT_ON)        4
set PROFILE_3(SHORT_JT_ONDELAY)   6
set PROFILE_3(SHORT_OFFDELAY_TIME_BASE)       {0 range 0 - 7}
set PROFILE_3(SHORT_OFFDELAY_TIME_FACTOR)     {0 range 0 - 31}
set PROFILE_3(SHORT_OFF_TIME_BASE)            {7 range 0 - 7}
set PROFILE_3(SHORT_OFF_TIME_FACTOR)          {31 range 0 - 31}
set PROFILE_3(SHORT_ONDELAY_TIME_BASE)        {0 range 0 - 7}
set PROFILE_3(SHORT_ONDELAY_TIME_FACTOR)      {0 range 0 - 31}
set PROFILE_3(SHORT_ON_TIME_BASE)             {7 range 0 - 7}
set PROFILE_3(SHORT_ON_TIME_FACTOR)           {31 range 0 - 31}
set PROFILE_3(SHORT_ON_TIME_MODE)             0
set PROFILE_3(SHORT_OFF_TIME_MODE)            0
set PROFILE_3(SHORT_PROFILE_ACTION_TYPE)      1
set PROFILE_3(UI_DESCRIPTION)  "Beim &Ouml;ffnen des Schaltkontaktes wird der Schalter ein- und beim Schlie&szlig;en ausgeschaltet. Die Schaltzuordnung l&auml;sst sich auch umkehren."
set PROFILE_3(UI_TEMPLATE)    $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3

set PROFILE_4(SHORT_JT_OFF)      0
set PROFILE_4(SHORT_JT_ON)      0
set PROFILE_4(SHORT_JT_OFFDELAY)  0
set PROFILE_4(SHORT_JT_ONDELAY)    0
set PROFILE_4(SHORT_JT_RAMPOFF)    0
set PROFILE_4(SHORT_JT_RAMPON)    0 
set PROFILE_4(SHORT_JT_REFOFF)    0
set PROFILE_4(SHORT_JT_REFON)    0
set PROFILE_4(UI_DESCRIPTION)  "Der Durchgangssensor ist au&szlig;er Betrieb."
set PROFILE_4(UI_TEMPLATE)  $PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)  4

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global  iface_url sender_address receiver_address dev_descr_sender dev_descr_receiver
  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    ps_descr

  foreach pro [array names PROFILES_MAP] {
    upvar PROFILE_$pro PROFILE_$pro
  }

  set channel $dev_descr_sender(INDEX)
  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]

  if {($cur_profile == 1) && ($dev_descr_receiver(PARENT_TYPE) == "HmIP-WHS2")} {
    set modifiedCondType  "{SHORT_CT_OFFDELAY {int 0}} {SHORT_CT_ON {int 0}}"
    catch {puts "[xmlrpc $iface_url($iface) putParamset [list string $receiver_address] [list string $sender_address] [list struct $modifiedCondType]]"}
    set ps(SHORT_CT_OFFDELAY) 0
    set ps(SHORT_CT_ON) 0
  }

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

  # Set SHORT_COND_VALUE_HI/LO to the value of the configuration parameters COND_TX_DECISION_ABOVE/BELOW
  array set sender_descrMaster [xmlrpc $iface_url($iface) getParamset [list string $dev_descr_sender(ADDRESS)] MASTER]

  if {$channel == 2} {
    set condTXDecisionValue $sender_descrMaster(COND_TX_DECISION_ABOVE)
    set decisionValue "{SHORT_COND_VALUE_HI {int $condTXDecisionValue}}"
    set ps(SHORT_COND_VALUE_HI) $condTXDecisionValue
    set scvlh SHORT_COND_VALUE_HI

  } elseif {$channel == 3} {
    set condTXDecisionValue $sender_descrMaster(COND_TX_DECISION_BELOW)
    set decisionValue "{SHORT_COND_VALUE_LO {int $condTXDecisionValue}}"
    set ps(SHORT_COND_VALUE_LO) $condTXDecisionValue
    set scvlh SHORT_COND_VALUE_LO
  }

  catch {puts "[xmlrpc $iface_url($iface) putParamset [list string $address] [list string $dev_descr_sender(ADDRESS)] [list struct $decisionValue]]"}

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
  append HTML_PARAMS(separate_$prn) "\${description_$channel\_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set pref 0
  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvlh\" value=\"$condTXDecisionValue\"/></tr></td>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"



#2
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$channel\_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set pref 0
  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvlh\" value=\"$condTXDecisionValue\"/></tr></td>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$channel\_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set pref 0
  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td><input type=\"text\" id=\"separate_receiver_$prn\_$pref\" name=\"$scvlh\" value=\"$condTXDecisionValue\"/></tr></td>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#4
  incr prn
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

}

constructor

