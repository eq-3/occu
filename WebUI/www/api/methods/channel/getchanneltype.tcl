##
# Channel.getChannelType
# Liefert den Kanaltyp
#
# Paramter:
#   id: [string] Id des Kanals
#
# Rückgabewert: [string]
#   Kanaltyp
##

set script {
  object obj = dom.GetObject(id);
  if ( obj )
  {
    Write(obj.HssType());
  }
}


jsonrpc_response [json_toString [hmscript $script args]]

