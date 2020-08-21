##
# CCU.getHeatingGroupList
# Liefert die Liste der Heizungsgruppen
#
# Parameter:  Keine
#
# Rückgabewert: [string]
#  /etc/config/groups.gson
##

set pathOfFile "/etc/config/groups.gson"
set result ""

if {[catch {set fp [open $pathOfFile r]}] == 0} {
  set result [read $fp]
  close $fp
} else {
  set result -1
}

jsonrpc_response [json_toString $result]

