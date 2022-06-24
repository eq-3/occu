##
# WebUI.setWebUIColors
# Setzt die Farben der WebUI

# Parameter:
# Key aus der www/webui/color.map- z. B. background
# color in Form von #192c6e
# cpFile - when 1, the color.map will be copied to the destination
#
# Rückgabewert: --
#
##

set webuiKey $args(key)
set color $args(color)
set cpFile $args(cpFile)

set pathOrigColorMap [file join $env(DOCUMENT_ROOT) "webui/color.map"]
set pathUserColorMap "/etc/config/color.map"

# copy original color.map to /tmp/color.map
if {[file exists $pathUserColorMap] != 1} {
  exec cp $pathOrigColorMap $pathUserColorMap
}

# Read the lines into a Tcl list
set f [open $pathUserColorMap]
set lines [split [read $f] "\n"]
close $f

# Make the replacement of the changed color keys
exec echo "" > $pathUserColorMap
foreach line $lines {
  if {([string equal [lindex [split $line " "]  0] $webuiKey] == 1) || ([string equal [lindex [split $line "\t\?"]  0] $webuiKey] == 1)} {
    exec echo "$webuiKey  $color" >> $pathUserColorMap
  } else {
    exec echo $line >> $pathUserColorMap
  }
}

set result true

jsonrpc_response $result
