#!/bin/tclsh

# hier koennen die Einheiten fuer die Zeitangaben in den Easymodeprofilen geaendert werden

set unit_hour	"h"
set unit_min	"min"
set unit_sec	"s"
set unit_perc	"%"
set unit_temp   " &deg;C"
set unit_cf		"0"
set free_value	"\${enterValue}"

proc GetTempUnit {} {
	
	# Funktion nur fÃ¼r den Heizungsregler HM-CC-TC verwenden, da
	# der Kanal der Receiver-Adresse manipuliert werden muss.
	# Es muss immer Kanal 2 gewÃ¤hlt werden, um die im Regler
	# eingestellte Einheit C/F zu erhalten.

	global url receiver_address unit_temp 
#	der Kanal von receiver-address wird fix auf 2 gestellt
	set receiver_address [lreplace [split $receiver_address ":"] 1 1 2]
	set receiver_address [join $receiver_address :]	
	
	array set dev_ps [xmlrpc $url getParamset $receiver_address MASTER]
	catch {
    switch $dev_ps(DISPLAY_TEMPERATUR_UNIT) {

        0	{set unit_temp	" &deg;C"; return 0}
        1	{set unit_temp	" &deg;F"; return 1}
      default {set unit_temp	" *"; return -1}
    }
  }
  return 0
}

proc EnterTime_h_m_s {profile pref special_input_id ps_descr param} {
	
	global dev_descr_sender 

	upvar HTML_PARAMS HTML_PARAMS
	upvar ps_descr descr 
	
	set id "$profile\_$pref\_$special_input_id"

	array_clear param_descr
	array set param_descr $descr($param)
	set min $param_descr(MIN)
	set max $param_descr(MAX)

	if {$dev_descr_sender(TYPE) == "MOTION_DETECTOR"} {
		append HTML_PARAMS(separate_$profile) "<script type=\"text/javascript\">ProofFreeTime('hour_$id', $min, $max);</script>"
	}

	append HTML_PARAMS(separate_$profile) "<div id=\"vis_hour_$id\" style=\"display:none\" name=\"vis_hour_$id\" title=\${hour}>"
	append HTML_PARAMS(separate_$profile) "<input type=\"text\" id=\"hour_$id\" size=\"2\" name=\"hour_$id\" value=\"00\" style=\"text-align:center\" onchange=\"ProofFreeTime('hour_$id', $min, $max);\"> " 
	append HTML_PARAMS(separate_$profile) ": </div>"
	
	append HTML_PARAMS(separate_$profile) "<div id=\"vis_min_$id\" style=\"display:none\" name=\"vis_min_$id\" title=\${minutes}>"
	append HTML_PARAMS(separate_$profile) "<input type=\"text\" id=\"min_$id\" size=\"2\" name=\"min_$id\" value=\"00\" style=\"text-align:center\" onchange=\"ProofFreeTime('min_$id', $min ,$max);\"> "
	append HTML_PARAMS(separate_$profile) ": </div>"

	append HTML_PARAMS(separate_$profile) "<div id=\"vis_sec_$id\" style=\"display:none\" name=\"vis_sec_$id\" title=\${seconds}>"
	append HTML_PARAMS(separate_$profile) "<input type=\"text\" id=\"sec_$id\" size=\"2\" name=\"sec_$id\" value=\"00\" style=\"text-align:center\" onchange=\"ProofFreeTime('sec_$id', $min, $max);\"> "
	append HTML_PARAMS(separate_$profile) "</div>"

}

proc EnterPercent {profile pref special_input_id ps_descr param} {
	upvar HTML_PARAMS HTML_PARAMS
	upvar ps_descr descr
	
	set id "$profile\_$pref\_$special_input_id"
	
	array_clear param_descr
	array set param_descr $descr($param)
	set min $param_descr(MIN)
	set max $param_descr(MAX)
	
	append HTML_PARAMS(separate_$profile) "<div id=\"vis_percent_$id\" style=\"display:none\" name=\"vis_percent_$id\">"
	append HTML_PARAMS(separate_$profile) "<input type=\"text\" id=\"percent_$id\" size=\"2\" name=\"percent_$id\" value=\"00\" style=\"text-align:center\" onchange=\"ProofFreePercent('percent_$id', $min, $max);\"> " 
	append HTML_PARAMS(separate_$profile) "% </div>"

}

proc EnterTemp {profile pref special_input_id ps_descr unit_cf param} {
	# unit_cf = 0 = Grad Celsius
	# unit_cf = 1 = Grad Fahrenheit
	global unit_temp
	upvar HTML_PARAMS HTML_PARAMS
	upvar ps_descr descr
	
	set id "$profile\_$pref\_$special_input_id"
	
	array_clear param_descr
	array set param_descr $descr($param)
	set min $param_descr(MIN)
	set max $param_descr(MAX)
	
	set default 12
	if {$unit_cf} {set default [expr $default * 9 / 5 + 32]}
	
	append HTML_PARAMS(separate_$profile) "<div id=\"vis_temp_$id\" style=\"display:none\" name=\"vis_temp_$id\">"
	append HTML_PARAMS(separate_$profile) "<input type=\"text\" id=\"temp_$id\" size=\"2\" name=\"temp_$id\" value=\"$default\" style=\"text-align:center\" onchange=\"ProofFreeTemp('temp_$id', $min, $max, $unit_cf);\"> " 
	append HTML_PARAMS(separate_$profile) "$unit_temp</div>"
}

proc EnterPulse {special_input_id ps_descr pulse_values} {
	# special_input_id = CHANNEL_1 bzw. CHANNEL_2
	
	upvar HTML_PARAMS HTML_PARAMS
	upvar ps_descr descr
	set id "$special_input_id"
	
	append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\" id=\"PulseTbl_$id\" style=\"display:none; table-layout:fixed; empty-cells:show\" >"

	for {set loop 1} {$loop <= 5} {incr loop} {
		set opt_value [lindex $pulse_values [expr $loop - 1]]
		set param "SEQUENCE_PULSE_$loop"
	
		array_clear param_descr
		array set param_descr $descr($param)
		set min [format {%1.3f} $param_descr(MIN)]
		set max [format {%1.3f} $param_descr(MAX)]

		append HTML_PARAMS(separate_1) "<tr><td style=\"width:12.5%\"> <span class=\"stringtable_value\">PULSE_SENSOR|$param</span> </td><td style=\"width:13.5%\">"
		append HTML_PARAMS(separate_1) "<div id=\"vis_pulse\_$loop\_$id\" style=\"display:inline\" >"
		append HTML_PARAMS(separate_1) "<select id=\"separate_$id\_$loop\_temp\" size=\"1\" name=\"SEQUENCE_PULSE_$loop\" class=\"stringtable_select\"style=\"text-align:center\" onchange =\"SenEP_activateEnterFreePulse('$id\_$loop', $min);\"> "
		append HTML_PARAMS(separate_1) "<option> $opt_value</option>"
		append HTML_PARAMS(separate_1) "<option>\${stringTableEnterValue}</option>"
		append HTML_PARAMS(separate_1) "<option>PULSE_SENSOR|SEQUENCE_PULSE_$loop=NOT_USED</option>"
		append HTML_PARAMS(separate_1) "</select><br /></div></td>"
	
		append HTML_PARAMS(separate_1) "<td style=\"width:25%\">"
		append HTML_PARAMS(separate_1) "<div id=\"vis_free_$id\_$loop\" style=\"display:none\" >"
		append HTML_PARAMS(separate_1) "<input type=\"text\" id=\"free_$id\_$loop\" size=\"8\" name=\"pulse_$loop\" style=\"text-align:center\" onchange=\"ProofFreeValue('free_$id\_$loop', $min, $max);\"> " 
		
		append HTML_PARAMS(separate_1) " s ($min - $max)</div></td>"

		if {$loop == 2} { 
			#append HTML_PARAMS(separate_1) "<td name=\"senEPImage\" rowspan=\"3\" colspan=\"6\" style=\"width: auto; background-image:url(/ise/img/hm-sen-ep.png); background-repeat:no-repeat\"></td>"
			append HTML_PARAMS(separate_1) "<td name=\"senEPImage\" rowspan=\"3\" colspan=\"6\" style=\"width: auto; background-repeat:no-repeat\"></td>"
			append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
			  append HTML_PARAMS(separate_1) "jQuery(\"\[name=senEPImage\]\").css(\"backgroundImage\", \"url(/ise/img/lang/\"+getLang()+\"/hm-sen-ep.png)\");"
			append HTML_PARAMS(separate_1) "</script>"

		}
		
		append HTML_PARAMS(separate_1) "</tr>"
	}
		set opt_value [format {%1.3f} [lindex $pulse_values 5]]
		set param "SEQUENCE_TOLERANCE"
		
		array_clear param_descr
		array set param_descr $descr($param)
		set min [format {%1.3f} $param_descr(MIN)]
		set max [format {%1.3f} $param_descr(MAX)]
		
		append HTML_PARAMS(separate_1) "<tr><td> <span class=\"stringtable_value\">PULSE_SENSOR|SEQUENCE_TOLERANCE</span> </td><td>"
		append HTML_PARAMS(separate_1) "<div id=\"vis_pulse\_$loop\_$id\" style=\"display:inline\" >"
		append HTML_PARAMS(separate_1) "<select id=\"separate_$id\_6_temp\" size=\"1\" name=\"SEQUENCE_TOLERANCE\" style=\"text-align:center\" onchange =\"SenEP_activateEnterFreePulse('$id\_6', $min);\"> "
		append HTML_PARAMS(separate_1) "<option> $opt_value</option>"
		append HTML_PARAMS(separate_1) "<option>\${stringTableEnterValue}</option>"
		append HTML_PARAMS(separate_1) "</select><br/></div> </td>"
	
		append HTML_PARAMS(separate_1) "<td>"
		append HTML_PARAMS(separate_1) "<div id=\"vis_free_$id\_6\" style=\"display:none\" >"
		append HTML_PARAMS(separate_1) "<input type=\"text\" id=\"free_$id\_6\" size=\"8\" name=\"pulse_6\" style=\"text-align:center\" onchange=\"ProofFreeValue('free_$id\_6', $min, $max);\"> " 
		append HTML_PARAMS(separate_1) " s ($min - $max)</td>"
		append HTML_PARAMS(separate_1) "</div></tr>"


		append HTML_PARAMS(separate_1) "</table>"
		append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">st_setStringTableValues();</script>"
}


proc EnterBrightness {profile pref special_input_id ps ps_descr param} {
	
	global url receiver_address sender_address 

	upvar HTML_PARAMS HTML_PARAMS
	upvar ps_descr descr
	upvar ps vdescr 

	set id "separate\_$special_input_id\_$profile\_$pref"

	array_clear param_descr
	array set param_descr $descr($param)
	set min $param_descr(MIN)
	set max $param_descr(MAX)
	
	puts "<script type=\"text/javascript\">"
		puts "MD_catchBrightness('$url', '$sender_address', '$receiver_address', 'false', '$id','','')"
	puts "</script>"

	append HTML_PARAMS(separate_$profile) "<table id=\"bright\_$profile\" class=\"ProfileTbl\" style=\"visibility:hidden\">"
	append HTML_PARAMS(separate_$profile) "<tr><td></td></tr><tr><td id=\"param\_$profile\_a\"><textarea id=\"profile\_$profile\_a\" style=\"display:none\">\${BRIGHTNESS_CONTROL}</textarea></td>"

	append HTML_PARAMS(separate_$profile) "<td><input type=\"text\" id=\"$id\" size=\"3\" name=\"$param\" value=\"$vdescr($param)\" style=\"text-align:center\" onchange=\"MD_init('$id', $min, $max);\"> " 
	append HTML_PARAMS(separate_$profile) "<input id=\"help_brightness\_$profile\" type=\"button\" name=\"Help\" value=\"Help\" onclick=\"MD_catchBrightness('$url', '$sender_address', '$receiver_address', 'true', '$id','help', '$min $max')\"></td></tr>"
	
	append HTML_PARAMS(separate_$profile) "<tr><td>"

	# Falls noch kein aktueller Helligkeitswert zur VerfÃ¼gung steht, soll  folgendes nicht sichtbar sein
	append HTML_PARAMS(separate_$profile) "<div id=\"brightDescr\_$profile\" style=\"display:none\">"	
	append HTML_PARAMS(separate_$profile) "<div id=\"div_bright\_$profile\"><textarea id=\"text_bright\_$profile\" style=\"display:none\">"
	append HTML_PARAMS(separate_$profile) "\${GET_CURRENT_BRIGHTNESS}"
	append HTML_PARAMS(separate_$profile) "</textarea></div></td>"
	append HTML_PARAMS(separate_$profile) "<script type=\"text/javascript\">\$('div_bright\_$profile').innerHTML = TrimPath.processDOMTemplate('text_bright\_$profile', localized\[0\]);</script>"	
	# Ende unsichtbar
	append HTML_PARAMS(separate_$profile) "</div>"	
	
	append HTML_PARAMS(separate_$profile) "<td><input type=\"hidden\" id=\"$id\_tmp\" size=\"3\" name=\"$param\_tmp\" value=\"$vdescr($param)\"> " 
	# Falls noch kein aktueller Helligkeitswert zur VerfÃ¼gung steht, soll  folgendes nicht sichtbar sein
	append HTML_PARAMS(separate_$profile) "<div id=\"okButton_$profile\" style=\"display:none\">"	
	append HTML_PARAMS(separate_$profile) "<input id=\"ok_brightness_$profile\" type=\"button\" name=\"catchBrightness\" value=\"OK\" onclick=\"MD_catchBrightness('$url', '$sender_address', '$receiver_address', 'true', '$id','setEasymode','')\">"
	# Ende unsichtbar
	append HTML_PARAMS(separate_$profile) "</div>"	
	append HTML_PARAMS(separate_$profile) "<script type=\"text/javascript\">\$('help_brightness\_$profile').value = localized\[0\]\['help'\];</script>"	
	append HTML_PARAMS(separate_$profile) "<script type=\"text/javascript\">\$('ok_brightness\_$profile').value = localized\[0\]\['ok'\];</script>"	
	
	append HTML_PARAMS(separate_$profile) "</td></tr>"


	append HTML_PARAMS(separate_$profile) "</td></tr></table>"
	append HTML_PARAMS(separate_$profile) "<script type=\"text/javascript\">if( \$('bright\_$profile').style.visibility == \'hidden\') { \$('param\_$profile\_a').innerHTML = TrimPath.processDOMTemplate('profile\_$profile\_a', localized\[0\])} ;"	
	append HTML_PARAMS(separate_$profile) "\$('bright\_$profile').style.visibility = \"visible\";</script>"	

}


