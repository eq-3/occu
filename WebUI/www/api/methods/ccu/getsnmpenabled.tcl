##
# CCU.getSNMPEnabled
# Prüft, ob snmp eingerichtet / aktiviert ist.
#
# Parameter: kein
#
# Rückgabewert: Zustand 0 (deaktiviert) oder 1 (aktiviert)
##

set file "/etc/config/snmp/snmpd-ccu3.conf"

set enabled 0
if { [file exists $file] } {
    set fd [open $file r]
    set data [read $fd]
    if { [string equal data  ""] == 0 } {
        set enabled 1
    }
}

jsonrpc_response $enabled