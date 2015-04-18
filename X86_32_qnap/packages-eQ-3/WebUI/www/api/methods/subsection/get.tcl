##
# Function.get
# Liefert Detailinformationen zu einem Gewerk.
#
# Paramseter:
#   id: [string] Id des Gewerks
#
# Rückgabewert: [object]
#   Folgende Felder sind definiert:
#     id:          [string] Id des Gewerks
#     name:        [string] Bezeichnung des Gewerks
#     description: [string] Kurzbeschreibung des Gewerks
#     channels:    [array]  Liste mit den IDs (Zeichenketten) der Kanäle
#                           ACHTUNG: Die Gewerkeliste enthält u. U. auch Kanäle noch nicht fertig konfigurierter Geräte!
##

set script {
  var func = dom.GetObject(id);
  if (func)
  {
    Write("ID {" # func.ID() # "}");
    Write(" NAME {" # func.Name() # "}");
    Write(" DESCRIPTION {" # func.EnumInfo() # "}");
  
    Write(" CHANNELS {");
    var first = true;
    string channelId;
    foreach(channelId, func.EnumUsedIDs())
    {
      if (true != first) { Write(" "); } else { first = false; }
      Write("{" # channelId # "}");
    }
    Write("}");
  }
}

array set function [hmscript $script args]

if { ![info exists function(NAME)] } then {
  jsonrpc_error 501 "function not found"
}

set result "\{"

append result "\"id\":[json_toString $function(ID)]"
append result ",\"name\":[json_toString $function(NAME)]"
append result ",\"description\":[json_toString $function(DESCRIPTION)]"

set first 1
append result ",\"channelIds\":\["
foreach channelId $function(CHANNELS) {
  if { 1 != $first } then { append result "," } else { set first 0 }
	append result [json_toString $channelId] 
}
append result "\]"

append result "\}"

jsonrpc_response $result
