##
# BidCoS_Wired.setConfiguration-wired
# Setzt die Konfiguration des BidCoS Services. Die Konfiguration wird es
# nach erneutem Starten der HomeMatic Zentrale übernommen.
#
# Parameter:
#   interfaces         : [array] Jedes Element enthält die Konfiguration eines Interfaces
#                               
#	  type		   : [string] Typ des Interfaces (HMWLGW)
#     serialNumber : [string] Seriennummer
#     encryptionKey: [string] Zugangsschlüssel
#     ipAddress    : [string] IP Adresse (Optional)
##

set result true

set portnumber 2000
catch { source "/etc/eq3services.ports.tcl" }
if { [info exists EQ3_SERVICE_HS485D_PORT] } {
	set portnumber $EQ3_SERVICE_HS485D_PORT
}

set header ""
# Read contents of current hs485d.conf until first interface section
set configexists [file exists /etc/config/hs485d.conf ]
if { $configexists == 1 } then { 
	set fd [open /etc/config/hs485d.conf r]
	while { [gets $fd line] >= 0 } {
	        if {  ![regexp {.*\[Interface [0-9]*\].*} $line ] } then {
	                append header $line "\n"
	        } else {
	                break
	        }
	}
	close $fd
} else {
	append header "# This File was automatically generated\n" 
	append header "# TCP Port for XmlRpc connections\n"
	append header "Listen Port = $portnumber\n"
	append header "\n"
	append header "Log Destination = Syslog\n"
	append header "Log Identifier = hs485d\n"
	append header "\n"
}

#Write configuration data read above
set fd [open /etc/config/hs485d.conf w]

puts $fd $header

#Write Lan Interfaces (Wired)
set i 0
  
if { [catch {
  foreach _interface_ $args(interfaces) {
    array set interface $_interface_

	  set type [array_getValue interface type]
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
