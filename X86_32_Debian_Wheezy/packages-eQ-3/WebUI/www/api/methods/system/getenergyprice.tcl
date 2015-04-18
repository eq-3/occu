##
# system.getEnergyPrice
# Gibt den unter /etc/config/energyPrice gespeicherten Preis per KW/h zurück

# Parameter:
#
#
# Rückgabewert:
# Wenn eine korrekte Konfigurationsdatei vorhanden ist: Preis pro KW/h in der Form {"Price": "0.28", "Currency":"EUR"}
# sonst {"Price": "unknown", "Currency":"unknown"}
##


set data {}

if {[catch {set fp [open "/etc/config/energyPrice" r]}] == 0} {
  while {[gets $fp line] >= 0} {
    lappend data $line
  }
  close $fp
} else {
  lappend data "unknown"
  lappend data "unknown"
}

set result "\{"
if {[llength $data] == 2} {
  # This is necessary for the old version of the config file
  append result "\"Price\" : [json_toString [lindex $data 0]],"
  append result "\"Currency\" : [json_toString [lindex $data 1]]"
} else {
  # This is for the new version of the config file
  # Values: 0=Currency, 1=Price Current, 2=Price Gas, 3=GasHeatingValue, 4=GasConditionNumber
  append result "[lindex $data 0],"
  append result "[lindex $data 1],"
  append result "[lindex $data 2],"
  append result "[lindex $data 3],"
  append result "[lindex $data 4]"
}
append result "\}"
jsonrpc_response $result
