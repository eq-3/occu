##
# BidCosRF.isPresent
# Prüft, ob der BidCos-RF-Dienst (rfd) läuft.
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
