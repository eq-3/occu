##
# Function.listAll
# Liefert die IDs aller Gewerke.
#
# Parameter:
#   <keine>
#
# Rückgabewert: [array]
#   Jeded Element ist eine Zeichenkette, welche die Id eines Raumes darstellt.
##

set script {
  string id;
  var first = true;
  foreach(id, dom.GetObject(ID_FUNCTIONS).EnumUsedIDs())
  {
    if (true != first) { Write(" "); } else { first = false; }
    Write("{" # id # "}");
  }
}

set ids [hmscript $script args]

set result "\["
set first  1

foreach id $ids {
  if { 1 != $first } then { append result "," } else { set first 0 }
  append result [json_toString $id]
}

append result "\]"

jsonrpc_response $result
