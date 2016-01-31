#!/bin/tclsh
#Kanal-EasyMode!

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]

set PROFILE_PNAME(LOAD_APPEAR_BEHAVIOUR) "\${stringTableDimmerLoadAppearBehaviour}"
set PROFILE_PNAME(LOGIC_COMBINATION) "\${stringTableLogicCombination}"
set PROFILE_PNAME(POWERUP_ACTION) "\${stringTableDimmerPowerUpAction}"
set PROFILE_PNAME(STATUSINFO_MINDELAY) "\${stringTableDimmerStatusInfoMinDelay}"
set PROFILE_PNAME(STATUSINFO_RANDOM) "\${stringTableDimmerStatusInfoRandom}"
set PROFILE_PNAME(TRANSMIT_TRY_MAX) "\${stringTableTransmitTryMax}"

set PROFILES_MAP(0)	"Experte"
set PROFILES_MAP(1)	"TheOneAndOnlyEasyMode"

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

	global env

	upvar PROFILES_MAP  PROFILES_MAP
	upvar HTML_PARAMS   HTML_PARAMS
	upvar PROFILE_PNAME PROFILE_PNAME
	upvar $pps          ps
	upvar $pps_descr    ps_descr

	foreach pro [array names PROFILES_MAP] {
		upvar PROFILE_$pro PROFILE_$pro
	}

  array_clear param_descr
	array set param_descr $ps_descr(STATUSINFO_MINDELAY)
	set minDelay_min [format {%1.2f} $param_descr(MIN)]
	set minDelay_max [format {%1.2f} $param_descr(MAX)]

  array_clear param_descr
	array set param_descr $ps_descr(STATUSINFO_RANDOM)
	set random_min [format {%1.2f} $param_descr(MIN)]
	set random_max [format {%1.2f} $param_descr(MAX)]

	array_clear param_descr
	array set param_descr $ps_descr(TRANSMIT_TRY_MAX)
	set tryMax_min $param_descr(MIN)
	set tryMax_max $param_descr(MAX)

	set ch [lindex [split $address ":"] 1]

	puts "<script type=\"text/javascript\">getLangInfo_Special('VIRTUAL_HELP.txt');</script>"

	append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\"><tr><td>"

    catch {
      array set loadAppearBehaviour "$ps_descr(LOAD_APPEAR_BEHAVIOUR)"
      append HTML_PARAMS(separate_1) "<tr><td>"
        array_clear options
        set options(0) "\${stringTableRestartOff}"
        set options(1) "\${stringTableRestartLast}"
        set options(2) "\${stringTableRestartButtonPress}"
        set options(3) "\${stringTableRestartButtonPressIfWasOn}"
        append HTML_PARAMS(separate_1) "<tr><td>$PROFILE_PNAME(LOAD_APPEAR_BEHAVIOUR)</td><td>"
        append HTML_PARAMS(separate_1) [get_ComboBox options LOAD_APPEAR_BEHAVIOUR separate_${special_input_id}_7 ps LOAD_APPEAR_BEHAVIOUR]
      append HTML_PARAMS(separate_1) "</td></tr>"
    }
		append HTML_PARAMS(separate_1) "<tr><td>"
			append HTML_PARAMS(separate_1) "<tr><td>$PROFILE_PNAME(LOGIC_COMBINATION)</td><td>"
			array_clear options
		  set options(0) "\${stringTableLogicInactive}"
			set options(1) "\${stringTableLogicOR}"
			set options(2) "\${stringTableLogicAND}"
			set options(3) "\${stringTableLogicXOR}"
			set options(4) "\${stringTableLogicNOR}"
			set options(5) "\${stringTableLogicNAND}"
			set options(6) "\${stringTableLogicORINVERS}"
			set options(7) \${stringTableLogicANDINVERS}"
			set options(8) "\${stringTableLogicPLUS}"
			set options(9) "\${stringTableLogicMINUS}"
			set options(10) "\${stringTableLogicMUL}"
			set options(11) "\${stringTableLogicPLUSINVERS}"
			set options(12) "\${stringTableLogicMINUSINVERS}"
      set options(13) "\${stringTableLogicMULINVERS}"
			set options(14) "\${stringTableLogicINVERSPLUS}"
			set options(15) "\${stringTableLogicINVERSMINUS}"
			set options(16) "\${stringTableLogicINVERSMUL}"
			append HTML_PARAMS(separate_1) [get_ComboBox options LOGIC_COMBINATION separate_${special_input_id}_6 ps LOGIC_COMBINATION]

			append HTML_PARAMS(separate_1) "&nbsp<input class=\"j_helpBtn\" id=\"virtual_help_button_$ch\" type=\"button\" value=\"Hilfe\" onclick=\"Virtual_DimmerChannel_help($ch);\">"
		append HTML_PARAMS(separate_1) "</td></tr>"


		append HTML_PARAMS(separate_1) "<tr><td>"
			append HTML_PARAMS(separate_1) "<tr><td>$PROFILE_PNAME(POWERUP_ACTION)</td><td>"
			array_clear options
			set options(0) "\${stringTablePowerUpOFF}"
			set options(1) "\${stringTablePowerUpON}"
			append HTML_PARAMS(separate_1) [get_ComboBox options POWERUP_ACTION separate_${special_input_id}_2 ps POWERUP_ACTION]
			append HTML_PARAMS(separate_1) "</td></tr>"
		append HTML_PARAMS(separate_1) "</td></tr>"

		append HTML_PARAMS(separate_1) "<tr><td>"

		append HTML_PARAMS(separate_1) "<tr><td>$PROFILE_PNAME(STATUSINFO_MINDELAY)</td><td>"
			set options(0) "\${stringTableNotUsed}"
			set options(1) "\${stringTableEnterValue}"

			append HTML_PARAMS(separate_1) [get_ComboBox options STATUSINFO_MINDELAY separate_${special_input_id}_3 ps STATUSINFO_MINDELAY "onchange=\"setMinDelayVisibility($ch, $ps(STATUSINFO_MINDELAY));\""]
			append HTML_PARAMS(separate_1) "<input type=\"text\" id= separate_${special_input_id}_4 name=\"STATUSINFO_MINDELAY\" value=[format {%1.2f} $ps(STATUSINFO_MINDELAY)]></td>"
			append HTML_PARAMS(separate_1) "<td> s ($minDelay_min - $minDelay_max)</td>"

			puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/DIMMER/dimmer_virt.js');</script>"
			append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
			append HTML_PARAMS(separate_1) "var freeValue = document.getElementById('separate_CHANNEL_$ch\_4');"
			append HTML_PARAMS(separate_1) "var option = document.getElementById('separate_CHANNEL_$ch\_3');"
			append HTML_PARAMS(separate_1) "if(freeValue.value > 0) {option.selectedIndex = 1;}"
		  append HTML_PARAMS(separate_1) " else {option.selectedIndex = 0;freeValue.style.display = \"none\"}"
			append HTML_PARAMS(separate_1) "setMinDelayVisibility($ch, $ps(STATUSINFO_MINDELAY));"
			append HTML_PARAMS(separate_1) "</script>"
		append HTML_PARAMS(separate_1) "</td></tr>"

	 	append HTML_PARAMS(separate_1) "<tr id=\"stateInfoRandom_$ch\"><td>$PROFILE_PNAME(STATUSINFO_RANDOM)</td>"
			append HTML_PARAMS(separate_1) "<td>[get_InputElem STATUSINFO_RANDOM  separate_${special_input_id}_5 ps tmp_STATUSINFO_RANDOM]</td>"
			append HTML_PARAMS(separate_1) "<td>s ($random_min - $random_max)</td>"
		append HTML_PARAMS(separate_1) "</tr>"

		append HTML_PARAMS(separate_1) "</td></tr>"

		append HTML_PARAMS(separate_1) "<tr><td>$PROFILE_PNAME(TRANSMIT_TRY_MAX)</td><td>"
			append HTML_PARAMS(separate_1) "[get_InputElem TRANSMIT_TRY_MAX  separate_${special_input_id}_1 ps TRANSMIT_TRY_MAX]</td>"
			append HTML_PARAMS(separate_1) "<td> ($tryMax_min - $tryMax_max)</td>"
		append HTML_PARAMS(separate_1) "</td></tr>"
	append HTML_PARAMS(separate_1) "</td></tr></table>"

	append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\" id=\"virtual_ch_help_$ch\" style=\"display:none\">"
	#set help_txt "<span class=\"CLASS22015\"><b>Die Hilfe steht leider nicht zur Verf&uuml;gung!<b></span>"
	#catch {source [file join $env(DOCUMENT_ROOT) config/virtualHelp.tcl]}
	#append HTML_PARAMS(separate_1) "<tr><td>$help_txt</td></tr>"

	append HTML_PARAMS(separate_1) "<tr><td>\${virtualHelpTxt}</td></tr>"

	append HTML_PARAMS(separate_1) "</table>"

	puts "<script type=\"text/javascript\">"
	  puts "jQuery(\".j_helpBtn\").val(translateKey(\"helpBtnTxt\"));"
	puts "</script>"
}

constructor
