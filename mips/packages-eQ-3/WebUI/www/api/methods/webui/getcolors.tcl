##
# WebUI.getColors
# Liefert die Systemfarben der HomeMatic WebUI
#
# Privilegstufe: NONE
# Prameter:      <keine>
#
# Rückgabewert: [object]
#   Jedes Element ist die Id einer Systemfarbe, der ihr jeweiliger Wert 
#   zugeordnet wird.
##


set SYSTEM_COLOR_FILE [file join $env(DOCUMENT_ROOT) "webui/color.map"]
set USER_COLOR_FILE   "/etc/config/color.map"

proc loadFromFile { filename } {
  set content ""
  
  catch {
    set fd [open $filename r]
    set content [read $fd]
    close $fd
  }
  
  return $content
}

array set colorMap [loadFromFile $SYSTEM_COLOR_FILE]

# var central wird in api/homematic.cgi gesetzt.
if {$central} then {
  array set colorMap [loadFromFile $USER_COLOR_FILE]
}

set result "\{"
set first 1
foreach id [array names colorMap] {
  if { 1 != $first } then { append result "," } else { set first 0 }
  
  append result "[json_toString $id]:[json_toString $colorMap($id)]"
}
append result "\}"

jsonrpc_response $result
