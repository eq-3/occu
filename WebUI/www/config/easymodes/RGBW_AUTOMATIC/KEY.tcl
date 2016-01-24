#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]

set PROFILES_MAP(0)	"\${expert}"
set PROFILES_MAP(1)	"\${dec_Program}"
set PROFILES_MAP(2)	"\${inc_Program}"
set PROFILES_MAP(3)	"\${set_Program}"

set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)		"Expertenprofil"
set PROFILE_0(UI_TEMPLATE)			"Expertenprofil"

set PROFILE_1(SHORT_ACT_COLOR_PROGRAM)	2
set PROFILE_1(SHORT_ACT_MIN_BOARDER)		{0 range 0 - 255}
set PROFILE_1(SHORT_ACT_MAX_BOARDER)		{0 range 0 - 255}
set PROFILE_1(LONG_ACT_COLOR_PROGRAM)		253
set PROFILE_1(LONG_ACT_MIN_BOARDER)	  	{0 range 0 - 255}
set PROFILE_1(LONG_ACT_MAX_BOARDER)	  	{0 range 0 - 255}
set PROFILE_1(UI_DESCRIPTION)	"Mit einem kurzen oder langen Tastendruck wird ....."
set PROFILE_1(UI_TEMPLATE)		$PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)	1

set PROFILE_2(SHORT_ACT_COLOR_PROGRAM)	0
set PROFILE_2(SHORT_ACT_MIN_BOARDER)		{0 range 0 - 255}
set PROFILE_2(SHORT_ACT_MAX_BOARDER)		{0 range 0 - 255}
set PROFILE_2(LONG_ACT_COLOR_PROGRAM)		254
set PROFILE_2(LONG_ACT_MIN_BOARDER)	  	{0 range 0 - 255}
set PROFILE_2(LONG_ACT_MAX_BOARDER)	  	{0 range 0 - 255}
set PROFILE_2(UI_DESCRIPTION)	"Mit einem kurzen oder langen Tastendruck wird ....."
set PROFILE_2(UI_TEMPLATE)		$PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)	2

set PROFILE_3(SHORT_ACT_COLOR_PROGRAM)	{0 range 0 - 6}
set PROFILE_3(SHORT_ACT_MIN_BOARDER)		{0 range 0 - 255}
set PROFILE_3(SHORT_ACT_MAX_BOARDER)		{0 range 0 - 255}
set PROFILE_3(LONG_ACT_COLOR_PROGRAM)		{0 range 0 - 6}
set PROFILE_3(LONG_ACT_MIN_BOARDER)	  	{0 range 0 - 255}
set PROFILE_3(LONG_ACT_MAX_BOARDER)	  	{0 range 0 - 255}
set PROFILE_3(UI_DESCRIPTION)	"Mit einem kurzen oder langen Tastendruck wird ....."
set PROFILE_3(UI_TEMPLATE)		$PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)	3

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
	
	global env receiver_address dev_descr_sender dev_descr_receiver
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
	puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/RGBW_Controller.js')</script>"

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

	append HTML_PARAMS(separate_$prn) "<tr><td>\${lblColorValueMin}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_ACT_MIN_BOARDER separate_${special_input_id}_$prn\_$pref ps SHORT_ACT_MIN_BOARDER "onchange=\"setValueLONG('$special_input_id', $prn, $pref);\" " ]</td>"
	append HTML_PARAMS(separate_$prn) "<td><input id=\"borderColorActive_${special_input_id}_$prn\_$pref\" type=\"checkbox\"><label for=\"borderColorActive_${special_input_id}_$prn\_$pref\">\${active_1}</label></td>"
	append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"javascript\">"
  append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {activateColorPickerMinMax($ps(SHORT_ACT_MIN_BOARDER), separate_${special_input_id}_$prn\_$pref);}, 200);"
  append HTML_PARAMS(separate_$prn) "</script>"

  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${lblColorValueMax}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_ACT_MAX_BOARDER separate_${special_input_id}_$prn\_$pref ps SHORT_ACT_MAX_BOARDER "onchange=\"setValueLONG('$special_input_id', $prn, $pref);\" "]</td>"
	append HTML_PARAMS(separate_$prn) "<td><input id=\"borderColorActive_${special_input_id}_$prn\_$pref\" type=\"checkbox\"><label for=\"borderColorActive_${special_input_id}_$prn\_$pref\">\${active_1}</label></td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"javascript\">"
  append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {activateColorPickerMinMax($ps(SHORT_ACT_MAX_BOARDER), separate_${special_input_id}_$prn\_$pref);}, 200);"
  append HTML_PARAMS(separate_$prn) "</script>"

  incr pref ;# 3
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td>LONG Start</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_ACT_MIN_BOARDER separate_${special_input_id}_$prn\_$pref ps LONG_ACT_MIN_BOARDER]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"

  incr pref ;# 4
  append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td>LONG END</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_ACT_MAX_BOARDER separate_${special_input_id}_$prn\_$pref ps LONG_ACT_MAX_BOARDER]</td>"
  append HTML_PARAMS(separate_$prn) "</tr>"

	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#2
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}

	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${lblColorValueMin}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_ACT_MIN_BOARDER separate_${special_input_id}_$prn\_$pref ps SHORT_ACT_MIN_BOARDER "onchange=\"setValueLONG('$special_input_id', $prn, $pref);\" "]</td>"
	append HTML_PARAMS(separate_$prn) "<td><input id=\"borderColorActive_${special_input_id}_$prn\_$pref\" type=\"checkbox\"><label for=\"borderColorActive_${special_input_id}_$prn\_$pref\">\${active_1}</label></td>"
	append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"javascript\">"
  append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {activateColorPickerMinMax($ps(SHORT_ACT_MIN_BOARDER), separate_${special_input_id}_$prn\_$pref);}, 200);"
  append HTML_PARAMS(separate_$prn) "</script>"

  incr pref ;# 2
  append HTML_PARAMS(separate_$prn) "<tr><td>\${lblColorValueMax}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_ACT_MAX_BOARDER separate_${special_input_id}_$prn\_$pref ps SHORT_ACT_MAX_BOARDER "onchange=\"setValueLONG('$special_input_id', $prn, $pref);\" "]</td>"
	append HTML_PARAMS(separate_$prn) "<td><input id=\"borderColorActive_${special_input_id}_$prn\_$pref\" type=\"checkbox\"><label for=\"borderColorActive_${special_input_id}_$prn\_$pref\">\${active_1}</label></td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"javascript\">"
  append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {activateColorPickerMinMax($ps(SHORT_ACT_MAX_BOARDER), separate_${special_input_id}_$prn\_$pref);}, 200);"
  append HTML_PARAMS(separate_$prn) "</script>"

    incr pref ;# 3
    append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td>LONG Start</td>"
    append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_ACT_MIN_BOARDER separate_${special_input_id}_$prn\_$pref ps LONG_ACT_MIN_BOARDER]</td>"
    append HTML_PARAMS(separate_$prn) "</tr>"

    incr pref ;# 4
    append HTML_PARAMS(separate_$prn) "<tr class=\"hidden\"><td>LONG END</td>"
    append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_ACT_MAX_BOARDER separate_${special_input_id}_$prn\_$pref ps LONG_ACT_MAX_BOARDER]</td>"
    append HTML_PARAMS(separate_$prn) "</tr>"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}

	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${lblShortKeyPress}</td><td>"

  set options(0) "\${optionPrg0}"
  set options(1) "\${optionPrg1}"
  set options(2) "\${optionPrg2}"
  set options(3) "\${optionPrg3}"
  set options(4) "\${optionPrg4}"
  set options(5) "\${optionPrg5}"
  set options(6) "\${optionPrg6}"

  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ACT_COLOR_PROGRAM separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ACT_COLOR_PROGRAM]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref; #2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${lblColorValueMin}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_ACT_MIN_BOARDER separate_${special_input_id}_$prn\_$pref ps SHORT_ACT_MIN_BOARDER "_onchange=\"setValueLONG('$special_input_id', $prn, $pref);\" "]</td>"
	append HTML_PARAMS(separate_$prn) "<td><input id=\"borderColorActive_${special_input_id}_$prn\_$pref\" type=\"checkbox\"><label for=\"borderColorActive_${special_input_id}_$prn\_$pref\">\${active_1}</label></td>"
	append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"javascript\">"
  append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {activateColorPickerMinMax($ps(SHORT_ACT_MIN_BOARDER), separate_${special_input_id}_$prn\_$pref);}, 200);"
  append HTML_PARAMS(separate_$prn) "</script>"

  incr pref ;# 3
  append HTML_PARAMS(separate_$prn) "<tr><td>\${lblColorValueMax}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem SHORT_ACT_MAX_BOARDER separate_${special_input_id}_$prn\_$pref ps SHORT_ACT_MAX_BOARDER "_onchange=\"setValueLONG('$special_input_id', $prn, $pref);\" "]</td>"
	append HTML_PARAMS(separate_$prn) "<td><input id=\"borderColorActive_${special_input_id}_$prn\_$pref\" type=\"checkbox\"><label for=\"borderColorActive_${special_input_id}_$prn\_$pref\">\${active_1}</label></td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"javascript\">"
  append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {activateColorPickerMinMax($ps(SHORT_ACT_MAX_BOARDER), separate_${special_input_id}_$prn\_$pref);}, 200);"
  append HTML_PARAMS(separate_$prn) "</script>"

  append HTML_PARAMS(separate_$prn) "<tr><td><hr></td></tr>"

  incr pref ;# 4
  append HTML_PARAMS(separate_$prn) "<tr><td>\${lblLongKeyPress}</td><td>"

  set options(0) "\${optionPrg0}"
  set options(1) "\${optionPrg1}"
  set options(2) "\${optionPrg2}"
  set options(3) "\${optionPrg3}"
  set options(4) "\${optionPrg4}"
  set options(5) "\${optionPrg5}"
  set options(6) "\${optionPrg6}"

  append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_ACT_COLOR_PROGRAM separate_${special_input_id}_$prn\_$pref PROFILE_$prn LONG_ACT_COLOR_PROGRAM]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref; #5
	append HTML_PARAMS(separate_$prn) "<tr><td>\${lblColorValueMin}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_ACT_MIN_BOARDER separate_${special_input_id}_$prn\_$pref ps LONG_ACT_MIN_BOARDER "_onchange=\"setValueLONG('$special_input_id', $prn, $pref);\" "]</td>"
	append HTML_PARAMS(separate_$prn) "<td><input id=\"borderColorActive_${special_input_id}_$prn\_$pref\" type=\"checkbox\"><label for=\"borderColorActive_${special_input_id}_$prn\_$pref\">\${active_1}</label></td>"
	append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"javascript\">"
  append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {activateColorPickerMinMax($ps(LONG_ACT_MIN_BOARDER), separate_${special_input_id}_$prn\_$pref);}, 200);"
  append HTML_PARAMS(separate_$prn) "</script>"

  incr pref ;# 6
  append HTML_PARAMS(separate_$prn) "<tr><td>\${lblColorValueMax}</td>"
  append HTML_PARAMS(separate_$prn) "<td>[get_InputElem LONG_ACT_MAX_BOARDER separate_${special_input_id}_$prn\_$pref ps LONG_ACT_MAX_BOARDER "_onchange=\"setValueLONG('$special_input_id', $prn, $pref);\" "]</td>"
	append HTML_PARAMS(separate_$prn) "<td><input id=\"borderColorActive_${special_input_id}_$prn\_$pref\" type=\"checkbox\"><label for=\"borderColorActive_${special_input_id}_$prn\_$pref\">\${active_1}</label></td>"
  append HTML_PARAMS(separate_$prn) "</tr>"
  append HTML_PARAMS(separate_$prn) "<script type=\"javascript\">"
  append HTML_PARAMS(separate_$prn) "window.setTimeout(function() {activateColorPickerMinMax($ps(LONG_ACT_MAX_BOARDER), separate_${special_input_id}_$prn\_$pref);}, 200);"
  append HTML_PARAMS(separate_$prn) "</script>"

	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}

constructor

