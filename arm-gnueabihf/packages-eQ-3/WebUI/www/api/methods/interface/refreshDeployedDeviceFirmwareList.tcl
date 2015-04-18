##
# Interface.refreshDeployedDeviceFirmwareList
# Refresht die Geräte-Firmware-Liste anhand der vorhandenen Firmware-Bundles unter /etc/config/firmware.
#
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle

#
# Rückgabewert: [boolean]
#   True, wenn erfolgreich
##


set result [catch {[xmlrpc $interface(URL) refreshDeployedDeviceFirmwareList]}]

jsonrpc_response [toJSONBoolean $result]