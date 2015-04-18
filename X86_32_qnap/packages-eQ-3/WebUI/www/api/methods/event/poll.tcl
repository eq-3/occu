##
# Event.poll
# Fragt momentan anliegende Ereignisse ab
##

set id     $args(_session_id_)
set events ""

if { [lock_tryget $EVENT_LOCK_FILE] } then {
	catch {
		set filename [file join $EVENT_DIRECTORY $id]
		set events [file_load $filename]
		file_clear $filename
	}
	lock_release $EVENT_LOCK_FILE
}

set result "\["
set first  1

foreach _event $events {
	array set event $_event
	
	if { 1 != $first } then { append result "," } else { set first 0 }
	append result "\{"
	append result "\"type\":[json_toString $event(TYPE)]"
	append result " ,\"data\":$event(DATA)"
	append result "\}"
	
	array_clear event
}
append result "\]"

jsonrpc_response $result
