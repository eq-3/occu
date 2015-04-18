##
# Interface.getInstallMode
# Liefert die verbleibende Restzeit zurück, für die sich die Schnittstelle noch im Anlernmodus befindet.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#
# Rückgabewert: [integer]
#   Restzeit des Anlernmodus in Sekunden.
##

checkXmlRpcStatus [catch {set  remainingTime [xmlrpc $interface(URL) getInstallMode] }]

jsonrpc_response $remainingTime