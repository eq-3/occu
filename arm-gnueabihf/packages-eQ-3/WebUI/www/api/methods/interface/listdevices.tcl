##
# Interface.listDevices
# Liefert eine Liste aller angelernten Geräte
#
# Parameter:
#   interface: [string] Bezeichnug der Schnittstelle
#
# Rückgabewert: [array]
#   Liste der Gerätebeschreibungen.
## 

checkXmlRpcStatus [catch { set deviceList [xmlrpc $interface(URL) listDevices] }]

set result "\["
set first  1

foreach device $deviceList {
  if { 1 != $first} then { append result "," } else { set first 0 }   
  append result [getDeviceDescription $device]
}

append result "\]"

jsonrpc_response $result
