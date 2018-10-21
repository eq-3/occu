##
# CCU.setAuthEnabled
#
# Sets service authentication enabled/disabled.
# Parameters: enabled:
#               Possible values:
#                       1: Authentication enabled 
#                       0: Authentication disabled 
#
# Return value:	True on success, null or false on error.
##

set enabled $args(enabled)

source "/lib/libsecuritylevel.tcl"

if { $enabled == "true" } {
		if { [SEC_setAuthEnabled true]  } {
			jsonrpc_response true
		} else {
			jsonrpc_response false
		}
} elseif { $enabled == "false" } {
		if { [SEC_setAuthEnabled false] } {
			jsonrpc_response true
		} else {
			jsonrpc_response false
		}
} else {
	jsonrpc_response false

}

