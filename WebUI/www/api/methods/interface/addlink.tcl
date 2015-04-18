##
# Interface.addLink
# Erstellt eine direkte Geräteverknüpfung.
#
# Parameter:
#   interface:   [string] Bezeichnung der Schnittstelle
#   sender:      [string] Adresse des Senders
#   receiver:    [string] Adresse des Emfängers
#   name:        [string] Bezeichnung der Verknüpfung
#   description: [string] Beschreibung der Verknüpfung
#
# Rückgabewert: [boolean]
#   true
##

set sender      $args(sender)
set receiver    $args(receiver)
set name        $args(name)
set description $args(description)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) addLink [list string $sender] [list string $receiver] [list string $name]  [list string $description] }]

jsonrpc_response true