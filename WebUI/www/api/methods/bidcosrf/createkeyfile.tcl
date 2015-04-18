##
# BidCoS_RF.createKeyFile
# Erstellt die Datei /etc/config/keys.
#
# Parameter:
#   key: [string] System-Sicherheitsschlüssel
##

##
# Konstanten
##

set KEY_FILE "/etc/config/keys"
set CURRENT_INDEX "Current user key"
set PREVIOUS_INDEX "Previous user key"

# Schlüssel erzeugen
package require md5
set hashedKey [::md5::md5 -hex $args(key)]


# Schlüssel-Index ermitteln
set fd [open "|crypttool -g" r]
set content [read $fd]
close $fd

array set keys {}
foreach line [split $content "\n"] {
  if { [regexp {([^=]*)=(.*)} $line dummy key value] } then {
    set key [string trim $key]
    set value [string trim $value]
    set keys($key) $value
  }
}

set currentIndex 0
if { [info exists keys($CURRENT_INDEX)] } then {
  set currentIndex $keys($CURRENT_INDEX)
}

set previousIndex 0
if { [info exists keys($PREVIOUS_INDEX)] } then {
  set previousIndex $keys($PREVIOUS_INDEX)
}

# Key-Datei erstellen

set fd [open $KEY_FILE w]
puts $fd "Current Index = $currentIndex"
puts $fd "Key 0 = "
if { $previousIndex != "0" } then {
  puts $fd "Key $previousIndex = $hashedKey"
}
if { $currentIndex != "0" } then {
  puts $fd "Key $currentIndex = $hashedKey"
}
puts $fd "Last Index = $previousIndex"
close $fd

# Rückgabe

jsonrpc_response true
