##
# Interface.addDevice
# Lernt ein Gerät anhand seiner Seriennummer an die HomeMatic Zentrale an.
#
# Parameter:
#   interface:    [string] Bezeichnung der Schnittstelle
#   serialNumber: [string] Seriennummer des Geräts
#
# Rückgabewert: [object]
#   Gerätebeschreibung des angelernten Geräts.
##

set serialNumber $args(serialNumber)

checkXmlRpcStatus [catch {set device [xmlrpc $interface(URL) addDevice [list string $serialNumber]] }]

jsonrpc_response [getDeviceDescription $device]
