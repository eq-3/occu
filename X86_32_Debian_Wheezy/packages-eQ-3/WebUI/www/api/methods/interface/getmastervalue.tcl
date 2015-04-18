##
# Interface.getMasterValue
# Liefert einen einzelnen Wert aus dem Parametersatz MASTER.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#   address  : [string] Adresse des logischen Geräts
#   valueKey : [string] Id des Parameters
#
# Rückgabewert: [string]
#  Wert des Parameters
##

set address  $args(address)
set valueKey $args(valueKey)

checkXmlRpcStatus [catch { array set paramset [xmlrpc $interface(URL) getParamset [list string $address] [list string MASTER]] }]

set value ""
if { ![catch { set value $paramset($valueKey) } ]} then {
  jsonrpc_response [json_toString $value]
} else {
  jsonrpc_error 501 "invalid value key"
}