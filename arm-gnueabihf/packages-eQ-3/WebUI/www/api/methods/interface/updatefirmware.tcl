##
# Interface.updateFirmware
# Führt das Firmware-Update eines Geräts durch. 
#
# Im Gegensatz zur XML-RPC-Version kann hier lediglich ein Gerät angegeben werden.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#   device:     Seriennummer des betreffenden Gerätes
#
# Rückgabewert: [boolean]
#   Enthält für jedes Gerät die Information, ob das Update erfolgreich war.
##

set device $args(device)

checkXmlRpcStatus [catch {set result [xmlrpc $interface(URL) updateFirmware  [list string $device]] }]

jsonrpc_response [toJSONBoolean $result]