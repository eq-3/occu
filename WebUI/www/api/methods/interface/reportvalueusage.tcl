##
# Interface.reportValueUsage
# Teilt der Schnittstelle mit, wie h�ufig die Logikschicht einen Wert verwendet
#
# Parameter:
#   interface : [string] Bezeichnung der Schnittstelle
#   address   : [string] Adresse des logischen Ger�ts
#   valueId   : [string] Wert des logischen Ger�ts
#   refCounter: [integer] Anzahl der verwendungen des Wertes
#
# R�ckgabewert: [boolean]
#   true
##

set address $args(address)
set valueId $args(valueId)
set refCounter $args(refCounter)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) reportValueUsage [list string $address] [list string $valueId] [list int $refCounter] }]

jsonrpc_response true