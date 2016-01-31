##
# Interface.listBidcosInterfaces
# Listet alle vorhandenen BidCoS-Interfaces auf.
#
# Parameter: 
#   interface: [string] Bezeichnung der Schnittstelle
#
# Rückgabewert: [array]
#   Jedes Element ist ein Objekt mit den folgenden Elementen:
#   address:     [string]  Seriennummer
#   description: [string]  Beschreibung
#   dutyCycle:   [integer] Duty Cycle (0 - 100)
#   isConnected: [boolean] true, falls das Interface gerade verbunden ist
#   isDefault:   [boolean] true, falls dieses das Standard-Interface ist
##

set gateways {}
checkXmlRpcStatus [catch { set gateways [xmlrpc $interface(URL) listBidcosInterfaces] }]


set result "\["
set first 1

foreach _gateway $gateways {
	array set gateway $_gateway
	if { 1 != $first } then { append result "," } else { set first 0 }
	
	append result "\{"
	append result "\"address\":[json_toString $gateway(ADDRESS)]"
	append result ",\"description\":[json_toString $gateway(DESCRIPTION)]"
	append result ",\"dutyCycle\":[json_toString $gateway(DUTY_CYCLE)]"
	append result ",\"isConnected\":[toJSONBoolean $gateway(CONNECTED)]"
	append result ",\"isDefault\":[toJSONBoolean $gateway(DEFAULT)]"
	append result ",\"fwVersion\":[json_toString $gateway(FIRMWARE_VERSION)]"
	append result ",\"type\":[json_toString $gateway(TYPE)]"
	append result "\}"
	
	array_clear gateway
}

append result "\]"

jsonrpc_response $result

