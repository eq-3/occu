##
# CCU.setInfoLedConfig
# Writes the configuration file evalutated by hss_led to control
# the behavior of the Info led on CCU3
#
# Parameter: [boolean] serviceLedOn:
#                                    true  - Info LED signals service messages
#                                    false - Info LED does not signal service messages
#            [boolean] alarmLedOn:
#                                    true  - Info LED signals service messages
#                                    false - Info LED does not signal service messages
#
# Returns: [boolean]
#  Always true
##


set ignoreService "false"
set ignoreAlarm "false"
if { $args(serviceLedOn) == "false" } {
    set ignoreService "true"
}
if { $args(alarmLedOn) == "false" } {
    set ignoreAlarm "true"
}

set fd [open "/etc/config/hss_led_info.conf" w]
puts $fd "IgnoreServiceMessages=$ignoreService"
puts $fd "IgnoreAlarmMessages=$ignoreAlarm"
close $fd

jsonrpc_response true