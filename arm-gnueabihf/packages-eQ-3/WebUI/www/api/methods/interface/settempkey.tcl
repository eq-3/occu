##
# Interface.setTempKey
# Ändert den von der HomeMatic Zentrale verwendeten temporären AES-Schlüssel.
#
# Paramter:
#   interface:  [string] Bezeichnung der Schnittstelle
#   passphrase: [string]
#
# Rückgabewert: [boolean]
#   true
##

set passphrase $args(passphrase)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) setTempKey [list string passphrase] }]

jsonrpc_response true
