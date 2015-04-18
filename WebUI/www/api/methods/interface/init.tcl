##
# Interface.init
# Meldet eine Logikschicht bei der Schnittstelle an
#
# Parameter:
#   interface:   [string] Bezeichnung der Schnittstelle
#   url:         [string] URL des XML-RPC-Servers
#   interfaceId: [string] Id, mit der sich die Schnittstelle bei der Logikschicht meldet
#
# Rückgabewert: [bool]
#   true
##

set url         $args(url)
set interfaceId $args(interfaceId)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) init [list string $url] [list string $interfaceId] }]

jsonrpc_response true