##
# Interface.restoreConfigToDevice
# Überträgt die auf der HomeMatic Zentrale gespeicherten Konfigurationsdaten erneut an ein Gerät.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#   address  : [string] Adresse des logischen Geräts
#
# Rückgabewert: [boolean]
#   true
##

set address $args(address)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) restoreConfigToDevice [list string $address] }]

jsonrpc_response true
