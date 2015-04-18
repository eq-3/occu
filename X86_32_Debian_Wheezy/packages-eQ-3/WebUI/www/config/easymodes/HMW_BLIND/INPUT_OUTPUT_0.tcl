#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options_hmw.tcl]

set PROFILES_MAP(0)	"\${expert}"
set PROFILES_MAP(1)	"\${open_up}"
set PROFILES_MAP(2)	"\${close_down}"
set PROFILES_MAP(3)	"\${open_close_up_down}"
set PROFILES_MAP(4)	"\${target_position}"

set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)	"Expertenprofil"
set PROFILE_0(UI_TEMPLATE)		"Expertenprofil"

# hier folgen die verschiedenen Profile
set PROFILE_1(SHORT_ACTION_TYPE)	1
set PROFILE_1(SHORT_DRIVING_MODE)	3
set PROFILE_1(SHORT_JT_OFF)			0
set PROFILE_1(SHORT_JT_OFFDELAY)	0
set PROFILE_1(SHORT_JT_ON)			0
set PROFILE_1(SHORT_JT_ONDELAY)		1
set PROFILE_1(SHORT_JT_RAMPOFF)		7
set PROFILE_1(SHORT_JT_RAMPON)		3
set PROFILE_1(SHORT_JT_REFOFF)		7
set PROFILE_1(SHORT_JT_REFON)		2
set PROFILE_1(SHORT_MAX_TIME_FIRST_DIR)	25.500000
set PROFILE_1(SHORT_OFFDELAY_TIME)	0.000000
set PROFILE_1(SHORT_OFF_TIME_MODE)	1
set PROFILE_1(SHORT_OFF_LEVEL)		0.000000
set PROFILE_1(SHORT_OFF_TIME)		16383000.000000
set PROFILE_1(SHORT_ONDELAY_TIME)	0.000000
set PROFILE_1(SHORT_ON_TIME_MODE)	1
set PROFILE_1(SHORT_ON_LEVEL)		1.000000
set PROFILE_1(SHORT_ON_TIME)		16383000.000000
set PROFILE_1(SHORT_TOGGLE_USE)		1
set PROFILE_1(UI_DESCRIPTION)	"Bei Bet&auml;tigung des Schalters f&auml;hrt die Jalousie/Markise/Rolllade ganz hoch. Wird der Schalter w&auml;hrend der Fahrt nochmal bet&auml;tigt, wird die Fahrt unterbrochen. Bei der n&auml;chsten Bet&auml;tigung wird die Fahrt wieder aufgenommen." 
append PROFILE_1(UI_DESCRIPTION) "&nbsp;Ist eine Hochfahrverz&ouml;gerungszeit eingestellt, so wird die Jalousie/Markise/Rolllade erst nach Ablauf dieser Zeit hoch gefahren."
set PROFILE_1(UI_TEMPLATE)		$PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)	1

set PROFILE_2(SHORT_ACTION_TYPE)	1
set PROFILE_2(SHORT_DRIVING_MODE)	3
set PROFILE_2(SHORT_JT_OFF)			4
set PROFILE_2(SHORT_JT_OFFDELAY)	5
set PROFILE_2(SHORT_JT_ON)			4
set PROFILE_2(SHORT_JT_ONDELAY)		4
set PROFILE_2(SHORT_JT_RAMPOFF)		7
set PROFILE_2(SHORT_JT_RAMPON)		3
set PROFILE_2(SHORT_JT_REFOFF)		6
set PROFILE_2(SHORT_JT_REFON)		3
set PROFILE_2(SHORT_MAX_TIME_FIRST_DIR)	25.500000
set PROFILE_2(SHORT_OFFDELAY_TIME)	0.000000
set PROFILE_2(SHORT_OFF_TIME_MODE)	1
set PROFILE_2(SHORT_OFF_LEVEL)		0.000000
set PROFILE_2(SHORT_OFF_TIME)		16383000.000000
set PROFILE_2(SHORT_ONDELAY_TIME)	0.000000
set PROFILE_2(SHORT_ON_TIME_MODE)	1
set PROFILE_2(SHORT_ON_LEVEL)		1.000000
set PROFILE_2(SHORT_ON_TIME)		16383000.000000
set PROFILE_2(SHORT_TOGGLE_USE)		1
set PROFILE_2(UI_DESCRIPTION)	"Bei Bet&auml;tigung des Schalters f&auml;hrt die Jalousie/Markise/Rolllade ganz herunter. Wird der Schalter w&auml;hrend der Fahrt nochmal bet&auml;tigt, wird die Fahrt unterbrochen. Bei der n&auml;chsten Bet&auml;tigung wird die Fahrt wieder aufgenommen." 
append PROFILE_2(UI_DESCRIPTION) "&nbsp;Ist eine Runterahrverz&ouml;gerungszeit eingestellt, so wird die Jalousie/Markise/Rolllade erst nach Ablauf dieser Zeit herunter gefahren."
set PROFILE_2(UI_TEMPLATE)		$PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)	2

set PROFILE_3(SHORT_ACTION_TYPE)	1
set PROFILE_3(SHORT_DRIVING_MODE)	3
set PROFILE_3(SHORT_JT_OFF)			0
set PROFILE_3(SHORT_JT_OFFDELAY)	5
set PROFILE_3(SHORT_JT_ON)			4
set PROFILE_3(SHORT_JT_ONDELAY)		1
set PROFILE_3(SHORT_JT_RAMPOFF)		7
set PROFILE_3(SHORT_JT_RAMPON)		3
set PROFILE_3(SHORT_JT_REFOFF)		7
set PROFILE_3(SHORT_JT_REFON)		3
set PROFILE_3(SHORT_MAX_TIME_FIRST_DIR)	25.500000
set PROFILE_3(SHORT_OFFDELAY_TIME)	0.000000
set PROFILE_3(SHORT_OFF_TIME_MODE)	1
set PROFILE_3(SHORT_OFF_LEVEL)		0.000000
set PROFILE_3(SHORT_OFF_TIME)		16383000.000000
set PROFILE_3(SHORT_ONDELAY_TIME)	0.000000
set PROFILE_3(SHORT_ON_TIME_MODE)	1
set PROFILE_3(SHORT_ON_LEVEL)		1.000000
set PROFILE_3(SHORT_ON_TIME)		16383000.000000
set PROFILE_3(SHORT_TOGGLE_USE)	1
set PROFILE_3(UI_DESCRIPTION)	"Mit jeder Bet&auml;tigung des Schalters f&auml;hrt die Jalousie/Markise/Rolllade im Wechsel ganz hoch bzw. ganz herunter (Togglefunktion). Wird der Schalter w&auml;hrend der Fahrt nochmals bet&auml;tigt, bleibt die Jalousie/Markise/Rolllade augenblicklich stehen." 
append PROFILE_3(UI_DESCRIPTION) "&nbsp;Ein erneutes Bet&auml;tigen des Schalters kehrt die Richtung um. Ist eine Hoch- oder Runterfahrverz&ouml;gerungszeit eingestellt, so wird die Jalousie/Markise/Rolllade erst nach Ablauf dieser Zeit gefahren."
set PROFILE_3(UI_TEMPLATE)		$PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)	3

set PROFILE_4(SHORT_ACTION_TYPE)	1
set PROFILE_4(SHORT_DRIVING_MODE)	3
set PROFILE_4(SHORT_JT_OFF)			0
set PROFILE_4(SHORT_JT_OFFDELAY)	0
set PROFILE_4(SHORT_JT_ON)			0
set PROFILE_4(SHORT_JT_ONDELAY)		1
set PROFILE_4(SHORT_JT_RAMPOFF)		7
set PROFILE_4(SHORT_JT_RAMPON)		2
set PROFILE_4(SHORT_JT_REFOFF)		7
set PROFILE_4(SHORT_JT_REFON)		2
set PROFILE_4(SHORT_MAX_TIME_FIRST_DIR)	25.500000
set PROFILE_4(SHORT_OFFDELAY_TIME)	0.000000
set PROFILE_4(SHORT_OFF_TIME_MODE)	1
set PROFILE_4(SHORT_OFF_LEVEL)		0.000000
set PROFILE_4(SHORT_OFF_TIME)		16383000.000000
set PROFILE_4(SHORT_ONDELAY_TIME)	0.000000
set PROFILE_4(SHORT_ON_TIME_MODE)	1
set PROFILE_4(SHORT_ON_LEVEL)		1.000000
set PROFILE_4(SHORT_ON_TIME)		16383000.000000
set PROFILE_4(SHORT_TOGGLE_USE)		1
set PROFILE_4(UI_DESCRIPTION)	"Mit jeder Bet&auml;tigung des Schalters f&auml;hrt die Jalousie/Markise/Rolllade zur gew&uuml;nschten Position. Ist eine entsprechende Fahrverz&ouml;gerungszeit eingestellt, so wird die Jalousie/Markise/Rolllade erst nach Ablauf dieser Zeit gefahren."
append PROFILE_4(UI_DESCRIPTION)	"&nbsp;Wird der Schalter w&auml;hrend der Fahrt nochmal bet&auml;tigt, wird die Fahrt unterbrochen. Bei der n&auml;chsten Bet&auml;tigung wird die Fahrt wieder aufgenommen."
set PROFILE_4(UI_TEMPLATE)		$PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)	4

#set SUBSET_1(NAME)					"Hochgefahren"
set SUBSET_1(NAME)					"\${subset_1}"
set SUBSET_1(SUBSET_OPTION_VALUE)	1
set SUBSET_1(SHORT_JT_OFF)			0
set SUBSET_1(SHORT_JT_OFFDELAY)		0
set SUBSET_1(SHORT_JT_ON)			0
set SUBSET_1(SHORT_JT_ONDELAY)		1
set SUBSET_1(SHORT_JT_RAMPOFF)		7
set SUBSET_1(SHORT_JT_RAMPON)		2
set SUBSET_1(SHORT_JT_REFOFF)		7
set SUBSET_1(SHORT_JT_REFON)		2


#set SUBSET_2(NAME)					"Runtergefahren"
set SUBSET_2(NAME)					"\${subset_2}"
set SUBSET_2(SUBSET_OPTION_VALUE)	2
set SUBSET_2(SHORT_JT_OFF)			4
set SUBSET_2(SHORT_JT_OFFDELAY)		5
set SUBSET_2(SHORT_JT_ON)			4
set SUBSET_2(SHORT_JT_ONDELAY)		4
set SUBSET_2(SHORT_JT_RAMPOFF)		6
set SUBSET_2(SHORT_JT_RAMPON)		3
set SUBSET_2(SHORT_JT_REFOFF)		6
set SUBSET_2(SHORT_JT_REFON)		3

#set SUBSET_3(NAME)					"Hoch- / Runtergefahren im Wechsel"
set SUBSET_3(NAME)					"\${subset_3}"
set SUBSET_3(SUBSET_OPTION_VALUE)	3
set SUBSET_3(SHORT_JT_OFF)			0
set SUBSET_3(SHORT_JT_OFFDELAY)		5
set SUBSET_3(SHORT_JT_ON)			4
set SUBSET_3(SHORT_JT_ONDELAY)		1
set SUBSET_3(SHORT_JT_RAMPOFF)		7
set SUBSET_3(SHORT_JT_RAMPON)		3
set SUBSET_3(SHORT_JT_REFOFF)		7
set SUBSET_3(SHORT_JT_REFON)		3

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

#	die Texte der Platzhalter einlesen > _sender(TYPE)_0 = der Sender ist als Schalter geschaltet.
	puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)_0', 'HMW_$dev_descr_receiver(TYPE)');</script>"
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
	
	incr pref; # 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${UP_DELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr></table></textarea></div>"
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
	append HTML_PARAMS(separate_$prn) "</td></tr></table></textarea></div>"
#3
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
	
	incr pref ;# 3
	append HTML_PARAMS(separate_$prn) "<tr><td>\${DOWN_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME|LONG_OFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFF_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 4
	append HTML_PARAMS(separate_$prn) "<tr><td>\${DOWN_DELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFFDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr></table></textarea></div>"
#4
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${UP_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onclick=\"SwitchOption('separate_${special_input_id}_4_2', 'separate_${special_input_id}_4_1', \$('${special_input_id}_profiles'),2,'${special_input_id}');\" onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	incr pref ; #2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${DOWN_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME|LONG_OFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME "onclick=\"SwitchOption('separate_${special_input_id}_4_1', 'separate_${special_input_id}_4_2',  \$('${special_input_id}_profiles'),1,'${special_input_id}');\" onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFF_TIME
	
	if {$cur_profile == $prn} then {
		append HTML_PARAMS(separate_$prn) "</td></tr>"
		append HTML_PARAMS(separate_$prn) "<tr><td>\${UP_LEVEL}</td><td>"
		append HTML_PARAMS(separate_$prn) "<input type=\"text\" id=\"separate_${special_input_id}_$prn\_3_temp\" name=\"SHORT_ON_LEVEL\" value=\"[expr $ps(SHORT_ON_LEVEL) * 100]\" onkeyup=\"ProofAndSetValue('separate_${special_input_id}_4_3_temp', 'separate_${special_input_id}_4_3', parseInt(0), parseInt(100), parseFloat(0.01));\" onmouseup=\"ProofAndSetValue('separate_${special_input_id}_4_3_temp', 'separate_${special_input_id}_4_3', parseInt(0), parseInt(100), parseFloat(0.01));\" onblur=\"ProofAndSetValue('separate_${special_input_id}_4_3_temp', 'separate_${special_input_id}_4_3', parseInt(0), parseInt(100), parseFloat(0.01));\" />\%<br />"
		append HTML_PARAMS(separate_$prn) "<input type=\"hidden\" id=\"separate_${special_input_id}_$prn\_3\" name=\"SHORT_ON_LEVEL\" value=\"[expr $ps(SHORT_ON_LEVEL)]\" />"
		
		append HTML_PARAMS(separate_$prn) "</td></tr>"
		append HTML_PARAMS(separate_$prn) "<tr><td>\${DOWN_LEVEL}</td><td>"
		append HTML_PARAMS(separate_$prn) "<input type=\"text\" id=\"separate_${special_input_id}_$prn\_8_temp\" name=\"SHORT_OFF_LEVEL\" value=\"[expr $ps(SHORT_OFF_LEVEL) * 100]\" onkeyup=\"ProofAndSetValue('separate_${special_input_id}_4_8_temp', 'separate_${special_input_id}_4_8', parseInt(0), parseInt(100), parseFloat(0.01));\" onmouseup=\"ProofAndSetValue('separate_${special_input_id}_4_8_temp', 'separate_${special_input_id}_4_8', parseInt(0), parseInt(100), parseFloat(0.01));\" onblur=\"ProofAndSetValue('separate_${special_input_id}_4_8_temp', 'separate_${special_input_id}_4_8', parseInt(0), parseInt(100), parseFloat(0.01));\" />\%"
		append HTML_PARAMS(separate_$prn) "<input type=\"hidden\" id=\"separate_${special_input_id}_$prn\_8\" name=\"SHORT_OFF_LEVEL\" value=\"[expr $ps(SHORT_OFF_LEVEL)]\" />"
		
	} else {
		append HTML_PARAMS(separate_$prn) "</td></tr>"
		append HTML_PARAMS(separate_$prn) "<tr><td>\${UP_LEVEL}</td><td>"
		append HTML_PARAMS(separate_$prn) "<input type=\"text\" id=\"separate_${special_input_id}_$prn\_3_temp\" name=\"SHORT_ON_LEVEL\" value=\"[expr $PROFILE_4(SHORT_ON_LEVEL) * 100]\" onkeyup=\"ProofAndSetValue('separate_${special_input_id}_4_3_temp', 'separate_${special_input_id}_4_3', parseInt(0), parseInt(100), parseFloat(0.01));\" onmouseup=\"ProofAndSetValue('separate_${special_input_id}_4_3_temp', 'separate_${special_input_id}_4_3', parseInt(0), parseInt(100), parseFloat(0.01));\" onblur=\"ProofAndSetValue('separate_${special_input_id}_4_3_temp', 'separate_${special_input_id}_4_3', parseInt(0), parseInt(100), parseFloat(0.01));\" />\%<br />"
		append HTML_PARAMS(separate_$prn) "<input type=\"hidden\" id=\"separate_${special_input_id}_$prn\_3\" name=\"SHORT_ON_LEVEL\" value=\"[expr $PROFILE_4(SHORT_ON_LEVEL)]\" />"
		
		append HTML_PARAMS(separate_$prn) "</td></tr>"
		append HTML_PARAMS(separate_$prn) "<tr><td>\${DOWN_LEVEL}</td><td>"
		append HTML_PARAMS(separate_$prn) "<input type=\"text\" id=\"separate_${special_input_id}_$prn\_8_temp\" name=\"SHORT_OFF_LEVEL\" value=\"[expr $PROFILE_4(SHORT_OFF_LEVEL) * 100]\" onkeyup=\"ProofAndSetValue('separate_${special_input_id}_4_8_temp', 'separate_${special_input_id}_4_8', parseInt(0), parseInt(100), parseFloat(0.01));\" onmouseup=\"ProofAndSetValue('separate_${special_input_id}_4_8_temp', 'separate_${special_input_id}_4_8', parseInt(0), parseInt(100), parseFloat(0.01));\" onblur=\"ProofAndSetValue('separate_${special_input_id}_4_8_temp', 'separate_${special_input_id}_4_8', parseInt(0), parseInt(100), parseFloat(0.01));\" />\%"
		append HTML_PARAMS(separate_$prn) "<input type=\"hidden\" id=\"separate_${special_input_id}_$prn\_8\" name=\"SHORT_OFF_LEVEL\" value=\"[expr $PROFILE_4(SHORT_OFF_LEVEL)]\" />"
	}
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	set pref 4 
	append HTML_PARAMS(separate_$prn) "<tr><td>\${UP_DELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 5
	append HTML_PARAMS(separate_$prn) "<tr><td>\${DOWN_DELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFFDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 6
	append HTML_PARAMS(separate_$prn) "<tr><td>\${JUMPTARGET}</td><td>"
	append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2 SUBSET_3} subset_$prn\_1 separate_${special_input_id}_$prn\_$pref PROFILE_$prn]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 7
	append HTML_PARAMS(separate_$prn) "<tr><td>\${DRIVING_MODE}</td><td>"
	array_clear options
	set options(0) "\${driving_mode_0}"
	set options(1) "\${driving_mode_1}"
	set options(2) "\${driving_mode_2}"
	set options(3) "\${driving_mode_3}"	
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_DRIVING_MODE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_DRIVING_MODE]
	append HTML_PARAMS(separate_$prn) "</td></tr></table></textarea></div>"
}

constructor
