#!/bin/tclsh
source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]

set PROFILES_MAP(0)	"Experte"
#set PROFILES_MAP(1)	"Sturmschwelle"
set PROFILES_MAP(1)	"\${weatherProfile1}"

set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION) "Expertenprofil"
set PROFILE_0(UI_TEMPLATE) "Expertenprofil"

set range {1 2 5 12 25 29 39 50 62 75 89 103 118}
set PROFILE_1(STORM_UPPER_THRESHOLD) $range
set PROFILE_1(STORM_LOWER_THRESHOLD) $range
# set PROFILE_1(UI_DESCRIPTION) "<br>Windst&auml;rke in Beaufort"
set PROFILE_1(UI_DESCRIPTION) "<br>\${windInBeaufort}"
set PROFILE_1(UI_TEMPLATE)	"Windst&auml;rke in Beaufort"
set PROFILE_1(UI_HINT)	1

set multilingual 1

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

	global dev_descr_sender dev_descr_receiver sender_address
	set ACTOR $dev_descr_receiver(TYPE) 
	# Kanal aus der Senderaddresse entfernen, aus EDD00001234:1 wird EDD00001234
	set sender_addr [string toupper [string range $sender_address 0 [expr [string first ":" $sender_address] -1] ]] 
	catch {puts "<input type=\"hidden\" id=\"dev_descr_sender_tmp\" value=\"$dev_descr_sender(TYPE)-$sender_addr\">"}
	catch {puts "<input type=\"hidden\" id=\"dev_descr_receiver_tmp\" value=\"$ACTOR\">"}

	# bei Verknuepfung Wetterstation - Kombisensor sinnlos	
	if {$ACTOR != "WS_CS"} {
		
		upvar PROFILES_MAP  PROFILES_MAP
		upvar HTML_PARAMS   HTML_PARAMS
		upvar PROFILE_PNAME PROFILE_PNAME
		upvar $pps          ps      
		upvar $pps_descr    ps_descr

		
		foreach pro [array names PROFILES_MAP] {
			upvar PROFILE_$pro PROFILE_$pro
		}
		
		set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]

		append HTML_PARAMS(separate_0) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_0]
		
		array_clear options
		set options(1)		"\${windForce0}"
		set options(2)		"\${windForce1}"
		set options(5)		"\${windForce2}"
		set options(12)		"\${windForce3}"
		set options(25)		"\${windForce4}"
		set options(29)		"\${windForce5}"
		set options(39)		"\${windForce6}"
		set options(50)		"\${windForce7}"
		set options(62)		"\${windForce8}"
		set options(75)		"\${windForce9}"
		set options(89)		"\${windForce10}"
		set options(103)	"\${windForce11}"
		set options(118)	"\${windForce12}"

		# obere Sturmschwelle
		
		append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\"><tr><td></td><td>"
		append HTML_PARAMS(separate_1) $PROFILE_1(UI_DESCRIPTION)
		append HTML_PARAMS(separate_1) "</td></tr><tr><td>"
		#append HTML_PARAMS(separate_1) "<span id=\"ein\">Einschaltschwelle</span>"
		append HTML_PARAMS(separate_1) "<span id=\"ein\">\${upperStormThreshold}</span>"
		append HTML_PARAMS(separate_1) "</td><td>"

		if {$cur_profile == 1} then {
			append HTML_PARAMS(separate_1) "<div id=\"title0\" title=\"Schaltbefehl bei &uuml;berschreiten der eingestellten Schaltschwelle\">"
			append HTML_PARAMS(separate_1) [get_ComboBox options STORM_UPPER_THRESHOLD separate_${special_input_id}_1_1 ps        STORM_UPPER_THRESHOLD "onchange=\"WEATHER_put_desc('separate_${special_input_id}_1_1',1);\""]
			append HTML_PARAMS(separate_1) "<script type=\"javascript\"> WEATHER_put_desc('separate_${special_input_id}_1_1',0); </script></div>"
		} else {
			append HTML_PARAMS(separate_1) [get_ComboBox options STORM_UPPER_THRESHOLD separate_${special_input_id}_1_1 PROFILE_1 STORM_UPPER_THRESHOLD "onchange=\"WEATHER_put_desc('separate_${special_input_id}_1_1',1);\""]
			append HTML_PARAMS(separate_1) "<script type=\"javascript\"> WEATHER_put_desc('separate_${special_input_id}_1_1',0); </script>"
		}
		append HTML_PARAMS(separate_1)	"</td></tr><tr><td></td><td><span id=\"upper_desc\">&nbsp;</span><br><br>"
		append HTML_PARAMS(separate_1) "</td></tr>"
		append HTML_PARAMS(separate_1) "</table>"
		
		# untere Sturmschwelle
		append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\" id=\"lower_tab\" style=\"display:block\">"
		append HTML_PARAMS(separate_1) "<tr><td>"
		#append HTML_PARAMS(separate_1) "<span id=\"aus\">Ausschaltschwelle</span>"
		append HTML_PARAMS(separate_1) "<span id=\"aus\">\${lowerStormThreshold}</span>"
		append HTML_PARAMS(separate_1)  
		append HTML_PARAMS(separate_1) "</td><td>"
		
		if {$cur_profile == 1} then {
			append HTML_PARAMS(separate_1) "<div id=\"title1\" title=\"Schaltbefehl bei unterschreiten der eingestellten Schaltschwelle\">"
			append HTML_PARAMS(separate_1) [get_ComboBox options STORM_LOWER_THRESHOLD separate_${special_input_id}_1_2 ps        STORM_LOWER_THRESHOLD "onchange=\"WEATHER_put_desc('separate_${special_input_id}_1_2',1);\""]
			append HTML_PARAMS(separate_1) "<script type=\"javascript\"> WEATHER_put_desc('separate_${special_input_id}_1_2',0); </script></div>"
		} else {
			append HTML_PARAMS(separate_1) [get_ComboBox options STORM_LOWER_THRESHOLD separate_${special_input_id}_1_2 PROFILE_1 STORM_LOWER_THRESHOLD "onchange=\"WEATHER_put_desc('separate_${special_input_id}_1_2',1);\""]
			append HTML_PARAMS(separate_1) "<script type=\"javascript\"> WEATHER_put_desc('separate_${special_input_id}_1_2',0); </script>"
		}
		append HTML_PARAMS(separate_1)	"</td></tr><tr><td></td><td><span id=\"lower_desc\">&nbsp;</span>"
		append HTML_PARAMS(separate_1) "</td></tr></table>"
	} else {
		puts "<script type=\"text/javascript\">document.getElementById('sender_profiles').style.visibility = \"hidden\"</script>"
	}
  
    #	die Texte der Platzhalter einlesen
	  puts "<script type=\"text/javascript\">"
	  puts "jQuery.getScript('/config/easymodes/WEATHER/localization/lang.js', function() {"
	  puts "translateAttribute(\"#title0\",\"title\",\"toolTip0\");"
	  puts "translateAttribute(\"#title1\",\"title\",\"toolTip1\");"
	  puts "translatePage('.easymode_wrapper');"
	  puts "});</script>"
		
    #puts "<script type=\"text/javascript\">window.setTimeout(\"translatePage(\'#body_wrapper\')\",500);</script>"
}

constructor
