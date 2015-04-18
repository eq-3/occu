##
# event.tcl
# Ereignisbehandlung.
##

##############
# Konstanten #
##############

set EVENT_DIRECTORY            "/tmp/event"
set EVENT_SUBSCRIBER_LIST_FILE "/tmp/event/subscriber.list"
set EVENT_LOCK_FILE            "/tmp/event/lock"
set EVENT_LIMIT                64

##############
# Prozeduren #
##############

##
# Löst ein Ereignis aus
##
proc event_fire { type message } {
	global EVENT_DIRECTORY EVENT_SUBSCRIBER_LIST_FILE EVENT_LIMIT EVENT_LOCK_FILE

	if { [lock_tryget $EVENT_LOCK_FILE] } then {
		catch {
			array set subscriberList [file_load $EVENT_SUBSCRIBER_LIST_FILE]

			foreach id [array names subscriberList] {
				array set subscriber $subscriberList($id)

				if {$EVENT_LIMIT > $subscriber(EVENT_COUNT)} then {
					catch { file_append [file join $EVENT_DIRECTORY $id] "[list [list TYPE $type DATA $message]]\n" }
					incr subscriber(EVENT_COUNT)
					set subscriberList($id) [array get subscriber]
				}
				array_clear subscriber
			}
			file_save $EVENT_SUBSCRIBER_LIST_FILE [array get subscriberList]
		}
		lock_release $EVENT_LOCK_FILE
	}
}

##################
# Einsprungpunkt #
##################

if { ![file exists $EVENT_SUBSCRIBER_LIST_FILE] } then {
	file mkdir $EVENT_DIRECTORY
	file_clear $EVENT_SUBSCRIBER_LIST_FILE
}
