#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
# source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options_hmip.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]

set PROFILES_MAP(0)  "\${expert}"
set PROFILES_MAP(1)  "\${switch_on}"
set PROFILES_MAP(2)  "\${switch_off}"
set PROFILES_MAP(3)  "\${switch_on_off}"
#set PROFILES_MAP(4)  "\${switch_shortOn_longOff}"
#set PROFILES_MAP(5)  "\${switch_shortOff_longOn}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)    "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)      "Expertenprofil"

set PROFILE_1(LONG_COND_VALUE_HI)           150
set PROFILE_1(LONG_COND_VALUE_LO)            50
set PROFILE_1(LONG_CT_OFF)                    0
set PROFILE_1(LONG_CT_OFFDELAY)               0
set PROFILE_1(LONG_CT_ON)                     0
set PROFILE_1(LONG_CT_ONDELAY)                0
set PROFILE_1(LONG_JT_OFF)                    {1 3}
set PROFILE_1(LONG_JT_OFFDELAY)               3
set PROFILE_1(LONG_JT_ON)                     3
set PROFILE_1(LONG_JT_ONDELAY)                3
set PROFILE_1(LONG_MULTIEXECUTE)              0
set PROFILE_1(LONG_OFFDELAY_TIME_BASE)        0
set PROFILE_1(LONG_OFFDELAY_TIME_FACTOR)      0
set PROFILE_1(LONG_OFF_TIME_BASE)             7
set PROFILE_1(LONG_OFF_TIME_FACTOR)          31
set PROFILE_1(LONG_OFF_TIME_MODE)             0
set PROFILE_1(LONG_ONDELAY_TIME_BASE)         {0 range 0 - 7}
set PROFILE_1(LONG_ONDELAY_TIME_FACTOR)       {0 range 0 - 31}
set PROFILE_1(LONG_ON_TIME_BASE)              {7 range 0 - 7}
set PROFILE_1(LONG_ON_TIME_FACTOR)            {31 range 0 - 31}
set PROFILE_1(LONG_ON_TIME_MODE)              0
set PROFILE_1(LONG_PROFILE_ACTION_TYPE)       1
set PROFILE_1(SHORT_COND_VALUE_HI)          150
set PROFILE_1(SHORT_COND_VALUE_LO)           50
set PROFILE_1(SHORT_CT_OFF)                   0
set PROFILE_1(SHORT_CT_OFFDELAY)              0
set PROFILE_1(SHORT_CT_ON)                    0
set PROFILE_1(SHORT_CT_ONDELAY)               0
set PROFILE_1(SHORT_JT_OFF)                   {1 3}
set PROFILE_1(SHORT_JT_OFFDELAY)              3
set PROFILE_1(SHORT_JT_ON)                    3
set PROFILE_1(SHORT_JT_ONDELAY)               3
set PROFILE_1(SHORT_MULTIEXECUTE)             0
set PROFILE_1(SHORT_OFFDELAY_TIME_BASE)       0
set PROFILE_1(SHORT_OFFDELAY_TIME_FACTOR)     0
set PROFILE_1(SHORT_OFF_TIME_BASE)            7
set PROFILE_1(SHORT_OFF_TIME_FACTOR)         31
set PROFILE_1(SHORT_OFF_TIME_MODE)            0
set PROFILE_1(SHORT_ONDELAY_TIME_BASE)        {0 range 0 - 7}
set PROFILE_1(SHORT_ONDELAY_TIME_FACTOR)      {0 range 0 - 31}
set PROFILE_1(SHORT_ON_TIME_BASE)             {7 range 0 - 7}
set PROFILE_1(SHORT_ON_TIME_FACTOR)           {31 range 0 - 31}
set PROFILE_1(SHORT_ON_TIME_MODE)             0
set PROFILE_1(SHORT_PROFILE_ACTION_TYPE)      1
set PROFILE_1(UI_DESCRIPTION)  "Mit einem kurzen oder langen Tastendruck wird der Schalter f&uuml;r die eingestellte Zeit eingeschaltet. Ist eine Einschaltverz&ouml;gerungszeit eingestellt, so wird der Schalter erst nach Ablauf dieser Zeit eingeschaltet."
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

set PROFILE_2(LONG_COND_VALUE_HI)           150
set PROFILE_2(LONG_COND_VALUE_LO)            50
set PROFILE_2(LONG_CT_OFF)                    0
set PROFILE_2(LONG_CT_OFFDELAY)               0
set PROFILE_2(LONG_CT_ON)                     0
set PROFILE_2(LONG_CT_ONDELAY)                0
set PROFILE_2(LONG_JT_OFF)                    6
set PROFILE_2(LONG_JT_OFFDELAY)               6
set PROFILE_2(LONG_JT_ON)                     6
set PROFILE_2(LONG_JT_ONDELAY)                6
set PROFILE_2(LONG_MULTIEXECUTE)              {0 6}
set PROFILE_2(LONG_OFFDELAY_TIME_BASE)        {0 range 0 - 7}
set PROFILE_2(LONG_OFFDELAY_TIME_FACTOR)      {0 range 0 - 31}
set PROFILE_2(LONG_OFF_TIME_BASE)             {7 range 0 - 7}
set PROFILE_2(LONG_OFF_TIME_FACTOR)           {31 range 0 - 7}
set PROFILE_2(LONG_OFF_TIME_MODE)             0
set PROFILE_2(LONG_ONDELAY_TIME_BASE)         0
set PROFILE_2(LONG_ONDELAY_TIME_FACTOR)       0
set PROFILE_2(LONG_ON_TIME_BASE)              7
set PROFILE_2(LONG_ON_TIME_FACTOR)            31
set PROFILE_2(LONG_ON_TIME_MODE)              0
set PROFILE_2(LONG_PROFILE_ACTION_TYPE)       1
set PROFILE_2(SHORT_COND_VALUE_HI)          150
set PROFILE_2(SHORT_COND_VALUE_LO)           50
set PROFILE_2(SHORT_CT_OFF)                   0
set PROFILE_2(SHORT_CT_OFFDELAY)              0
set PROFILE_2(SHORT_CT_ON)                    0
set PROFILE_2(SHORT_CT_ONDELAY)               0
set PROFILE_2(SHORT_JT_OFF)                   6
set PROFILE_2(SHORT_JT_OFFDELAY)              6
set PROFILE_2(SHORT_JT_ON)                    6
set PROFILE_2(SHORT_JT_ONDELAY)               6
set PROFILE_2(SHORT_MULTIEXECUTE)             0
set PROFILE_2(SHORT_OFFDELAY_TIME_BASE)       {0 range 0 - 7}
set PROFILE_2(SHORT_OFFDELAY_TIME_FACTOR)     {0 range 0 - 31}
set PROFILE_2(SHORT_OFF_TIME_BASE)            {7 range 0 - 7}
set PROFILE_2(SHORT_OFF_TIME_FACTOR)          {31 range 0 - 31}
set PROFILE_2(SHORT_OFF_TIME_MODE)            0
set PROFILE_2(SHORT_ONDELAY_TIME_BASE)        0
set PROFILE_2(SHORT_ONDELAY_TIME_FACTOR)      0
set PROFILE_2(SHORT_ON_TIME_BASE)             7
set PROFILE_2(SHORT_ON_TIME_FACTOR)           31
set PROFILE_2(SHORT_ON_TIME_MODE)             0
set PROFILE_2(SHORT_PROFILE_ACTION_TYPE)      1
set PROFILE_2(UI_DESCRIPTION)  "Mit einem kurzen oder langen Tastendruck wird der Schalter f&uuml;r die eingestellte Zeit eingeschaltet. Ist eine Einschaltverz&ouml;gerungszeit eingestellt, so wird der Schalter erst nach Ablauf dieser Zeit eingeschaltet."
set PROFILE_2(UI_TEMPLATE)    $PROFILE_2(UI_DESCRIPTION)  
set PROFILE_2(UI_HINT)  2

set PROFILE_3(LONG_COND_VALUE_HI)           150
set PROFILE_3(LONG_COND_VALUE_LO)            50
set PROFILE_3(LONG_CT_OFF)                    0
set PROFILE_3(LONG_CT_OFFDELAY)               0
set PROFILE_3(LONG_CT_ON)                     0
set PROFILE_3(LONG_CT_ONDELAY)                0
set PROFILE_3(LONG_JT_OFF)                    1
set PROFILE_3(LONG_JT_OFFDELAY)               6
set PROFILE_3(LONG_JT_ON)                     4
set PROFILE_3(LONG_JT_ONDELAY)                3
set PROFILE_3(LONG_MULTIEXECUTE)              0
set PROFILE_3(LONG_OFFDELAY_TIME_BASE)        0
set PROFILE_3(LONG_OFFDELAY_TIME_FACTOR)      0
set PROFILE_3(LONG_OFF_TIME_BASE)             7
set PROFILE_3(LONG_OFF_TIME_FACTOR)          31
set PROFILE_3(LONG_OFF_TIME_MODE)             0
set PROFILE_3(LONG_ONDELAY_TIME_BASE)         {0 range 0 - 7}
set PROFILE_3(LONG_ONDELAY_TIME_FACTOR)       {0 range 0 - 31}
set PROFILE_3(LONG_ON_TIME_BASE)              {7 range 0 - 7}
set PROFILE_3(LONG_ON_TIME_FACTOR)            {31 range 0 - 31}
set PROFILE_3(LONG_ON_TIME_MODE)              0
set PROFILE_3(LONG_PROFILE_ACTION_TYPE)       1
set PROFILE_3(SHORT_COND_VALUE_HI)          150
set PROFILE_3(SHORT_COND_VALUE_LO)           50
set PROFILE_3(SHORT_CT_OFF)                   0
set PROFILE_3(SHORT_CT_OFFDELAY)              0
set PROFILE_3(SHORT_CT_ON)                    0
set PROFILE_3(SHORT_CT_ONDELAY)               0
set PROFILE_3(SHORT_JT_OFF)                   1
set PROFILE_3(SHORT_JT_OFFDELAY)              6
set PROFILE_3(SHORT_JT_ON)                    4
set PROFILE_3(SHORT_JT_ONDELAY)               3
set PROFILE_3(SHORT_MULTIEXECUTE)             0
set PROFILE_3(SHORT_OFFDELAY_TIME_BASE)       0
set PROFILE_3(SHORT_OFFDELAY_TIME_FACTOR)     0
set PROFILE_3(SHORT_OFF_TIME_BASE)            7
set PROFILE_3(SHORT_OFF_TIME_FACTOR)         31
set PROFILE_3(SHORT_OFF_TIME_MODE)            0
set PROFILE_3(SHORT_ONDELAY_TIME_BASE)        {0 range 0 - 7}
set PROFILE_3(SHORT_ONDELAY_TIME_FACTOR)      {0 range 0 - 31}
set PROFILE_3(SHORT_ON_TIME_BASE)             {7 range 0 - 7}
set PROFILE_3(SHORT_ON_TIME_FACTOR)           {31 range 0 - 31}
set PROFILE_3(SHORT_ON_TIME_MODE)             0
set PROFILE_3(SHORT_PROFILE_ACTION_TYPE)      1
set PROFILE_3(UI_DESCRIPTION)  "Mit einem kurzen oder langen Tastendruck wird der Schalter f&uuml;r die eingestellte Zeit eingeschaltet. Ist eine Einschaltverz&ouml;gerungszeit eingestellt, so wird der Schalter erst nach Ablauf dieser Zeit eingeschaltet."
set PROFILE_3(UI_TEMPLATE)    $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3

set PROFILE_4(LONG_COND_VALUE_HI)           150
set PROFILE_4(LONG_COND_VALUE_LO)            50
set PROFILE_4(LONG_CT_OFF)                    0
set PROFILE_4(LONG_CT_OFFDELAY)               0
set PROFILE_4(LONG_CT_ON)                     0
set PROFILE_4(LONG_JT_OFF)                    6
set PROFILE_4(LONG_JT_OFFDELAY)               6
set PROFILE_4(LONG_JT_ON)                     4
set PROFILE_4(LONG_JT_ONDELAY)                6
set PROFILE_4(LONG_MULTIEXECUTE)              0
set PROFILE_4(LONG_OFFDELAY_TIME_BASE)        {0 range 0 - 7}
set PROFILE_4(LONG_OFFDELAY_TIME_FACTOR)      {0 range 0 - 31}
set PROFILE_4(LONG_OFF_TIME_BASE)             {7 range 0 - 7}
set PROFILE_4(LONG_OFF_TIME_FACTOR)           {31 range 0 - 31}
set PROFILE_4(LONG_OFF_TIME_MODE)             0
set PROFILE_4(LONG_ONDELAY_TIME_BASE)         {0 range 0 - 7}
set PROFILE_4(LONG_ONDELAY_TIME_FACTOR)       {0 range 0 - 31}
set PROFILE_4(LONG_ON_TIME_BASE)              {7 range 0 - 7}
set PROFILE_4(LONG_ON_TIME_FACTOR)            {31 range 0 - 31}
set PROFILE_4(LONG_ON_TIME_MODE)              0
set PROFILE_4(LONG_PROFILE_ACTION_TYPE)       1
set PROFILE_4(SHORT_COND_VALUE_HI)          150
set PROFILE_4(SHORT_COND_VALUE_LO)           50
set PROFILE_4(SHORT_CT_OFF)                   0
set PROFILE_4(SHORT_CT_OFFDELAY)              0
set PROFILE_4(SHORT_CT_ON)                    0
set PROFILE_4(SHORT_CT_ONDELAY)               0
set PROFILE_4(SHORT_JT_OFF)                   1
set PROFILE_4(SHORT_JT_OFFDELAY)              3
set PROFILE_4(SHORT_JT_ON)                    3
set PROFILE_4(SHORT_JT_ONDELAY)               3
set PROFILE_4(SHORT_MULTIEXECUTE)             0
set PROFILE_4(SHORT_OFFDELAY_TIME_BASE)       0
set PROFILE_4(SHORT_OFFDELAY_TIME_FACTOR)     0
set PROFILE_4(SHORT_OFF_TIME_BASE)            7
set PROFILE_4(SHORT_OFF_TIME_FACTOR)         31
set PROFILE_4(SHORT_OFF_TIME_MODE)            0
set PROFILE_4(SHORT_ONDELAY_TIME_BASE)        {0 range 0 - 7}
set PROFILE_4(SHORT_ONDELAY_TIME_FACTOR)      {0 range 0 - 31}
set PROFILE_4(SHORT_ON_TIME_BASE)             {7 range 0 - 7}
set PROFILE_4(SHORT_ON_TIME_FACTOR)           {31 range 0 - 31}
set PROFILE_4(SHORT_ON_TIME_MODE)             0
set PROFILE_4(SHORT_PROFILE_ACTION_TYPE)      1
set PROFILE_4(UI_DESCRIPTION)  "Mit einem kurzen oder langen Tastendruck wird der Schalter f&uuml;r die eingestellte Zeit eingeschaltet. Ist eine Einschaltverz&ouml;gerungszeit eingestellt, so wird der Schalter erst nach Ablauf dieser Zeit eingeschaltet."
set PROFILE_4(UI_TEMPLATE)    $PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)  4

set PROFILE_5(LONG_COND_VALUE_HI)           150
set PROFILE_5(LONG_COND_VALUE_LO)            50
set PROFILE_5(LONG_CT_OFF)                    0
set PROFILE_5(LONG_CT_OFFDELAY)               0
set PROFILE_5(LONG_CT_ON)                     0
set PROFILE_5(LONG_JT_OFF)                    1
set PROFILE_5(LONG_JT_OFFDELAY)               3
set PROFILE_5(LONG_JT_ON)                     3
set PROFILE_5(LONG_JT_ONDELAY)                3
set PROFILE_5(LONG_MULTIEXECUTE)              0
set PROFILE_5(LONG_OFFDELAY_TIME_BASE)        0
set PROFILE_5(LONG_OFFDELAY_TIME_FACTOR)      0
set PROFILE_5(LONG_OFF_TIME_BASE)             7
set PROFILE_5(LONG_OFF_TIME_FACTOR)          31
set PROFILE_5(LONG_OFF_TIME_MODE)             0
set PROFILE_5(LONG_ONDELAY_TIME_BASE)         {0 range 0 - 7}
set PROFILE_5(LONG_ONDELAY_TIME_FACTOR)       {0 range 0 - 31}
set PROFILE_5(LONG_ON_TIME_BASE)              {7 range 0 - 7}
set PROFILE_5(LONG_ON_TIME_FACTOR)            {31 range 0 - 31}
set PROFILE_5(LONG_ON_TIME_MODE)              0
set PROFILE_5(LONG_PROFILE_ACTION_TYPE)       1
set PROFILE_5(SHORT_COND_VALUE_HI)          150
set PROFILE_5(SHORT_COND_VALUE_LO)           50
set PROFILE_5(SHORT_CT_OFF)                   0
set PROFILE_5(SHORT_CT_OFFDELAY)              0
set PROFILE_5(SHORT_CT_ON)                    0
set PROFILE_5(SHORT_CT_ONDELAY)               0
set PROFILE_5(SHORT_JT_OFF)                   6
set PROFILE_5(SHORT_JT_OFFDELAY)              6
set PROFILE_5(SHORT_JT_ON)                    4
set PROFILE_5(SHORT_JT_ONDELAY)               6
set PROFILE_5(SHORT_MULTIEXECUTE)             0
set PROFILE_5(SHORT_OFFDELAY_TIME_BASE)       {0 range 0 - 7}
set PROFILE_5(SHORT_OFFDELAY_TIME_FACTOR)     {0 range 0 - 31}
set PROFILE_5(SHORT_OFF_TIME_BASE)            {7 range 0 - 7}
set PROFILE_5(SHORT_OFF_TIME_FACTOR)          {31 range 0 - 31}
set PROFILE_5(SHORT_OFF_TIME_MODE)            0
set PROFILE_5(SHORT_ONDELAY_TIME_BASE)        {0 range 0 - 7}
set PROFILE_5(SHORT_ONDELAY_TIME_FACTOR)      {0 range 0 - 31}
set PROFILE_5(SHORT_ON_TIME_BASE)             {7 range 0 - 7}
set PROFILE_5(SHORT_ON_TIME_FACTOR)           {31 range 0 - 31}
set PROFILE_5(SHORT_ON_TIME_MODE)             0
set PROFILE_5(SHORT_PROFILE_ACTION_TYPE)      1
set PROFILE_5(UI_DESCRIPTION)  "Mit einem kurzen oder langen Tastendruck wird der Schalter f&uuml;r die eingestellte Zeit eingeschaltet. Ist eine Einschaltverz&ouml;gerungszeit eingestellt, so wird der Schalter erst nach Ablauf dieser Zeit eingeschaltet."
set PROFILE_5(UI_TEMPLATE)    $PROFILE_5(UI_DESCRIPTION)
set PROFILE_5(UI_HINT)  5

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
  
#  die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
  puts "<script type=\"text/javascript\">getLangInfo_Special('HmIP_DEVICES.txt');</script>"

  set prn 0
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

#1
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${ONDELAY_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "delay"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  # *** SHORT KEYPRESS ***
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

  # *** LONG KEYPRESS ***
  append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"
  incr pref

  # ****
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${ONDELAY_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "delay"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${ONDELAY_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_ONDELAY_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_ONDELAY_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${ONDELAY_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_ONDELAY_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps LONG_ONDELAY_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"

  incr pref

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${ON_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "timeOnOff"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${ON_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_ON_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_ON_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${ON_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_ON_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps LONG_ON_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  # ****

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#2
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${OFFDELAY_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "delay"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  # *** SHORT KEYPRESS ***
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

  # *** LONG KEYPRESS ***
  append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"
  incr pref

  # ****
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${OFFDELAY_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "delay"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${OFFDELAY_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_OFFDELAY_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_OFFDELAY_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${OFFDELAY_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_OFFDELAY_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps LONG_OFFDELAY_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"
  incr pref

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${OFF_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "timeOnOff"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${OFF_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_OFF_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_OFF_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${OFF_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_OFF_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps LONG_OFF_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  # ****

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${ONDELAY_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "delay"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  # *** SHORT KEYPRESS ***
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

  # *** LONG KEYPRESS ***
    append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${ONDELAY_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "delay"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${ONDELAY_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_ONDELAY_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_ONDELAY_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayOption($prn, $pref, \"$special_input_id\");}, 100)</script>"


  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${ONDELAY_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_ONDELAY_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps LONG_ONDELAY_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${ON_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "timeOnOff"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${ON_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_ON_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_ON_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${ON_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_ON_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps LONG_ON_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${OFFDELAY_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "delay"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${OFFDELAY_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_OFFDELAY_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_OFFDELAY_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayOption($prn, $pref, \"$special_input_id\");}, 100)</script>"


  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${OFFDELAY_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_OFFDELAY_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps LONG_OFFDELAY_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${OFF_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "timeOnOff"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${OFF_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_OFF_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_OFF_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${OFF_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_OFF_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps LONG_OFF_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

set comment {
#4
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

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

  # *** LONG KEYPRESS ***
  append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${OFFDELAY_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "delay"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${OFFDELAY_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_OFFDELAY_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_OFFDELAY_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${OFFDELAY_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_OFFDELAY_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps LONG_OFFDELAY_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${OFF_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "timeOnOff"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${OFF_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_OFF_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_OFF_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${OFF_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_OFF_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps LONG_OFF_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#5
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

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

  append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr>\${description_longkey}</td>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${ONDELAY_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "delay"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${ONDELAY_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_ONDELAY_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_ONDELAY_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${ONDELAY_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_ONDELAY_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps LONG_ONDELAY_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<tr id=\"space_$prn\_$pref\" class=\"hidden\"><td><br/></td></tr>"

  incr pref

  append HTML_PARAMS(separate_$prn) "<tr>"
  append HTML_PARAMS(separate_$prn) "<td>\${ON_TIME_FACTOR_DESCR}</td>"
  append HTML_PARAMS(separate_$prn) [getComboBox $prn $pref $special_input_id "timeOnOff"]
  append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\"><td>\${ON_TIME_BASE}</td><td>"
  option TIMEBASE_LONG
  append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_ON_TIME_BASE separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_ON_TIME_BASE]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">setTimeout(function() {setCurrentTimeOption($prn, $pref, \"$special_input_id\");}, 100)</script>"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr id=\"timeFactor\_$prn\_$pref\" class=\"hidden\"><td>\${ON_TIME_FACTOR}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_ON_TIME_FACTOR separate_${special_input_id}_$prn\_$pref ps LONG_ON_TIME_FACTOR ]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
}
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}

constructor
