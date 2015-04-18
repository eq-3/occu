#!/bin/tclsh

source once.tcl
sourceOnce cgi.tcl
sourceOnce common.tcl

proc setBrightness {url sender_address} {
	global brightness
	
	set brightness [xmlrpc $url getValue [list string $sender_address] [list string BRIGHTNESS]]
	
	return $brightness
}

cgi_eval {
	
	cgi_input
	catch {
		import debug
		cgi_debug -on
	}

	catch {import url} 
	catch {import sender_address} 
	catch {import receiver_address}
	catch {import set_value}
	catch {import id}
	catch {import commando}
	catch {import parameter}
	catch {import active_bright}

	set brightness [setBrightness $url $sender_address]
	
	switch $commando {

		"" {
				puts "<script type=\"text/javascript\">"	
				puts "document.getElementById('$id\_tmp').value = \'$brightness\'"
				if {$set_value == "true"} {puts "document.getElementById('$id').value = \'$brightness\'"}
				puts "</script>"
			}
	
		"set" {
				puts "<script type=\"text/javascript\">"	
				puts "document.getElementById('$id\_tmp').value = \'$brightness\'"
				if {$set_value == "true"} {puts "document.getElementById('$id').value = \'$brightness\'"}
				puts "</script>"
				
				set first_start "{SHORT_COND_VALUE_LO {int $brightness}}"
				puts "[xmlrpc $url putParamset [list string $receiver_address] [list string $sender_address] [list struct $first_start]]"
				set brightness_set "true"
			}
	
		"help" {
				set aktiv "unbekannt"
				set min [lindex $parameter 0]
				set max [lindex $parameter 1]
				
				if {$brightness < $active_bright} {set aktiv "aktiv"} else {set aktiv "inaktiv"}
				
				set help_txt "Ist die vom Sensor ermittelte Helligkeit kleiner als der hier "
				append help_txt "eingegebene Wert, ist der Aktor aktiv.\\n"
				append help_txt "Ist es heller, bleibt der Aktor "
				append help_txt "bei erkannter Bewegung inaktiv.\\n\\n"
				append help_txt "Der g%FCltige Bereich reicht von $min - $max\\n\\n"
				append help_txt "Bei einem Wert von $max ist der Aktor immer aktiv, bei 0 ist er inaktiv.\\n\\n"
				append help_txt "Zur Zeit liegt die ermittelte Helligkeit bei $brightness. "
				append help_txt "Der Aktor ist also $aktiv.\\n\\n"
				append help_txt "Weitere Informationen entnehmen Sie bitte der Dokumentation."
				
				puts "<script type=\"text/javascript\">"	
				puts "alert(unescape('$help_txt'));"
				puts "</script>"
			}
	}
}
