##
# BidCoS_Wired.getConfiguration
# Liefert die Konfiguration des BidCoS-Wired Dienstes.
#
# Parameter:
#  <keine>
#
# Rückgabewert: [object]
#   Folgende Felder sind definiert:
#     interfaces        : [array] LAN-Interfaces, die einzelnen Elemente sind
#        Objekte mit den folgenden Feldern:
#		   type         : [string] Interface Typ : HMWLGW, ...
#          serialNumber : [string] Seriennummer
#          encryptionKey: [string] Zugriffcode
#          ipAddress    : [string] IP Adresse
#          
##


set CONFIG_FILE {/etc/config/hs485d.conf}

##
# Schritt 1: rfd.conf einlesen
##

array set config  {}
array set section {}
set sectionName {}

catch {
  set fd [open $CONFIG_FILE r]
  
  catch {
    while { ![eof $fd] } {
    
      set line [string trimleft [gets $fd]]
  
      if { "\#" != [string index $line 0] } then {
  
        if { [regexp {\[([^\]]+)\]} $line dummy newSectionName] } then {
          set config($sectionName) [array get section]
          array_clear section
          set sectionName $newSectionName
        }
  
        if { [regexp {([^=]+)=(.+)} $line dummy name value] } then {
          set section([string trim $name]) [string trim $value]
        }
    
      }      
    
    }
    set config($sectionName) [array get section]
    array_clear section
  }
  
  close $fd
}

##
# Schritt 2: Benötigte Konfigurationsdaten sammeln
##

set interfaces {}

foreach sectionName [array names config] {
  if { {} != $sectionName } then {
    array set section $config($sectionName)
    
    set type [array_getValue section {Type}]
   
#    if { $type != {CCU2} } then {
     
      array set interface {}
      set interface(type)          [array_getValue section {Type}]
      set interface(userName)      [array_getValue section {Name}]
      set interface(serialNumber)  [array_getValue section {Serial Number}]
      set interface(encryptionKey) [array_getValue section {Encryption Key}]
      set interface(ipAddress)     [array_getValue section {IP Address}]
      
      lappend interfaces [array get interface]
      
      array_clear interface
 #   }
    
    array_clear section
  }
}

##
# Schritt 3: Ausgabe
##

set result "\{"
set first 1

#append result "\"useInternalAntenna\": $useInternalAntenna,"
append result "\"interfaces\": \["

foreach _interface_ $interfaces {
    array set interface $_interface_
  
    if { 0 == $first } then { append result "," } else { set first 0 }
  
    append result "\{"
    append result "\"type\": [json_toString $interface(type)],"
    append result "\"userName\": [json_toString $interface(userName)],"
    append result "\"serialNumber\": [json_toString $interface(serialNumber)],"
    append result "\"encryptionKey\": [json_toString $interface(encryptionKey)],"
    append result "\"ipAddress\": [json_toString $interface(ipAddress)]"
    append result "\}"
  
    array_clear interface
}

append result "\]"
append result "\}"

jsonrpc_response $result 

