##
# Interface.getDeviceDescription
# Liefert die Beschreibung eines logischen Geräts.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#   address:   [string] Adresse des logischen Geräts
#
# Rückgabewert: [object]
#   Gerätebeschreibung.
##

set address $args(address)

checkXmlRpcStatus [catch { set device [xmlrpc $interface(URL) getDeviceDescription [list string $address]] }]

jsonrpc_response [getDeviceDescription $device]
