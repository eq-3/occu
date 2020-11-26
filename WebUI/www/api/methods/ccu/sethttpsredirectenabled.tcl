##
# CCU.setHttpsRedirectEnabled
#
# Sets automatic redirect from http to https enabled/disabled.
# Parameters: enabled:
#               Possible values:
#                       1: Redirect enabled 
#                       0: Redirect disabled 
#
# Return value:	True on success, null or false on error.
##

set enabled $args(enabled)
set file "/etc/config/httpsRedirectEnabled"

if { $enabled == "true" } {
		if { [exec touch $file]  } {
			jsonrpc_response true
		} else {
			jsonrpc_response false
		}
} elseif { $enabled == "false" } {
		if { [exec rm $file] } {
			jsonrpc_response true
		} else {
			jsonrpc_response false
		}
} else {
	jsonrpc_response false

}

