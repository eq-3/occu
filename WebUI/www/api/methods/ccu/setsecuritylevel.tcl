##
# CCU.setSecurityLevel
#
# Sets current security level.
# Parameters: Security level as String:
#               Possible values:
#                       LOW :   Low security. (compatibility mode)
#                       MEDIUM: Medium security - Authentication enabled; Firewall set to MOST_OPEN
#                       HIGH:   High security - Authentication enabled; Firewall set to RESTRICTIVE
#
# Return value:	True on success, null or false on error.
##

set lvl $args(level)

source "/lib/libsecuritylevel.tcl"
if { [string compare $lvl "LOW"] == 0 || [string compare $lvl "MEDIUM"] == 0 || [string compare $lvl "HIGH"] == 0 } {
	if { [ SEC_setsecuritylevel $lvl ]  } {
		jsonrpc_response true
	}
	else {
		jsonrpc_response false
	}
} else {
	jsonrpc_response false
}

