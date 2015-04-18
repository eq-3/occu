##
# Interface.deleteDevice
# Löscht ein Gerät aus der Schnittstelle
#
# Parameter:
#   inteface: [string]  Bezeichnung der Schnittstelle
#   address:  [string]  Adresse des logischen Geräts
#   flags:    [integer] Flags
#                       0x01: [DELTE_FLAG_RESET]  Setzt das Gerät in den Werkszustand zurück
#                       0x02: [DELETE_FLAG_FORCE] Löscht das Gerät auch, wenn dieses nicht erreichbar ist
#                       0x04: [DELETE_FLAG_DEFER] Löscht das Gerät bei der nächsten Gelegenheit
#
# Rückgabewert: [boolean]
#   true (Falls das Gerät nicht gelöscht werden kann, tritt eine Exception auf)
##

set address $args(address)
set flags   $args(flags)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) deleteDevice [list string $address] [list int $flags] }]

jsonrpc_response true