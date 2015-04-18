##
# Function.listProgramIds
# Liefert eine Liste der Ids aller Programme, die mindesten einen Kanal
# in dem Gewerk verwenden.
#
# Parameter:
#   id: [string] Id des Gewerks
#
# Rückgabewert:
#   Ids der entsprechenden Programme
##

set script {
  var func  = dom.GetObject(id);
  var first = true;

  string channelId;
  foreach(channelId, func.EnumUsedIDs())
  {
    var channel = dom.GetObject(channelId);
    if (false == channel.Internal())
    {
      string programId;
      foreach(programId, channel.ChnEnumDPUsagePrograms())
      {
        if (true != first) { Write(" "); } else { first = false; }
        Write("{" # programId # "}");
      }
    }
  }
}

set ids [-lrmdups [hmscript $script args]]

set result "\["
set first 1

foreach id $ids {
  if {$first != 1} then { append result ","} else { set first 0 }
  append result [json_toString $id ]
}

append result "\]"

jsonrpc_response $result
