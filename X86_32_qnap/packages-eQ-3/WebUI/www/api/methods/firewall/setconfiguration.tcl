##
# Firwall.setConfiguration
# Setzt die Konfiguration der Firewall. Diese wird sofort übernommen.
#
# Parameter:
#  services: [array] Enthält die geänderten Zugriffsrechte der einzelnen Services.
#                    Jedes Element ist ein Object mit den folgenden Feldern:
#                    id    : [string] Id des Services
#                    access: [string] Zugriffsberechtigung
#                                     ("full", "restricted", "none")
#  ips: [array] Liste der IP-Adressen und IP-Adressgruppen für eingeschränkte 
#               Berechtigung. Jedes Element ist eine Zeichenkette.
#
# Rückgabewert: [bool]
#  true
##

source /lib/libfirewall.tcl

set services $args(services)
set ips      $args(ips)

Firewall_loadConfiguration

set Firewall_IPS $ips

foreach _service $services {
	array set service $_service
	
	set name   $service(name)
	set access $service(access)
	
	if { [info exists Firewall_SERVICES($name)] } then {
		array set knownService  $Firewall_SERVICES($name)
		set knownService(ACCESS) $access
		set Firewall_SERVICES($name) [array get knownService]
		array_clear knownService
	}
	
	array_clear service
}

Firewall_saveConfiguration
Firewall_configureFirewall 

jsonrpc_response true