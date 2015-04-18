##
# Interface.clearConfigCache
# Löscht alle Konfigurationsdaten, welche die HomeMatic Zentral für das Gerät speichert.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#   address:   [string] Adresse des logischen Geräts
#
# Rückgabewert: [boolean]
#   true 
##

set address $args(address)

checkXmlRpcStatus [catch { xmlrpc $interface(URL) clearConfigCache [list string $address] }]

jsonrpc_response true
