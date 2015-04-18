##
# Channel.setLogging
# Legt fest, ob der Kanal protokolliert werden soll.
#
# Parameter:
#   id:       [string]  Id des Kanals
#   isLogged: [boolean] Prokollierung aktiv (true) oder inaktiv (false)
##

set script {
  var bIsLogged = false;
  if (isLogged == "true") { bIsLogged = true; }

  var channel = dom.GetObject(id);
  if (channel)
  {
    channel.ChnArchive(bIsLogged);
    Write(channel.ChnArchive());
  }
}

set result [hmscript $script args]

if {("true" == $result) || ("false" == $result)} then {
  jsonrpc_response $result
} else {
  jsonrpc_error 500 "homematic script error"
}
