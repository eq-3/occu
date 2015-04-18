##
# Interface.getParamsetDescription
# Liefert die Beschreibung eines Paramsets.
#
# Parameter:
#   interface:    [stirng] Bezeichnung der Schnittstelle
#   address:      [string] Adresse des logischen Geräts
#   paramsetType: [string] Typ des Paramsets (MASTER, VALUES, LINK)
#
# Rückgabewert: [array]
#   Jedes Element ist ein Objekt, welches einen Parameter beschreibt.
#   Folgende Felder sind definiert:
#     NAME:       [string] Bezeichnung des Parameters
#     TYPE:       [string] Datentyp des Parameters (STRING, INTEGER
#     OPERATIONS: [string]
#     FLAGS:      [string] Flags für die Darstellung
#                          0x01: [VISIBLE]   Gibt an, ob der Parameter sichtbar ist
#                          0x02: [INTERNAL]  Gibt an, ob der Parameter nur intern verwendet wird
#                          0x04: [TRANSFORM] Eine Änderung des Parameters bewirkt eine gravierende Änderung im Verhalten des Kanals
#                                            ==> ist nur dann veränderbar, wenn keine Verknüpfungen mit diesem Kanal existieren
#                          0x08: [SERVICE]   Kennzeichnet Servicemeldungen
#                          0x10: [STICKY]    Kennzeichnet Servicemeldungen, die sich nicht selbstständig zurücksetzen
#     DEFAULT:    [string] Standardwert des Parameters
#     MAX:        [string] Maximaler Wert der Parameters
#     MIN:        [string] Minimaler Wert des Parameters
#     UNIT:       [string] Maßeinheit des Parameters
#     TAB_ORDER   [string] Liefert die Reihenfolge des Parameters im Paramset
#     CONTROL:    [string] Optional. Gibt an, welches Bedienelement für die Darstellung verwendet werden soll
#     VALUE_LIST: [string] Optional. Mögliche Werte beim Typ ENUM
#     SPECIAL:    [string] Optional. Liste spezieller Werte (ID VALUE)
#   Es können weitere Felder vorhanden sein.
##

set address      $args(address)
set paramsetType $args(paramsetType)

checkXmlRpcStatus [catch { array set description [xmlrpc $interface(URL) getParamsetDescription [list string $address] [list string $paramsetType]] }]

set result "\["
set first 1

foreach name [array names description] {
	if {1 != $first} then { append result "," } else { set first 0 }
	
	append result "\{"
	append result "\"NAME\":[json_toString $name]"
	
	foreach {valueName value} $description($name) {
		append result ",[json_toString $valueName]:[json_toString $value]"
	}
	
	append result "\}"
}

append result "\]"

jsonrpc_response $result
