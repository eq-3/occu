##
# User.getLanguage
# Ermittelt die vom User gewählte Sprache
#
# Parameter:
#   userName: [string] userName des Anwenders
#
# Rückgabewert: Gewählte Sprache des Users
##



if {[catch {set fp [open "/etc/config/userprofiles/$args(userName).lang" r]}] == 0} {
  set data [read $fp]
  set lang [split $data "\n"]
  close $fp
} else {
  set lang "0"
}

jsonrpc_response [lindex $lang 0]