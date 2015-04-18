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
set fd [open /etc/config/rfd.conf w]
  
# HM-CFG-LAN verwenden

puts $fd "# This File was automatically generated"
puts $fd "# TCP Port for XmlRpc connections"
puts $fd "Listen Port = 2001"
puts $fd ""
puts $fd "Log Destination = Syslog"
puts $fd "Log Identifier = rfd"
puts $fd ""
puts $fd "Persist Keys = 1"
puts $fd ""
puts $fd "#PID File = /var/rfd.pid"
puts $fd "#UDS File = /var/socket_rfd"
puts $fd ""
puts $fd "Device Description Dir = /firmware/rftypes"
puts $fd "Device Files Dir = /etc/config/rfd"
puts $fd "Address File = /etc/config/ids"
puts $fd "Key File = /etc/config/keys"
puts $fd "Firmware Dir = /firmware"
puts $fd "Replacemap File = /firmware/rftypes/replaceMap/rfReplaceMap.xml"
puts $fd ""
puts $fd ""	

#CCU2 Koprozessor
puts $fd "\[Interface 0\]"
puts $fd "Type = CCU2"
puts $fd "Description = CCU2-Coprocessor"
puts $fd "ComPortFile = /dev/ttyAPP0"
puts $fd "AccessFile = /dev/null"
puts $fd "ResetFile = /dev/ccu2-ic200"
puts $fd ""

#Lan Interfaces (RF)
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
