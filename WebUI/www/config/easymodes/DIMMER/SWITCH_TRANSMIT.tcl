#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]

set PROFILES_MAP(0)   "\${expert}"

set PROFILES_MAP(1)   "\${dimmer_on_off}"

set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION) "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)  "Expertenprofil"

# hier folgen die verschiedenen Profile

set PROFILE_1(SHORT_ACTION_TYPE)  1
set PROFILE_1(SHORT_COND_VALUE_HI)  180
set PROFILE_1(SHORT_COND_VALUE_LO)  50
set PROFILE_1(SHORT_CT_OFF)     0
set PROFILE_1(SHORT_CT_OFFDELAY)  0
set PROFILE_1(SHORT_CT_ON)      2
set PROFILE_1(SHORT_CT_ONDELAY)   2
set PROFILE_1(SHORT_CT_RAMPOFF)   0
set PROFILE_1(SHORT_CT_RAMPON)    0
set PROFILE_1(SHORT_DIM_MAX_LEVEL)  1.0
set PROFILE_1(SHORT_DIM_MIN_LEVEL)  0.0
set PROFILE_1(SHORT_DIM_STEP)   0.05
set PROFILE_1(SHORT_JT_OFF)     1
set PROFILE_1(SHORT_JT_OFFDELAY)  2
set PROFILE_1(SHORT_JT_ON)      4
set PROFILE_1(SHORT_JT_ONDELAY)   4
set PROFILE_1(SHORT_JT_RAMPOFF)   2
set PROFILE_1(SHORT_JT_RAMPON)    3
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
set PROFILE_1(SHORT_ON_TIME)    111600.0
set PROFILE_1(SHORT_ON_TIME_MODE) 0
set PROFILE_1(SHORT_RAMPOFF_TIME) 0.5
set PROFILE_1(SHORT_RAMPON_TIME)  0.5
set PROFILE_1(SHORT_RAMP_START_STEP)  0.05
set PROFILE_1(UI_DESCRIPTION) "Sendet der Wandthermostat den Heizbefehl, wird das Licht f&uuml;r die gew&uuml;nschte Zeit auf den festgelegten Helligkeitswert eingeschaltet."
set PROFILE_1(UI_TEMPLATE)  $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

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
# die Texte der Platzhalter einlesen - VIRTUAL_DIMMER = DIMMER
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

  append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPON_TIME}</td><td>"
  option RAMPTIME
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_RAMPON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_RAMPON_TIME 
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
  option LENGTH_OF_STAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
  EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 3
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn        SHORT_ON_LEVEL "onchange=\"ActivateFreePercent(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "<tr><td colspan=\"2\">$actor_off_hint</td></tr>"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}

constructor
