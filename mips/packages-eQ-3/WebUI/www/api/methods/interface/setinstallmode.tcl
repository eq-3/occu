##
# Interface.setInstallMode
# Aktiviert bzw. deaktiviert den Anlernmodus.
#
# Parameter:
#   interface: [string]  Bezeichnung der Schnittstelle
#   on:        [boolean] Legt fest, ob der Anlernmodus aktiviert (true) oder deaktiviert (false) wird
#
# Rückgabewert: [boolean]
#   true
##

set on $args(on)
if { (1 == $on) || ("true" == $on) } then { set on 1 } else { set on 0 } 

checkXmlRpcStatus [catch {xmlrpc $interface(URL) setInstallMode [list bool $on] }]

jsonrpc_response true
