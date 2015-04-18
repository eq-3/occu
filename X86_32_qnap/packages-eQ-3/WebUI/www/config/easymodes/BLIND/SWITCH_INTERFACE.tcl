#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/BLIND/mapping/SWITCH_INTERFACE_map.tcl]

set PROFILES_MAP(0)	"\${expert}"
set PROFILES_MAP(1)	"\${open_up}"
set PROFILES_MAP(2)	"\${close_down}"
set PROFILES_MAP(3)	"\${open_close_up_down}"
set PROFILES_MAP(4)	"\${open_up_stopover}"
set PROFILES_MAP(5)	"\${close_down_stopover}"

set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)	"Expertenprofil"
set PROFILE_0(UI_TEMPLATE)	"Expertenprofil"

# hier folgen die verschiedenen Profile
set PROFILE_1(SHORT_CT_RAMPOFF)		0
set PROFILE_1(SHORT_CT_RAMPON)		0
set PROFILE_1(SHORT_CT_OFFDELAY)	0
set PROFILE_1(SHORT_CT_ONDELAY)		0
set PROFILE_1(SHORT_CT_OFF)			0
set PROFILE_1(SHORT_CT_ON)			0
set PROFILE_1(SHORT_CT_REFOFF)		0
set PROFILE_1(SHORT_CT_REFON)		0
set PROFILE_1(SHORT_COND_VALUE_LO)	50 
set PROFILE_1(SHORT_COND_VALUE_HI)	100
set PROFILE_1(SHORT_ONDELAY_TIME)	0
set PROFILE_1(SHORT_ON_TIME)		111600
set PROFILE_1(SHORT_OFFDELAY_TIME)	0
set PROFILE_1(SHORT_OFF_TIME)		111600
set PROFILE_1(SHORT_ON_TIME_MODE)	0
set PROFILE_1(SHORT_OFF_TIME_MODE)	0
set PROFILE_1(SHORT_ACTION_TYPE)	1
set PROFILE_1(SHORT_JT_OFF)			1
set PROFILE_1(SHORT_JT_ON)			1
set PROFILE_1(SHORT_JT_OFFDELAY)	1
set PROFILE_1(SHORT_JT_ONDELAY)		2
set PROFILE_1(SHORT_JT_RAMPOFF)		8
set PROFILE_1(SHORT_JT_RAMPON)		4
set PROFILE_1(SHORT_JT_REFOFF)		8
set PROFILE_1(SHORT_JT_REFON)		3
set PROFILE_1(SHORT_OFF_LEVEL)		0
set PROFILE_1(SHORT_ON_LEVEL)		1
set PROFILE_1(SHORT_MAX_TIME_FIRST_DIR)	25.5
set PROFILE_1(SHORT_DRIVING_MODE)	0
set PROFILE_1(UI_DESCRIPTION)	"Mit dem Bet&auml;tigen des Schalters f&auml;hrt die Jalousie/Markise/Rolllade ganz hoch. Wird der Schalter w&auml;hrend der Fahrt nochmal bet&auml;tigt, wird die Fahrt unterbrochen. Bei der n&auml;chsten Bet&auml;tigung wird die Fahrt wieder aufgenommen." 
append PROFILE_1(UI_DESCRIPTION) "&nbsp;Ist eine Hochfahrverz&ouml;gerungszeit eingestellt, so wird die Jalousie/Markise/Rolllade erst nach Ablauf dieser Zeit hoch gefahren."
set PROFILE_1(UI_TEMPLATE)		$PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)	1

set PROFILE_2(SHORT_CT_RAMPOFF)		0
set PROFILE_2(SHORT_CT_RAMPON)		0
set PROFILE_2(SHORT_CT_OFFDELAY)	0
set PROFILE_2(SHORT_CT_ONDELAY)		0
set PROFILE_2(SHORT_CT_OFF)			0
set PROFILE_2(SHORT_CT_ON)			0
set PROFILE_2(SHORT_CT_REFOFF)		0
set PROFILE_2(SHORT_CT_REFON)		0
set PROFILE_2(SHORT_COND_VALUE_LO)	50
set PROFILE_2(SHORT_COND_VALUE_HI)	100
set PROFILE_2(SHORT_ONDELAY_TIME)	0
set PROFILE_2(SHORT_ON_TIME)		111600
set PROFILE_2(SHORT_OFFDELAY_TIME)	0
set PROFILE_2(SHORT_OFF_TIME)		111600
set PROFILE_2(SHORT_ON_TIME_MODE)	0
set PROFILE_2(SHORT_OFF_TIME_MODE)	0
set PROFILE_2(SHORT_ACTION_TYPE)	1
set PROFILE_2(SHORT_JT_OFF)			5
set PROFILE_2(SHORT_JT_ON)			5
set PROFILE_2(SHORT_JT_OFFDELAY)	6
set PROFILE_2(SHORT_JT_ONDELAY)		5
set PROFILE_2(SHORT_JT_RAMPOFF)		8
set PROFILE_2(SHORT_JT_RAMPON)		4
set PROFILE_2(SHORT_JT_REFOFF)		7
set PROFILE_2(SHORT_JT_REFON)		4
set PROFILE_2(SHORT_OFF_LEVEL)		0
set PROFILE_2(SHORT_ON_LEVEL)		1
set PROFILE_2(SHORT_MAX_TIME_FIRST_DIR)	25.5
set PROFILE_2(SHORT_DRIVING_MODE)	0
set PROFILE_2(UI_DESCRIPTION)	"Mit dem Bet&auml;tigen des Schalters f&auml;hrt die Jalousie/Markise/Rolllade ganz herunter. Wird der Schalter w&auml;hrend der Fahrt nochmal bet&auml;tigt, wird die Fahrt unterbrochen. Bei der n&auml;chsten Bet&auml;tigung wird die Fahrt wieder aufgenommen." 
append PROFILE_2(UI_DESCRIPTION) "&nbsp;Ist eine Runterfahrverz&ouml;gerungszeit eingestellt, so wird die Jalousie/Markise/Rolllade erst nach Ablauf dieser Zeit herunter gefahren."
set PROFILE_2(UI_TEMPLATE)		$PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)	2

set PROFILE_3(SHORT_CT_RAMPOFF)		0
set PROFILE_3(SHORT_CT_RAMPON)		0
set PROFILE_3(SHORT_CT_OFFDELAY)	0
set PROFILE_3(SHORT_CT_ONDELAY)		0
set PROFILE_3(SHORT_CT_OFF)			0
set PROFILE_3(SHORT_CT_ON)			0
set PROFILE_3(SHORT_CT_REFOFF)		0
set PROFILE_3(SHORT_CT_REFON)		0
set PROFILE_3(SHORT_COND_VALUE_LO)	50 
set PROFILE_3(SHORT_COND_VALUE_HI)	100
set PROFILE_3(SHORT_ONDELAY_TIME)	0
set PROFILE_3(SHORT_ON_TIME)		111600
set PROFILE_3(SHORT_OFFDELAY_TIME)	0
set PROFILE_3(SHORT_OFF_TIME)		111600
set PROFILE_3(SHORT_ON_TIME_MODE)	0
set PROFILE_3(SHORT_OFF_TIME_MODE)	0
set PROFILE_3(SHORT_ACTION_TYPE)	1
set PROFILE_3(SHORT_JT_OFF)			1
set PROFILE_3(SHORT_JT_ON)			5
set PROFILE_3(SHORT_JT_OFFDELAY)	6
set PROFILE_3(SHORT_JT_ONDELAY)		2
set PROFILE_3(SHORT_JT_RAMPOFF)		8
set PROFILE_3(SHORT_JT_RAMPON)		4
set PROFILE_3(SHORT_JT_REFOFF)		8
set PROFILE_3(SHORT_JT_REFON)		4
set PROFILE_3(SHORT_OFF_LEVEL)		0
set PROFILE_3(SHORT_ON_LEVEL)		1
set PROFILE_3(SHORT_MAX_TIME_FIRST_DIR)	25.5
set PROFILE_3(SHORT_DRIVING_MODE)	0
set PROFILE_3(UI_DESCRIPTION)	"Mit jedem Tastendruck f&auml;hrt die Jalousie/Markise/Rolllade im Wechsel ganz hoch bzw. ganz herunter (Togglefunktion). Wird die Taste w&auml;hrend der Fahrzeit nochmals bet&auml;tigt, bleibt die Jalousie/Markise/Rolllade augenblicklich stehen." 
append PROFILE_3(UI_DESCRIPTION) "&nbsp;Ein erneutes Bet&auml;tigen der Taste kehrt die Richtung um. Ist eine Hoch- oder Runterfahrverz&ouml;gerungszeit eingestellt, so wird die Jalousie/Markise/Rolllade erst nach Ablauf dieser Zeit gefahren.<br>"
set PROFILE_3(UI_TEMPLATE)		$PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)	3

set PROFILE_4(SHORT_ACTION_TYPE)	1
set PROFILE_4(SHORT_DRIVING_MODE)	0
set PROFILE_4(SHORT_JT_OFF)			1
set PROFILE_4(SHORT_JT_OFFDELAY)	1
set PROFILE_4(SHORT_JT_ON)			3
set PROFILE_4(SHORT_JT_ONDELAY)		2
set PROFILE_4(SHORT_JT_RAMPOFF)		8
set PROFILE_4(SHORT_JT_RAMPON)		4
set PROFILE_4(SHORT_JT_REFOFF)		8
set PROFILE_4(SHORT_JT_REFON)		3
set PROFILE_4(SHORT_MAX_TIME_FIRST_DIR)	25.5
set PROFILE_4(SHORT_OFFDELAY_TIME)	0
set PROFILE_4(SHORT_OFF_LEVEL)		0
set PROFILE_4(SHORT_OFF_TIME)		111600
set PROFILE_4(SHORT_OFF_TIME_MODE)	0
set PROFILE_4(SHORT_ONDELAY_TIME)	0
set PROFILE_4(SHORT_ON_LEVEL)		1
set PROFILE_4(SHORT_ON_TIME)		111600
set PROFILE_4(SHORT_ON_TIME_MODE)	0
set PROFILE_4(UI_DESCRIPTION)	"Mit jedem Tastendruck f&auml;hrt die Jalousie/Markise/Rolllade ganz hoch. Ist eine Hochfahrverz&ouml;gerungszeit eingestellt, so wird die Jalousie/Markise/Rolllade erst nach Ablauf dieser Zeit hoch gefahren."
append PROFILE_4(UI_DESCRIPTION) "&nbsp;Wird die Taste w&auml;hrend der Fahrzeit nochmals bet&auml;tigt, bleibt die Jalousie/Markise/Rolllade an der derzeitigen Position stehen. Ein nochmaliges Bet&auml;tigen f&uuml;hrt die Fahrt fort."
set PROFILE_4(UI_TEMPLATE)		$PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)	4

set PROFILE_5(SHORT_ACTION_TYPE)	1
set PROFILE_5(SHORT_DRIVING_MODE)	0
set PROFILE_5(SHORT_JT_OFF)			7
set PROFILE_5(SHORT_JT_OFFDELAY)	6
set PROFILE_5(SHORT_JT_ON)			5
set PROFILE_5(SHORT_JT_ONDELAY)		5
set PROFILE_5(SHORT_JT_RAMPOFF)		8
set PROFILE_5(SHORT_JT_RAMPON)		4
set PROFILE_5(SHORT_JT_REFOFF)		7
set PROFILE_5(SHORT_JT_REFON)		4
set PROFILE_5(SHORT_MAX_TIME_FIRST_DIR)	25.5
set PROFILE_5(SHORT_OFFDELAY_TIME)	0
set PROFILE_5(SHORT_OFF_LEVEL)		0
set PROFILE_5(SHORT_OFF_TIME)		111600
set PROFILE_5(SHORT_OFF_TIME_MODE)	0
set PROFILE_5(SHORT_ONDELAY_TIME)	0
set PROFILE_5(SHORT_ON_LEVEL)		1
set PROFILE_5(SHORT_ON_TIME)		111600
set PROFILE_5(SHORT_ON_TIME_MODE)	0
set PROFILE_5(UI_DESCRIPTION)	"Mit jedem Tastendruck f&auml;hrt die Jalousie/Markise/Rolllade ganz herunter. Ist eine Runterfahrverz&ouml;gerungszeit eingestellt, so wird die Jalousie/Markise/Rolllade erst nach Ablauf dieser Zeit herunter gefahren."
append PROFILE_5(UI_DESCRIPTION) "&nbsp;Wird die Taste w&auml;hrend der Fahrzeit nochmals bet&auml;tigt, bleibt die Jalousie/Markise/Rolllade an der derzeitigen Position stehen. Ein nochmaliges Bet&auml;tigen f&uuml;hrt die Fahrt fort."
set PROFILE_5(UI_TEMPLATE)		$PROFILE_5(UI_DESCRIPTION)
set PROFILE_5(UI_HINT)	5


# hier folgen die eventuellen Subsets

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

#	die Texte der Platzhalter einlesen
	puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
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

	append HTML_PARAMS(separate_$prn) "<tr><td>\${UP_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${UP_DELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#2	
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${DOWN_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME|LONG_OFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFF_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${DOWN_DELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFFDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#3	
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${DOWN_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME|LONG_OFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME "onclick=\"SwitchOption('separate_${special_input_id}_$prn\_2', 'separate_${special_input_id}_$prn\_1', \$('${special_input_id}_profiles'),2,'${special_input_id}');\"onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFF_TIME	
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${UP_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onclick=\"SwitchOption('separate_${special_input_id}_$prn\_1', 'separate_${special_input_id}_$prn\_2', \$('${special_input_id}_profiles'),1,'${special_input_id}');\" onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\"" ]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 3
	append HTML_PARAMS(separate_$prn) "<tr><td>\${UP_DELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 4
	append HTML_PARAMS(separate_$prn) "<tr><td>\${DOWN_DELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFFDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#4
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${UP_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${UP_DELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#5
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${DOWN_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME|LONG_OFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFF_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${DOWN_DELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFFDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"	
}

constructor
