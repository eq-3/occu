##
# Interface.setBidcosInterface
# Ordnet ein Gerät einem Gateway zu
#
# Parameter:
#   interface:   [string]  Bezeichnung der Schnittstelle
#   deviceId:    [string]  Geräteadresse
#   interfaceId: [string]  Adresse des Gateways
#   roaming:     [boolean] Deaktiviert die feste Interface-Zuordnung
#
# Rückgabewert: [boolean]
#   true
##

set deviceId $args(deviceId)
set interfaceId $args(interfaceId)
set roaming $args(roaming)

checkXmlRpcStatus [catch { xmlrpc $interface(URL) setBidcosInterface [list string $deviceId] [list string $interfaceId] [list bool $roaming] }]

jsonrpc_response true
