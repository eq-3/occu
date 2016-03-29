##
# BidCoS_RF.setConfigurationCCU2
# Setzt die Konfiguration des BidCoS Services. Die Konfiguration wird es
# nach erneutem Starten der HomeMatic Zentrale übernommen.
#
# Parameter:
#   interfaces         : [array] Jedes Element enthält die Konfiguration eines
#                                HM-CFG-LAN:
#	  type		   : [string] Typ des Interfaces (Lan Interface)
#     serialNumber : [string] Seriennummer
#     encryptionKey: [string] Zugangsschlüssel
#     ipAddress    : [string] IP Adresse (Optional)
##

set result true

# Read header of current rfd.conf until [Interface 1] (exclusive)
set fd [open /etc/config/rfd.conf r]
while { [gets $fd line] >= 0 } {
        if {  ![regexp {.*\[Interface [1-9]*\].*} $line ] } then {
                append header $line "\n"
        } else {
                break
        }
}
close $fd


# Write new file
set fd [open /etc/config/rfd.conf w]
  
# Write back header and [Interface 0] section
puts $fd $header

#Write Lan Interface sections (if any)
set i 1
  
if { [catch {
  foreach _interface_ $args(interfaces) {
    array set interface $_interface_

	  set type          [array_getValue interface type]
	  set userName      [array_getValue interface userName]
    set serialNumber  [array_getValue interface serialNumber]
    set encryptionKey [array_getValue interface encryptionKey]
    set ipAddress     [array_getValue interface ipAddress]
      
    puts $fd "\[Interface $i\]"
    puts $fd "Type = $type"
    puts $fd "Name = $userName"
    puts $fd "Serial Number = $serialNumber"
    puts $fd "Encryption Key = $encryptionKey"
    if { {} != $ipAddress } then {
      puts $fd "IP Address = $ipAddress"
    }
    puts $fd ""
      
    array_clear interface
    incr i
  }
} ]} then {
  set result false
}
  


close $fd

jsonrpc_response $result
