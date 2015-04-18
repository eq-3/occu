##
# Room.addChannel
# Fügt dem Raum einen Kanal hinzu.
#
# Parameter:
#   id:        [string] Id des Raums
#   channelId: [string] Id des Kanals
##

set script {
  var room = dom.GetObject(id);
  if (room)
  {
    room.Add(channelId);
    Write("true");
  }
}

set result [hmscript $script args]

if {("true" == $result)} then {
  jsonrpc_response $result
} else {
  jsonrpc_error 500 "homematic script error"
}
