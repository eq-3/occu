##
# Interface.setValue
# Setzt den Wert eines Parameters im Paramset VALUES.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#   address:   [string] Adresse des logischen Geräts
#   valueKey:  [string] Id des Parameters
#   type:      [string] Datentyp des Parameters (string, int, bool)
#   value:     [string] Neuer Wert des Parameters
#
# Rückgabewert: [boolean]
#   true
##

set address  $args(address)
set valueKey $args(valueKey)
set type     $args(type)
set value    $args(value)

checkXmlRpcStatus [catch { xmlrpc $interface(URL) setValue [list string $address] [list string $valueKey] [list $type $value] }]

jsonrpc_response true
