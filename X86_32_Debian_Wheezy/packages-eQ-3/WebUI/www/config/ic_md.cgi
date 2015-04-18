#!/bin/tclsh

# wird fuer den Motion-Detector benoetigt

source once.tcl
sourceOnce [file join $env(DOCUMENT_ROOT) cgi.tcl]
sourceOnce [file join $env(DOCUMENT_ROOT) common.tcl]


cgi_eval {
	
	cgi_input
	catch {
		import debug
	}
	
	http_head
	
	catch {import url} 
	catch {import sender_address} 
	catch {import receiver_address}
	catch {import set_value}
	catch {import id}
	catch {import commando}
	catch {import parameter}
	catch {import active_bright}

	set profile [lindex [split $id "_"] 2]
	set brightness -1
	set xmlCatch [catch {set brightness [xmlrpc $url getValue [list string $sender_address] [list string BRIGHTNESS]]}]	
	
	puts "<script type=\"text/javascript\">"

	switch $commando {
		
		"setEasymode" 	{
				# Der Wert wird nur in der Weboberfläche gesetzt, aber nicht zum MotionDetector übertragen
				# puts "document.getElementById('$id\_tmp').value = \'$brightness\'"
				if {$set_value == "true"} {puts "document.getElementById('$id').value = \'$brightness\'"}
				
			}
	
		"set" 	{
				if {$xmlCatch == 0} then {			
					if {$set_value == "true"} {puts "document.getElementById('$id').value = \'$brightness\'"}
					set first_start "{SHORT_COND_VALUE_LO {int $brightness}}"
					puts "[xmlrpc $url putParamset [list string $receiver_address] [list string $sender_address] [list struct $first_start]]"
					set brightness_set "true"
				} else {
					#dieser Zweig sollte nie aufgerufen werden.
					puts "alert('Es ist noch kein aktueller Helligkeitswert vorhanden.');"		
				}
			}
	
		"help" {
				set min [lindex $parameter 0]
				set max [lindex $parameter 1]

				
				if {$xmlCatch == 0} then {
					#Die aktuelle Helligkeit steht zur Verfügung
					#active 0 = inaktiv, 1 = aktiv
					if {$brightness < $active_bright} {set active "1"} else {set active "0"}
					puts "MD_catchBright_help('$min','$max','$brightness','$active', true);"		
				} else {
					#Die aktuelle Helligkeit steht nicht zur Verfügung, da der Sender noch kein Datenpaket gesendet hat.
					puts "MD_catchBright_help('$min','$max','$brightness','', '');"	
				}
			}
			
		default {
				# Falls kein Helligkeitswert zur Verfügung steht, dann soll der Button
				# Akutelle Helligkeit übernehmen nicht sichtbar sein.
				if {$xmlCatch == 0} then {				
					puts "\$('okButton_' + $profile).style.display = 'inline';"				
					puts "\$('brightDescr_' + $profile).style.display = 'inline';"
				} else {
					puts "\$('brightDescr_' + $profile).style.display = 'none';"
					puts "\$('okButton_' + $profile).style.display = 'none';"					
				}
				
			} 	
	}
	puts "</script>"
}
