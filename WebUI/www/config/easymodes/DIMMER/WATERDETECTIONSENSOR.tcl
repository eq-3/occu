#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/DIMMER/mapping/WATERDETECTIONSENSOR_map.tcl]

set PROFILES_MAP(0) "\${expert}"
set PROFILES_MAP(1) "\${dimmer_on_off}"
set PROFILES_MAP(2) "\${change_signal}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)   "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)      "Expertenprofil"

# hier folgen die verschiedenen Profile
set PROFILE_1(LONG_ACTION_TYPE)   0
set PROFILE_1(SHORT_ACTION_TYPE)  1
set PROFILE_1(SHORT_COND_VALUE_HI)  180
set PROFILE_1(SHORT_COND_VALUE_LO)  50
set PROFILE_1(SHORT_CT_OFF)     0
set PROFILE_1(SHORT_CT_OFFDELAY)  0
set PROFILE_1(SHORT_CT_ON)      2
set PROFILE_1(SHORT_CT_ONDELAY)   2
set PROFILE_1(SHORT_CT_RAMPOFF)   0
set PROFILE_1(SHORT_CT_RAMPON)    2
set PROFILE_1(SHORT_DIM_MAX_LEVEL)  1.0
set PROFILE_1(SHORT_DIM_MIN_LEVEL)  0.0
set PROFILE_1(SHORT_DIM_STEP)   0.05
set PROFILE_1(SHORT_JT_OFF)     1
set PROFILE_1(SHORT_JT_OFFDELAY)  2
set PROFILE_1(SHORT_JT_ON)      4
set PROFILE_1(SHORT_JT_ONDELAY)   4
set PROFILE_1(SHORT_JT_RAMPOFF)   2
set PROFILE_1(SHORT_JT_RAMPON)    4
set PROFILE_1(SHORT_OFFDELAY_BLINK) 1
set PROFILE_1(SHORT_OFFDELAY_NEWTIME) 0.5
set PROFILE_1(SHORT_OFFDELAY_OLDTIME) 0.5
set PROFILE_1(SHORT_OFFDELAY_STEP)  0.05
set PROFILE_1(SHORT_OFFDELAY_TIME)  0.0
set PROFILE_1(SHORT_OFF_LEVEL)    0.0
set PROFILE_1(SHORT_OFF_TIME)   111600.0
set PROFILE_1(SHORT_OFF_TIME_MODE)  0
set PROFILE_1(SHORT_ONDELAY_MODE) 0
set PROFILE_1(SHORT_ONDELAY_TIME) 0.0
set PROFILE_1(SHORT_ON_LEVEL)   {1.0 1.005}
set PROFILE_1(SHORT_ON_LEVEL_PRIO)  0
set PROFILE_1(SHORT_ON_MIN_LEVEL) 0.1
set PROFILE_1(SHORT_ON_TIME)  111600.0
set PROFILE_1(SHORT_ON_TIME_MODE) 0
set PROFILE_1(SHORT_RAMPOFF_TIME) 0.5
set PROFILE_1(SHORT_RAMPON_TIME)  0.5
set PROFILE_1(SHORT_RAMP_START_STEP)  0.05
set PROFILE_1(UI_DESCRIPTION) "Bei Feuchte wird das Licht auf die eingestellte Helligkeit eingeschaltet und bei Trockenheit ausgeschaltet. Die Schaltzuordnung l&auml;sst sich auch umkehren."
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1


set PROFILE_2(LONG_ACTION_TYPE)   0
set PROFILE_2(SHORT_ACTION_TYPE)  1
set PROFILE_2(SHORT_COND_VALUE_HI)  180
set PROFILE_2(SHORT_COND_VALUE_LO)  50
set PROFILE_2(SHORT_CT_OFF)     0
set PROFILE_2(SHORT_CT_OFFDELAY)  0
set PROFILE_2(SHORT_CT_ON)      0
set PROFILE_2(SHORT_CT_ONDELAY)   0
set PROFILE_2(SHORT_CT_RAMPOFF)   0
set PROFILE_2(SHORT_CT_RAMPON)    0
set PROFILE_2(SHORT_DIM_MAX_LEVEL)  1.0
set PROFILE_2(SHORT_DIM_MIN_LEVEL)  0.0
set PROFILE_2(SHORT_DIM_STEP)   0.05
set PROFILE_2(SHORT_JT_OFF)     1
set PROFILE_2(SHORT_JT_OFFDELAY)  2
set PROFILE_2(SHORT_JT_ON)      2
set PROFILE_2(SHORT_JT_ONDELAY)   0
set PROFILE_2(SHORT_JT_RAMPOFF)   2
set PROFILE_2(SHORT_JT_RAMPON)    0
set PROFILE_2(SHORT_OFFDELAY_BLINK) 1
set PROFILE_2(SHORT_OFFDELAY_NEWTIME) 0.5
set PROFILE_2(SHORT_OFFDELAY_OLDTIME) 0.5
set PROFILE_2(SHORT_OFFDELAY_STEP)  0.05
set PROFILE_2(SHORT_OFFDELAY_TIME)  0.0
set PROFILE_2(SHORT_OFF_LEVEL)    0.0
set PROFILE_2(SHORT_OFF_TIME)   111600.0
set PROFILE_2(SHORT_OFF_TIME_MODE)  0
set PROFILE_2(SHORT_ONDELAY_MODE) 0
set PROFILE_2(SHORT_ONDELAY_TIME) 0.0
set PROFILE_2(SHORT_ON_LEVEL)   1.0
set PROFILE_2(SHORT_ON_LEVEL_PRIO)  0
set PROFILE_2(SHORT_ON_MIN_LEVEL) 0.1
set PROFILE_2(SHORT_ON_TIME)    111600.0
set PROFILE_2(SHORT_ON_TIME_MODE) 0
set PROFILE_2(SHORT_RAMPOFF_TIME) 0.5
set PROFILE_2(SHORT_RAMPON_TIME)  0.5
set PROFILE_2(SHORT_RAMP_START_STEP)  0.05
set PROFILE_2(UI_DESCRIPTION) "Bei &Auml;nderung der Feuchtigkeit wird das Licht f&uuml;r die eingestellte Zeit auf die eingestellte Helligkeit ein- oder aber, je nach Einstellung, ausgeschaltet."
set PROFILE_2(UI_TEMPLATE)  $PROFILE_2(UI_DESCRIPTION)  
set PROFILE_2(UI_HINT)  2

# hier folgen die eventuellen Subsets
#set SUBSET_1(NAME)         "Trocken-Ein/Feucht-Aus"
set SUBSET_1(NAME)          "\${subset_1}"
set SUBSET_1(SUBSET_OPTION_VALUE) 1
set SUBSET_1(SHORT_CT_OFF)      2
set SUBSET_1(SHORT_CT_OFFDELAY)   2
set SUBSET_1(SHORT_CT_ON)     0
set SUBSET_1(SHORT_CT_ONDELAY)    0
set SUBSET_1(SHORT_CT_RAMPOFF)    2
set SUBSET_1(SHORT_CT_RAMPON)   0

#set SUBSET_2(NAME)         "Trocken-Aus/Feucht-Ein"
set SUBSET_2(NAME)          "\${subset_2}"
set SUBSET_2(SUBSET_OPTION_VALUE) 2
set SUBSET_2(SHORT_CT_OFF)      0
set SUBSET_2(SHORT_CT_OFFDELAY)   0
set SUBSET_2(SHORT_CT_ON)     2
set SUBSET_2(SHORT_CT_ONDELAY)    2
set SUBSET_2(SHORT_CT_RAMPOFF)    0
set SUBSET_2(SHORT_CT_RAMPON)   2

#set SUBSET_3(NAME)         "Ein bei absoluter Trockenheit"
set SUBSET_3(NAME)          "\${subset_3}"
set SUBSET_3(SUBSET_OPTION_VALUE) 3
set SUBSET_3(SHORT_CT_OFF)      2
set SUBSET_3(SHORT_CT_OFFDELAY)   2
set SUBSET_3(SHORT_CT_ON)     2
set SUBSET_3(SHORT_CT_ONDELAY)    2
set SUBSET_3(SHORT_CT_RAMPOFF)    2
set SUBSET_3(SHORT_CT_RAMPON)   2
set SUBSET_3(SHORT_COND_VALUE_LO) 50
set SUBSET_3(SHORT_JT_OFF)      2
set SUBSET_3(SHORT_JT_OFFDELAY)   2
set SUBSET_3(SHORT_JT_ON)     2
set SUBSET_3(SHORT_JT_ONDELAY)    2
set SUBSET_3(SHORT_JT_RAMPOFF)    2
set SUBSET_3(SHORT_JT_RAMPON)   2
set SUBSET_3(SHORT_OFFDELAY_BLINK)  1

#set SUBSET_4(NAME)         "Ein bei Feuchte"
set SUBSET_4(NAME)          "\${subset_4}"
set SUBSET_4(SUBSET_OPTION_VALUE) 4
set SUBSET_4(SHORT_CT_OFF)      4
set SUBSET_4(SHORT_CT_OFFDELAY)   4
set SUBSET_4(SHORT_CT_ON)     4
set SUBSET_4(SHORT_CT_ONDELAY)    4
set SUBSET_4(SHORT_CT_RAMPOFF)    4
set SUBSET_4(SHORT_CT_RAMPON)   4
set SUBSET_4(SHORT_COND_VALUE_LO) 50
set SUBSET_4(SHORT_JT_OFF)      2
set SUBSET_4(SHORT_JT_OFFDELAY)   2
set SUBSET_4(SHORT_JT_ON)     2
set SUBSET_4(SHORT_JT_ONDELAY)    2
set SUBSET_4(SHORT_JT_RAMPOFF)    2
set SUBSET_4(SHORT_JT_RAMPON)   2
set SUBSET_4(SHORT_OFFDELAY_BLINK)  1

#set SUBSET_5(NAME)         "Ein bei Wasserstand 1.5mm"
set SUBSET_5(NAME)          "\${subset_5}"
set SUBSET_5(SUBSET_OPTION_VALUE) 5
set SUBSET_5(SHORT_CT_OFF)      1
set SUBSET_5(SHORT_CT_OFFDELAY)   1
set SUBSET_5(SHORT_CT_ON)     1
set SUBSET_5(SHORT_CT_ONDELAY)    1
set SUBSET_5(SHORT_CT_RAMPOFF)    1
set SUBSET_5(SHORT_CT_RAMPON)   1
set SUBSET_5(SHORT_COND_VALUE_LO) 50
set SUBSET_5(SHORT_JT_OFF)      2
set SUBSET_5(SHORT_JT_OFFDELAY)   2
set SUBSET_5(SHORT_JT_ON)     2
set SUBSET_5(SHORT_JT_ONDELAY)    2
set SUBSET_5(SHORT_JT_RAMPOFF)    2
set SUBSET_5(SHORT_JT_RAMPON)   2
set SUBSET_5(SHORT_OFFDELAY_BLINK)  1

#set SUBSET_6(NAME)         "Ein bei Feuchte oder Wasserstand 1.5mm"
set SUBSET_6(NAME)          "\${subset_6}"
set SUBSET_6(SUBSET_OPTION_VALUE) 6
set SUBSET_6(SHORT_CT_OFF)      0
set SUBSET_6(SHORT_CT_OFFDELAY)   0
set SUBSET_6(SHORT_CT_ON)     0
set SUBSET_6(SHORT_CT_ONDELAY)    0
set SUBSET_6(SHORT_CT_RAMPOFF)    0
set SUBSET_6(SHORT_CT_RAMPON)   0
set SUBSET_6(SHORT_COND_VALUE_LO) 50
set SUBSET_6(SHORT_JT_OFF)      2
set SUBSET_6(SHORT_JT_OFFDELAY)   2
set SUBSET_6(SHORT_JT_ON)     2
set SUBSET_6(SHORT_JT_ONDELAY)    2
set SUBSET_6(SHORT_JT_RAMPOFF)    2
set SUBSET_6(SHORT_JT_RAMPON)   2
set SUBSET_6(SHORT_OFFDELAY_BLINK)  1

#set SUBSET_7(NAME)         "Ein bei jeder Änderung"
set SUBSET_7(NAME)          "\${subset_7}"
set SUBSET_7(SUBSET_OPTION_VALUE) 7
set SUBSET_7(SHORT_CT_OFF)      5
set SUBSET_7(SHORT_CT_OFFDELAY)   5
set SUBSET_7(SHORT_CT_ON)     5
set SUBSET_7(SHORT_CT_ONDELAY)    5
set SUBSET_7(SHORT_CT_RAMPOFF)    5
set SUBSET_7(SHORT_CT_RAMPON)   5
set SUBSET_7(SHORT_COND_VALUE_LO) 150
set SUBSET_7{SHORT_JT_OFF)      2
set SUBSET_7(SHORT_JT_OFFDELAY)   2
set SUBSET_7(SHORT_JT_ON)     2
set SUBSET_7(SHORT_JT_ONDELAY)    2
set SUBSET_7(SHORT_JT_RAMPOFF)    2
set SUBSET_7(SHORT_JT_RAMPON)   2
set SUBSET_7(SHORT_OFFDELAY_BLINK)  1

#set SUBSET_8(NAME)         "Aus bei absoluter Trockenheit"
set SUBSET_8(NAME)          "\${subset_8}"
set SUBSET_8(SUBSET_OPTION_VALUE) 8
set SUBSET_8(SHORT_CT_OFF)      2
set SUBSET_8(SHORT_CT_OFFDELAY)   2
set SUBSET_8(SHORT_CT_ON)     2
set SUBSET_8(SHORT_CT_ONDELAY)    2
set SUBSET_8(SHORT_CT_RAMPOFF)    2
set SUBSET_8(SHORT_CT_RAMPON)   2
set SUBSET_8(SHORT_COND_VALUE_LO) 50
set SUBSET_8(SHORT_JT_OFF)      6
set SUBSET_8(SHORT_JT_OFFDELAY)   6
set SUBSET_8(SHORT_JT_ON)     6
set SUBSET_8(SHORT_JT_ONDELAY)    6
set SUBSET_8(SHORT_JT_RAMPOFF)    6
set SUBSET_8(SHORT_JT_RAMPON)   6
set SUBSET_8(SHORT_OFFDELAY_BLINK)  1

#set SUBSET_9(NAME)         "Aus bei Feuchte"
set SUBSET_9(NAME)          "\${subset_9}"
set SUBSET_9(SUBSET_OPTION_VALUE) 9
set SUBSET_9(SHORT_CT_OFF)      4
set SUBSET_9(SHORT_CT_OFFDELAY)   4
set SUBSET_9(SHORT_CT_ON)     4
set SUBSET_9(SHORT_CT_ONDELAY)    4
set SUBSET_9(SHORT_CT_RAMPOFF)    4
set SUBSET_9(SHORT_CT_RAMPON)   4
set SUBSET_9(SHORT_COND_VALUE_LO) 50
set SUBSET_9(SHORT_JT_OFF)      6
set SUBSET_9(SHORT_JT_OFFDELAY)   6
set SUBSET_9(SHORT_JT_ON)     6
set SUBSET_9(SHORT_JT_ONDELAY)    6
set SUBSET_9(SHORT_JT_RAMPOFF)    6
set SUBSET_9(SHORT_JT_RAMPON)   6
set SUBSET_9(SHORT_OFFDELAY_BLINK)  1

#set SUBSET_10(NAME)          "Aus bei Wasserstand 1.5mm"
set SUBSET_10(NAME)         "\${subset_10}"
set SUBSET_10(SUBSET_OPTION_VALUE)  10
set SUBSET_10(SHORT_CT_OFF)     1
set SUBSET_10(SHORT_CT_OFFDELAY)  1
set SUBSET_10(SHORT_CT_ON)      1
set SUBSET_10(SHORT_CT_ONDELAY)   1
set SUBSET_10(SHORT_CT_RAMPOFF)   1
set SUBSET_10(SHORT_CT_RAMPON)    1
set SUBSET_10(SHORT_COND_VALUE_LO)  50
set SUBSET_10(SHORT_JT_OFF)     6
set SUBSET_10(SHORT_JT_OFFDELAY)  6
set SUBSET_10(SHORT_JT_ON)      6
set SUBSET_10(SHORT_JT_ONDELAY)   6
set SUBSET_10(SHORT_JT_RAMPOFF)   6
set SUBSET_10(SHORT_JT_RAMPON)    6
set SUBSET_10(SHORT_OFFDELAY_BLINK) 1

#set SUBSET_11(NAME)          "Aus bei Feuchte oder Wasserstand 1.5mm"
set SUBSET_11(NAME)         "\${subset_11}"
set SUBSET_11(SUBSET_OPTION_VALUE)  11
set SUBSET_11(SHORT_CT_OFF)     0
set SUBSET_11(SHORT_CT_OFFDELAY)  0
set SUBSET_11(SHORT_CT_ON)      0
set SUBSET_11(SHORT_CT_ONDELAY)   0
set SUBSET_11(SHORT_CT_RAMPOFF)   0
set SUBSET_11(SHORT_CT_RAMPON)    0
set SUBSET_11(SHORT_COND_VALUE_LO)  50
set SUBSET_11(SHORT_JT_OFF)     6
set SUBSET_11(SHORT_JT_OFFDELAY)  6
set SUBSET_11(SHORT_JT_ON)      6
set SUBSET_11(SHORT_JT_ONDELAY)   6
set SUBSET_11(SHORT_JT_RAMPOFF)   6
set SUBSET_11(SHORT_JT_RAMPON)    6
set SUBSET_11(SHORT_OFFDELAY_BLINK) 1

#set SUBSET_12(NAME)          "Aus bei jeder Änderung"
set SUBSET_12(NAME)         "\${subset_12}"
set SUBSET_12(SUBSET_OPTION_VALUE)  12
set SUBSET_12(SHORT_CT_OFF)     5
set SUBSET_12(SHORT_CT_OFFDELAY)  5
set SUBSET_12(SHORT_CT_ON)      5
set SUBSET_12(SHORT_CT_ONDELAY)   5
set SUBSET_12(SHORT_CT_RAMPOFF)   5
set SUBSET_12(SHORT_CT_RAMPON)    5
set SUBSET_12(SHORT_COND_VALUE_LO)  150
set SUBSET_12(SHORT_JT_OFF)     6
set SUBSET_12(SHORT_JT_OFFDELAY)  6
set SUBSET_12(SHORT_JT_ON)      6
set SUBSET_12(SHORT_JT_ONDELAY)   6
set SUBSET_12(SHORT_JT_RAMPOFF)   6
set SUBSET_12(SHORT_JT_RAMPON)    6
set SUBSET_12(SHORT_OFFDELAY_BLINK) 1

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global dev_descr_sender dev_descr_receiver  
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

# feststellen, ob der Aktorkanal aktiv ist
  global url receiver_address 
  array set dev_descr [xmlrpc $url getParamset [list string $receiver_address] MASTER]
  set actor_off_hint ""
  set channel [lindex [split $address  ":"] 1]
  
  catch {
    if {$channel > 99} {
      if {[format {%5.3f} $dev_descr(LOGIC_COMBINATION)] == 0}  {
        set actor_off_hint "<div class=\"attention\">\${actor_nonactive}&nbsp;$receiver_address!</div>"
      } 
    }
  }

  # die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">
    var type = \"DIMMER\"
    type = ('$dev_descr_receiver(TYPE)' == \"VIRTUAL_DIMMER\") ? \"DIMMER\" : type ;
    getLangInfo('$dev_descr_sender(TYPE)', type);
  </script>"

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

  append HTML_PARAMS(separate_$prn) "<tr><td>\${SWITCH_DIR}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  
  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${DEF_HUMIDITY}</td><td>"
  array_clear options
  set options(50) "\${moisty}"
  set options(150) "\${watery}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_COND_VALUE_LO separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_COND_VALUE_LO]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 3
  append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPON_TIME}</td><td>"
  option RAMPTIME
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 4
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 5
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_TIME}</td><td>"
  incr pref ;# 6
  array_clear options
  option DELAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFFDELAY_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 7
  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_BLINK}</td><td>"
  array_clear options
  set options(0) "\${off}"
  set options(1) "\${on}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_BLINK separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_BLINK]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  
  incr pref ;# 8
  append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPOFF_TIME}</td><td>"
  option RAMPTIME
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPOFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPOFF_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "<tr><td colspan=\"2\">$actor_off_hint</td></tr>"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#2
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tbody><tr><td>\${CHANGE_SIGNAL}&nbsp;&nbsp;</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_3 SUBSET_4 SUBSET_5 SUBSET_6 SUBSET_7 SUBSET_8 SUBSET_9 SUBSET_10 SUBSET_11 SUBSET_12 } subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn "onchange=\"WDS_DisableOnTime(\$('separate_${special_input_id}_$prn\_$pref'));\""]
  append HTML_PARAMS(separate_$prn) "</td></tr></tbody>"

  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tbody class=\"ProfileTbl\" id=\"on_time\" style=\"visibility:hidden\">"
  append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPON_TIME}</td><td>"
  option RAMPTIME
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_RAMPON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  
  incr pref ;# 3
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 4
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "<tr><td colspan=\"2\">$actor_off_hint</td></tr>"
  append HTML_PARAMS(separate_$prn) "</tbody></table></textarea></div>"

  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">WDS_DisableOnTime(\$('separate_${special_input_id}_$prn\_1'));</script>"
}

constructor
