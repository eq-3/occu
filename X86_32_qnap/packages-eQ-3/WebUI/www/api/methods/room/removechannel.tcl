##
# room.removeChannel
# Entfernt einen Kanal aus einem Raum
#
# Parameter:
#   id:        [string] Id des Raums
#   channelId: [string] Id des Kanals
##

set script {
  var room = dom.GetObject(id);
  if (room)
  {
    room.Remove(channelId);
    Write("true");
  }
}

set result [hmscript $script args]

if {("true" == $result)} then {
  jsonrpc_response $result
} else {
  jsonrpc_error 500 "homematic script error"
}
