##
# Room.listAll
# Liefert die IDs aller Räume.
#
# Parameter:
#   <keine>
#
# Rückgabewert: [array]
#   Jedes Element ist eine Zeichenkette, welche die Id des Raums darstellt.
##

set script {
  string id;
  var first = true;
  foreach(id, dom.GetObject(ID_ROOMS).EnumUsedIDs())
  {
    if (true != first) { Write(" "); } else { first = false; }
    Write("{" # id # "}");
  }
}

set ids [hmscript_run script]

set result "\["
set first  1

foreach id $ids {
	if { 1 != $first } then { append result "," } else { set first 0 }
	append result [json_toString $id]
}

append result "\]"

jsonrpc_response $result
