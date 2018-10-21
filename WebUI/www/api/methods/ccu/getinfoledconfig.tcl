##
# CCU.getInfoLedConfig
# Reads the configuration file evalutated by hss_led to control
# the behavior of the Info led on CCU3
#
# Parameter: None
#
# Returns: json object containing two boolean values: 
#            [boolean] serviceLedOn:
#                                    true  - Info LED signals service messages
#                                    false - Info LED does not signal service messages
#            [boolean] alarmLedOn:
#                                    true  - Info LED signals service messages
#                                    false - Info LED does not signal service messages
# Example return json-string:
# { "serviceLedOn":"true", "alarmLedOn":"false" }
##


proc read_var { filename varname} {
    set fd [open $filename r]
    set var ""
    if { $fd >=0 } {
        while { [gets $fd buf] >=0 } {
          if [regexp "^ *$varname *= *(.*)$" $buf dummy var] break
        }
        close $fd
    }
    return $var
}

set ignoreService false
set ignoreAlarm false
# read data from file
catch { set ignoreService [read_var "/etc/config/hss_led_info.conf" "IgnoreServiceMessages"] }
catch { set ignoreAlarm [read_var "/etc/config/hss_led_info.conf" "IgnoreAlarmMessages"] }

# evaluate
set serviceLedOn "true"
set alarmLedOn "true"
if { [string equal $ignoreService "true"] == 1 } {
    set serviceLedOn "false"
}
if { [string equal $ignoreAlarm "true"] == 1} {
    set alarmLedOn "false"
}

# write answer json string

jsonrpc_response "\{\"serviceLedOn\":$serviceLedOn,\"alarmLedOn\":$alarmLedOn\}"
