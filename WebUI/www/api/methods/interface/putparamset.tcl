##
# Interface.putParamset
# Setzt Parameter in einem Paramset.
#
# Parameter:
#   interface  : [string] Bezeichnung der Schnittstelle
#   address    : [string] Adresse des logischen Geräts
#   paramsetKey: [string] Bezeichnung des Paramsets
#   set        : [array] Paramset
#                Jedes Element ist ein Objekt mit den folgenden Feldern:
#                  name:  [string] Bezeichnung des Parameters
#                  type:  [string] Datentyp des Parameters (string, int, bool)
#                  value: [string] Wert des Parameters
#
# Rückgabewert: [boolean]
#   true
##

set address $args(address)
set paramsetKey $args(paramsetKey)
set params $args(set)

set paramset ""
foreach param $params {
	array set parameter $param
	
	set name  $parameter(name)
	set type  $parameter(type)
	set value $parameter(value)
  lappend paramset [list $name [list $type $value]]
	
	array_clear parameter
}

checkXmlRpcStatus [catch { xmlrpc $interface(URL) putParamset [list string $address] [list string $paramsetKey] [list struct $paramset] }]

jsonrpc_response true
