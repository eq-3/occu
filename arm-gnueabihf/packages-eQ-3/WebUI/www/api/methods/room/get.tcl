##
# Room.get
# Liefert Detailinformationen zu einem Raum.
#
# Parameter:
#   id: [string] Id des Raums
#
# Rückgabewert: [object]
#   Folgende Felder sind definiert:
#     id:          [string] ID des Raums
#     name:        [string] Bezeichnung des Raums
#     description: [string] Kurzbeschreibung des Raums
#     channels:    [array] Liste mit den IDs (Zeichenketten) der Kanäle
#                          ACHTUNG: Die Raumliste enthält u. U. auch Kanäle noch nicht fertig konfigurierter Geräte!
##

set script {
  var room = dom.GetObject(id);
  if (room)
  {
    Write("ID {" # room.ID() # "}");
    Write(" NAME {" # room.Name() # "}");
    Write(" DESCRIPTION {" # room.EnumInfo() # "}");

    Write(" CHANNELS {");
    var first = true;
    string channelId;
    foreach(channelId, room.EnumUsedIDs())
    {
      if (true != first) { Write(" "); } else { first = false; }
      Write("{" # channelId # "}");
    }
    Write("}");
  }
}

array set room [hmscript $script args]


if { ![info exists room(NAME)] } then {
	jsonrpc_error 501 "room not found"
}

set result "\{"

append result "\"id\":[json_toString $room(ID)]"
append result ",\"name\":[json_toString $room(NAME)]"
append result ",\"description\":[json_toString $room(DESCRIPTION)]"

set first 1
append result ",\"channelIds\":\["
foreach channelId $room(CHANNELS) {
	if { 1 != $first } then { append result "," } else { set first 0 }
	append result [json_toString $channelId] 
}
append result "\]"

append result "\}"

jsonrpc_response $result
