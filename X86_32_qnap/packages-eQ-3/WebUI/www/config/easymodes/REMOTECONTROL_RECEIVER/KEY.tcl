#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]


set PROFILES_MAP(0) "\${expert}"
set PROFILES_MAP(1) "\${mode}"

set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)	"Expertenprofil"
set PROFILE_0(UI_TEMPLATE)	"Expertenprofil"

# hier folgen die verschiedenen Profile
set PROFILE_1(SHORT_CONTROL_RC)   {1 range 0 - 6}
set PROFILE_1(SHORT_TEMPERATUR_RC)   {17.00 range 5.00 - 30.00}
set PROFILE_1(LONG_CONTROL_RC)   {0 range 0 - 6}
set PROFILE_1(LONG_TEMPERATUR_RC)   {17.00 range 5.00 - 30.00}
set PROFILE_1(UI_DESCRIPTION)	"Expertenprofil"
set PROFILE_1(UI_TEMPLATE)	"Expertenprofil"
set PROFILE_1(UI_HINT)	1

# hier folgen die eventuellen Subsets

proc isLinkActive {manuMode partyMode} {
  set active 1

  if {$manuMode != 1 || $partyMode != 1} {
    set active 0
  }
  return $active
}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

	global url dev_descr_sender dev_descr_receiver
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

  array set dev_descr [xmlrpc $url getParamset [list string $dev_descr_receiver(PARENT)] MASTER]
  set MANU_MODE_PRIO [lindex [array get dev_descr MANU_MODE_PRIORITIZATION] 1]
  set PARTY_MODE_PRIO [lindex [array get dev_descr PARTY_MODE_PRIORITIZATION] 1]
  set linkIsActive [isLinkActive $MANU_MODE_PRIO $PARTY_MODE_PRIO]


  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/CC.js');</script>"

#	die Texte der Platzhalter einlesen
	puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
	set prn 0	
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
	append HTML_PARAMS(separate_$prn) "</textarea></div>"

# hier folgt die Profildarstellung
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${mode}</td><td>"
	set options(0) "\${option0}"
	set options(1) "\${option1}"
	set options(2) "\${option2}"
	set options(3) "\${option3}"
	set options(4) "\${option4}"
	set options(5) "\${option5}"
	#set options(6) "\${option6}"
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_CONTROL_RC|LONG_CONTROL_RC separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_CONTROL_RC "onchange=\"setPointVisibility('${special_input_id}', $prn)\""]
	append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref
	append HTML_PARAMS(separate_$prn) "<tr id='setpoint_${special_input_id}' class='hidden'><td>\${SetPointTemperature}</td><td>"
  array_clear options
	for {set val 5} {$val <= 30 } {incr val} {
	  set options($val) "$val &#176;C"
	}
	set options(99999997) "Wert eingeben"

	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_TEMPERATUR_RC|LONG_TEMPERATUR_RC separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_TEMPERATUR_RC "onchange=\"CC_ActivateFreeTemp(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTemp $prn $pref ${special_input_id} ps_descr 0 SHORT_TEMPERATUR_RC

	append HTML_PARAMS(separate_$prn) "</td></tr>"

	append HTML_PARAMS(separate_$prn) "</table>"

  if {$linkIsActive != 1} {
  	append HTML_PARAMS(separate_$prn) "<hr>"
	  append HTML_PARAMS(separate_$prn) "<span class='attention'>\${hintKeyPressIgnored}</span>"
  }
	append HTML_PARAMS(separate_$prn) "</textarea></div>"

  # Depending of the current mode the setpoint input field is visible or not.
  append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_$prn) "setPointVisibility(\"${special_input_id}\", $prn);"
  append HTML_PARAMS(separate_$prn) "</script>"

}

constructor
