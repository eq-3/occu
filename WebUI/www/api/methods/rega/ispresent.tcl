##
# ReGa.isPresent
# Prüft, ob die Logikschicht (ReGa) bereit ist.
#
# Privilegstufe: NONE
# Parameter:     <keine>
#
# Rückgabewert: [bool]
#   true, falls ReGa läuft, sonst false.
##

if { "OK" == [hmscript_runInline "Write('OK');"] } then {
  jsonrpc_response true
} else {
  jsonrpc_response false
}