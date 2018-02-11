##
# Interface.isPresent
# Prüft, ob der gewählte Interface-Dienst läuft.
#
# Prameter:
#   interface: [string] Bezeichnung der Schnittstelle
#
# Rückgabewert: [bool]
#   true, falls rfd läuft, sonst false.
##

if { ![catch { xmlrpc $interface(URL) system.listMethods } ] } then {
  jsonrpc_response true
} else {
  jsonrpc_response false
}
