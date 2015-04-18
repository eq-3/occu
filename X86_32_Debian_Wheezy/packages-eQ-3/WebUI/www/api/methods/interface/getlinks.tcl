##
# Interface.getLinks
# Liefert alle direkten Verknüpfungen eines Kanals.
#
# Parameter:
#   interface: [string]  Bezeichnung der Schnittstelle
#   address:   [string]  Adresse des Kanals oder "", für die gesamte Schnittstelle
#   flags:     [integer] Flags
#                        0x01: [GL_FLAG_GROUP]             Liefert alle Verknüpfungen einer Kanalgruppe
#                        0x02: [GL_FLAG_SENDER_PARAMSET]   Das Feld senderParamset wird gefüllt
#                        0x04: [GL_GLAG_RECEIVER_PARAMSET] Das Feld receiverParamset wird gefüllt
# Rückgabewert: [array]
#   Jedes Element ist ein Objekt, welches eine Verknüpfung beschreibt.
#   Die folgenden Felder sind definiert:
#     sender:           [string]  Adresse des Senders
#     recevier:         [string]  Adresse des Empfängers
#     name:             [string]  Bezeichnung der Verknüpfung
#     description:      [string]  Beschreibung der Verknüpfung
#     flags:            [integer] Flags
#                                 0x01: [LINK_FLAG_SENDER_BROKEN]    Verknüpfung ist auf Senderseite nicht intakt
#                                 0x02: [LINK_FLAG_RECEIVER_BROCKEN] Verknüpfung ist auf Empfängerseite nicht intakt
#     senderParamset:   [object]  Optional. Link-Paramset des Senders
#     receiverParamset: [object]  Optional. Link-Paramset des Empfängers
##

###################
# Hilfsfunktionen #
###################

##
# Gibt ein Paramset aus
##
proc appendParamset { p_result name paramset } {
	upvar $p_result result
	append result ",[json_toString $name]:\{"
	set first 1
	
	foreach {param value} $paramset {
		if {1 != $first} then { append result "," } else { set first 0 }
		append result "[json_toString $param]:[json_toString $value]"
	}
	
	append result "\}"
	return result
}

##################
# Einsprungpunkt #
##################

set address $args(address)
set flags   $args(flags)

checkXmlRpcStatus [catch {set links [xmlrpc $interface(URL) getLinks [list string $address] [list int $flags]] }]

set result "\["
set first 1

foreach _link $links {
	array set link $_link
	if { 1 != $first } then { append result "," } else { set first 0 }
	
	append result "\{"
	append result "\"name\":[json_toString $link(NAME)]"
	append result ",\"description\":[json_toString $link(DESCRIPTION)]"
	append result ",\"flags\": $link(FLAGS)"
	append result ",\"sender\":[json_toString $link(SENDER)]"
	append result ",\"receiver\":[json_toString $link(RECEIVER)]"
	
	if { [info exists link(SENDER_PARAMSET)] } then { 
		appendParamset result senderParamset $link(SENDER_PARAMSET)
	}
	
	if { [info exists link(RECEIVER_PARAMSET)] } then { 
		appendParamset result receiverParamset $link(RECEIVER_PARAMSET)
	}
	
	append result "\}"
	array_clear link
}

append result "\]"

jsonrpc_response $result