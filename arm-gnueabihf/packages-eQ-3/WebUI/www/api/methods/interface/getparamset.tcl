##
# Interface.getParamset
# Liefert ein komplettes Paramset.
#
# Parameter:
#   interface:   [string] Bezeichnung der Schnittstelle
#   address:     [string] Adresse des logischen Geräts
#   paramsetKey: [string] Schlüssel des Parametersets (z.B. "MASTER" oder "VALUE")
#
# Rückgabewert: [object]
#   Für jeden Parameter wird dessen Wert als Zeichenkette zurückgegeben.
##

set address     $args(address)
set paramsetKey $args(paramsetKey)

checkXmlRpcStatus [catch { set paramset [xmlrpc $interface(URL) getParamset [list string $address] [list string $paramsetKey]] }]

set result "\{"
set first 1

foreach {name value} $paramset {
  if { 1 != $first } then { append result "," } else { set first 0 }
  append result "[json_toString $name]:[json_toString $value]"
} 

append result "\}"

jsonrpc_response $result
