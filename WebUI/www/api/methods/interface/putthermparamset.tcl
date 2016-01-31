##
# Interface.putThermParamset
# Schreibt den Partymode für einen Thermostaten
#
# Parameter:
#   interface  : [string] Bezeichnung der Schnittstelle
#   address    : [string] Adresse des logischen Geräts
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
set paramsetKey "VALUES"
set params $args(set)

set paramset ""
foreach param $params {
  array set parameter $param
  
  set name  $parameter(name)
  set type  $parameter(type)
  set value $parameter(value)
  lappend paramset [list $name [list $type $value]]

  if {$name == "PARTY_TEMPERATURE"} {
       set validParamset 1
  }

  array_clear parameter
}

if {$validParamset == 1} {
  checkXmlRpcStatus [catch { xmlrpc $interface(URL) putParamset [list string $address] [list string $paramsetKey] [list struct $paramset] }]
}
jsonrpc_response true
