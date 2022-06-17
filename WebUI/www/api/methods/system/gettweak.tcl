##
# system.getTweak
# Ließt einen Key aus der Datei /etc/config/tweaks

# Parameter:
# string key - der gewünschte key
#
# Rückgabewert:
# Der Wert des Keys, wenn er vorhanden ist. Ansonsten -1
#
##

set _key $args(key)

proc read_var { filename varname} {
    set var ""

    set fd -1
    catch { set fd [open $filename r] }
    if { $fd >=0 } {
        while { [gets $fd buf] >=0 } {
          if [regexp "^ *$varname *= *(.*)$" $buf dummy var] break
        }
      close $fd
    }

    return $var
}

catch {set result [read_var /etc/config/tweaks $_key]}

if {$result == ""} {set result false}

jsonrpc_response $result
