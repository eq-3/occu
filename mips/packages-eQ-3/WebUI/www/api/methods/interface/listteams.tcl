##
# Interface.listTeams
# Liefert eine Liste aller Team-Geräte
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#
# Rückgabewert: [array]
#   Lister mit Gerätebeschreibungen der Team-Geräte.
##


checkXmlRpcStatus [catch { set deviceList [xmlrpc $interface(URL) listTeams] }]

set result "\["
set first  1

foreach device $deviceList {
	if { 1 != $first } then { append result "," } else { set first 0 }
	append result [getDeviceDescription $device]
}

append result "\]"

jsonrpc_response $result
