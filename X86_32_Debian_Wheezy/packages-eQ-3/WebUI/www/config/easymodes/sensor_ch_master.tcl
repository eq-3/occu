#!/bin/tclsh
#Kanal-EasyMode!
source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]

# set PROFILE_PNAME(Lichthupe) "Wie oft soll die Lichthupe zum Ausl&ouml;sen des Aktors bet&auml;tigt werden? "
set PROFILE_PNAME(Lichthupe) "\${triggerNecessary}"

set PROFILES_MAP(0)	"Experte"
set PROFILES_MAP(1)	"TheOneAndOnlyEasyMode"

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

	puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/SenEP.js');</script>"
	
	upvar PROFILES_MAP  PROFILES_MAP
	upvar HTML_PARAMS   HTML_PARAMS
	upvar PROFILE_PNAME PROFILE_PNAME
	upvar $pps          ps
   	upvar $pps_descr	ps_descr
   
   	array set arr_pulse ""

  puts "<script type=\"text/javascript\">getLangInfo_Special('PULSE_SENSOR.txt');</script>"
	
	append HTML_PARAMS(separate_1) "<div id=\"param_1\"><textarea id=\"profile_1\" style=\"display:non_\">"
	append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\"><tr><td>"
	append HTML_PARAMS(separate_1) $PROFILE_PNAME(Lichthupe)
	append HTML_PARAMS(separate_1) "</td><td>"

	array_clear options

	set comment {
    set options(99999992) "nicht aktiv "
    set options(99999993) "einmal"
    set options(99999994) "zweimal"
    set options(99999995) "dreimal"
    set options(99999996) "Experte"
	}

  set options(99999992) "\${notActive}"
  set options(99999993) "\${one}"
  set options(99999994) "\${two}"
  set options(99999995) "\${three}"
  set options(99999996) "\${expert}"

	append HTML_PARAMS(separate_1) [get_Pulse options separate_${special_input_id}_1 ps SEQUENCE_PULSE_5 $address arr_pulse "onchange=\"SenEP_activateEnterPulse('$special_input_id');\""]
	
	for {set loop 1} {$loop <= 6} {incr loop} {
		set pulse_values [lappend pulse_values $arr_pulse($loop)] 
		
	}
	
	append HTML_PARAMS(separate_1) "<script type=\"text/javascript\"> 
									SenEP_activateEnterPulse('$special_input_id');
									SenEP_setPulseActorValue('$special_input_id', '$pulse_values'); 
									</script>"

	append HTML_PARAMS(separate_1) "</td></tr></table></textarea></div>"
	

	EnterPulse ${special_input_id} ps_descr $pulse_values

  puts "<script type=\"text/javascript\">translate(\"1\", \"$special_input_id\");</script>"

}

constructor
