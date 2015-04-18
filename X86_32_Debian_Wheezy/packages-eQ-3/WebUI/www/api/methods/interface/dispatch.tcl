##
# dispatch.tcl
# 
##

###################
# Hilfsfunktionen #
###################

##
# Erzeugt ein JSON-Stringarray
##
proc toJSONArray { p_array } {
  upvar $p_array arrayList
  set result "\["
  set first 1
  
  foreach item $arrayList {
    if { 1 != $first } then { append result "," } else { set first 0 }
    append result [json_toString $item]
  }
  
  append result "\]"
  return $result
}

##
# Erzeugt einen JSON-Boolean-Wert
##
proc toJSONBoolean { value } {
  if { 1 == $value } then {
    return true
  } else {
    return false
  }
}

##
# Liefert die Gerätebeschreibung
#
#   Allgemeine Felder:
#     type      [string]  Gerätetyp
#     address   [string]  Seriennummer des Geräts
#     paramsets [array]   Namen der verfügbaren Paramsets  
#     version   [integer] Versionsnummer der Beschreibung
#     flags     [integer] Flags für die Darstellung
#
#   Nur Geräte:
#     children          [array]  Seriennummern der untergeordneten Kanäle
#     firmware          [string] Optional. Aktuelle Firmware-Version
#     availableFirmware [string] Optional. Verfügbare Firmware-Version
#
#   Nur Kanäle:
#     parent          [string]  Seriennummer des übergeordneten Geräts
#     parentType      [string]  Gerätetyp des übergeordneten Geräts
#     index           [integer] Kanalnummer
#     aesActive       [bool]    Gibt an, ob die AES-Verschlüsselung aktiv ist
#     linkSourceRoles [array]   Bezeichnung der Rollen, die der Kanal in einer Verknüpfung als Sender einnehmen kann
#     linkTargetRoles [array]   Bezeichnung der Rollen, die der Kanal in einer Verknüpfung als Empfänger einnemhen kann
#     direction       [integer] Gibt die Kategorie des Geräts an (Sender, Empfänger oder nicht verknüpfbar)
#     group           [string]  Optional. Seriennummer des Partners in einer Kanalgruppe
#     team            [string]  Optional. Seriennummer des Team-Kanals
#     teamTag         [string]  Optional. ???
#     teamChannels    [array]   Optional. Seriennummern der Kanäle im Team
##
proc getDeviceDescription { deviceString } {
  array set device $deviceString
  
  set result "\{"
  
  # Allgemeine Felder
  append result "\"type\":[json_toString $device(TYPE)]"
  append result ",\"address\":[json_toString $device(ADDRESS)]"
  append result ",\"paramsets\":[toJSONArray device(PARAMSETS)]"
  append result ",\"version\":$device(VERSION)"
  append result ",\"flags\":$device(FLAGS)"
  
  if  { [info exists device(CHILDREN)] } then {
    # Felder für Geräte
    append result ",\"children\":[toJSONArray device(CHILDREN)]"
    if { [info exists device(FIRMWARE)] } then {
      append result ",\"firmware\":[json_toString $device(FIRMWARE)]"
    }
    if { [info exists device(AVAILABLE_FIRMWARE)] } then {
      append result ",\"availableFirmware\":[json_toString $device(AVAILABLE_FIRMWARE)]"
    }
  } else {
    # Felder für Kanäle
    append result ",\"parent\":[json_toString $device(PARENT)]"
    append result ",\"parentType\":[json_toString $device(PARENT_TYPE)]"
    append result ",\"index\":$device(INDEX)"
    append result ",\"aesActive\":[toJSONBoolean $device(AES_ACTIVE)]"
    append result ",\"linkSourceRoles\":[toJSONArray device(LINK_SOURCE_ROLES)]"
    append result ",\"linkTargetRoles\":[toJSONArray device(LINK_TARGET_ROLES)]"
    append result ",\"direction\":$device(DIRECTION)"
    if { [info exists device(GROUP)] } then {
      append result ",\"group\":[json_toString $device(GROUP)]"
    }
    if { [info exists device(TEAM)] } then {
      append result ",\"team\":[json_toString $device(TEAM)]"
    }
    if { [info exists device(TEAM_TAG)] } then {
      append result ",\"teamTag\":[json_toString $device(TEAM_TAG)]"
    }
    if { [info exists device(TEAM_CHANNELD)] } then {
      append result ",\"teamChannels\":[toJSONArray device(TEAM_CHANNELS)]"
    }
  }
  
  # BidCoS-RF
  if { [info exists device(INTERFACE)] } then {
    append result ",\"interface\": [json_toString $device(INTERFACE)]"
  }
  if { [info exists device(ROAMING)] } then {
    append result ",\"roaming\": [toJSONBoolean $device(ROAMING)]"
  }
  
  append result "\}"
  
  return $result
}

##
# Prüft das Ergebnis eines XML-RPC Aufrufs.
##
proc checkXmlRpcStatus { status } {
  if { 0 != $status } then {
    switch -exact -- $status {
       1      { jsonrpc_error 601 "TCL error" }
       2      { jsonrpc_error 602 "TCL return" }
       3      { jsonrpc_error 603 "TCL break" }
       4      { jsonrpc_error 604 "TCL continue" }
      -1      { jsonrpc_error 501 "XML-RPC: general error" }
      -2      { jsonrpc_error 502 "XML-RPC: unknown device or channel" }
      -3      { jsonrpc_error 503 "XML-RPC: unknown paramset" }
      -4      { jsonrpc_error 504 "XML-RPC: device address expected" }
      -5      { jsonrpc_error 505 "XML-RPC: unknown argument or value" }
      -6      { jsonrpc_error 506 "XML-RPC: operation not supported" }
      default { jsonrpc_error 599 "unknown error ($status)" }
    }
  }
}

###################
# Einsprunktpunkt #
###################

set interfaceName $args(interface) 

if { [catch { array set interface $INTERFACE_LIST($interfaceName) }] } then {
  jsonrpc_error 500 "unknown interface ($interfaceName)"
}

source "methods/$method(METHOD_FILE)"
