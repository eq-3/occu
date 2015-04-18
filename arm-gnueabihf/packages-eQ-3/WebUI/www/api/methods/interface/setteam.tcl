##
# Interface.setTeam
# Fügt einen Kanal einem Team hinzu.
#
# Parameter:
#   interface     : [string] Bezeichnung der Schnittstelle
#   channelAddress: [string] Adresse des Kanals
#   teamAddress   : [string] Addresse des Teamkanals
#
# Rückgabewert: [boolean]
#   true
##

set channelAddress $args(channelAddress)
set teamAddress $args(teamAddress)

checkXmlRpcStatus [catch {xmlrpc $interface(URL) setTeam [list string channelAddress] [list string teamAddress] }]

jsonrpc_response true
