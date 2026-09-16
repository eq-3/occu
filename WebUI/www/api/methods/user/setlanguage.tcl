##
# User.setLanguage
# Speichert die vom User gewählte Sprache
#
# Parameter:
#   userName: [string] userName des Anwenders
#   userLang: [string] Sprache
#
# Rückgabewert: [boolean] true, sonst JSON-RPC-Fehler
##
set userName $args(userName)
set userLang $args(userLang)

set userName [file tail $userName]
set path [file join /etc/config/userprofiles $userName.lang]

if {[catch {
    set fh [open $path w]
    puts -nonewline $fh $userLang
    close $fh
} err]} {
    jsonrpc_error 500 "could not write user profile"
}

jsonrpc_response true
