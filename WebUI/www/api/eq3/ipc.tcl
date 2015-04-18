#!/bin/tclsh

##
# ipc.tcl
# Zugriff auf die Schnittstellen-Prozesse
#
# @author: Falk Werner
##

##
# Interface-Datei
# XML-Datei, welche die verfügbaren Interfaces enthält.
##
set IPC_INTERFACES_FILE "/etc/config/InterfacesList.xml"

##
# Cache-Datei
# Speichert die einmal gelesene Interface-Liste
##
set IPC_CACHE_FILE "/var/tmp/api_ipc.cache"

##
# Liefert die Liste der verfügbaren Interfaces
##
proc ipc_getInterfaces { } {
	global IPC_INTERFACES_FILE IPC_CACHE_FILE
	
	set interfaces [file_load $IPC_CACHE_FILE]
	if { "" == $interfaces } {
		set interfaces [ipc_loadInterfacesFromFile $IPC_INTERFACES_FILE]
		file_save $IPC_CACHE_FILE $interfaces
	}
	
	return $interfaces
}

##
# Liest die verfügbaren Interfaces aus der Interface-Datei
##
proc ipc_loadInterfacesFromFile { filename } {
	global env
	array set interfaces ""
	
	# HomeMatic PC-Konfigurations-Tool
	if { [info exist env(BIDCOS_SERVICE)] } {
		set name default
		set url "$env(BIDCOS_SERVICE)"
		set port [ipc_getPort $url]
		set info {Allgemeine BidCoS-Schnittstelle}
		set interfaces($name) [list PORT $port URL $url INFO $info]
	}
	
	# HomeMatic Zentrale
	set content [file_load $filename]
	
	set node_start [string first "<ipc"  $content]
	set node_end	 [string first "</ipc" $content $node_start]
	while { (0 < $node_start) && (0 < $node_end) } {
		set node [string range $content $node_start $node_end]
		if {
				[regexp {<name[^>]*>(.+)</name[^>]*>} $node dummy name] &&
				[regexp {<url[^>]*>(.+)</url[^>]*>}   $node dummy url] &&
				[regexp {<info[^>]*>(.+)</info[^>]*>} $node dummy info]
		} {
			set port [ipc_getPort $url]
			set interfaces($name) [list PORT $port URL $url INFO $info]
		}
		set node_start [string first "<ipc" $content $node_end]
		set node_end   [string first "</ipc" $content $node_start]
	}

	return [array get interfaces]
}

##
# Ermittelt den Port eines Services aus der URL
##
proc ipc_getPort { url } {
	if { ![regexp {:([0-9]+)} $url dummy port] } {
		set port 0
	}
	
	return $port
}


