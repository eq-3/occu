##
# Interface.getSuppressedServiceMessages
# Get arrays of suppressed service message parameters for given channel.
#
# Parameter:
#   interface:     [string] Interface id
#   channelAddress: [string] Channel address
#
# Returns: [array]
#   Array of suppressed service parameter names / ids.
##

set channel $args(channelAddress)

checkXmlRpcStatus [catch { set params [xmlrpc $interface(URL) getSuppressedServiceMessages [list string $channel]] }]


set result "\["
set first  1

foreach param $params {
	if { 1 != $first } then { append result "," } else { set first 0 }
	append result [json_toString $param]
}

append result "\]"

jsonrpc_response [json_toString $result]
