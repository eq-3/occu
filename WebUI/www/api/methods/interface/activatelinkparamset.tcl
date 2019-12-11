##
# Interface.activateLinkParamset
# Aktiviert ein Link-Parmeterset.
#
# Parameter:
#   interface:   [string] Bezeichnung der Schnittstelle
#   address:     [string] Adresse des logischen Geräts
#   peerAddress: [string] Adresse des Kommunikationspartners
#   longPress:   [bool]   Aktivert das Parameterset für den langen Tastendruck
#
# Rückgabewert: [bool]
#   true
##

set address     $args(address)
set peerAddress $args(peerAddress)
set longPress   $args(longPress)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) activateLinkParamset [list string $address] [list string $peerAddress] [list bool $longPress] }]

jsonrpc_response true
