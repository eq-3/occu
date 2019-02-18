##
# Channel.hasProgramIds
# Prüft, ob der Kanal in Programmen verwendet wird
#
# Paramter:
#  id: [string] Id des Kanals
#
# Rückgabewert: boolean  true/false
#
##

set script {
  var channel = dom.GetObject(id);
  if ( (channel) )
  {
    string programIds = channel.ChnEnumDPUsagePrograms();
    if (programIds.Length() > 0) {
      Write(true);
    } else {
      Write(false);
    }
  }
}

jsonrpc_response [hmscript $script args]
