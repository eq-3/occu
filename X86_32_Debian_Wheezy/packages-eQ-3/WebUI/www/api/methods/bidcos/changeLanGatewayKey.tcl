##
# BidCoS_RF.createKeyFile
# Erstellt die Datei /etc/config/keys.
#
# Parameter:
#   lgwclass  : [string] Class of lan gateway (RF or Wired)
#   lgwserial : [string] Serial number of lan gateway
#   lgwip     : [string] IP Address of lan gateway (overrides serial if given)
#   newkey    : [string] Passphrase to generate access code
#   curkey    : [string] Current aes key as hexadecimal string
##

##
# Konstanten
##
#package require md5

#Path for update key file
set LGWKEY_FILE_PATH "/etc/config/"

if { $args(lgwserial) != "" } then {
  # Schlüssel erzeugen
  #set hashedKey [::md5::md5 -hex $args(passphrase)]
  # Dateinamen zusammenbauen
  set LGWKEY_FILE "$LGWKEY_FILE_PATH/$args(lgwserial).keychange"
  # Datei schreiben
  set fd [open $LGWKEY_FILE w]
  puts $fd "Class=$args(lgwclass)"
  puts $fd "Serial=$args(lgwserial)"
  puts $fd "IP=$args(lgwip)"
  puts $fd "KEY=$args(newkey)"
  puts $fd "CURKEY=$args(curkey)"
  close $fd
  # return
  jsonrpc_response true
} else {
  jsonrpc_response false
}

