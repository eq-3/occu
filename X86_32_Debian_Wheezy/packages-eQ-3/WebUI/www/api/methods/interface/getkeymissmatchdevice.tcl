##
# Interface.getKeyMissmatchDevice
# Liefert die Seriennummer des letzten Geräts, das nicht angelernt werden konnte.
#
# Parameter:
#   interface: [string]  Bezeichnung der Schnittstelle
#   reset:     [boolean] Setzt diese Information in der Schnittstelle zurück (true)
#
# Rückgabewert: [string]
#   Seriennummer des betreffenden Geräts
##

set reset $args(reset)
if { (1 == $reset) || ("true" == $reset) } then { set reset 1 } else { set reset 0 }

checkXmlRpcStatus [catch {set serial [xmlrpc $interface(URL) getKeyMissmatchDevice [list bool $reset]] }]

jsonrpc_response $serial
