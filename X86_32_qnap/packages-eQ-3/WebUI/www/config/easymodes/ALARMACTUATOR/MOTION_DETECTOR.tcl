#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options_alarmactuator.tcl]

set PROFILES_MAP(0)	"\${expert}"
set PROFILES_MAP(1)	"\${alarm_on}"

set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)	"Expertenprofil"
set PROFILE_0(UI_TEMPLATE)		"Expertenprofil"

# hier folgen die verschiedenen Profile

set PROFILE_1(SHORT_CT_OFFDELAY)	2
set PROFILE_1(SHORT_CT_ONDELAY)		2
set PROFILE_1(SHORT_CT_OFF)			2
set PROFILE_1(SHORT_CT_ON)			2
set PROFILE_1(SHORT_COND_VALUE_LO)	255
set PROFILE_1(SHORT_COND_VALUE_HI)	{100 range 0 - 255}
set PROFILE_1(SHORT_ONDELAY_TIME)	0
set PROFILE_1(SHORT_ON_TIME)		{120 300} 
set PROFILE_1(SHORT_OFFDELAY_TIME)	{0 20}	
set PROFILE_1(SHORT_OFF_TIME)		111600
set PROFILE_1(SHORT_ON_TIME_MODE)	{1 0}
set PROFILE_1(SHORT_OFF_TIME_MODE)	0
set PROFILE_1(SHORT_ACTION_TYPE)	1
set PROFILE_1(SHORT_JT_OFF)			1
set PROFILE_1(SHORT_JT_ON)			2
set PROFILE_1(SHORT_JT_OFFDELAY)	2
set PROFILE_1(SHORT_JT_ONDELAY)		2 
set PROFILE_1(LONG_ACTION_TYPE)		{0 1}
set PROFILE_1(UI_DESCRIPTION)	"Beim Ausl&ouml;sen des Sensors wird der Alarm mindestens f&uuml;r die eingestellte Zeit eingeschaltet. Ist eine Einschaltverz&ouml;gerungszeit eingestellt, so wird der Alarm erst nach Ablauf dieser Zeit eingeschaltet.<br /> "
set PROFILE_1(UI_TEMPLATE)		$PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)	1

# hier folgen die eventuellen Subsets


proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
	
	global url receiver_address sender_address	dev_descr_sender dev_descr_receiver
	upvar PROFILES_MAP  PROFILES_MAP
	upvar HTML_PARAMS   HTML_PARAMS
	upvar PROFILE_PNAME PROFILE_PNAME
	upvar $pps          ps      
	upvar $pps_descr    ps_descr
	
	# hier wird der gewaehlte Kancal der ASA ermittelt, Kanal 1 = Sirene - Kanal 2 = Blitzlicht
	set ch [string range $receiver_address [expr [string first ":" $receiver_address] +1] [string length $receiver_address]]  
	set manner(1) "siren"
	set manner(2) "flashlight"

	set sender_addr $sender_address
	puts "<input type=\"hidden\" id=\"dev_descr_sender_tmp\" value=\"$dev_descr_sender(TYPE)-$sender_addr\">" 	
		
	array set dev_ps [xmlrpc $url getParamset $sender_address MASTER]
	set	min_interval 4

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

	set absolut_minimal  $ps(SHORT_ON_TIME_MODE)
	# absolut_minimal enthaelt den derzeitigen Modus der Verweildauer
	# 0 entspricht 'absolut', 1 entspricht 'minimal'
	set min_interval $dev_ps(MIN_INTERVAL)
	# Mindestsendeabstand min_interval = Wert 0, 1, 2, 3,4 >>> 0 = 15s, 1 = 30s, 2 = 60s, 3 = 120s, 4 = 240s
	puts "<input type=\"hidden\" id=\"md_min_interval_1_1\" value=\"$min_interval,$absolut_minimal\">"

#	die Texte der Platzhalter einlesen
	puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)')</script>"
	set prn 0	
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
	append HTML_PARAMS(separate_$prn) "</textarea></div>"

#1	Alarm Ein
	incr prn
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn\_s}&nbsp;\${actor_$ch}&nbsp;\${description_$prn\_e}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME_MODE}</td><td>"
	array_clear options 
	set options(0) "\${absolute}"
	set options(1) "\${minimal}"
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME_MODE|LONG_ON_TIME_MODE separate_${special_input_id}_$prn\_1 PROFILE_$prn SHORT_ON_TIME_MODE "onchange=\"MD_checkPNAME('separate_${special_input_id}_$prn\_1','md_verweildauer_$prn\_2', 'separate_${special_input_id}_$prn\_2'); MD_setMode('separate_${special_input_id}_$prn\_1','$ch', 'separate_${special_input_id}_$prn\_2');\""]
	append HTML_PARAMS(separate_$prn) "&nbsp<input type=\"button\" value=\"\${help}\" onclick=\"MD_link_help();\">"

	append HTML_PARAMS(separate_$prn) "<tr><td><span class=\"translated\" id=\"md_verweildauer_$prn\_2\">&nbsp;</span></td><td>"
	append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">MD_checkPNAME('separate_${special_input_id}_$prn\_1','md_verweildauer_$prn\_2', 'separate_${special_input_id}_$prn\_2');</script>"
	
	option $manner($ch)	
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_2 PROFILE_$prn SHORT_ON_TIME ]
	EnterTime_h_m_s $prn 2 ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

	# Hinweis, wenn Verweildauer < Mindestsendeabstand
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
	append HTML_PARAMS(separate_$prn) "<tr><td><span class=\"CLASS20100\" id=\"separate_${special_input_id}_$prn\_2_hint0\">&nbsp</span></td></tr>"	
	append HTML_PARAMS(separate_$prn) "<tr><td><span class=\"CLASS20100\" id=\"separate_${special_input_id}_$prn\_2_hint1\">&nbsp</span></td></tr>"	
	append HTML_PARAMS(separate_$prn) "</table>"
	
	# auf gesetzlich erlaubten Höchstwert für Alarmsirenen testen und ggf. Hinweis
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
	append HTML_PARAMS(separate_$prn) "<tr><td><span id=\"hint_$prn\_2\">&nbsp;</span></td></tr>"
	append HTML_PARAMS(separate_$prn) "</table>"
	append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">MD_checkMaxValue('separate_${special_input_id}_$prn\_2','$ch', 'separate_${special_input_id}_$prn\_1');</script>"
	
	#Helligkeit
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
	append HTML_PARAMS(separate_$prn) "<td colspan =\"2\"><hr></td>"
	append HTML_PARAMS(separate_$prn) "<tr><td></td></tr><tr><td>"
	EnterBrightness $prn 3 ${special_input_id} ps ps_descr SHORT_COND_VALUE_LO
	append HTML_PARAMS(separate_$prn) "</td></tr></table>"
	
}

constructor
