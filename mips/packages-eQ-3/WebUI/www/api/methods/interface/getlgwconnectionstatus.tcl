##
# Interface.getlgwstatus.tcl
# Liefert eine Liste der verfügbaren Schnittstellen
#
# Parameter:
# interface: [string] Bezeichnung der Schnittstelle
#
# Rückgabewert:
# object containing:
# 
#
##

#checkXmlRpcStatus [catch {array set result [xmlrpc $interface(URL) getLGWStatus] }]
set serial $args(serial)
#read info from file
set filename "/var/status/${serial}.connstat"
set fd [open "$filename" "r"]
set filedata [read $fd]
close $fd

jsonrpc_response "\{\"connstat\":[json_toString $filedata], \"serial\":[json_toString $serial]\}"
