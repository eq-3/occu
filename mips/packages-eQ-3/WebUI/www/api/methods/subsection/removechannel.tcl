##
# Subsection.removeChannel
# Entfernt einen Kanal aus einem Gewerk.
#
# Parameter:
#   id:        [string] Id des Gewerks
#   channelId: [string] Id des Kanals
##

set script {
  var subsection = dom.GetObject(id);
  if (subsection)
  {
    subsection.Remove(channelId);
    Write("true");
  }
}

set result [hmscript $script args]

if {("true" == $result)} then {
  jsonrpc_response $result
} else {
  jsonrpc_error 500 "homematic script error"
}
