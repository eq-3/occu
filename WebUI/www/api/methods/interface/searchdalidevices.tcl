##
# Interface.searchDaliDevices
# Das ist eine Abwandlung von Interface.setValue.
# Hier wird das setValue lediglich mit einem catch abgefangen (ohne den Wrapper checkXmlRpcStatus), um eventuelle Fehler in der Datei /tmp/searchDali.log auszugeben.
# Im Fehlerfall wird das Script wie bei Interface.setValue mittels exit abgebrochen.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#   address:   [string] Adresse des logischen Geräts
#   valueKey:  [string] Id des Parameters
#   type:      [string] Datentyp des Parameters (string, int, double, bool)
#   value:     [string] Neuer Wert des Parameters
#
# Rückgabewert: [boolean]
#   true
##

set address  $args(address)
set valueKey $args(valueKey)
set type     $args(type)
set value    $args(value)

catch { xmlrpc $interface(URL) setValue [list string $address] [list string $valueKey] [list $type $value] } errorMessage

# In case of an error
if {$errorMessage != ""} {
  set systemTime [clock seconds]
  exec echo "[clock format $systemTime -format %D] - [clock format $systemTime -format %H:%M:%S] setValue errorMessage: $errorMessage" >> /tmp/searchDali.log
  #checkXmlRpcStatus [catch { xmlrpc $interface(URL) setValue [list string $address] [list string $valueKey] [list $type $value] }]
  exit
}

jsonrpc_response true
