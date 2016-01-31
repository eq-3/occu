#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options_md.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/DIMMER/mapping/MOTION_DETECTOR_map.tcl]


set PROFILES_MAP(0) "\${expert}"
set PROFILES_MAP(1) "\${dimmer_on} / \${light_stairway}" 
set PROFILES_MAP(2) "\${no_action}" 


set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION) "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)    "Expertenprofil"

# hier folgen die verschiedenen Profile

set PROFILE_1(SHORT_CT_RAMPOFF)   2
set PROFILE_1(SHORT_CT_RAMPON)    2
set PROFILE_1(SHORT_CT_OFFDELAY)  2
set PROFILE_1(SHORT_CT_ONDELAY)   2
set PROFILE_1(SHORT_CT_OFF)     2
set PROFILE_1(SHORT_CT_ON)      2
set PROFILE_1(SHORT_COND_VALUE_LO)  {255 range 0 - 255}
set PROFILE_1(SHORT_COND_VALUE_HI)  {100 range 0 - 255}
set PROFILE_1(SHORT_ON_TIME)    {300.0 range 0.0 - 108000.0}
set PROFILE_1(SHORT_OFFDELAY_TIME)  {0.0 range 0.0 - 111600.0}
set PROFILE_1(SHORT_ON_TIME_MODE) {1 0}
set PROFILE_1(SHORT_JT_OFF)     1
set PROFILE_1(SHORT_JT_ON)      2
set PROFILE_1(SHORT_JT_OFFDELAY)  2
set PROFILE_1(SHORT_JT_ONDELAY)   2
set PROFILE_1(SHORT_JT_RAMPOFF)   2
set PROFILE_1(SHORT_JT_RAMPON)    0
set PROFILE_1(SHORT_OFFDELAY_BLINK) {1 0}
set PROFILE_1(SHORT_ON_LEVEL)   {1.0 range 0.0 - 1.005}
set PROFILE_1(SHORT_RAMPON_TIME)  {0.5 range 0.0 - 111600}
set PROFILE_1(SHORT_RAMPOFF_TIME) {0.5 range 0.0 - 111600}
set PROFILE_1(UI_DESCRIPTION) "Beim Ausl&ouml;sen des Sensors wird das Licht mindestens f&uuml;r die eingestellte Zeit eingeschaltet.&nbsp;"
set PROFILE_1(UI_TEMPLATE)  $PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)  1

set PROFILE_2(SHORT_JT_OFF)     0
set PROFILE_2(SHORT_JT_ON)      0
set PROFILE_2(SHORT_JT_OFFDELAY)  0
set PROFILE_2(SHORT_JT_ONDELAY)   0
set PROFILE_2(SHORT_JT_RAMPOFF)   0
set PROFILE_2(SHORT_JT_RAMPON)    0
set PROFILE_2(UI_DESCRIPTION) "Der Bewegungsmelder ist au&szlig;er Betrieb."
set PROFILE_2(UI_TEMPLATE)  $PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)  2


# hier folgen die eventuellen Subsets
proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global url sender_address receiver_address dev_descr_receiver dev_descr_sender
  set sender_addr $sender_address
  puts "<input type=\"text\" id=\"dev_descr_sender_tmp\" value=\"$dev_descr_sender(TYPE)-$sender_addr\" style=\"display:none\">"  

  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps      
  upvar $pps_descr    ps_descr
  
  array set dev_ps [xmlrpc $url getParamset $sender_address MASTER]
  set min_interval 4
  
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
  set channel_off_hint ""
  set channel [lindex [split $address  ":"] 1]
  
  catch {
    if {$channel > 99} {
      if {[format {%5.3f} $dev_descr(LOGIC_COMBINATION)] == 0}  {
        set channel_off_hint "<div class=\"attention\">\${actor_nonactive}&nbsp;$receiver_address!</div>"
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
  set Verweildauer "Art der Verweildauer"
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME_MODE}</td><td>"
  array_clear options 
  set options(0) "\${absolute}"
  set options(1) "\${minimal}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME_MODE|LONG_ON_TIME_MODE separate_${special_input_id}_$prn\_1 PROFILE_$prn SHORT_ON_TIME_MODE "onchange=\"MD_checkPNAME('separate_${special_input_id}_1_1','md_verweildauer_1_2', 'separate_${special_input_id}_1_2');\""]
  append HTML_PARAMS(separate_$prn) "&nbsp<input type=\"button\" value=\"\${help}\" onclick=\"MD_link_help();\">"

  # absolut_minimal enthaelt den derzeitigen Modus der Verweildauer
  # 0 entspricht 'absolut', 1 entspricht 'minimal'
  set absolut_minimal  $ps(SHORT_ON_TIME_MODE)
  # Mindestsendeabstand min_interval = Wert 0, 1, 2, 3,4 >>> 0 = 15s, 1 = 30s, 2 = 60s, 3 = 120s, 4 = 240s
  set min_interval $dev_ps(MIN_INTERVAL)
  puts "<input type=\"hidden\" id=\"md_min_interval_$prn\_1\" value=\"$min_interval,$absolut_minimal\">"
  
  append HTML_PARAMS(separate_$prn) "<tr><td><span class=\"translated\" id=\"md_verweildauer_$prn\_2\">&nbsp;</span></td><td>"
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">MD_checkPNAME('separate_${special_input_id}_$prn\_1','md_verweildauer_$prn\_2', 'separate_${special_input_id}_$prn\_2');</script>"

  if {$min_interval == 4} then {option LENGTH_OF_STAY_classic} else {option LENGTH_OF_STAY_dynamic_$min_interval} 

  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_2 PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),2);\""]
  EnterTime_h_m_s $prn 2 ${special_input_id} ps_descr SHORT_ON_TIME
  append HTML_PARAMS(separate_$prn) "<tr><td colspan=\"2\"><span class=\"CLASS20100\" id=\"separate_${special_input_id}_$prn\_2_hint0\">&nbsp</span></td></tr>" 
  append HTML_PARAMS(separate_$prn) "<tr><td colspan=\"2\"><span class=\"CLASS20100\" id=\"separate_${special_input_id}_$prn\_2_hint1\">&nbsp</span></td></tr>" 
  
  append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPON_TIME}</td><td>"
  option RAMPTIME
  append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_RAMPON_TIME|SHORT_RAMPON_TIME separate_${special_input_id}_$prn\_3 PROFILE_$prn SHORT_RAMPON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),3);\""]
  EnterTime_h_m_s $prn 3 ${special_input_id} ps_descr SHORT_RAMPON_TIME 
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL|LONG_ON_LEVEL separate_${special_input_id}_$prn\_4 PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent(\$('${special_input_id}_profiles'),4);\""]
  EnterPercent $prn 4 ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_TIME}</td><td>"
  option DELAY
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME|LONG_OFFDELAY_TIME separate_${special_input_id}_$prn\_5 PROFILE_$prn SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),5);\""]
  EnterTime_h_m_s $prn 5 ${special_input_id} ps_descr LONG_OFFDELAY_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_BLINK}</td><td>"
  array_clear options
  set options(0)    "\${off}"
  set options(1)    "\${on}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_BLINK|LONG_OFFDELAY_BLINK separate_${special_input_id}_$prn\_6 PROFILE_$prn SHORT_OFFDELAY_BLINK]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPOFF_TIME}</td><td>"
  option RAMPTIME
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPOFF_TIME|LONG_RAMPOFF_TIME separate_${special_input_id}_$prn\_7 PROFILE_$prn SHORT_RAMPOFF_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),7);\""]
  EnterTime_h_m_s $prn 7 ${special_input_id} ps_descr SHORT_RAMPOFF_TIME
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  
  append HTML_PARAMS(separate_$prn) "<tr><td colspan=\"2\">$channel_off_hint</td></tr>"
  append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr></td>"
  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
  # Brightness
  EnterBrightness $prn 8 ${special_input_id} ps ps_descr SHORT_COND_VALUE_LO
#2  
  incr prn
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "</textarea></div>"
}

constructor
