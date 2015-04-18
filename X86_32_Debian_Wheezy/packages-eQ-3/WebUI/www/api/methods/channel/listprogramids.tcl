##
# Channel.listProgramIds
# Liefert eine Liste der Ids aller Programme, die den Kanal vewenden
#
# Paramter:
#  id: [string] Id des Kanals
#
# Rückgabewert: [array]
#  Die einzelnen Elemente sind Zeichenketten, welche die Ids der Programme enthalten.
##

set script {
  var channel = dom.GetObject(id);
  var first   = true;

  if ( (channel) )
  {
    string programId;
    foreach(programId, channel.ChnEnumDPUsagePrograms())
    {
      if (true != first) { Write(" "); } else { first = false; }
      Write("{" # programId # "}");
    }
  }
}

set ids [hmscript $script args]

set result "\["
set first  1

foreach id $ids {
  if {$first != 1} then { append result "," } else { set first 0 }
  append result [json_toString $id]
}

append result "\]"

jsonrpc_response $result
