##
# Channel.getValue
# Liefert den Wert des Kanals.
#
# Paramter:
#   id: [string] Id des Kanals
#
# Rückgabewert: [string]
#   Wert
##

set script {
  object obj = dom.GetObject(id);
  if ( obj )
  {
    Write(obj.State());
  }
}


jsonrpc_response [json_toString [hmscript $script args]]

