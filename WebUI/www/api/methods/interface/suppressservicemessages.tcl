##
# Interface.suppressServiceMessages
# Suppress service messages for given channel (service parameter).
# Provide empty parameter string to suppress all service parameters of given channel.
#
# Parameter:
#   interface:      [string]  Interface id
#   channelAddress: [string]  Channel address
#   parameterId:    [string]  Optional: Service parameter name / id. Use empty string to supress all service parameters.
#   suppress:       [boolean] True: Suppress service messages. False: Do not suppress service messages. 
#
# Returns: [boolean]
#   true
##

set channel  $args(channelAddress)
set parameter $args(parameterId)
set suppress     $args(suppress)

checkXmlRpcStatus [catch { xmlrpc $interface(URL) suppressServiceMessages [list string $channel] [list string $parameter] [list boolean $suppress] }]

jsonrpc_response true
