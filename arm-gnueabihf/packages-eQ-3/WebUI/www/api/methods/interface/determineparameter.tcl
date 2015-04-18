##
# Interface.determineParameter
# Bestimmt automatisch einen Parameter.
#
# Parameter:
#   interface  : [string] Bezeichnung der Schnittstelle
#   address    : [string] Adresse des logischen Geräts
#   paramsetKey: [string] Bezeichnung des Paramsets
#   parameterId: [string] Bezeichnung des Parameters
#
# Rückgabewert: [boolean]
#   true
##

set address $args(address)
set paramsetKey $args(paramsetKey)
set parameterId $args(parameterId)

checkXmlRpcStatus [catch { xmlrpc $interface(URL) determineParameter [list string $address] [list string $paramsetKey] [list string $parameterId] }]

jsonrpc_response true
