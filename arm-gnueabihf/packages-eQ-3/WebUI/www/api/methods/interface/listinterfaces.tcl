##
# Interface.listInterfaces
# Liefert eine Liste der verfügbaren Schnittstellen
#
# Parameter:
#   <keine>
#
# Rückgabewert: [array]
#   Für jedes Interface wird ein Objekt mit den folgenden Feldern angegeben:
#     name: [string]  Bezeichnung der Schnittstelle
#     port: [integer] Portnummer des zugehörigen XML-RPC Servers
#     info: [string]  Kurzbeschreibung der Schnittstelle
##

set result "\["
set first 1

foreach interfaceName [array names INTERFACE_LIST] {
  array set interface $INTERFACE_LIST($interfaceName)
  
  if { 1 != $first } then { append result "," } else { set first 0 } 
  
  append result "\{"
  append result "\"name\":[json_toString $interfaceName]"
  append result ",\"port\":$interface(PORT)"
  append result ",\"info\":[json_toString $interface(INFO)]"
  append result "\}"
  
  array_clear interface
}

append result "\]"

jsonrpc_response $result