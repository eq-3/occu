##
# CCU.setSNMPEnabled
# Prueft, ob snmp eingerichtet / aktiviert ist.
#
# Parameter: 
#       bool enabled    - enable (true) or disbale (false) SNMP
#       string usr      - username (ignored if enabled is false)
#       string pass     - password (ignored if enabled is false)
#
# Rueckgabewert: none
##

source "/lib/libfirewall.tcl"

set enable $args(enabled)
set user $args(usr)
set pass $args(pass)

# load firewall settings
Firewall_setLoggingEnabled 1
Firewall_loadConfiguration


if { $enable } {
    set rc [catch { exec -- /bin/setSNMPUser.sh $user $pass >/dev/null } msg]     
    Firewall_set_service_access SNMP full
} else {
    set rc [catch { exec -- /bin/unsetSNMPUser.sh >/dev/null } msg]     
    Firewall_set_service_access SNMP none
}

if {$rc == 0} {
  Firewall_saveConfiguration
  Firewall_configureFirewall
  set msg "noError"
}

set result "\{\"msg\" : [json_toString $msg]\}"

jsonrpc_response $result
