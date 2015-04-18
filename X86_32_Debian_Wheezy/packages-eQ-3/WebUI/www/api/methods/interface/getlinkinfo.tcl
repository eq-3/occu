##
# Interface.getLinkInfo
# Liefert den Namen und die Beschreibung einer direkten Geräteverknüpfung
#
# Parameter:
#   interface:       [string] Bezeichnung der Schnittstelle
#   senderAddress:   [string] Adresse des Senders
#   receiverAddress: [string] Adresse des Empfängers
#
# Rückgabewert: [object]
#   Folgende Felder sind definiert:
#     name:        [string] Bezeichnug der Verknüpfung
#     description: [string] Beschreibung der Verknüpfung
##

set senderAddress   $args(senderAddress)
set receiverAddress $args(receiverAddress)

checkXmlRpcStatus [catch {array set result [xmlrpc $interface(URL) getLinkInfo [list string $senderAddress] [list string $receiverAddress]] }]

set name        $result(NAME)
set description $result(DESCRIPTION)

jsonrpc_response "\{\"name\":[json_toString $name],\"description\":[json_toString $description]\}"
