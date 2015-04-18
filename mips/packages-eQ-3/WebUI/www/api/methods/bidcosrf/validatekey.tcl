##
# BidCoS_RF.validateKey
# Prüft, ob der angegebene Sicherheits-Schlüssel korrekt ist.
#
# Parameter:
#   key: [string] System-Sicherheitsschlüssel
##

set result true
if { [catch { exec crypttool -v -t 3 -k "$args(key)" }] } then {
  set result false
}

jsonrpc_response $result