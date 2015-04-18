#!/bin/tclsh


source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]


set PROFILES_MAP(0)	"\${expert}"
set PROFILES_MAP(1)	"\${temperature_lowering_value}" 

set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)	"Expertenprofil"
set PROFILE_0(UI_TEMPLATE)	"Expertenprofil"

set PROFILE_1(TEMPERATUR_WINDOW_OPEN_VALUE)	{12 range 6 - 30}
set PROFILE_1(UI_DESCRIPTION)	"Beim &Ouml;ffnen des Kontaktes wird die Temperatur auf die Absenktemperatur eingestellt."
set PROFILE_1(UI_TEMPLATE)	"Beim &Ouml;ffnen des Kontaktes wird die Temperatur auf #{TEMPERATUR_WINDOW_OPEN_VALUE} Grad C bzw. F eingestellt."
set PROFILE_1(UI_HINT)	1

proc isLinkActive {manuMode partyMode} {
  set active 1
  # manuMode or partyMode doesn¥t exist in older heating controls so the profile is always active
  if {[string length $manuMode] == 0 || [string length $partyMode] == 0} {$active}

  # The new heating control has modes which prevents links to work
  if {$manuMode != 1 || $partyMode != 1} {
    set active 0
  }
  return $active
}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
	
	puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/CC.js');</script>"
	
	global url dev_descr_sender dev_descr_receiver sender_address
	upvar PROFILES_MAP  PROFILES_MAP
	upvar HTML_PARAMS   HTML_PARAMS
	upvar PROFILE_PNAME PROFILE_PNAME
	upvar $pps          ps      
	upvar $pps_descr    ps_descr
	
	global unit_temp unit_cf
	set unit_cf [GetTempUnit]
	set t $unit_temp
	upvar free_value Wert

	# die Optionswerte bei Bedarf in Fahrenheit umrechnen
	array set opt [list 1 10 2 12 3 14 4 16 5 18]
	if {$unit_cf} {
		foreach item [array names opt *] {
			set opt($item) [expr $opt($item) * 9 / 5 + 32]
		}
	}

	foreach pro [array names PROFILES_MAP] {
		upvar PROFILE_$pro PROFILE_$pro
	}

  catch {
    array set dev_descr [xmlrpc $url getParamset [list string $dev_descr_receiver(PARENT)] MASTER]
    set MANU_MODE_PRIO [lindex [array get dev_descr MANU_MODE_PRIORITIZATION] 1]
    set PARTY_MODE_PRIO [lindex [array get dev_descr PARTY_MODE_PRIORITIZATION] 1]
    set linkIsActive [isLinkActive $MANU_MODE_PRIO $PARTY_MODE_PRIO]
  }

	set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]

	#	die Texte der Platzhalter einlesen

	puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
	set prn 0	
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
	append HTML_PARAMS(separate_$prn) "</textarea></div>"

	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${TEMPERATURE_LOWERING_VALUE}</td><td>" 
	array_clear options
	set options(10) "$opt(1)$t"
	set options(12) "$opt(2)$t"
	set options(14) "$opt(3)$t"
	set options(16) "$opt(4)$t"
	set options(18) "$opt(5)$t"
	set options(99999997) "$Wert"
	append HTML_PARAMS(separate_$prn) [get_ComboBox options TEMPERATUR_WINDOW_OPEN_VALUE separate_${special_input_id}_$prn\_$pref PROFILE_$pref TEMPERATUR_WINDOW_OPEN_VALUE "onchange=\"CC_ActivateFreeTemp(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTemp $prn $pref ${special_input_id} ps_descr $unit_cf TEMPERATUR_WINDOW_OPEN_VALUE
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

  if {$linkIsActive != 1} {
    append HTML_PARAMS(separate_$prn) "<hr>"
    append HTML_PARAMS(separate_$prn) "<span class='attention'>HINT - Der Heizungssteller ist so konfiguriert, daﬂ dieses Profil deaktiviert ist!<br/><br/>Siehe Konfig-Parameter MANU/PARTY_MODE_PRIORITIZATION</span>"
  }
  append HTML_PARAMS(separate_$prn) "</textarea></div>"
}

constructor
