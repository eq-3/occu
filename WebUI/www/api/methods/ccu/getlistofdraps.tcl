##
# CCU.getListOfDraps
# Liefert die angelernten DRAPs der HomeMatic Zentrale
#
# Parameter:  pathOfFile; [file] Pfad der Datei mit den vorhandenen DRAPs
#
# Rückgabewert: [string]
#  List der angelernten DRAPs
##

set pathOfFile $args(pathOfFile)
set result ""

if {[catch {set fp [open $pathOfFile r]}] == 0} {
  set result [read $fp]
  close $fp
} else {
  set result -1
}

jsonrpc_response [json_toString $result]

