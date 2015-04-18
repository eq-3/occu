##
# Room.listProgramIds
# Liefert eine Liste der Ids aller Programme, die mindesten einen Kanal
# in dem Raum verwenden.
#
# Parameter:
#   id: [string] Id des Raums
#
# Rückgabewert:
#   Ids der entsprechenden Programme
##

set script {
  var room  = dom.GetObject(id);
  var first = true;

  string channelId;
  foreach(channelId, room.EnumUsedIDs())
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
