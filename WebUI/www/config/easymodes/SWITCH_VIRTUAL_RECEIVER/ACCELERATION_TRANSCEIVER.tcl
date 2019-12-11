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
set PROFILES_MAP(4) "\${switch_on_off}"



set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)    "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)      "Expertenprofil"

# 0 = NOP
# 1 = ON_DELAY
# 2 = RAMP_ON
# 3 = ON
# 4 = OFF_DELAY
# 5 = RAMP_OFF
# 6 = OFF

set PROFILE_1(SHORT_COND_VALUE_HI)          150
set PROFILE_1(SHORT_COND_VALUE_LO)           50
set PROFILE_1(SHORT_CT_OFF)      {0 2 5}
set PROFILE_1(SHORT_CT_OFFDELAY)  {0 2 5}
set PROFILE_1(SHORT_CT_ON)      {0 2 5}
set PROFILE_1(SHORT_CT_ONDELAY)    {0 2 5}
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
set PROFILE_1(UI_DESCRIPTION)  "Bei Bewegungserkennung toggelt wird der Schaltaktor in den entgegengesetzten Zustand versetzt."
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

set PROFILE_2(SHORT_COND_VALUE_HI)          150
set PROFILE_2(SHORT_COND_VALUE_LO)           50
set PROFILE_2(SHORT_CT_OFF)      {0 2 5}
set PROFILE_2(SHORT_CT_OFFDELAY)  {0 2 5}
set PROFILE_2(SHORT_CT_ON)      {0 2 5}
set PROFILE_2(SHORT_CT_ONDELAY) {0 2 5}
set PROFILE_2(SHORT_JT_OFF)      1
set PROFILE_2(SHORT_JT_OFFDELAY)  3
set PROFILE_2(SHORT_JT_ON)      3
set PROFILE_2(SHORT_JT_ONDELAY)    1
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
set PROFILE_2(UI_DESCRIPTION)  "Bei Bewegungserkennung wird der Schalter f&uuml;r eine bestimmte Zeit eingeschaltet."
set PROFILE_2(UI_TEMPLATE)    $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2

set PROFILE_3(SHORT_COND_VALUE_HI)          151
set PROFILE_3(SHORT_COND_VALUE_LO)           50
set PROFILE_3(SHORT_CT_OFF)                   {0 2 5}
set PROFILE_3(SHORT_CT_OFFDELAY)              {0 2 5}
set PROFILE_3(SHORT_CT_ON)                    {0 2 5}
set PROFILE_3(SHORT_CT_ONDELAY)               {0 2 5}
set PROFILE_3(SHORT_JT_OFF)                   6
set PROFILE_3(SHORT_JT_OFFDELAY)              4
set PROFILE_3(SHORT_JT_ON)                    4
set PROFILE_3(SHORT_JT_ONDELAY)               6
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
set PROFILE_3(UI_DESCRIPTION)  "Bei Bewegungserkennung wird der Schalter f&uuml;r eine bestimmte Zeit ausgeschaltet."
set PROFILE_3(UI_TEMPLATE)    $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3

set PROFILE_4(SHORT_COND_VALUE_HI)          150
set PROFILE_4(SHORT_COND_VALUE_LO)           50
set PROFILE_4(SHORT_CT_OFF)       {0 2}
set PROFILE_4(SHORT_CT_OFFDELAY)  {0 2}
set PROFILE_4(SHORT_CT_ON)        {2 1}
set PROFILE_4(SHORT_CT_ONDELAY)   {2 1}
set PROFILE_4(SHORT_JT_OFF)       {1 1}
set PROFILE_4(SHORT_JT_OFFDELAY)  {3 3}
set PROFILE_4(SHORT_JT_ON)        {4 4}
set PROFILE_4(SHORT_JT_ONDELAY)   {6 6}
set PROFILE_4(SHORT_OFFDELAY_TIME_BASE)       {0 range 0 - 7}
set PROFILE_4(SHORT_OFFDELAY_TIME_FACTOR)     {0 range 0 - 31}
set PROFILE_4(SHORT_OFF_TIME_BASE)            {7 range 0 - 7}
set PROFILE_4(SHORT_OFF_TIME_FACTOR)          {31 range 0 - 31}
set PROFILE_4(SHORT_ONDELAY_TIME_BASE)        {0 range 0 - 7}
set PROFILE_4(SHORT_ONDELAY_TIME_FACTOR)      {0 range 0 - 31}
set PROFILE_4(SHORT_ON_TIME_BASE)             {7 range 0 - 7}
set PROFILE_4(SHORT_ON_TIME_FACTOR)           {31 range 0 - 31}
set PROFILE_4(SHORT_ON_TIME_MODE)             0
set PROFILE_4(SHORT_OFF_TIME_MODE)            0
set PROFILE_4(SHORT_PROFILE_ACTION_TYPE)      1
set PROFILE_4(UI_DESCRIPTION)  "Bei Bewegungserkennung toggelt wird der Schaltaktor in den entgegengesetzten Zustand versetzt."
set PROFILE_4(UI_TEMPLATE)    $PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)  4


# "Bewegung/Senkrecht"
set SUBSET_1(NAME)          "\${subset_1}"
set SUBSET_1(SUBSET_OPTION_VALUE)  1
set SUBSET_1(SHORT_CT_OFF)      0
set SUBSET_1(SHORT_CT_OFFDELAY)    0
set SUBSET_1(SHORT_CT_ON)      0
set SUBSET_1(SHORT_CT_ONDELAY)    0

# "Ruhe/Waagerecht"
set SUBSET_2(NAME)          "\${subset_2}"
set SUBSET_2(SUBSET_OPTION_VALUE)  2
set SUBSET_2(SHORT_CT_OFF)      2
set SUBSET_2(SHORT_CT_OFFDELAY)    2
set SUBSET_2(SHORT_CT_ON)      2
set SUBSET_2(SHORT_CT_ONDELAY)    2

# "Jede &Auml;nderung"
set SUBSET_3(NAME)          "\${subset_3}"
set SUBSET_3(SUBSET_OPTION_VALUE)  3
set SUBSET_3(SHORT_CT_OFF)      5
set SUBSET_3(SHORT_CT_OFFDELAY)    5
set SUBSET_3(SHORT_CT_ON)      5
set SUBSET_3(SHORT_CT_ONDELAY)    5


#set SUBSET_4(NAME)          "Bewegung-Ein/Ruhe-Aus"
set SUBSET_4(NAME)          "\${subset_4}"
set SUBSET_4(SUBSET_OPTION_VALUE)  4
set SUBSET_4(SHORT_CT_OFF)      0
set SUBSET_4(SHORT_CT_OFFDELAY)    0
set SUBSET_4(SHORT_CT_ON)      2
set SUBSET_4(SHORT_CT_ONDELAY)    2
set SUBSET_4(SHORT_JT_OFF)      1
set SUBSET_4(SHORT_JT_OFFDELAY)    3
set SUBSET_4(SHORT_JT_ON)      4
set SUBSET_4(SHORT_JT_ONDELAY)    6


#set SUBSET_5(NAME)          "Bewegung-Aus/Ruhe-Ein"
set SUBSET_5(NAME)          "\${subset_5}"
set SUBSET_5(SUBSET_OPTION_VALUE)  5
set SUBSET_5(SHORT_CT_OFF)      2
set SUBSET_5(SHORT_CT_OFFDELAY)    2
set SUBSET_5(SHORT_CT_ON)      1
set SUBSET_5(SHORT_CT_ONDELAY)    1
set SUBSET_5(SHORT_JT_OFF)      1
set SUBSET_5(SHORT_JT_OFFDELAY)    3
set SUBSET_5(SHORT_JT_ON)      4
set SUBSET_5(SHORT_JT_ONDELAY)    6


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
  append HTML_PARAMS(separate_$prn) "<tr><td>\${SWITCH_MODE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2 SUBSET_3} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"



#2
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${SWITCH_MODE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2 SUBSET_3} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${SWITCH_MODE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2 SUBSET_3} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#4
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"


  set pref 1

  append HTML_PARAMS(separate_$prn) "<tr><td>\${SWITCH_MODE}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_4 SUBSET_5} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  #incr pref
  #append HTML_PARAMS(separate_$prn) "<tr><td>\${SWITCH_MODE}</td><td>"
  #append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2 SUBSET_3} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  #append HTML_PARAMS(separate_$prn) "</td></tr>"

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}

constructor

