##
# Interface.getValue
# Liefert den Wert eines Parameters im Paramset VALUES.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#   address:   [string] Adresse des logischen Geräts
#   valueKey:  [string] Id des Parameters
#
# Rückgabewert: [string]
#   Wert des Parameters. 
##

set address $args(address)
set valueKey $args(valueKey)

checkXmlRpcStatus [catch { set value [xmlrpc $interface(URL) getValue [list string $address] [list string $valueKey]] }]

jsonrpc_response [json_toString $value]
