##
# Interface.setLocalInstallModeHMIP
# Aktiviert bzw. deaktiviert den Anlernmodus.
#
# Parameter:
#   on:        [boolean] Legt fest, ob der Anlernmodus aktiviert (true) oder deaktiviert (false) wird
#   time:      [int] Legt die Zeit in Sekunden fest, nach der der Install-Mode deaktiviert werden soll. Default 30 s.
#   address - gibt die SGTIN bzw. ID des Gerätes ls
#
#   key_mode - gibt den verwendeten Inclusions-Typ an:
#    LOCAL
#    MASTER - wird zur Zeit noch nicht unterstützt
#    DEFAULT - wird zur Zeit noch nicht unterstützt
#
#   key - gibt den verwendeten Geräteschlüssel an.
#
#  Wird KEY_MODE und KEY nicht angegeben, wird versucht, den MASTER-Key vom Keyserver zu beziehen.
#
# Rückgabewert: true
#
##

# TODO Parameter description


set on $args(on)
set address $args(address)
set key $args(key)
set keymode $args(keymode)
set installMode $args(installMode)

if { ($on != "") && (($on == "true") || ($on == 1) || ($on == "1"))} {
  set on 1
} else {
  set on 0
}

if {$args(time) != ""} {
  set time $args(time)
} else {
  set time 30
}

proc array2xmlrpcstruct { array_name } {
  upvar $array_name arr
  set struct ""
  foreach key [array names arr] {
    set struct_entry $key
    lappend struct_entry $arr($key)
    lappend struct $struct_entry
  }
  return $struct
}

if {[string equal $installMode LOCAL]} {
  # Locales Anlernen, ohne Keyserver. Key muss übergeben werden

  array set whitelistDev {}
  set whitelistDev(ADDRESS) $address
  set whitelistDev(KEY) $key
  set whitelistDev(KEY_MODE) $keymode

  lappend whitelist [list struct [array2xmlrpcstruct whitelistDev]]

  checkXmlRpcStatus [catch {xmlrpc $interface(URL) setInstallModeWithWhitelist [list bool $on] [list int $time] [list array $whitelist]}]
} elseif {[string equal $installMode ALL]} {
  # Key vom Keyserver
  checkXmlRpcStatus [catch {xmlrpc $interface(URL) setInstallMode [list bool $on] [list int $time]}]
} else {
  # STOP
  #exec echo "STOP" >> /tmp/hmip.log
  set $on 0
  checkXmlRpcStatus [catch {xmlrpc $interface(URL) setInstallMode [list bool $on]}]
}

jsonrpc_response true
