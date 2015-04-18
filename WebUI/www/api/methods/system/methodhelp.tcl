##
# system.methodHelp
# Liefert die Kurzbeschreibung einer Methode.
#
# Privilegstufe: NONE
#
# Parameter:
#   name: [string] Name der Methode, deren Beschreibung gesucht ist
#
# Rückgabe:
#   [string] Kurzbeschreibung der Methode
##

set methodName $args(name)

if { [catch { array set method $METHOD_LIST($methodName) }] } then  {
  jsonrpc_error 500 "unknown method ($methodName)"
}

jsonrpc_response [json_toString $method(INFO)]
