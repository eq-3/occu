##
# Device.startComTest
# Startet den Funktionstest für ein Gerät
#
# Parameter:
#   id: [string] Id des Kanals
#
# Rückgabewert: [string]
#   Id des Funktionstests
##

set script {
  var device = dom.GetObject(id);

  if (device)
  {
    Write(system.Date("%Y-%m-%d %H:%M:%S"));
    device.DevStartComTest();
  }
}

set result [hmscript $script args]

if { "" != $result } then {
  jsonrpc_response [json_toString $result]
} else {
  jsonrpc_error 500 "homematic script error"
}
