##
# CCU.getHmIPAddress
# Liefert die Adresse der HomeMatic Zentrale
#
# Parameter: <keine>
#
# Rückgabewert: [string]
#  Adresse der HomeMatic Zentrale
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

proc get_address { } {
    return [read_var /etc/config/hmip_address.conf Adapter.1.Address]
}

jsonrpc_response [json_toString [get_address]]
