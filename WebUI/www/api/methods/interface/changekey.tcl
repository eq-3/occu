##
# Interface.changeKey
# Ändert den verwendeten AES-Schlüssel.
#
# Parameter:
#   interface:  [string] Bezeichnung der Schnittstelle
#   passphrase: [string] 
#
# Rückgabewert: [boolean]
#   true
##

set passphrase $args(passphrase)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) [list string $passphrase] }]

jsonrpc_response true