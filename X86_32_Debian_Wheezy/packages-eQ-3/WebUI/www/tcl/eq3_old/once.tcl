#!/bin/tclsh

#Funktion "Include source files only once"
#Datum: 09.11.2006
#Quellen:
#- http://sourceforge.net/tracker/?func=detail&aid=793779&group_id=10894&atid=360894
#- http://wiki.tcl.tk/1113
#modifiziert: 15.11.2006 - Badberg - Abfrage: $tcl_version < 8.4
#             Bei http://wiki.tcl.tk/1113 wird file normalize benutzt. Das Statement
#             liefert einen immer eindeutigen Namen. Bei unserer heutigen Version 
#             von tcl (8.2) ist diese Funktion noch nicht enthalten. Das Statement
#             file nativename liefert nur den Dateinamen, und verhindert deshalb nur 
#             das doppelte sourcen einer Datei im gleichen Verzeichnis. Für die meisten 
#             Fälle reicht dies aber aus.
proc sourceOnce { file } {

    if { ! [file isfile $file] } {
        if { [file isfile [file join .. $file]] } {
            set file [file join .. $file]
        }
        
    }
    
	upvar "1" sources sources

	if { $::tcl_version < 8.4 } then {
	
		if { ! [info exists sources([file nativename $file])] } then {
	
			# don't catch errors, since that may indicate 
			# we failed to load it...?
			uplevel "1" [list source $file]
			
			# mark it as loaded since it was source'd with no error...
			set sources([file nativename $file]) "1"
		}
	} else {

		if { ! [info exists sources([file normalize $file])] } then {
	
			# don't catch errors, since that may indicate 
			# we failed to load it...?
			uplevel "1" [list source $file]
			
			# mark it as loaded since it was source'd with no error...
			set sources([file normalize $file]) "1"
		}
	}
}

proc loadOnce { file } {

	upvar "1" loaded loaded

	if { $::tcl_version < 8.4 } then {
	
		if { ! [info exists loaded([file nativename $file])] } then {
		
			# don't catch errors, since that may indicate 
			# we failed to load it...?
			uplevel "1" [list load $file]
			
			# mark it as loaded since it was source'd with no error...
			set loaded([file nativename $file]) "1"
		}
	} else {

		if { ! [info exists loaded([file normalize $file])] } then {
		
			# don't catch errors, since that may indicate 
			# we failed to load it...?
			uplevel "1" [list load $file]
			
			# mark it as loaded since it was source'd with no error...
			set loaded([file normalize $file]) "1"
		}
	}
}
