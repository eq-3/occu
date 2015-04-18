##
# Interface.searchDevices
# Durchsucht den Bus nach neuen Geräten.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#
# Rückgabewert: [integer]
#   Anzahl der gefundenen Geräte
##

checkXmlRpcStatus [catch { set count [xmlrpc $interface(URL) searchDevices] }]

jsonrpc_response $count
