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
set pathTmpColorMap "/tmp/_color.map"
set pathNewColorMap "/tmp/color.map"

# copy original color.map to /tmp/color.map
if {[file exists $pathTmpColorMap] != 1} {
  exec cp $pathOrigColorMap $pathTmpColorMap
}

# Read the lines into a Tcl list
set f [open $pathTmpColorMap]
set lines [split [read $f] "\n"]
close $f

# Make the replacement of the changed color keys
foreach line $lines {
  if {([string equal [lindex [split $line " "]  0] $webuiKey] == 1) || ([string equal [lindex [split $line "\t\?"]  0] $webuiKey] == 1)} {
    exec echo "$webuiKey  $color" >> $pathNewColorMap
  } else {
    exec echo $line >> $pathNewColorMap
  }
}

# Move the newly generated color.map to the original position and delete the temporarily created files
exec mount -o remount,rw /
if {$cpFile == 1} {
  catch {exec mv $pathNewColorMap $pathOrigColorMap}
  catch {exec rm $pathTmpColorMap}
} else {
  catch {exec mv $pathNewColorMap $pathTmpColorMap}
}
exec mount -o remount,ro /

set result true

jsonrpc_response $result
