#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]

set PROFILES_MAP(0)	"\${expert}"
set PROFILES_MAP(1)	"\${open_up}"
set PROFILES_MAP(2)	"\${close_down}"
set PROFILES_MAP(3)	"\${open_close_up_down}"
set PROFILES_MAP(4)	"\${target_position}"


set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)	"Expertenprofil"
set PROFILE_0(UI_TEMPLATE)		"Expertenprofil"

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
set PROFILE_1(SHORT_JT_RAMPON)		3
set PROFILE_1(SHORT_JT_REFOFF)		8
set PROFILE_1(SHORT_JT_REFON)		3
set PROFILE_1(SHORT_OFF_LEVEL)		0
set PROFILE_1(SHORT_ON_LEVEL)		1
set PROFILE_1(SHORT_MAX_TIME_FIRST_DIR)	25.5
set PROFILE_1(SHORT_DRIVING_MODE)	0
set PROFILE_1(LONG_CT_RAMPOFF)		0
set PROFILE_1(LONG_CT_RAMPON)		0
set PROFILE_1(LONG_CT_OFFDELAY)		0
set PROFILE_1(LONG_CT_ONDELAY)		0
set PROFILE_1(LONG_CT_OFF)			0
set PROFILE_1(LONG_CT_ON)			0
set PROFILE_1(LONG_CT_REFOFF)		0
set PROFILE_1(LONG_CT_REFON)		0
set PROFILE_1(LONG_COND_VALUE_LO)	50
set PROFILE_1(LONG_COND_VALUE_HI)	100
set PROFILE_1(LONG_ONDELAY_TIME)	0
set PROFILE_1(LONG_ON_TIME)			111600
set PROFILE_1(LONG_OFFDELAY_TIME)	0
set PROFILE_1(LONG_OFF_TIME)		111600
set PROFILE_1(LONG_ON_TIME_MODE)	0
set PROFILE_1(LONG_OFF_TIME_MODE)	0
set PROFILE_1(LONG_MULTIEXECUTE)	1
set PROFILE_1(LONG_ACTION_TYPE)		1 
set PROFILE_1(LONG_JT_OFF)			1
set PROFILE_1(LONG_JT_ON)			1
set PROFILE_1(LONG_JT_OFFDELAY)		1
set PROFILE_1(LONG_JT_ONDELAY)		2
set PROFILE_1(LONG_JT_RAMPOFF)		8
set PROFILE_1(LONG_JT_RAMPON)		3
set PROFILE_1(LONG_JT_REFOFF)		8
set PROFILE_1(LONG_JT_REFON)		3
set PROFILE_1(LONG_OFF_LEVEL)		0
set PROFILE_1(LONG_ON_LEVEL)		1
set PROFILE_1(LONG_MAX_TIME_FIRST_DIR)	{0.5 0.8}
set PROFILE_1(LONG_DRIVING_MODE)	0
set PROFILE_1(UI_DESCRIPTION)	"Mit einem kurzen Tastendruck f&auml;hrt die Jalousie/Markise/Rolllade f&uuml;r die eingestellte Zeit ganz hoch. Ist eine Hochfahrverz&ouml;gerungszeit eingestellt, so wird die Jalousie/Markise/Rolllade erst nach Ablauf dieser Zeit hochgefahren. Mit einem langen Tastendruck f&auml;hrt die Jalousie/Markise/Rolllade nur so lange hoch wie die Taste gedr&uuml;ckt ist. "
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
set PROFILE_2(SHORT_JT_RAMPOFF)		7
set PROFILE_2(SHORT_JT_RAMPON)		4
set PROFILE_2(SHORT_JT_REFOFF)		7
set PROFILE_2(SHORT_JT_REFON)		4
set PROFILE_2(SHORT_OFF_LEVEL)		0
set PROFILE_2(SHORT_ON_LEVEL)		1
set PROFILE_2(SHORT_MAX_TIME_FIRST_DIR)	25.5
set PROFILE_2(SHORT_DRIVING_MODE)	0
set PROFILE_2(LONG_CT_RAMPOFF)		0
set PROFILE_2(LONG_CT_RAMPON)		0
set PROFILE_2(LONG_CT_OFFDELAY)		0
set PROFILE_2(LONG_CT_ONDELAY)		0
set PROFILE_2(LONG_CT_OFF)			0
set PROFILE_2(LONG_CT_ON)			0
set PROFILE_2(LONG_CT_REFOFF)		0
set PROFILE_2(LONG_CT_REFON)		0
set PROFILE_2(LONG_COND_VALUE_LO)	50
set PROFILE_2(LONG_COND_VALUE_HI)	100
set PROFILE_2(LONG_ONDELAY_TIME)	0
set PROFILE_2(LONG_ON_TIME)			111600
set PROFILE_2(LONG_OFFDELAY_TIME)	0
set PROFILE_2(LONG_OFF_TIME)	111600
set PROFILE_2(LONG_ON_TIME_MODE)	0
set PROFILE_2(LONG_OFF_TIME_MODE)	0
set PROFILE_2(LONG_MULTIEXECUTE)	1
set PROFILE_2(LONG_ACTION_TYPE)		1
set PROFILE_2(LONG_JT_OFF)			5
set PROFILE_2(LONG_JT_ON)			5
set PROFILE_2(LONG_JT_OFFDELAY)		6
set PROFILE_2(LONG_JT_ONDELAY)		5
set PROFILE_2(LONG_JT_RAMPOFF)		7
set PROFILE_2(LONG_JT_RAMPON)		4
set PROFILE_2(LONG_JT_REFOFF)		7
set PROFILE_2(LONG_JT_REFON)		4
set PROFILE_2(LONG_OFF_LEVEL)		0
set PROFILE_2(LONG_ON_LEVEL)		1
set PROFILE_2(LONG_MAX_TIME_FIRST_DIR)	{0.5 0.8}
set PROFILE_2(LONG_DRIVING_MODE)	0
set PROFILE_2(UI_DESCRIPTION)	"Mit einem kurzen Tastendruck f&auml;hrt die Jalousie/Markise/Rolllade f&uuml;r die eingestellte Zeit ganz runter. Ist eine Runterfahrverz&ouml;gerungszeit eingestellt, so wird die Jalousie/Markise/Rolllade erst nach Ablauf dieser Zeit runtergefahren. Mit einem langen Tastendruck f&auml;hrt die Jalousie/Markise/Rolllade nur so lange runter wie die Taste gedr&uuml;ckt ist. "
set PROFILE_2(UI_TEMPLATE)		$PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)	2

set PROFILE_3(LONG_ACTION_TYPE)		1
set PROFILE_3(LONG_COND_VALUE_HI)	100
set PROFILE_3(LONG_COND_VALUE_LO)	50
set PROFILE_3(LONG_CT_OFF)			0
set PROFILE_3(LONG_CT_OFFDELAY)		0
set PROFILE_3(LONG_CT_ON)			0
set PROFILE_3(LONG_CT_ONDELAY)		0
set PROFILE_3(LONG_CT_RAMPOFF)		0
set PROFILE_3(LONG_CT_RAMPON)		0
set PROFILE_3(LONG_CT_REFOFF)		0
set PROFILE_3(LONG_CT_REFON)		0
set PROFILE_3(LONG_DRIVING_MODE)	0
set PROFILE_3(LONG_JT_OFF)			1
set PROFILE_3(LONG_JT_OFFDELAY)		6
set PROFILE_3(LONG_JT_ON)			5
set PROFILE_3(LONG_JT_ONDELAY)		2
set PROFILE_3(LONG_JT_RAMPOFF)		8
set PROFILE_3(LONG_JT_RAMPON)		4
set PROFILE_3(LONG_JT_REFOFF)		8
set PROFILE_3(LONG_JT_REFON)		4
set PROFILE_3(LONG_MAX_TIME_FIRST_DIR)	{0.5 0.8}
set PROFILE_3(LONG_MULTIEXECUTE)	1
set PROFILE_3(LONG_OFFDELAY_TIME)	0
set PROFILE_3(LONG_OFF_LEVEL)		0
set PROFILE_3(LONG_OFF_TIME)		111600
set PROFILE_3(LONG_OFF_TIME_MODE)	0
set PROFILE_3(LONG_ONDELAY_TIME)	0
set PROFILE_3(LONG_ON_LEVEL)		1
set PROFILE_3(LONG_ON_TIME)			111600
set PROFILE_3(LONG_ON_TIME_MODE)	0
set PROFILE_3(SHORT_ACTION_TYPE)	1
set PROFILE_3(SHORT_COND_VALUE_HI)	100
set PROFILE_3(SHORT_COND_VALUE_LO)	50 
set PROFILE_3(SHORT_CT_OFF)			0
set PROFILE_3(SHORT_CT_OFFDELAY)	0
set PROFILE_3(SHORT_CT_ON)			0
set PROFILE_3(SHORT_CT_ONDELAY)		0
set PROFILE_3(SHORT_CT_RAMPOFF)		0
set PROFILE_3(SHORT_CT_RAMPON)		0
set PROFILE_3(SHORT_CT_REFOFF)		0
set PROFILE_3(SHORT_CT_REFON)		0
set PROFILE_3(SHORT_DRIVING_MODE)	0
set PROFILE_3(SHORT_JT_OFF)			1
set PROFILE_3(SHORT_JT_OFFDELAY)	6
set PROFILE_3(SHORT_JT_ON)			5
set PROFILE_3(SHORT_JT_ONDELAY)		2
set PROFILE_3(SHORT_JT_RAMPOFF)		8
set PROFILE_3(SHORT_JT_RAMPON)		4
set PROFILE_3(SHORT_JT_REFOFF)		8
set PROFILE_3(SHORT_JT_REFON)		4
set PROFILE_3(SHORT_MAX_TIME_FIRST_DIR)	25.5
set PROFILE_3(SHORT_OFFDELAY_TIME)	0
set PROFILE_3(SHORT_OFF_LEVEL)		0
set PROFILE_3(SHORT_OFF_TIME)		111600
set PROFILE_3(SHORT_OFF_TIME_MODE)	0
set PROFILE_3(SHORT_ONDELAY_TIME)	0
set PROFILE_3(SHORT_ON_LEVEL)		1
set PROFILE_3(SHORT_ON_TIME)		111600
set PROFILE_3(SHORT_ON_TIME_MODE)	0
set PROFILE_3(UI_DESCRIPTION)		"Mit einem kurzen Tastendruck f&auml;hrt die Jalousie/Markise/Rolllade im Wechsel ganz hoch bzw. ganz runter (Togglefunktion). Ist eine Hoch- oder Runterfahrverz&ouml;gerungszeit eingestellt, so wird die Jalousie/Markise/Rolllade erst nach Ablauf dieser Zeit gefahren. Bei einem langen Tastendruck f&auml;hrt die Jalousie/Markise/Rolllade so lange wie die Taste gedr&uuml;ckt ist."
set PROFILE_3(UI_TEMPLATE)			$PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)	3

set PROFILE_4(LONG_ACTION_TYPE)		1
set PROFILE_4(LONG_COND_VALUE_HI)	100
set PROFILE_4(LONG_COND_VALUE_LO)	50
set PROFILE_4(LONG_CT_OFF)			0
set PROFILE_4(LONG_CT_OFFDELAY)		0
set PROFILE_4(LONG_CT_ON)			0
set PROFILE_4(LONG_CT_ONDELAY)		0
set PROFILE_4(LONG_CT_RAMPOFF)		0
set PROFILE_4(LONG_CT_RAMPON)		0
set PROFILE_4(LONG_CT_REFOFF)		0
set PROFILE_4(LONG_CT_REFON)		0
set PROFILE_4(LONG_DRIVING_MODE)	0
set PROFILE_4(LONG_JT_OFF)			1
set PROFILE_4(LONG_JT_OFFDELAY)		1
set PROFILE_4(LONG_JT_ON)			1
set PROFILE_4(LONG_JT_ONDELAY)		2
set PROFILE_4(LONG_JT_RAMPOFF)		8
set PROFILE_4(LONG_JT_RAMPON)		3
set PROFILE_4(LONG_JT_REFOFF)		8
set PROFILE_4(LONG_JT_REFON)		3
set PROFILE_4(LONG_MAX_TIME_FIRST_DIR)	{0.5 0.8}
set PROFILE_4(LONG_MULTIEXECUTE)	1
set PROFILE_4(LONG_OFFDELAY_TIME)	0
set PROFILE_4(LONG_OFF_LEVEL)		0
set PROFILE_4(LONG_OFF_TIME)		111600
set PROFILE_4(LONG_OFF_TIME_MODE)	0
set PROFILE_4(LONG_ONDELAY_TIME)	0
set PROFILE_4(LONG_ON_LEVEL)		1
set PROFILE_4(LONG_ON_TIME)			111600
set PROFILE_4(LONG_ON_TIME_MODE)	0
set PROFILE_4(SHORT_ACTION_TYPE)	1
set PROFILE_4(SHORT_COND_VALUE_HI)	100
set PROFILE_4(SHORT_COND_VALUE_LO)	50 
set PROFILE_4(SHORT_CT_OFF)			0
set PROFILE_4(SHORT_CT_OFFDELAY)	0
set PROFILE_4(SHORT_CT_ON)			0
set PROFILE_4(SHORT_CT_ONDELAY)		0
set PROFILE_4(SHORT_CT_RAMPOFF)		0
set PROFILE_4(SHORT_CT_RAMPON)		0
set PROFILE_4(SHORT_CT_REFOFF)		0
set PROFILE_4(SHORT_CT_REFON)		0
set PROFILE_4(SHORT_DRIVING_MODE)	0
set PROFILE_4(SHORT_JT_OFF)			1
set PROFILE_4(SHORT_JT_OFFDELAY)	1
set PROFILE_4(SHORT_JT_ON)			1
set PROFILE_4(SHORT_JT_ONDELAY)		2
set PROFILE_4(SHORT_JT_RAMPOFF)		8
set PROFILE_4(SHORT_JT_RAMPON)		3
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
set PROFILE_4(UI_DESCRIPTION)	"Mit einem kurzen Tastendruck f&auml;hrt die Jalousie/Markise/Rolllade f&uuml;r die eingestellte Zeit zur gew&uuml;nschten Position. Ist eine entsprechende Fahrverz&ouml;gerungszeit eingestellt, so wird die Jalousie/Markise/Rolllade erst nach Ablauf dieser Zeit gefahren. Mit einem langen Tastendruck f&auml;hrt die Jalousie/Markise/Rolllade nur so lange in die Richtung der gew&uuml;nschten Position wie die Taste gedr&uuml;ckt ist. "
set PROFILE_4(UI_TEMPLATE)		$PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)	4

# hier folgen die eventuellen Subsets
#set SUBSET_1(NAME)					"Hochgefahren"
set SUBSET_1(NAME)					"\${subset_1}"
set SUBSET_1(SUBSET_OPTION_VALUE)	1
set SUBSET_1(SHORT_JT_OFF)			1
set SUBSET_1(SHORT_JT_OFFDELAY)		1
set SUBSET_1(SHORT_JT_ON)			1
set SUBSET_1(SHORT_JT_ONDELAY)		2
set SUBSET_1(SHORT_JT_RAMPOFF)		8
set SUBSET_1(SHORT_JT_RAMPON)		3
set SUBSET_1(SHORT_JT_REFOFF)		8
set SUBSET_1(SHORT_JT_REFON)		3
set SUBSET_1(LONG_JT_OFF)			1
set SUBSET_1(LONG_JT_OFFDELAY)		1
set SUBSET_1(LONG_JT_ON)			1
set SUBSET_1(LONG_JT_ONDELAY)		2
set SUBSET_1(LONG_JT_RAMPOFF)		8
set SUBSET_1(LONG_JT_RAMPON)		3
set SUBSET_1(LONG_JT_REFOFF)		8
set SUBSET_1(LONG_JT_REFON)			3

#set SUBSET_2(NAME)					"Runtergefahren"
set SUBSET_2(NAME)					"\${subset_2}"
set SUBSET_2(SUBSET_OPTION_VALUE)	2
set SUBSET_2(LONG_JT_OFF)			5
set SUBSET_2(LONG_JT_OFFDELAY)		6
set SUBSET_2(LONG_JT_ON)			5
set SUBSET_2(LONG_JT_ONDELAY)		5
set SUBSET_2(LONG_JT_RAMPOFF)		7
set SUBSET_2(LONG_JT_RAMPON)		4
set SUBSET_2(LONG_JT_REFOFF)		7
set SUBSET_2(LONG_JT_REFON)			4
set SUBSET_2(SHORT_JT_OFF)			5
set SUBSET_2(SHORT_JT_OFFDELAY)		6
set SUBSET_2(SHORT_JT_ON)			5
set SUBSET_2(SHORT_JT_ONDELAY)		5
set SUBSET_2(SHORT_JT_RAMPOFF)		7
set SUBSET_2(SHORT_JT_RAMPON)		4
set SUBSET_2(SHORT_JT_REFOFF)		7
set SUBSET_2(SHORT_JT_REFON)		4

#set SUBSET_3(NAME)					"Hoch-/Runtergefahren im Wechsel"
set SUBSET_3(NAME)					"\${subset_3}"
set SUBSET_3(SUBSET_OPTION_VALUE)	3
set SUBSET_3(LONG_JT_OFF)			1
set SUBSET_3(LONG_JT_OFFDELAY)		6
set SUBSET_3(LONG_JT_ON)			5
set SUBSET_3(LONG_JT_ONDELAY)		2
set SUBSET_3(LONG_JT_RAMPOFF)		8
set SUBSET_3(LONG_JT_RAMPON)		4
set SUBSET_3(LONG_JT_REFOFF)		8
set SUBSET_3(LONG_JT_REFON)			4
set SUBSET_3(SHORT_JT_OFF)			1
set SUBSET_3(SHORT_JT_OFFDELAY)		6
set SUBSET_3(SHORT_JT_ON)			5
set SUBSET_3(SHORT_JT_ONDELAY)		2
set SUBSET_3(SHORT_JT_RAMPOFF)		8
set SUBSET_3(SHORT_JT_RAMPON)		4
set SUBSET_3(SHORT_JT_REFOFF)		8
set SUBSET_3(SHORT_JT_REFON)		4

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
	
	global iface_url sender_address receiver_address dev_descr_sender dev_descr_receiver
	upvar PROFILES_MAP  PROFILES_MAP
	upvar HTML_PARAMS   HTML_PARAMS
	upvar PROFILE_PNAME PROFILE_PNAME
	upvar $pps          ps      
	upvar $pps_descr    ps_descr
	
	foreach pro [array names PROFILES_MAP] {
		upvar PROFILE_$pro PROFILE_$pro
	}

  set url $iface_url($iface)

  # TWIST-441
  array set chGrpDescr [list AES_ACTIVE 0]

  array set chDescr [xmlrpc $url getParamset [list string $sender_address] [list string "MASTER"]]
  catch {array set chGrpDescr [xmlrpc $url getParamset [list string $sender_group] [list string "MASTER"]]}

  set valLONG_MAX_TIME_FIRST_DIR $ps(LONG_MAX_TIME_FIRST_DIR)
  if {(($chDescr(AES_ACTIVE) == 1) || ($chGrpDescr(AES_ACTIVE) == 1)) && ([format "%.2f" $ps(LONG_MAX_TIME_FIRST_DIR)] < 0.8) } {
    set valLONG_MAX_TIME_FIRST_DIR 0.8
  }

  set param  "{LONG_MAX_TIME_FIRST_DIR {$valLONG_MAX_TIME_FIRST_DIR}}"
  puts "[xmlrpc $url putParamset [list string $receiver_address] [list string $sender_address] [list struct $param]]"
  catch {puts "[xmlrpc $url putParamset [list string $receiver_address] [list string $sender_group] [list struct $param]]"}
  set ps(LONG_MAX_TIME_FIRST_DIR) $valLONG_MAX_TIME_FIRST_DIR

  # END TWIST-441

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

	append HTML_PARAMS(separate_$prn) "<tr><td>\${JUMPTARGET}</td><td>"
	append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2 SUBSET_3} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn "onchange=\"BLIND_setPosition('separate_${special_input_id}_$prn\_$pref')\""]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${DRIVING_MODE}</td><td>"
	array_clear options
	set options(0) "\${driving_mode_0}"
	set options(1) "\${driving_mode_1}"
	set options(2) "\${driving_mode_2}"
	set options(3) "\${driving_mode_3}"
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_DRIVING_MODE separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_DRIVING_MODE]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	if {$cur_profile == $prn} then {
		append HTML_PARAMS(separate_$prn) "<tr style=\"visibility:hidden;display:none\" id=\"upLevel_${special_input_id}_$prn\_1\"><td>\${UP_LEVEL}</td>"
		append HTML_PARAMS(separate_$prn) "<td>"
		append HTML_PARAMS(separate_$prn) "<input type=\"text\" id=\"separate_${special_input_id}_$prn\_3_temp\" name=\"SHORT_ON_LEVEL\" value=\"[format %.1f [expr $ps(SHORT_ON_LEVEL) * 100]]\" onkeyup=\"ProofAndSetValue('separate_${special_input_id}_$prn\_3_temp', 'separate_${special_input_id}_$prn\_3', parseInt(0), parseInt(100), parseFloat(0.01));\" onmouseup=\"ProofAndSetValue('separate_${special_input_id}_$prn\_3_temp', 'separate_${special_input_id}_$prn\_3', parseInt(0), parseInt(100), parseFloat(0.01));\" onblur=\"ProofAndSetValue('separate_${special_input_id}_$prn\_3_temp', 'separate_${special_input_id}_$prn\_3', parseInt(0), parseInt(100), parseFloat(0.01));\" />\%"
		append HTML_PARAMS(separate_$prn) "<input type=\"hidden\" id=\"separate_${special_input_id}_$prn\_3\" name=\"SHORT_ON_LEVEL\" value=\"[expr $ps(SHORT_ON_LEVEL)]\" />"
		append HTML_PARAMS(separate_$prn) "</td></tr>"

		append HTML_PARAMS(separate_$prn) "<tr style=\"visibility:hidden;display:none\" id=\"downLevel_${special_input_id}_$prn\_1\"><td>\${DOWN_LEVEL}</td>"
		append HTML_PARAMS(separate_$prn) "<td>"
		append HTML_PARAMS(separate_$prn) "<input type=\"text\" id=\"separate_${special_input_id}_$prn\_4_temp\" name=\"SHORT_OFF_LEVEL\" value=\"[format %.1f [expr $ps(SHORT_OFF_LEVEL) * 100]]\" onkeyup=\"ProofAndSetValue('separate_${special_input_id}_$prn\_4_temp', 'separate_${special_input_id}_$prn\_4', parseInt(0), parseInt(100), parseFloat(0.01));\" onmouseup=\"ProofAndSetValue('separate_${special_input_id}_$prn\_4_temp', 'separate_${special_input_id}_$prn\_4', parseInt(0), parseInt(100), parseFloat(0.01));\" onblur=\"ProofAndSetValue('separate_${special_input_id}_$prn\_4_temp', 'separate_${special_input_id}_$prn\_4', parseInt(0), parseInt(100), parseFloat(0.01));\" />\%"
		append HTML_PARAMS(separate_$prn) "<input type=\"hidden\" id=\"separate_${special_input_id}_$prn\_4\" name=\"SHORT_OFF_LEVEL\" value=\"[expr $ps(SHORT_OFF_LEVEL)]\" />"
		append HTML_PARAMS(separate_$prn) "</td></tr>"
		
	} else {
		append HTML_PARAMS(separate_$prn) "<tr style=\"visibility:hidden;display:none\" id=\"upLevel_${special_input_id}_$prn\_1\"><td>\${UP_LEVEL}</td>"
		append HTML_PARAMS(separate_$prn) "<td>"
		append HTML_PARAMS(separate_$prn) "<input type=\"text\" id=\"separate_${special_input_id}_$prn\_3_temp\" name=\"SHORT_ON_LEVEL\" value=\"[format %.1f [expr $PROFILE_4(SHORT_ON_LEVEL) * 100]]\" onkeyup=\"ProofAndSetValue('separate_${special_input_id}_$prn\_3_temp', 'separate_${special_input_id}_$prn\_3', parseInt(0), parseInt(100), parseFloat(0.01));\" onmouseup=\"ProofAndSetValue('separate_${special_input_id}_$prn\_3_temp', 'separate_${special_input_id}_$prn\_3', parseInt(0), parseInt(100), parseFloat(0.01));\" onblur=\"ProofAndSetValue('separate_${special_input_id}_$prn\_3_temp', 'separate_${special_input_id}_$prn\_3', parseInt(0), parseInt(100), parseFloat(0.01));\" />\%"
		append HTML_PARAMS(separate_$prn) "<input type=\"hidden\" id=\"separate_${special_input_id}_$prn\_3\" name=\"SHORT_ON_LEVEL\" value=\"[expr $PROFILE_4(SHORT_ON_LEVEL)]\" />"
		append HTML_PARAMS(separate_$prn) "</div></td></tr>"
		
		append HTML_PARAMS(separate_$prn) "<tr style=\"visibility:hidden;display:none\" id=\"downLevel_${special_input_id}_$prn\_1\"><td>\${DOWN_LEVEL}</td>"
		append HTML_PARAMS(separate_$prn) "<td>"
		append HTML_PARAMS(separate_$prn) "<input type=\"text\" id=\"separate_${special_input_id}_$prn\_4_temp\" name=\"SHORT_OFF_LEVEL\" value=\"[format %.1f [expr $PROFILE_4(SHORT_OFF_LEVEL) * 100]]\" onkeyup=\"ProofAndSetValue('separate_${special_input_id}_$prn\_4_temp', 'separate_${special_input_id}_$prn\_4', parseInt(0), parseInt(100), parseFloat(0.01));\" onmouseup=\"ProofAndSetValue('separate_${special_input_id}_$prn\_4_temp', 'separate_${special_input_id}_$prn\_4', parseInt(0), parseInt(100), parseFloat(0.01));\" onblur=\"ProofAndSetValue('separate_${special_input_id}_$prn\_4_temp', 'separate_${special_input_id}_$prn\_4', parseInt(0), parseInt(100), parseFloat(0.01));\" />\%"
		append HTML_PARAMS(separate_$prn) "<input type=\"hidden\" id=\"separate_${special_input_id}_$prn\_4\" name=\"SHORT_OFF_LEVEL\" value=\"[expr $PROFILE_4(SHORT_OFF_LEVEL)]\" />"
		append HTML_PARAMS(separate_$prn) "</td></tr>"
	}
	
	set pref 5
	append HTML_PARAMS(separate_$prn) "<tr style=\"visibility:hidden;display:none\" id=\"upTime_${special_input_id}_$prn\_1\"><td>\${UP_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onclick=\"SwitchOption('separate_${special_input_id}_$prn\_6', 'separate_${special_input_id}_$prn\_5', \$('${special_input_id}_profiles'),6,'${special_input_id}');\" onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 6
	append HTML_PARAMS(separate_$prn) "<tr style=\"visibility:hidden;display:none\" id=\"downTime_${special_input_id}_$prn\_1\"><td>\${DOWN_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME|LONG_OFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME "onclick=\"SwitchOption('separate_${special_input_id}_$prn\_5', 'separate_${special_input_id}_$prn\_6', \$('${special_input_id}_profiles'),5,'${special_input_id}');\" onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFF_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 7
	append HTML_PARAMS(separate_$prn) "<tr style=\"visibility:hidden;display:none\" id=\"upDelayTime_${special_input_id}_$prn\_1\"><td>\${UP_DELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 8
	append HTML_PARAMS(separate_$prn) "<tr style=\"visibility:hidden;display:none\" id=\"downDelayTime_${special_input_id}_$prn\_1\"><td>\${DOWN_DELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFFDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
	append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">BLIND_setPosition('separate_${special_input_id}_$prn\_1');</script>"
	
}
constructor
