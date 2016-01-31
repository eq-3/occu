#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
# source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options_hmip.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1) "\${switch_toggle}"
set PROFILES_MAP(2)  "\${switch_on_off}"
set PROFILES_MAP(3) "\${change_signal}"



set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)    "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)      "Expertenprofil"

set PROFILE_1(SHORT_COND_VALUE_HI)          150
set PROFILE_1(SHORT_COND_VALUE_LO)           50

set PROFILE_1(SHORT_CT_OFF)      {0 2}
set PROFILE_1(SHORT_CT_OFFDELAY)  {0 2}
set PROFILE_1(SHORT_CT_ON)      {0 2}
set PROFILE_1(SHORT_CT_ONDELAY)    {0 2}

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

set PROFILE_2(SHORT_COND_VALUE_HI)          150
set PROFILE_2(SHORT_COND_VALUE_LO)           50

set PROFILE_2(SHORT_CT_OFF)      {0 2}
set PROFILE_2(SHORT_CT_OFFDELAY)  {0 2}
set PROFILE_2(SHORT_CT_ON)      {0 2}
set PROFILE_2(SHORT_CT_ONDELAY)    {0 2}

set PROFILE_2(SHORT_JT_OFF)      {1 range 0 - 6}
set PROFILE_2(SHORT_JT_OFFDELAY)  {3 range 0 - 6}
set PROFILE_2(SHORT_JT_ON)      {6 range 0 - 6}
set PROFILE_2(SHORT_JT_ONDELAY)    {6 range 0 - 6}

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

set PROFILE_3(SHORT_COND_VALUE_HI)          150
set PROFILE_3(SHORT_COND_VALUE_LO)           50

set PROFILE_3(SHORT_CT_OFF)                   {0 2 5}
set PROFILE_3(SHORT_CT_OFFDELAY)              {0 2 5}
set PROFILE_3(SHORT_CT_ON)                    {0 2 5}
set PROFILE_3(SHORT_CT_ONDELAY)               {0 2 5}

set PROFILE_3(SHORT_JT_OFF)                   1
set PROFILE_3(SHORT_JT_OFFDELAY)              3
set PROFILE_3(SHORT_JT_ON)                    3
set PROFILE_3(SHORT_JT_ONDELAY)               0

set PROFILE_3(SHORT_MULTIEXECUTE)             0
set PROFILE_3(SHORT_OFFDELAY_TIME_BASE)       {0 range 0 - 7}
set PROFILE_3(SHORT_OFFDELAY_TIME_FACTOR)     {0 range 0 - 31}
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

#set SUBSET_1(NAME)          "Offen-Ein/Zu-Aus"
set SUBSET_1(NAME)          "\${subset_1}"
set SUBSET_1(SUBSET_OPTION_VALUE)  1
set SUBSET_1(SHORT_CT_OFF)      0
set SUBSET_1(SHORT_CT_OFFDELAY)    0
set SUBSET_1(SHORT_CT_ON)      2
set SUBSET_1(SHORT_CT_ONDELAY)    2

#set SUBSET_2(NAME)          "Offen-Aus/Zu-Ein"
set SUBSET_2(NAME)          "\${subset_2}"
set SUBSET_2(SUBSET_OPTION_VALUE)  2
set SUBSET_2(SHORT_CT_OFF)      2
set SUBSET_2(SHORT_CT_OFFDELAY)    2
set SUBSET_2(SHORT_CT_ON)      0
set SUBSET_2(SHORT_CT_ONDELAY)    0

#set SUBSET_3(NAME)          "Oeffnen"
set SUBSET_3(NAME)          "\${subset_3}"
set SUBSET_3(SUBSET_OPTION_VALUE)  3
set SUBSET_3(SHORT_CT_OFF)      0
set SUBSET_3(SHORT_CT_OFFDELAY)    0
set SUBSET_3(SHORT_CT_ON)      0
set SUBSET_3(SHORT_CT_ONDELAY)    0

#set SUBSET_4(NAME)          "Schliessen"
set SUBSET_4(NAME)          "\${subset_4}"
set SUBSET_4(SUBSET_OPTION_VALUE)  4
set SUBSET_4(SHORT_CT_OFF)      2
set SUBSET_4(SHORT_CT_OFFDELAY)    2
set SUBSET_4(SHORT_CT_ON)      2
set SUBSET_4(SHORT_CT_ONDELAY)    2


#set SUBSET_5(NAME)          "Aendern"
set SUBSET_5(NAME)          "\${subset_5}"
set SUBSET_5(SUBSET_OPTION_VALUE)  5
set SUBSET_5(SHORT_CT_OFF)      5
set SUBSET_5(SHORT_CT_OFFDELAY)    5
set SUBSET_5(SHORT_CT_ON)      5
set SUBSET_5(SHORT_CT_ONDELAY)    5

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  
  global receiver_address dev_descr_sender dev_descr_receiver
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
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${SWITCH_DIR}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_3 SUBSET_4} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref
  # ONDELAY
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${ONDELAY_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "delay"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${ONDELAY_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${ONDELAY_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_ONDELAY_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps SHORT_ONDELAY_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"

  # ON_TIME
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${ON_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "timeOnOff"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${ON_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${ON_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_ON_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps SHORT_ON_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"

  # OFFDELAY
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${OFFDELAY_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "delay"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${OFFDELAY_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${OFFDELAY_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_OFFDELAY_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps SHORT_OFFDELAY_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"

  # OFF_TIME
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${OFF_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "timeOnOff"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${OFF_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${OFF_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_OFF_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps SHORT_OFF_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#2
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${SWITCH_DIR}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # ONDELAY
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${ONDELAY_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "delay"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${ONDELAY_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${ONDELAY_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_ONDELAY_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps SHORT_ONDELAY_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"

  # ON_TIME
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${ON_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "timeOnOff"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${ON_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${ON_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_ON_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps SHORT_ON_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"

  # OFFDELAY
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${OFFDELAY_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "delay"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${OFFDELAY_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${OFFDELAY_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_OFFDELAY_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps SHORT_OFFDELAY_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"

  # OFF_TIME
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${OFF_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "timeOnOff"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${OFF_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${OFF_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_OFF_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps SHORT_OFF_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"  
  

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${CHANGE_SIGNAL}&nbsp;\${at}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_3 SUBSET_4 SUBSET_5} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref
  # ONDELAY
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${ONDELAY_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "delay"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${ONDELAY_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${ONDELAY_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_ONDELAY_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps SHORT_ONDELAY_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"

  # ON_TIME
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${ON_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "timeOnOff"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${ON_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${ON_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_ON_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps SHORT_ON_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"

  # OFFDELAY
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${OFFDELAY_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "delay"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${OFFDELAY_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${OFFDELAY_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_OFFDELAY_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps SHORT_OFFDELAY_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"

  # OFF_TIME
  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${OFF_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "timeOnOff"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${OFF_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${OFF_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_OFF_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps SHORT_OFF_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}

constructor

