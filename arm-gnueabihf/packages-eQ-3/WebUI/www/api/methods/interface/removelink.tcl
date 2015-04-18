##
# Interface.removeLink
# Entfernt eine direkte Geräteverknüpfung.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#   sender:    [string] Adresse des Senders
#   receiver:  [string] Adresse des Empfängers
#
# Rückgabewert: [boolean]
#   true
##

set sender   $args(sender)
set receiver $args(receiver)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) removeLink [list string $sender] [list string $receiver] }]

jsonrpc_response true