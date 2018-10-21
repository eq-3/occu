##
# CCU.getAuthEnabled
#
# Checks if service authentication is enabled or disabled.
# Return value:         1: Authentication enabled 
#                       0: Authentication disabled 
#
##

source "/lib/libsecuritylevel.tcl"

if { [SEC_getAuthEnabled] } {
			jsonrpc_response 1
} else {
		jsonrpc_response 0 
}

