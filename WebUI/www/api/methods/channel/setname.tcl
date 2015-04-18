##
# Channel.setName
# Legt den Namen des Kanals fest.
#
# Paramter:
#   id: [string] Id des Kanals.
#   name: [string] Neuer Name des Kanals
#
# Rückgabewert: [string]
#   Neuer Name des Kanals-*
#
# *: Kanalnamen müssen immer eindeutig sein. Falls der neue Name dies
#    nicht ist, wird er entsprechend angepasst.
##


set script {
  var channel = dom.GetObject(id);
  if (channel)
  {
    channel.Name(name);
    Write(channel.Name());
  }
}

jsonrpc_response [json_toString [hmscript $script args]]

