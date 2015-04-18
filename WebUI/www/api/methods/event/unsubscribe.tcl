##
# Event.unsubscribe
# Meldet das Abo von Ereignisbenachrichtigungen ab.
#
# Parameter:
#  _session_id: [string] Session-Id
#
# Rückgabewert [boolean]
#   true, falls die Abmeldung erfolgreich war
#   false, falls Fehler aufgetreten sind (z.B. Sperre nicht erhalten)
##

set id     $args(_session_id_)
set result false

if { [lock_tryget $EVENT_LOCK_FILE] } then {
	catch {
		array set subscriberList [file_load $EVENT_SUBSCRIBER_LIST_FILE]
		file delete -force -- [file join $EVENT_DIRECTORY $id]
		unset subscriberList($id)
		file_save $EVENT_SUBSCRIBER_LIST_FILE [array get subscriberList]
		set result true
	}
	lock_release $EVENT_LOCK_FILE
}

jsonrpc_response $result
