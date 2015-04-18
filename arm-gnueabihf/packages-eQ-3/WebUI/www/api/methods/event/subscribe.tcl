##
# Event.subscribe
# Anmeldung zum Erhalt von Ereignisbenachrichtigungen
#
# Parameter:
#   _session_id_: [string] Session-Id
#
# Rückgabewert: [boolean]
#   true, falls die Anmeldung erfolgreich war
#   false, falls die Anmeldung nicht erfolgreich war (z.B. Sperre konnte nicht erhalten werden)
##

####################
# Hilfs-Prozeduren #
####################

##
# Prüft, ob eine Session-Id gültig ist
##
proc isValid { id } {
	array set args ""
	set args(_session_id_) $id
	
  
	return [hmscript_runFromFile "common/checksid.hms" args]
}

##################
# Einsprungpunkt #
##################

set id     $args(_session_id_)
set result false
	
if { [lock_tryget $EVENT_LOCK_FILE] } then {
	catch {
		file_clear [file join $EVENT_DIRECTORY $id]
    
		array set subscriberList [file_load $EVENT_SUBSCRIBER_LIST_FILE]
    
		foreach _id [array names subscriberList] {
      set result "\"$_id a\""
			if { "true" != [isValid $_id] } then {
				unset subscriberList($_id)
				file delete -force -- [file join $EVENT_DIRECTORY $_id]
			}
		}
    
		set subscriberList($id) [list EVENT_COUNT 0]
		file_save $EVENT_SUBSCRIBER_LIST_FILE [array get subscriberList]
    
		set result true
	}
	event_fire init null
	lock_release $EVENT_LOCK_FILE
}
	
jsonrpc_response $result
