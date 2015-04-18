##
# Device.listAll
# Liefert die IDs aller fertig konfigurierten Geräte.
#
# Parameter:
#   <keine>
#
# Rückgabewert: [array]
#   Jedes Element ist eine Zeichenkette, welche die Id des Geräts symbolisiert.
##

set script {
  string id;
  boolean first = true;
  foreach(id, root.Devices().EnumIDs())
  {
    var device = dom.GetObject(id);
    if (true == device.ReadyConfig())
    {
      if (true != first) { Write(" "); } else { first = false; }
    Write("{" # id # "}");
    }
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
