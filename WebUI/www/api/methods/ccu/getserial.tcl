##
# CCU.getSerial
# Liefert die Seriennummer der HomeMatic Zentrale
#
# Parameter: <keine>
#
# Rückgabewert: [string]
#  Seriennummer der HomeMatic Zentrale
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

proc get_serial { } {
    return [read_var /var/ids SerialNumber]
}

jsonrpc_response [json_toString [get_serial]]
